# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Setup gnome-keyring
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCKET
fi

export EDITOR=nvim
export JUJU_REPOSITORY=$HOME/src/juju/charms
export CHARM_LAYER_DIR=$JUJU_REPOSITORY/layers
export CHARM_INTERFACE_DIR=$JUJU_REPOSITORY/interfaces

# charm-create
export PATH=$PATH:~/src/charm-template

# Git remote bzr
#export PATH=$PATH:~/src/git-remote-bzr

# AppImage
export PATH=$PATH:~/AppImage

# Builds snaps in lxd
export SNAPCRAFT_BUILD_ENVIRONMENT=lxd

# Taskwarrior
alias tr='task ready +@work'
alias tc='task +@charming'
alias tl='task +@lab'
alias tw='task +@work'
alias in='task add +in'
alias taskl='task list limit:10 -meeting'
alias tl=taskl
alias td='task status:completed sort:end- limit:10 all'
# export PS1='$(task +in +PENDING count) '$PS1

# Multiline prompt
# Venv from https://stackoverflow.com/questions/10406926/how-do-i-change-the-default-virtualenv-prompt
function __virtualenv_ps1 {
    echo "${VIRTUAL_ENV:+(${VIRTUAL_ENV##*/})}"
}

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Line art from https://superuser.com/questions/218699/how-can-i-change-my-prompt-to-include-box-drawing-unicode-characters
# Vim unicode <ctl>-v, u+code
export PS1="╭$(__virtualenv_ps1)${PS1}
╰➤ "

# Use NeoVim
alias vim=nvim

# k8s default context:
unset KUBECONFIG
# [ -e ~/.kube/config ] && export KUBECONFIG=$HOME/.kube/config

# We put other contexts in ~/.kube/contexts
for c in $(IFS=$'\n' find ~/.kube/contexts -type f -name "*.yaml")
do
    export KUBECONFIG=$c:$KUBECONFIG
done

# Autostart tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux new
fi

# Juju debug-hooks that don't suck
function juju-dug-hooks {
    juju ssh "$unit" 'echo "export TERM=xterm-256color; stty sane; reset" | sudo tee -a /root/.bashrc >> ~/.bashrc'
    juju debug-hooks "$@"
}

# k8s-show-n
alias k8s-show-ns=" kubectl api-resources --verbs=list --namespaced -o name  | xargs -n 1 kubectl get --show-kind --ignore-not-found  -n"

# Sealed Secrets
export SEALED_SECRETS_CONTROLLER_NAMESPACE="sealed-secrets"

# added by pipx (https://github.com/pipxproject/pipx)
export PATH="/home/chris/.local/bin:$PATH"

# Add Go
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/home/chris/go/bin"

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

export PATH=$PATH:/home/chris/bin

source '/home/chris/lib/azure-cli/az.completion'

# export B2_ACCOUNT_ID="0016da816e60ede0000000004"
# export B2_ACCOUNT_KEY="K0015Wkib4AAuqrG/nA397MJch5eA8Y"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_PREVIEW_LINES=40
