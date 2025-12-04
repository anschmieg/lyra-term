# Lyra Terminal Initialization Script for POSIX Shells (bash, zsh)

export LYRA_TERM=1

# For Zsh
if [ -n "$ZSH_VERSION" ]; then
    # Save original prompt
    export LYRA_ORIG_PROMPT="$PROMPT"
    export LYRA_ORIG_RPROMPT="$RPROMPT"

    # Define a precmd to handle mode switching
    precmd() {
        if [ "$LYRA_INPUT_MODE" = "agent" ]; then
            # Agent Mode: Hide Cursor and Prompt
            printf "\033[?25l"
            PROMPT=""
            RPROMPT=""
        else
            # Interactive Mode: Show Cursor and Restore Prompt
            printf "\033[?25h"
            if [ -n "$LYRA_ORIG_PROMPT" ]; then
                PROMPT="$LYRA_ORIG_PROMPT"
                RPROMPT="$LYRA_ORIG_RPROMPT"
            else
                PROMPT="%F{green}Lyra>%f "
                RPROMPT=""
            fi
        fi
    }
fi

# Ensure PATH is correct
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin:$HOME/Library/Python/3.14/bin:$PATH"

alias lyra-on='export LYRA_INPUT_MODE="agent"; precmd; zle reset-prompt 2>/dev/null'
alias lyra-off='export LYRA_INPUT_MODE="off"; precmd; zle reset-prompt 2>/dev/null'


