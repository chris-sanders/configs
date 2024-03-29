# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/chris/.oh-my-zsh"

# Which plugins would you like to load?
plugins=(
	git
    git-prompt
    kubectl
    fzf
	csanders-common
	csanders-fzf
	csanders-k8s
	csanders-taskwarrior
	)

source $ZSH/oh-my-zsh.sh

# Automatically attach to tmux session, or create one if none exists
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  # Attempt to attach to existing session
  tmux attach -t default || tmux new -s default
fi

