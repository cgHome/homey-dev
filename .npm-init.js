const appJson = require('/app/app.json');

const GIT_URL = process.env.GIT_URL || 'https://github.com';
const GIT_USER = process.env.GIT_USERNAME || 'YOUR_GIT_USERNAME';

const gitRepo = GIT_URL + "/" + GIT_USER + "/" + appJson.id;

const data = {
    name: appJson.id,
    version: appJson.version,
    description: appJson.description.en,
    main: "app.js",
    scripts: {
        start: "clear; athom app --run",
        test: "set NODE_ENV=test && npm run start",
        validate: "clear; athom app validate",
        build: "echo \"Error: build not implemented yet\" && exit 1",
        deploy: "echo \"Error: deploy not implemented yet\" && exit 1"
    },
    keywords: ["Smart Home", "athom", "homey", "app", appJson.name],
    author: {
        name: appJson.author.name,
        email: appJson.author.email,
    },
    license: "GPLv3",
    repository: {
        type: "git",
        url: gitRepo + ".git"
    },
    bugs: {
        url: gitRepo + "/issues"
    },
    homepage: "https://apps.athom.com/app/" + appJson.id,
};

// package.json value
exports.name = package.name || data.name;
exports.version = data.version;
exports.description = package.description || data.description;
exports.main = package.main || data.main;
exports.scripts = Object.assign({}, package.scripts || {}, data.scripts);
exports.keywords = [ ...new Set([].concat(package.keywords || [], data.keywords))];
exports.author = data.author;
exports.license = package.license || data.license;         //** License-id not exist (use default) **
exports.repository = package.repository || data.repository;
exports.bugs = package.bugs || data.bugs;
exports.homepage = package.homepage || data.homepage;