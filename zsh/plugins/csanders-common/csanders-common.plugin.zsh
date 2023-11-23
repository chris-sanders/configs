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
#if [ -z "$TMUX" ]
#then
#    tmux new
#fi

# Automatically attach to tmux session, or create one if none exists
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux new-session -A -s default
  exit
fi

# Use aliases with watch
alias watch="watch "
