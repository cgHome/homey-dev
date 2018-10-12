#!/usr/bin/env bash
echo "Install (docker) homey-dev environment"

# Define homey bash-functions
# Mac OS X .bashrc not working, to fix see: https://superuser.com/a/244990
# To delete run: unset -f homey homey-init homey-start homey-create && rm ~/.bashrc OR remove the function on nano ~/.bashrc

source ~/.bashrc
# Run a command inside homey-dev container
if [ -n "$(type -t homey)" ] && [ "$(type -t homey)" = function ]; then 
    echo "homey bash-function already exist";
else
    CMD='homey() { ARGS=${@}; docker exec -ti ${PWD##*/} sh -c "$ARGS"; }'
    echo "$CMD" >> ~/.bashrc
    source ~/.bashrc
    echo "homey bash-function added";
fi
# Initialize homey-dev container
if [ -n "$(type -t homey-init)" ] && [ "$(type -t homey-init)" = function ]; then 
    echo "homey-init bash-function already exist";
else
    CMD='homey-init() { docker container rm -f ${PWD##*/}; homey-start &&  homey athom login; }'
    echo "$CMD" >> ~/.bashrc
    source ~/.bashrc
    echo "homey-init bash-function added";
fi
# Start homey-dev container
if [ -n "$(type -t homey-start)" ] && [ "$(type -t homey-start)" = function ]; then 
    echo "homey-start bash-function already exist";
else
    CMD='homey-start() { docker run -d -ti -v ${PWD}:/app -p 9229:9229 --rm --name ${PWD##*/} homey-dev }'
    echo "$CMD" >> ~/.bashrc
    source ~/.bashrc
    echo "homey-start bash-function added";
fi
# Create a new homey-app
if [ -n "$(type -t homey-create)" ] && [ "$(type -t homey-create)" = function ]; then 
    echo "homey-create bash-function already exist";
else
    CMD='homey-create() { docker run -it -v ${PWD}:/app --rm homey-dev athom app create && cd $(ls -td */ | head -n1) && homey-init && homey npm init; }'
    echo "$CMD" >> ~/.bashrc
    source ~/.bashrc
    echo "homey-create bash-function added";
fi
# Run npm-script
if [ -n "$(type -t homey-run)" ] && [ "$(type -t homey-run)" = function ]; then 
    echo "homey-run bash-function already exist";
else 
    CMD='homey-run() { ARGS=${@}; homey npm run-script "$ARGS"; }'
    echo "$CMD" >> ~/.bashrc
    source ~/.bashrc
    echo "homey-run bash-function added";
fi

printf "\n\e[93mAttention: Restart the current terminal-session or run: source ~/.bashrc\e[39m\n\n"