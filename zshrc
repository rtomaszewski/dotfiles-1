bindkey -e

#########################
# Zgen plugin manager
#########################
source "${HOME}/.zgen/zgen.zsh"
# if the init scipt doesn't exist
if ! zgen saved; then
  # specify plugins here
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/gitfast
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-completions src
  zgen oh-my-zsh plugins/rvm
  zgen oh-my-zsh plugins/tmux
  zgen oh-my-zsh plugins/docker
  zgen oh-my-zsh plugins/colored-man-pages

  # Theme
  zgen oh-my-zsh themes/arrow

  # generate the init script from plugins above
  zgen save
fi


#########################
# visual command edit
#########################
export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
# core configuration
CASE_SENSITIVE="true"

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"


#
# Plugins configuration
#
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=false
ZSH_TMUX_ITERM2=false
ZSH_TMUX_AUTOQUIT=false


# Store device specific settings like DEFAULT_USER
source ~/.zshrc.local

# Key mappings
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

# RVM
if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi
export PATH="$HOME/.bin:$PATH:$HOME/.rvm/bin"

# Shared tmux widnow
alias irc='tmux new-session -s shared "tmux new-window -n irc weechat"'
alias ag='ag --color-path "1;36"'

# Netsec aliases
alias ns-cli="~/devel/nscli/ns_cli.py"
alias nscli="~/devel/nscli/ns_cli.py"

PERL_MB_OPT="--install_base \"/Users/marek.skrobacki/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/marek.skrobacki/perl5"; export PERL_MM_OPT;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'
alias weather="curl -4 http://wttr.in/London"
alias t="task"

