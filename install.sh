#!/usr/bin/env bash
echo "Install (docker) homey-dev environment"

# Define homey bash-functions
# Mac OS X .bashrc not working, to fix see: https://superuser.com/a/244990
# To delete run: unset -f homey homey-run homey-init homey-start homey-create && rm ~/.bashrc OR remove the function on nano ~/.bashrc

# Run a bash command inside homey-dev container
if [ -n "$(type -t homey)" ] && [ "$(type -t homey)" = function ]; then 
    echo "homey bash-function already exist";
else
    CMD='homey() { ARGS=${@}; docker exec -ti ${PWD##*/} sh -c "$ARGS"; }';
    echo "$CMD" >> ~/.bashrc; source ~/.bashrc;
    echo "homey bash-function added";
fi
# Run npm-script inside homey-dev container
if [ -n "$(type -t homey-run)" ] && [ "$(type -t homey-run)" = function ]; then 
    echo "homey-run bash-function already exist";
else 
    CMD='homey-run() { ARGS=${@}; homey npm run-script "$ARGS"; }';
    echo "$CMD" >> ~/.bashrc; source ~/.bashrc;
    echo "homey-run bash-function added";
fi
# Start homey-dev container
if [ -n "$(type -t homey-start)" ] && [ "$(type -t homey-start)" = function ]; then 
    echo "homey-start bash-function already exist";
else
    CMD='homey-start() { 
        [[ $(docker ps -a --filter="name=${PWD##*/}" -q | xargs) ]] && echo "Container $(docker container rm -f ${PWD##*/}) removed";
        docker run -d -it -v ${PWD}:/app -p 9229:9229 -e GIT_USERNAME="$(git config user.name)" --rm --name ${PWD##*/} cghome/homey-dev && echo "Container ${PWD##*/} started";        
        homey athom login;
    }';
    echo "$CMD" >> ~/.bashrc; source ~/.bashrc;
    echo "homey-start bash-function added";
fi
# Create a new homey-app
if [ -n "$(type -t homey-createApp)" ] && [ "$(type -t homey-createApp)" = function ]; then 
    echo "homey-createApp bash-function already exist";
else
    CMD='homey-createApp() { 
        docker run -d -it -v ${PWD}:/app -e GIT_USERNAME="$(git config user.name)" --name homey-dev cghome/homey-dev && 
        docker exec -it homey-dev sh -c "athom login && athom app create" &&  
        docker exec -it homey-dev sh -c "cd $(ls -td */ | head -1) && npm init -y" && 
        docker container rm -f homey-dev && 
        cd $(ls -td */ | head -n1) && homey-start;
    }';
    echo "$CMD" >> ~/.bashrc; source ~/.bashrc;
    echo "homey-create bash-function added";
fi

printf "\n\e[93mAttention: Reload the bashrc-file (source ~/.bashrc) or restart the terminal-session\e[39m\n\n"
