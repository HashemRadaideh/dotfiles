# Zsh

<!-- START doctoc generated TOC please keep comment here to allow auto update -->

<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Startup Files](#startup-files)
- [Load Order](#load-order)
- [Practical Rules](#practical-rules)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Startup Files

| File | When it runs | Purpose | Sourced |
| :---: | :---: | :---: | :---: |
| .zshenv | Every zsh | Environment variables | in scripts invocation and non-interactive shells |
| .zprofile | Login shells only | runs before .zshrc. Equivalent to bash's .bash_profile | Login-time setup |
| .zshrc | Interactive shells | aliases, functions, prompt, plugins and completions | every interactive invocation |
| .zlogin | Login shells only | intended for commands that need the full env ready | Runs after .zshrc. Rarely used |
| .zlogout | Login shell exit | Cleanup (clear screen, kill agents, etc.) | at logout |

## Load Order

Login + Interactive: .zshenv → .zprofile → .zshrc → .zlogin
Login + Non-interactive: .zshenv → .zprofile → .zlogin
Interactive only: .zshenv → .zshrc
Script (non-interactive): .zshenv only

## Practical Rules

- .zshenv — exported env vars that scripts need. Keep it minimal and fast; it runs on every zsh call
  including scripts.
- .zshrc — everything interactive: aliases, functions, prompt, nvm/pyenv init, completions.
- .zprofile — things that should run once at login, like eval "$(brew shellenv)".
- .zlogin — almost never needed; .zprofile covers the login use case.
- .zlogout — optional cleanup. Most people don't use it.
