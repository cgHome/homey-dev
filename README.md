# homey-dev

Homey development environment

## Install

Create Project:

```bash
mkdir [homey-app]
cd [homey-app]
git init
touch README.md
git add README.md
git remote add origin [repo-url]
git remote -v
```

Add homey-dev:

```bash
git subtree add --prefix homey-dev https://github.com/cghome/homey-dev.git master --squash
```

Update homey-dev:

```bash
git subtree pull --prefix homey-dev https://github.com/cghome/homey-dev.git master --squash
```
