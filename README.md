# homey-dev

Homey (docker) development environment

## Reason

## Installation

```bash
$ wget -O - https://raw.githubusercontent.com/cgHome/homey-dev/master/install.sh | bash

Attention:
    Restart the current terminal-session or run: source ~/.bashrc
```

## Usage

```bash
Commands:
    homey <command>         Run a command inside homey-dev container
    homey-create            Create a new homey-app
    homey-init              Initialize homey-dev container
    homey-start             Start homey-dev container
    homey-run <npm-script>  Run npm-script
```

### Example

## Install npm-scripts

```json
package.json

"scripts": {
    "start":    "clear; athom app --run",
    "debug":    "NODE_ENV=debug && npm run start",
    "validate": "clear; athom app validate",
    "test":     "echo \"Error: no test specified\" && exit 1"
```

```js
    // Start Node.js debugger
    require('inspector').open(9229, '0.0.0.0', true);
```