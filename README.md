# ExtraBrainCLI

A CLI for extrabrain that you can use in your termnial.

## Install using homebrew

```bash
$ brew tap standout/formulae
$ brew install extrabrain
```

## Build a release for your machine

```bash
$ swift build -c release
```

It will print a path for the `eb` binary, copy that file to some place that is included in your `$PATH`.

## Login

The CLI expects that you have an account for extrabrain. Run `eb login` to login using your account. Credentials will be stored in Apples keychain and you will probably be asked for your next command if you allow the app to use the credentials.

## Run tests

```bash
$ swift test
```
