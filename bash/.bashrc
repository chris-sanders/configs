export EDITOR=vim
export JUJU_REPOSITORY=$HOME/src/juju/charms
export LAYER_PATH=$JUJU_REPOSITORY/layers
export INTERFACE_PATH=$JUJU_REPOSITORY/interfaces

# Taskwarrior
alias tr='task ready +@work'
alias tc='task +@charming'
alias tl='task +@lab'
alias tw='task +@work'
alias in='task add +in'
tickle () {
    deadline=$1
    shift
    in +tickle wait:$deadline $@
}
alias tick=tickle
alias think='tickle +1d'

export PS1='$(task +in +PENDING count) '$PS1
