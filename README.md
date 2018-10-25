# Homey-Dev

Homey (docker) development environment

## Intro

Nachdem mein alter MacMini gestorben war (RIP), habe ich beschlossen, dass mein neuer Computer (MacBook Pro) keinen "Node.js Versions Messi" mehr sein wird. Denn verschiedene Server-Applikationen brauchen unterschiedliche Konfigurationen und Versionen, die man laden und verwalten muss. Wenn man zum Beispiel, ein Server eine zeitlang nicht mehr verwendet wurde, ist die Wahrscheinlichkeit gross, dass dieser nicht mehr einwandfrei funktioniert und man zuerst das Ganze wieder aufwendig korrigieren muss. Nur um danach festzustellen, dass es jetzt bei einer anderen Server-Konfiguration zu neuen Problemen kommt.

> **Aus diesem Grund installiere ich, keinen (Nodejs-App, DB, etc.) Server mehr auf dem Computer, sondern erstelle für alle ein separates Docker-Image.**

## What is Homey-Dev ???

Homey-Dev ist eine Entwicklungs-Umgebung, bestehend aus einer normalen Homey-App sowie einer Laufzeitumgebung ([via athom-cli](https://github.com/athombv/node-athom-cli)) in einem Docker-Container. Die Steuerung des Containers erfolgt über diverse Kommandos ([siehe Usage](#usage)), die als bash-functions bei der Installation definiert werden. Des weiteren kann man via homey-run, npm-scripts im Container starten, sowie die Homey-App remote debuggen ([siehe Add-ons](#add-ons)).

## Requirements

Configure git on host

    $ git config --global hub.protocol https
    $ git config --global user.name ["NAME"]
    $ git config --global user.email ["name@example.com"]
    $ git config --global color.ui auto
  
## Installation

```bash
curl -s https://raw.githubusercontent.com/cgHome/homey-dev/master/install.sh | bash && source ~/.bashrc
```

### Uninstall

```bash
unset -f homey homey-run homey-start homey-createApp && rm ~/.bashrc

# OR remove the homey bash-functions on ~/.bashrc

unset -f homey homey-run homey-start homey-createApp && nano ~/.bashrc

```

***Attention:***

> **After the bashrc-file modification, you have to reload the file (source ~/.bashrc) or restart the terminal-session.**

## Usage

### Commands

```bash
homey <command>         Run a bash command inside homey-dev container
homey-run <npm-script>  Run a npm-script inside homey-dev container

homey-start             Start a homey-dev container
homey-createApp         Create a new homey-app
```

### Example

#### Step 1: Install Homey-Dev

```bash
$ curl -s https://raw.githubusercontent.com/cgHome/homey-dev/master/install.sh | bash && source ~/.bashrc

Install (docker) homey-dev environment
homey bash-function added
homey-run bash-function added
homey-start bash-function added
homey-createApp bash-function added

Attention: Reload the bashrc-file (source ~/.bashrc) or restart the terminal-session
```

#### Step 2: Create Homey-App

```bash

```

#### Step 3: Start Homey-Dev docker-container

```bash
```

## Add-ons

### Remote (node.js) debuger

```js
app.js

// Set internal node environment variables
const NODE_ENV = process.env.NODE_ENV || "production";
const DEBUGER_PORT = process.env.DEBUGER_PORT || 9229;

// Start Node.js debugger
if (NODE_ENV !== "production") {
    require('inspector').open(DEBUGER_PORT, '0.0.0.0', true);
};
```

## Changelog

v0.1.0

* Initial release

## ToDo

* add homey-run build script
* add homey-run deploy script

## Copyright and license

Copyright 2018, 2018 cflat-inc.org under [MIT License](LICENSE)
