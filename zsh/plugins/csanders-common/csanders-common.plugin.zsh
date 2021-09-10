# Use nvim
alias vim=nvim
export EDITOR=nvim

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
