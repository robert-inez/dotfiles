set fish_greeting ""

# set -gx TERM xterm-256color

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions

# NodeJS
set -gx PATH node_modules/.bin $PATH

if not ssh-add -l | grep -q 'robertinez@Roberts-MacBook-Pro'
	eval (ssh-add)
end

# Catppuccin Theme
# fish_config theme save "Catppuccin Mocha"
# fish_config theme save "Rosé Pine"

alias ls "exa -la --icons"
alias yss "yarn && yarn start:standalone"
alias ob "open /Applications/Obsidian.app"
alias yd "yarn && ELASTIC_APM_LOG_LEVEL=off yarn dev"
alias ibdr "cd ~/IB/git/cenari/darwin-root/ && API_URL=http://localhost:1234 ELASTIC_APM_LOG_LEVEL=off yarn dev"
alias gs "git status"
alias bump "npm version patch && git add package.json && git commit"
alias sterncon "stern -n evolve-dev msvc-continuity 'kube-probe' -e elastic-apm-node"
alias pulsarrestart 'docker compose rm -sv pulsar-local -f && docker rmi cenari-local-pulsar-local && docker volume rm cenari-local_pulsarconf && docker volume rm cenari-local_pulsardata && docker compose up -d pulsar-local'


starship init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end
