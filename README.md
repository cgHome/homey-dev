# homey-dev

Homey development environment

## Install

Create Homey-app:

```bash
mkdir [Homey-app]
cd [Homey-app]
git init --bare
```

Add homey-dev to your (exiting) project/app:

```bash
git subtree add --prefix homey-dev --squash git@github.com:cghome/homey-dev.git master
```

Update homey-dev to a never version:

```bash
git subtree pull --prefix homey-dev --squash git@github.com:cghome/homey-dev.git master
```

Start homey-dev:

```bash
homey-dev/start.sh && source ~/.bashrc
```

Test homey-dev:

```bash
homey ls -la
```

Example:

```bash
homey ls -la
```

For Developer:

```bash
# (Edit file)
git commit -am "[Message]"
git subtree split --prefix homey-dev --branch split
git push ${PWD}/homey-dev split:master
```

OR: Use vscode .....