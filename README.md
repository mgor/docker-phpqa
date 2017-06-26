# docker-phpqa

Docker image containing all the tools needed for the vim plugin `vim-phpqa`.

Packages installed:

* `php-cli`
* `phpmd`
* `php-codesniffer`

Needed executables:

* `php`
* `phpcs`
* `phpmd`

I'm using it the following way:

`~/.bash_aliases`:

```bash
shopt -s expand_aliases

run_in_docker() {
    local executable="${FUNCNAME[1]#_}"
    local name="${1}"
    shift

    docker run -it -d --name "${name}" -h "${name}" -v "${HOME}:${HOME}" "mgor/${name}" /bin/bash &> /dev/null || true

    docker exec -i "${name}" "${executable}" "$@"
}

_php() {
    run_in_docker phpqa "$@"
}

_phpcs() {
    run_in_docker phpqa "$@"
}

_phpmd() {
    run_in_docker phpqa "$@"
}

alias phpcs=_phpcs
alias phpmd=_phpmd
```

`~/.bashrc`:
```bash
[[ -e "$HOME/.bash_aliases" ]] && . "$HOME/.bash_aliases"
[[ "${PATH}" == *"${HOME}/.local/bin"* ]] || export PATH=$PATH:$HOME/.local/bin
```

`~/.local/bin/php` (did not find a good way for vim to recognize aliases as executables):
```bash
#!/usr/bin/env bash

_php "${@}"
```

`.vimrc` (or where ever you have your vim configuration):
```
let $BASH_ENV = "~/.bashrc"
```

Install [joonty/vim-phpqa](https://github.com/joonty/vim-phpqa) and you're ready to rock n' roll!

Before starting vim the first time, it might be a good idea to pull the docker image:

```bash
docker pull mgor/phpqa
```
