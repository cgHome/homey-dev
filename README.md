# homey-dev

Homey (docker) development environment

## Reason

## Usage

1. Clone Homey-app:

    ```sh
    git clone https://github.com/cgHome/homey-app.git
    ```

2. Add homey-dev to your project/app:

    ```sh
    git submodule add https://github.com/cghome/homey-dev.git homey-dev
    ```

3. Update homey-dev to a never version:

    ```sh
    git submodule update homey-dev
    ```

4. Init/Start homey-dev:

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

