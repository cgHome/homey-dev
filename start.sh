#!/usr/bin/env bash
echo "Start homey-dev environment"

# Buid docker 
docker container rm -f ${PWD##*/}

docker build -t homey-dev "homey-dev/"
docker run -d -ti -v ${PWD}:/app -p 9229:9229 --rm --name ${PWD##*/} homey-dev
docker exec -ti ${PWD##*/} sh -c "athom login"

# Define homey bash-functions
# Mac OS X .bashrc not working, see: https://superuser.com/a/244990
# To delete run: unset -f homey homey-run && rm ~/.bashrc OR remove on nano ~/.bashrc
source ~/.bashrc
if [ -n "$(type -t homey)" ] && [ "$(type -t homey)" = function ]; then 
    echo "homey bash-function already exist";
else 
    CMD='homey() { ARGS=${@}; docker exec -ti ${PWD##*/} sh -c "$ARGS"; }'
    echo "$CMD" >> ~/.bashrc
    source ~/.bashrc
    echo "homey bash-function added (!Attention! Restart the current terminal-session or run: source ~/.bashrc)";
fi
if [ -n "$(type -t homey-run)" ] && [ "$(type -t homey-run)" = function ]; then 
    echo "homey-run bash-function already exist";
else 
    CMD='homey-run() { ARGS=${@}; homey npm run-script "$ARGS" --prefix homey-dev; }'
    echo "$CMD" >> ~/.bashrc
    source ~/.bashrc
    echo "homey-run bash-function added (!Attention! Restart the current terminal-session or run: source ~/.bashrc)";
fi
