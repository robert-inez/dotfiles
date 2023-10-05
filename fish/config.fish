set fish_greeting ""

# set -gx TERM xterm-256color

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

if not ssh-add -l | grep -q 'robertinez@Roberts-MacBook-Pro'
	eval (ssh-add)
end

# Catppuccin Theme
# fish_config theme save "Catppuccin Mocha"

alias ls "exa -la --icons"
alias yss "yarn && yarn start:standalone"
alias ob "open /Applications/Obsidian.app"
alias yd "yarn && ELASTIC_APM_LOG_LEVEL=off yarn dev"
alias ibdr "cd ~/IB/git/cenari/darwin-root/ && API_URL=http://localhost:1234 ELASTIC_APM_LOG_LEVEL=off yarn dev"
alias gs "git status"
alias bump "npm version patch && git add package.json && git commit"


starship init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end
