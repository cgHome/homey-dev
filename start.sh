#!/usr/bin/env bash

if [ -n "$(type -t homey)" ] && [ "$(type -t homey)" = function ];
    then 
        echo "homey cmd already exist (see: ~/.bashrc)"; 
    else 
        CMD='homey() { echo "homey >> ${@}"; docker exec -ti homey-dev sh -c "${@}"; }';
        echo "$CMD" >> ~/.bashrc; exec bash
        echo "homey bash-function added";  
fi

# Build image
docker build -t homey-dev .
# Run&Init container  
docker run -d -ti -v ${PWD}:/app -p 9229:9229 --rm --name homey-dev homey-dev
docker exec -ti homey-dev sh -c "athom login"
