# Install brew
eval "$(/opt/homebrew/bin/brew shellenv)"

add_to_path_once() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

# Add go to path
add_to_path_once "/usr/local/go/bin"

# Add zk (this is where it installs it)
add_to_path_once "Users/chris/go/bin"

# Add krew to the path
add_to_path_once "$HOME/.krew/bin"
