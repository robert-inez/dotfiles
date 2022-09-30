if status is-interactive
    # Commands to run in interactive sessions can go here

  # Color Scheme

  # TokyoNight Color Palette
  set -l foreground c0caf5
  set -l selection 33467c
  set -l comment 565f89
  set -l red f7768e
  set -l orange ff9e64
  set -l yellow e0af68
  set -l green 9ece6a
  set -l purple 9d7cd8
  set -l cyan 7dcfff
  set -l pink bb9af7

  # Syntax Highlighting Colors
  set -g fish_color_normal $foreground
  set -g fish_color_command $cyan
  set -g fish_color_keyword $pink
  set -g fish_color_quote $yellow
  set -g fish_color_redirection $foreground
  set -g fish_color_end $orange
  set -g fish_color_error $red
  set -g fish_color_param $purple
  set -g fish_color_comment $comment
  set -g fish_color_selection --background=$selection
  set -g fish_color_search_match --background=$selection
  set -g fish_color_operator $green
  set -g fish_color_escape $pink
  set -g fish_color_autosuggestion $comment

  # Completion Pager Colors
  set -g fish_pager_color_progress $comment
  set -g fish_pager_color_prefix $cyan
  set -g fish_pager_color_completion $foreground
  set -g fish_pager_color_description $comment
  set -g fish_pager_color_selected_background --background=$selection
  

## GIT ##

alias ga='git add'
alias gs='git status'
alias gcl='git clone'
alias gc='git commit -m'
alias gpl='git pull'
alias gps='git push'
alias gd='git diff --color main..HEAD | less -RN'

## NODE ##

alias ns='npm start'
alias ni='npm install'
alias naf='npm audit fix'
alias nu='npm update'
alias nrd='npm run dev'
alias nt='npm test'
alias nb='npm version patch -m "Bumping version"'

## YARN ##

alias ys='yarn start'
alias yi='yarn'
alias yd='yarn && yarn dev'
alias conyd='NODE_ENV=local yarn dev'
alias yt='yarn test'
alias yss='yarn && yarn start:standalone'

## IB ##
alias gwiam='cd ~/IB/git/evolve/Darwin/Foundation/gw-apollo && IAM_URL=http://localhost:3334 yarn dev'
alias gwcon='cd ~/IB/git/evolve/Darwin/Foundation/gw-apollo && yarn && IAM_URL=http://localhost:3334 CONTINUITY_URL=http://localhost:4892 yarn dev'
alias ibdr='cd ~/IB/git/evolve/Darwin/Foundation/darwin-root/ && API_URL=http://localhost:1234 yarn dev'
alias iam='cd ~/IB/git/evolve/Darwin/Foundation/msvc-iam/'
alias mfepep='cd ~/IB/git/evolve/Darwin/Foundation/mfe-people-react/'
alias mfecomp='cd ~/IB/git/evolve/Darwin/Foundation/mfe-components/'
alias conmfe='cd ~/IB/git/evolve/Darwin/Continuity/mfe-continuity-react'
alias conmsvc='cd ~/IB/git/evolve/Darwin/Continuity/msvc-continuity'
alias sterniam="stern --kubeconfig ~/ib-dev-c1.yaml -n evolve-dev msvc-iam -e 'kube-probe' --color auto"
alias sterncon="stern --kubeconfig ~/ib-dev-c1.yaml -n evolve-dev msvc-continuity -e 'kube-probe'" 
alias ibtun='kubectl -n evolve-dev port-forward rds-port-forward-postgres-5432 4444:5432'
alias ibtun2='kubectl -n dev-pulsar port-forward svc/dev-pulsar-proxy 6650:6650'

## KITTY ##

alias kt-msvc='kitty --session ~/.config/kitty/msvc.conf'


## MISC ##

alias c.='code .'
alias rmf='rm -rf'
alias pgs='pg_ctl -D /usr/local/var/postgres start'
alias de='direnv allow'
alias lw='xattr -d com.apple.quarantine /Applications/LibreWolf.app'
alias vim='nvim'
alias c='clear'
alias bump='npm version patch && git add package.json && git commit'
alias ob='open /Applications/Obsidian.app'
# export MANPATH="/usr/local/man:$MANPATH"

eval "$(/opt/homebrew/bin/brew shellenv)"

function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
pyenv init - | source

end
# starship init fish | source
