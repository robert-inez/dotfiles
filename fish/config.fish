set fish_greeting ""
set fish_function_path $fish_function_path ~/.config/fish/functions
# set -gx TERM xterm-256color

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH $PATH ~/.cargo/bin

# NodeJS
set -gx PATH node_modules/.bin $PATH

# if not ssh-add -l | grep -q 'robertinez@Roberts-MacBook-Pro'
# 	eval (ssh-add)
# end

# Catppuccin Theme
# fish_config theme save "Catppuccin Mocha"

alias ls "eza -la --icons"
alias yss "yarn && yarn start:standalone"
alias ob "open /Applications/Obsidian.app"
alias yd "yarn && ELASTIC_APM_LOG_LEVEL=off yarn dev"
alias ibdr "cd ~/IB/git/cenari/darwin-root/ && API_URL=http://localhost:1234 ELASTIC_APM_LOG_LEVEL=off yarn dev"
alias gs "git status"
alias bump "npm version patch && git add package.json && git commit"
alias token "curl --request POST \
     --url 'https://crs1-dev.us.auth0.com/oauth/token' \
     --header 'content-type: application/x-www-form-urlencoded' \
     --data grant_type=client_credentials \
     --data client_id=oNjjI6L1Q0Q2WIzcNf5SZUOTSHOZFC2w \
     --data client_secret=yQRcPir878olmpe3Tos4IBBT9MR_MKEfIrzyZUz7YBLbZZGT2ZqM4CSjsAQofRnK \
     --data audience=https://crsone-api-dev | jq -r '.access_token' | pbcopy"
# --header 'content-type: application/json' \
# alias pbcopy wl-copy
alias pbcopy 'xclip -selection clipboard'
alias logdev "echo 'Tailing logs for crsone-server-dev stdout' && aws logs tail /aws/elasticbeanstalk/Crsone-server-env-env/var/log/web.stdout.log --follow --profile crsone-dev"
alias unit_test "NODE_ENV='unit_test' npm run test"
alias t tmux
alias ta "t a -t"
alias tls "t ls"
alias tn "t new-session -s"
alias linkway "ln -s /mnt/wslg/runtime-dir/wayland-0* /run/user/1000/"
alias update "sudo apt update && sudo apt upgrade"
alias killnvim "pkill -f nvim"
alias rinvim="reinstall_nvim"


starship init fish | source
direnv hook fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# set -gx GOPATH $HOME/go
# set -gx GOROOT $HOME/.go
# set -gx PATH $GOPATH/bin $PATH
# g-install: do NOT edit, see https://github.com/stefanmaric/g
