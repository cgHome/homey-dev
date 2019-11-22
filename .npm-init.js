const appJson = require(dirname + '/app.json');

// Create a dummy-url
let repoUrl = "https://github.com/cgHome/homey-dev.git";
try {
    repoUrl = require('child_process').execSync('git ls-remote --get-url').toString();
}
catch (e) {}

const data = {
    name: appJson.id,
    version: appJson.version,
    description: appJson.description.en,
    main: "app.js",
    scripts: {
        "info": "npm run -s _homeyRun -- info && exit; printf \"[Homey-App] \t $npm_package_name \n Version: \t v$npm_package_version \n Description: \t $npm_package_description \n Host: \t\t ${HOSTNAME} \n\nEnvironment variables:\n\n \" ",
        "test": "npm run -s _homeyRun -- test && exit; homey app run",
        "setup": "npm run -s _homeyRun -- setup && exit; homey app install",
        "build": "npm run -s _homeyRun -- build && exit; homey app build && npm run init:app",
        "deploy:patch": "npm run -s _homeyRun -- deploy:patch && exit; npm run _dbuild -- patch && npm run _release && homey app publish",
        "deploy:minor": "npm run -s _homeyRun -- deploy:minor && exit; npm run _dbuild -- minor && npm run _release && homey app publish",
        "deploy:major": "npm run -s _homeyRun -- deploy:major && exit; npm run _dbuild -- major && npm run _release && homey app publish",
        "init:app": "npm run -s _homeyRun -- init:app && exit; npm init --quiet -y 1>/dev/null",
        "createRepo": "npm run -s _homeyRun -- createRepo && exit; hub create -d \"$npm_package_description\" -h $npm_package_homepage $npm_package_name && npm run init:app",
        "_homeyRun": "source ~/.bashrc && [[ \"$(type -t homey-run)\" = function ]] && homey-run -s",
        "_release": "git checkout master && git pull && git tag v$npm_package_version && git push origin v$npm_package_version",
        "_dbuild": "func() { homey app version $1 && npm run init:app && npm run __dbuild && git push origin master; }; func",
        "__dbuild": "git commit -am v$npm_package_version"
    },
    keywords: ["Smart Home", "athom", "homey", "app", appJson.name],
    author: {
        name: appJson.author.name,
        email: appJson.author.email,
    },
    license: "GPL-3.0",
    homepage: "https://homey.app/a/" + appJson.id,
};

// package.json value
exports.name = package.name || data.name;
exports.version = data.version;
exports.description = package.description || data.description;
exports.main = package.main || data.main;
exports.scripts = Object.assign({}, package.scripts || {}, data.scripts);
exports.keywords = [...new Set([].concat(package.keywords || [], data.keywords))];
exports.author = data.author;
exports.license = package.license || data.license;         //** License-id not exist (use default) **
exports.repository = repoUrl;
exports.bugs = repoUrl.replace('.git\n','/issues');
exports.homepage = package.homepage || data.homepage;
