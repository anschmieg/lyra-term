# Lyra Terminal Initialization Script for POSIX Shells (bash, zsh)

# Ensure terminal is in a sane state
stty sane

export LYRA_TERM=1

# Minimal Prompt for Debugging
if [ -n "$ZSH_VERSION" ]; then
    export PROMPT="%F{green}Lyra>%f "
    export RPROMPT=""
fi

# Ensure PATH is correct
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin:$HOME/Library/Python/3.14/bin:$PATH"

alias lyra-on='export LYRA_INPUT_MODE="agent"; echo "Lyra Mode: ON"'
alias lyra-off='export LYRA_INPUT_MODE="off"; echo "Lyra Mode: OFF"'


