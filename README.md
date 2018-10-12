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
    homey <command>         Run a bash command inside homey-dev container
    homey-run <npm-script>  Run npm-script inside homey-dev container
    homey-create            Create a new homey-app 
    homey-init              Initialize a new homey-dev container
    homey-start             Start homey-dev container
```

### Example

```bash
```

## Addon's

### Homey-run (npm) scripts

```json
package.json

"scripts": {
    "start":    "clear; athom app --run",
    "test":     "set NODE_ENV=test && npm run start",
    "validate": "clear; athom app validate"
};
```

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