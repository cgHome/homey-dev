# Homey-Dev

Homey (docker) development environment

## Intro

After my old MacMini had died (RIP), I decided that my new computer (MacBook Pro) should no longer be a "Node.js Versions Messi". Because different server applications need different configurations and versions to load and manage. For example, if a Node.js app has not been used for a while, there is a good chance that it won't work properly anymore and you have to adapt the whole environment first. Only to find out afterwards that there are new problems with another server app.

> **For this reason, I no longer install a server (Nodejs app, DB, etc.) directly on the computer, but create a separate docker image/container for all of them.**

## What is Homey-Dev ???

Homey-Dev is a development environment consisting of the normal homey app and a runtime environment ([via athom-cli](https://github.com/athombv/node-athom-cli)) in a docker container. The container is controlled by various commands ([see Usage](#usage)), which are defined as "bash-functions" during installation. Furthermore you can start commands via homey-run (aka npm-scripts) in the container and debug the homey app remotely.

## Pre-requisites

- Bash compatible OS (Tested with macOS Mojave)
- [Docker](https://www.docker.com/products/docker) installed
- Git installed
- Github account
- Athom developer account

## Installation

### Install Homey-Dev

```bash
curl -s https://raw.githubusercontent.com/cgHome/homey-dev/master/install.sh | bash && source ~/.bashrc
```

### Configure git on host-os

    git config --global hub.protocol https

    git config --global credential.helper store
    git config --global credential.helper 'cache --timeout 7200'

    git config --global user.name ["GITUSER_NAME"]
    git config --global user.email ["name@example.com"]

    Optional:

    git config --global color.ui auto
    git config --global format.pretty oneline

## Uninstall

```bash
unset -f homey homey-run homey-start homey-createApp && rm ~/.bashrc

# OR remove the homey bash-functions on ~/.bashrc

unset -f homey homey-run homey-start homey-createApp && nano ~/.bashrc

```

***Attention:***

> **After the bashrc-file modification, you have to reload the file (source ~/.bashrc) or restart the terminal-session.**

## Usage

### bash commands

```bash
homey <command>         Run a bash command inside your homey-dev container
homey-run <npm-script>  Run a npm-script inside homey-dev container

homey-start             Start a homey-dev container for your homey-app
homey-createApp         Create a new homey-app & homey-dev container
```

### homey-run commands

```bash
test                    Run a Homey App in development/debug mode
install                 Install a Homey App
build                   Build a Homey App for publishing
vbuild                  Update a Homey App version and build it.
deploy:xxx              Workflow: vbuild, push & relase on github and publish them to the Homey Apps Store.
deploy:major            - MAJOR version when you make incompatible API changes.
deploy:minor            - MINOR version when you add functionality in a backwards-compatible manner, and
deploy:patch            - PATCH version when you make backwards-compatible bug fixes. (see semver.org)
release                 Push and relase/tag a Homey-App on github
init:app                (Re)Initialize Homey-App based on homey-app/app.json (see .npm-init.js)
```

## Example

(There is also a sample app see: [org.cflat-inc.homey-app](https://github.com/cgHome/org.cflat-inc.homey-app))

### Step 1: Install Homey-Dev

```bash
curl -s https://raw.githubusercontent.com/cgHome/homey-dev/master/install.sh | bash && source ~/.bashrc
```

### Step 2: Create a Homey-App

```bash
cd ../[repo]
homey-createApp
```

### Step 2a: Or (if app exist) start Homey-Dev docker-container

```bash
cd ../[repo]/[homey-app]
homey-start
```

### Step 3: Add Remote (node.js) debuger

#### Replace app.js

```js
'use strict';

const Homey = require('homey');

const DEBUG = process.env.DEBUG === '1';

class App extends Homey.App {
    constructor(...args) {
        super(...args);
    };

    onInit() {
        this.log(`${ this.id } is running...(debug mode ${ DEBUG ? 'on' : 'off' })`);
        if (DEBUG) {
            require('inspector').open(9229, '0.0.0.0');
        };
    };
}

module.exports = App;
```

#### Add to (VS Code) launch.json

```json
{
    "type": "node",
    "request": "attach",
    "name": "Attach to Homey",
    "address": "xxx.xxx.xxx.xxx",         <- Homey IpAdr
    "port": 9229,
    "localRoot": "${workspaceFolder}",
    "remoteRoot": "/",
}
```

### Step 4: Happy coding & testing

```bash
cd ../[repo]/[homey-app]

homey-run test
```

### Step 5: Deploy/Relase the Homey App on github and publish them to the Homey Apps Store

```bash
cd ../[repo]/[homey-app]

homey-run deploy:xxx
```

### Step 5a: Install App on your homey

```bash
cd ../[repo]/[homey-app]

homey-run install
```

## Changelog

v0.1.0

* Initial release

## ToDo

## Copyright and license

Copyright 2018, 2018 cflat-inc.org under [MIT License](LICENSE)
