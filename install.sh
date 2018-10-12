#!/usr/bin/env bash
echo "Install homey-dev environment"

source ~/.bashrc

# Create homey app
#docker run -it -v ${PWD}:/app --rm homey-dev athom app create;
#cd $(ls -1c . | tail -1);
#homey-start && npm init

if [ -n "$(type -t homey)" ] && [ "$(type -t homey)" = function ]; then 
    echo "homey bash-function already exist";
else 
    CMD='homey() { 
        ARGS=${@} 
        docker exec -ti ${PWD##*/} sh -c "$ARGS"
    }'
    echo "$CMD" >> ~/.bashrc
    source ~/.bashrc
    echo "homey bash-function added (!Attention! Restart the current terminal-session or run: source ~/.bashrc)";
fi
