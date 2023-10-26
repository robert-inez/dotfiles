set fish_greeting ""

# Load custom configuration files from the conf.d directory
# for file in ~/.config/fish/conf.d/*.fish
#     source $file
# end

# If not already authenticated to my ssh key ask for password.
if not ssh-add -l | grep -q 'robertinez@Roberts-MacBook-Pro'
	eval (ssh-add)
end

alias ls "exa -la --icons"
alias yss "yarn && yarn start:standalone"
alias ob "open /Applications/Obsidian.app"
alias yd "yarn && ELASTIC_APM_LOG_LEVEL=off yarn dev"
alias ibdr "cd ~/IB/git/cenari/darwin-root/ && API_URL=http://localhost:1234 ELASTIC_APM_LOG_LEVEL=off yarn dev"
alias gs "git status"
alias bump "npm version patch && git add package.json && git commit"
alias sterncon "stern -n evolve-dev msvc-continuity 'kube-probe' -e elastic-apm-node"
alias pulsarrestart 'docker compose rm -sv pulsar-local -f && docker rmi cenari-local-pulsar-local && docker volume rm cenari-local_pulsarconf && docker volume rm cenari-local_pulsardata && docker compose up -d pulsar-local'
alias yarn-link-base "rm -rf node_modules yarn.lock ; yarn && yarn build && yarn link"
alias yarn-link-recip "yarn unlink @infiniteblue/msvc-utils ; rm -rf node_modules yarn.lock ; yarn link && yarn install"


starship init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end
