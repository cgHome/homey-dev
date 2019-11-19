#!/usr/bin/env bash
echo "Install (docker) homey-dev environment"

# Mac OS X .bashrc not working, to fix see: https://superuser.com/a/244990
# To delete run: unset -f homey-dev homey-run homey-init homey-start homey-create && rm ~/.bashrc OR remove the function on nano ~/.bashrc

# Load current bashrc-file
[[ -f ~/.bashrc ]] && source ~/.bashrc || echo "~/.bashrc not exist";

# Run a bash command inside homey-dev container
if [[ -n "$(declare -F homey-dev)" ]]; then 
    echo "homey-dev bash-function already exist";
else
    CMD='homey-dev() { ARGS=${@}; docker exec -ti ${PWD##*/} sh -c "$ARGS"; }';
    echo "$CMD" >> ~/.bashrc; source ~/.bashrc;
    echo "homey-dev bash-function added";
fi
# Run npm-script inside homey-dev container
if [[ -n "$(declare -F homey-run)" ]]; then 
    echo "homey-run bash-function already exist";
else 
    CMD='homey-run() { ARGS=${@}; homey-dev npm run-script "$ARGS"; }';
    echo "$CMD" >> ~/.bashrc; source ~/.bashrc;
    echo "homey-run bash-function added";
fi
# Start homey-dev container
if [[ -n "$(declare -F homey-start)" ]]; then 
    echo "homey-start bash-function already exist";
else
    CMD='homey-start() { 
        [[ $(docker ps -a --filter="name=${PWD##*/}" -q | xargs) ]] && echo "Container $(docker container rm -f ${PWD##*/}) removed";
        docker run -d -it --rm \
            -p 9229:9229 \
            --name ${PWD##*/} \
            --hostname ${PWD##*/}.homey-dev \
            --mount type=bind,source=${PWD},target=/app,consistency=default \
            --mount type=bind,source=${HOME}/.gitconfig,target=/root/.gitconfig,consistency=default \
            --env GITHUB_USER=$(git config user.name) \
            cghome/homey-dev &&
        homey-dev athom login && 
        echo "Container ${PWD##*/} started";
    }';
    echo "$CMD" >> ~/.bashrc; source ~/.bashrc;
    echo "homey-start bash-function added";
fi
# Create a new homey-app
if [[ -n "$(declare -F homey-createApp)" ]]; then 
    echo "homey-createApp bash-function already exist";
else
    CMD='homey-createApp() {
        read -p "Do you wish to create a homey-app & dev-container? (y/N)" -n 1 -r -t 3 
        if [[ ! $REPLY =~ ^[Yy]$ ]] ;then
            [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
        fi
        [[ $(docker ps -a --filter="name=homey-dev" -q | xargs) ]] && echo "Container $(docker container rm -f homey-dev) removed";
        echo "Start homey-dev container..." &&
        docker run -d -it --rm \
            --name homey-dev \
            --hostname homey-dev \
            --mount type=bind,source=${PWD},target=/app,consistency=default \
            --mount type=bind,source=${HOME}/.gitconfig,target=/root/.gitconfig,consistency=default \
            --env GITHUB_USER=$(git config user.name) \
            cghome/homey-dev &&
        echo "Create homey-app..." &&
        docker exec -it homey-dev sh -c "athom login && athom app create" &&
        docker container rm -f homey-dev &&
        cd $(ls -td */ | head -n1) && 
        homey-start &&
        echo "Create ${PWD##*/} git repository..." &&
        git init &&
        homey-dev npm init -y 1>/dev/null && 
        homey-dev npm run createRepo &&
        git add . && git commit -m '\''Initial commit'\'' &&       
        git push -u origin master &&
        echo "Homey-App ${PWD##*/} & Dev container created";
        echo
    }';
    echo "$CMD" >> ~/.bashrc; source ~/.bashrc;
    echo "homey-createApp bash-function added";
fi

printf "\n\e[93mAttention: Reload the bashrc-file (source ~/.bashrc) or restart the terminal-session\e[39m\n\n"