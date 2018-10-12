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
    homey-run <npm-script>  Run npm-script inside homey-dev container
    homey-create            Create a new homey-app 
    homey-init              Initialize a new homey-dev container
    homey-start             Start homey-dev container
```

### Example

## Install npm-scripts

```json
package.json

"scripts": {
    "start":    "clear; athom app --run",
    "test":    "NODE_ENV=test && npm run start",
    "validate": "clear; athom app validate"
};
```

```js
app.js

// Set internal NODE_ENV variable
const NODE_ENV = process.env.NODE_ENV || "production";
// Start Node.js debugger
if (NODE_ENV !== "production") {
    require('inspector').open(9229, '0.0.0.0', true);
};
```