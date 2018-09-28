# homey-dev

Homey (docker) development environment

## Reason

## Usage

1. Clone Homey-app:

    ```sh
    git clone https://github.com/cgHome/homey-app.git
    ```

2. Add homey-dev to .gitignore:

    ```json
    # homey-dev
    homey-dev
    ```

3. Add homey-dev to your project/app:

    ```sh
    git subtree add --prefix homey-dev --squash https://github.com/cghome/homey-dev.git master
    ```

4. Update homey-dev to a never version:

    ```sh
    git subtree pull --prefix homey-dev --squash https://github.com/cghome/homey-dev.git master
    ```

5. Start homey-dev:

    ```sh
    homey-dev/start.sh && source ~/.bashrc
    ```

6. Test homey-dev:

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

