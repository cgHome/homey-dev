#!/usr/bin/env bash

echo "Start homey-dev environment"

docker build -t homey-dev .
docker run -d -ti -v ${PWD}:/app -p 9229:9229 --rm --name homey-dev homey-dev
docker exec -ti homey-dev sh -c "athom login"

# Define homey bash-function
# Mac OS X .bashrc not working, see: https://superuser.com/a/244990
source ~/.bashrc
if [ -n "$(type -t homey)" ] && [ "$(type -t homey)" = function ];
    then 
        echo "homey: bash-function already exist (To delete run: unset -f homey && nano or rm ~/.bashrc)";
    else 
        CMD='homey() { ARGS=${@}; docker exec -ti homey-dev sh -c "$ARGS"; }'
        echo "$CMD" >> ~/.bashrc
        echo "homey: bash-function added (!Attention! Restart the terminal-session or run: source ~/.bashrc)";
fi
