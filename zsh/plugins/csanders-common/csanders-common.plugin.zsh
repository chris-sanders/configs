# Use nvim
alias vim=nvim
export EDITOR=nvim

# Color please
export CLICOLOR=1

# Prompt
export PROMPT='%F{green}%n:%F{blue}%~%f %% '
export PROMPT="╭$PROMPT
╰➤ "

# Disable auto title renaming in tmux
DISABLE_AUTO_TITLE=true

# Auto tmux
if [ -z "$TMUX" ]
then
    tmux new
fi
