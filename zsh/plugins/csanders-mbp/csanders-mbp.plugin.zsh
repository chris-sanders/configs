# Install brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add go to path
export PATH=$PATH:/usr/local/go/bin

# Add zk (this is where it installs it)
export PATH=$PATH:/Users/chris/go/bin

# Add krew to the path
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
