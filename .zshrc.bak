# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_THEME=""


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle :prompt:pure:git:branch color '#94e2d5'

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
#
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git jira colored-man-pages web-search colorize pip python brew macos keychain ssh-agent zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

## GIT ##

alias ga='git add'
alias gs='git status'
alias gcl='git clone'
alias gc='git commit -m'
alias gpl='git pull'
alias gps='git push'
alias gpsu='git push -u origin'
alias gd='git diff --color main..HEAD | less -RN'
alias gwa='git worktree add'
alias gws='cd $(git worktree list | grep -i)'
alias gwr='git worktree remove'
alias gwls='git worktree list'

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
alias yd='yarn && ELASTIC_APM_LOG_LEVEL=off yarn dev'
alias conyd='yarn && ELASTIC_APM_LOG_LEVEL=off NODE_ENV=local yarn dev'
alias yt='yarn test'
alias yss='yarn && yarn start:standalone'

## IB ##
alias gwiam='cd ~/IB/git/cenari/gw-apollo && IAM_URL=http://localhost:3334 ELASTIC_APM_LOG_LEVEL=off yarn dev'
alias gwfile='cd ~/IB/git/cenari/gw-apollo && IAM_URL=http://localhost:3334 ELASTIC_APM_LOG_LEVEL=off FILE_URL=http://localhost:9007 yarn dev'
alias gwfilecon='cd ~/IB/git/cenari/gw-apollo && IAM_URL=http://localhost:3334 ELASTIC_APM_LOG_LEVEL=off FILE_URL=http://localhost:9007 CONTINUITY_URL=http://localhost:4892 yarn dev'
alias gwfileres='cd ~/IB/git/cenari/gw-apollo && IAM_URL=http://localhost:3334 ELASTIC_APM_LOG_LEVEL=off FILE_URL=http://localhost:9007 RESOURCE_URL=http://localhost:9010 yarn dev'
alias gwcon='cd ~/IB/git/cenari/gw-apollo && yarn && IAM_URL=http://localhost:3334 CONTINUITY_URL=http://localhost:4892 ELASTIC_APM_LOG_LEVEL=off yarn dev'
alias gwplan='cd ~/IB/git/cenari/gw-apollo && yarn && IAM_URL=http://localhost:3334 CONTINUITY_URL=http://localhost:4892 PLAN_URL=http://localhost:6969 ELASTIC_APM_LOG_LEVEL=off yarn dev'
alias gwintel='cd ~/IB/git/cenari/gw-apollo && yarn && IAM_URL=http://localhost:3334 CONTINUITY_URL=http://localhost:4892 INTELLIGENCE_URL=http://localhost:9101 ELASTIC_APM_LOG_LEVEL=off yarn dev'
alias ibdr='cd ~/IB/git/cenari/darwin-root/ && API_URL=http://localhost:1234 ELASTIC_APM_LOG_LEVEL=off yarn dev'
alias iam='cd ~/IB/git/cenari/msvc-iam/'
alias mfepep='cd ~/IB/git/cenari/mfe-people-react/'
alias mfecomp='cd ~/IB/git/cenari/mfe-components/'
alias conmfe='cd ~/IB/git/cenari/mfe-continuity-react'
alias conmsvc='cd ~/IB/git/cenari/msvc-continuity'
alias sterniam="stern -n evolve-dev msvc-iam 'kube-probe' -e elastic-apm-node"
alias sterncon="stern -n evolve-dev msvc-continuity 'kube-probe' -e elastic-apm-node" 
alias sternint="stern -n evolve-dev msvc-intelligence 'kube-probe' -e elastic-apm-node" 
alias sternfile="stern -n evolve-dev msvc-file 'kube-probe' -e elastic-apm-node" 
alias sternplan="stern -n evolve-dev msvc-plan 'kube-probe' -e elastic-apm-node" 
alias sternsend="stern -n evolve-dev msvc-sendigo 'kube-probe' -e elastic-apm-node" 
alias sternplanstage="stern -n evolve-staging msvc-plan 'kube-probe' -e elastic-apm-node" 
alias ibtun='kubectl -n evolve-dev port-forward rds-port-forward-postgres-5432 4444:5432'
alias ibtun2='kubectl -n dev-pulsar port-forward svc/dev-pulsar-proxy 6650:6650'
alias ibtun3='kubectl -n evolve-dev port-forward nep-port-forward-dev 8182:8182'
alias gremstart='~/IB/git/gremlin-server/bin/gremlin-server.sh start'
alias gremstop='~/IB/git/gremlin-server/bin/gremlin-server.sh stop'
alias gremlogs='cat ~/IB/git/gremlin-server/logs/gremlin.log'
alias gremcon='~/IB/git/gremlin-console/bin/gremlin.sh'

## KITTY ##

alias kt-msvc='kitty --session ~/.config/kitty/msvc.conf'

## Kubernetes ##

alias k='kubectl'
alias kget='kubectl -n evolve-dev get pods'
alias kdesc='kubectl -n evolve-dev describe pod'

## MISC ##

alias c.='code .'
alias rmf='rm -rf'
alias pgs='pg_ctl -D /usr/local/var/postgres start'
alias de='direnv allow'
alias lw='xattr -d com.apple.quarantine /Applications/LibreWolf.app'
alias c='clear'
alias bump='npm version patch && git add package.json && git commit'
alias utils='yarn add @infiniteblue/msvc-utils@latest'
alias ob='open /Applications/Obsidian.app'
alias ls='exa -la --icons'
alias src='exec zsh'
alias google='web_search google'
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='nvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH=/Users/robertinez/.local/bin:$PATH

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
eval "$(pyenv init --path)"
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure
# eval "$(starship init zsh)"
