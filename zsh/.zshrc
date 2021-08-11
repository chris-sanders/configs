# Add go to path
export PATH=$PATH:/usr/local/go/bin

# Add zk (this is where it installs it)
export PATH=$PATH:/Users/chris/go/bin

# Use nvim
alias vim=nvim
export EDITOR=nvim

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Color please
export CLICOLOR=1

# Prompt
export PROMPT='%F{green}%n:%F{blue}%~%f %% '
export PROMPT="╭$PROMPT
╰➤ "

# Auto tmux
if [ -z "$TMUX" ]
then
    tmux new
fi

# Let's put kubectl config in the config folder
KUBEFOLDER=~/.config/kube
export KUBECONFIG=$KUBEFOLDER/config
# Load contexts from individual files
function set-kubeconfig {
  # Does NOT overwrite KUBECONFIG if the KUBECONFIG_MANUAL env var is set
  if [ -d $KUBEFOLDER/contexts ]; then
    if [ -z "$KUBECONFIG_MANUAL" ]; then
      export KUBECONFIG=$KUBEFOLDER/config$(find $KUBEFOLDER/contexts -type f 2>/dev/null | xargs -I % echo -n ":%")
    fi
  fi
}

set-kubeconfig
