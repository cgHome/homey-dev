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
        "info": "npm run -s _homeyRun -- info || printf \"[Homey-App] \t $npm_package_name \n Version: \t v$npm_package_version \n Description: \t $npm_package_description \n Host: \t\t ${HOSTNAME} \n\nEnvironment variables:\n\n \" ",
        "test": "npm run -s _homeyRun -- test || athom app run",
        "install": "npm run -s _homeyRun -- install || athom app install",
        "deploy:patch": "npm run -s _homeyRun -- deploy:patch || npm run vbuild -- patch && npm run deploy",
        "deploy:minor": "npm run -s _homeyRun -- deploy:minor || npm run vbuild -- minor && npm run deploy",
        "deploy:major": "npm run -s _homeyRun -- deploy:major || npm run vbuild -- major && npm run deploy",
        "deploy": "npm run -s _homeyRun -- deploy || npm run release && athom app publish",
        "release": "npm run -s _homeyRun -- release || git checkout master && git pull && git tag v$npm_package_version && git push origin v$npm_package_version",
        "init:app": "npm run -s _homeyRun -- init:app || npm init --quiet -y 1>/dev/null",
        "createRepo": "npm run -s _homeyRun -- createRepo || hub create -d \"$npm_package_description\" -h $npm_package_homepage $npm_package_name && npm run init:app",
        "build": "npm run -s _homeyRun -- build || athom app build && npm run init:app",
        "vbuild": "npm run -s _homeyRun -- vbuild || athom app version",
        "postvbuild": "npm run init:app && npm run _postvbuild && git push origin master",
        "_postvbuild": "git commit -am v$npm_package_version",
        "_homeyRun": "homeyRun() { source ~/.bashrc && [[ \"$(type -t homey-run)\" = function ]] && homey-run -s $1 && exit 0; }; homeyRun"
    },
    keywords: ["Smart Home", "athom", "homey", "app", appJson.name],
    author: {
        name: appJson.author.name,
        email: appJson.author.email,
    },
    license: "GPL-3.0",
    homepage: "https://apps.athom.com/app/" + appJson.id,
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
