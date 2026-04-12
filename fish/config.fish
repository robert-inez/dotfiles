set fish_greeting ""
set fish_function_path $fish_function_path ~/.config/fish/functions

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH $PATH ~/.cargo/bin
fish_add_path $HOME/go/bin
fish_add_path ~/.local/share/bob/nvim-bin

alias ls "eza -la --icons"
alias gs "git status"
alias token "curl --request POST \
     --url 'https://crs1-dev.us.auth0.com/oauth/token' \
     --header 'content-type: application/x-www-form-urlencoded' \
     --data grant_type=client_credentials \
     --data client_id=oNjjI6L1Q0Q2WIzcNf5SZUOTSHOZFC2w \
     --data client_secret=yQRcPir878olmpe3Tos4IBBT9MR_MKEfIrzyZUz7YBLbZZGT2ZqM4CSjsAQofRnK \
     --data audience=https://crsone-api-dev | jq -r '.access_token' | pbcopy"
alias pbcopy 'xclip -selection clipboard'
alias t tmux
alias ta "t a -t"
alias tls "t ls"
alias tn "t new-session -s"
alias linkway "ln -s /mnt/wslg/runtime-dir/wayland-0* /run/user/1000/"
alias update "sudo apt update && sudo apt upgrade && sudo snap refresh"
alias killnvim "pkill -f nvim"
alias rinvim="reinstall_nvim"
alias ssh_crs360_qat="ssh -i ~/.ssh/crs1-qa.pem -L 5434:crs360-qat-db-cluster.cluster-crm8jbucghf1.us-east-1.rds.amazonaws.com:5432 ec2-user@3.94.160.94"
alias ssh_crsone_qat="ssh -i ~/.ssh/crs1-qa.pem -L 5434:crs-one-qat-db-cluster.cluster-crm8jbucghf1.us-east-1.rds.amazonaws.com:5432 ec2-user@3.94.160.94"
alias ssh_crs360_uat="ssh -i ~/.ssh/crs1-uat.pem -L 5434:crs360-uat-db-cluster.cluster-cgq1dzkiyvf1.us-east-1.rds.amazonaws.com:5432 ec2-user@34.206.54.61"
alias ssh_crsone_uat="ssh -i ~/.ssh/crs1-uat.pem -L 5434:crs-one-uat-db-cluster.cluster-cgq1dzkiyvf1.us-east-1.rds.amazonaws.com:5432 ec2-user@34.206.54.61"


starship init fish | source
direnv hook fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end
