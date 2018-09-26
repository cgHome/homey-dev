const pathTo = require('path').join.bind(null, process.cwd());
module.exports = {
    scripts: {
        default: 'echo "This runs on `nps`"', // nps
        // you can assign a script property to a string
        npsScript: 'echo "this is easy"', // nps simple
        // you can specify whether some scripts should be excluded from the help list
        hidden: {
            script: 'debugging script',
            hiddenFromHelp: true,
        },
    },
}