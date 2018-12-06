# Homey-Dev

Homey (docker) development environment

## Intro

After my old MacMini had died (RIP), I decided that my new computer (MacBook Pro) should no longer be a "Node.js Versions Messi". Because different server applications need different configurations and versions to load and manage. For example, if a Node.js app has not been used for a while, there is a good chance that it won't work properly anymore and you have to adapt the whole environment first. Only to find out afterwards, that there are new problems with another server app.

> **For this reason, I no longer install a server (Nodejs app, DB, etc.) directly on the computer, but create a separate docker image/container for all of them.**

## What is Homey-Dev ???

Homey-Dev is a development environment consisting of the normal Homey-App and a runtime environment ([via athom-cli](https://github.com/athombv/node-athom-cli)) in a (Homey-Dev) docker container. The container is controlled by various commands (see [Bash commands](#bash-commands)), which are defined as "bash-functions" during installation.

Furthermore, different Build-Tools commands are integrated, which are implemented as [npm-scripts](#homey-dev-build-tools) and can be used with "homey-run ..." or "npm run ..." (If node.js is installed on host). In addition, a remote debugger can be defined for the Homey-App in development mode.

## Pre-requisites

- Bash compatible OS (Tested with macOS Mojave)
- [Docker](https://www.docker.com/products/docker) installed
- [Git](https://git-scm.com/) installed
- Github account
- Athom developer account

[Optional]

- [Node.js](https://nodejs.org/en/download/) installed on host

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

## Upgrade

```bash
# Reinstall docker-image
[app-root] docker container rm -f ${PWD##*/}
[app-root] docker rmi cghome/homey-dev

# Reinstall the Homey-Dev bash-functions (if needed)
unset -f homey homey-run homey-start homey-createApp && nano ~/.bashrc
curl -s https://raw.githubusercontent.com/cgHome/homey-dev/master/install.sh | bash && source ~/.bashrc

# Start new Homey-Dev app-container
[app-root] homey-start
```

***Attention:***

> **After the bashrc-file modification, you have to reload the file (source ~/.bashrc) or restart the terminal-session.**

## Usage

### Bash commands

```bash
homey <command>         Run a bash command inside your homey-dev container
homey-run <npm-script>  Run a npm-script inside homey-dev container

homey-start             Start a homey-dev container for your homey-app
homey-createApp         Create a new homey-app & homey-dev container
```

### Homey-Dev Build-Tools

```bash
info                    Homey-App (container) information
test                    Run a Homey-App in development/debug mode
install                 Install a Homey-App
build                   Build a Homey-App for publishing
deploy:xxx              Workflow: build, push & relase on github and publish them to the Homey Apps Store.
deploy:major            - MAJOR version when you make incompatible API changes.
deploy:minor            - MINOR version when you add functionality in a backwards-compatible manner, and
deploy:patch            - PATCH version when you make backwards-compatible bug fixes. (see semver.org)
init:app                (Re)Initialize package.json based on homey-app/app.json (see .npm-init.js)

[User-Scripts]          User defined npm-scripts.
```

#### Define npm-scripts

```json
# Format
"[Name]": "npm run -s _homeyRun -- [Name] && exit; [App-Container commands]"

# Sample
"foo": "npm run -s _homeyRun -- foo && exit; echo \">> bar on: (${HOSTNAME})\" "
```

## Working with

(There is also a sample app see: [org.cflat-inc.homey-app](https://github.com/cgHome/org.cflat-inc.homey-app))

### Step 1: Install Homey-Dev

```bash
curl -s https://raw.githubusercontent.com/cgHome/homey-dev/master/install.sh | bash && source ~/.bashrc
```

### Step 2: Create a Homey-App

```bash
[repo] homey-createApp
```

### Step 2a: Or (if app exist) start Homey-Dev app-container

```bash
[app-root] homey-start
```

### Step 2b: Migration of the <package.json> file into the Homey-Dev environment

```bash
[app-root] homey npm init -y
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
[app-root] homey-run test

[app-root] npm run test                 <- (*1)
```

### Step 5: Deploy/Relase the Homey App on github and publish them to the Homey Apps Store

```bash
[app-root] homey-run deploy:minor

[app-root] npm run deploy:minor         <- (*1)
```

### Step 5a: Or install App on your homey

```bash
[app-root] homey-run install

[app-root] npm run install              <- (*1)
```

(*1 = If node.js is installed on host)

## Changelog

v0.2.1

- _homeyRun dedection fixed

v0.2.0

- Homey-Dev Build-Tools added

v0.1.0

- Initial release

## ToDo

- See [homey-dev/pulls](https://github.com/cgHome/homey-dev/pulls)

## Copyright and license

Copyright 2018, 2018 cflat-inc.org under [MIT License](LICENSE)
