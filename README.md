# homey-dev

Homey development environment

## Reason

## Usage

1. Create Homey-app:

    ```sh
    mkdir [Homey-app]
    cd [Homey-app]
    git init --bare
    ```

2. Add homey-dev to your (exiting) project/app:

    ```sh
    git subtree add --prefix homey-dev --squash https://github.com/cghome/homey-dev.git master
    ```

3. Update homey-dev to a never version:

    ```sh
    git subtree pull --prefix homey-dev --squash https://github.com/cghome/homey-dev.git master
    ```

4. Start homey-dev:

    ```sh
    homey-dev/start.sh && source ~/.bashrc
    ```

5. Test homey-dev:

    ```sh
    homey ls -la
    ```

Example:

```sh
homey ls -la
```

For Developer:

```sh
# (Edit file)
git commit -am "[Message]"
git subtree split --prefix homey-dev --branch split
git push ${PWD}/homey-dev split:master
```

OR: Use vscode .....

