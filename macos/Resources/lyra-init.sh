# Lyra Terminal Initialization Script for POSIX Shells (bash, zsh)

# 1. Hide Cursor (DECTCEM)
printf "\033[?25l"

# 2. Set Environment Variable
export LYRA_TERM=1

# 3. Hide Prompt & Style
# For Bash
if [ -n "$BASH_VERSION" ]; then
    # Set PS1 to include hidden cursor + green marker
    export PS1="\[\033[?25l\]\[\033[32m\]❯ \[\033[0m\]"
    # Ensure cursor stays hidden
    export PROMPT_COMMAND="printf '\033[?25l'" 
fi

# For Zsh
if [ -n "$ZSH_VERSION" ]; then
    # Set PROMPT to include hidden cursor + green marker
    export PROMPT="%{\033[?25l%}%F{green}❯ %f"
    export RPROMPT=""
    precmd() {
        printf "\033[?25l"
    }

    # Lyra Input Interception
    lyra-enter() {
        # Debug print (remove later)
        # echo "DEBUG: Mode is $LYRA_INPUT_MODE"
        
        if [[ "$LYRA_INPUT_MODE" == "agent" ]]; then
            # If buffer is empty, just accept line (newline)
            if [[ -z "$BUFFER" ]]; then
                zle .accept-line
                return
            fi
            
            # Run lyra command
            # We print a newline first to separate from prompt
            echo
            
            # Check if lyra command exists
            if ! command -v lyra &> /dev/null; then
                echo "Error: 'lyra' command not found. Please ensure it is in your PATH."
                echo "Current PATH: $PATH"
                BUFFER=""
                zle reset-prompt
                return
            fi

            lyra "$BUFFER"
            
            # Clear buffer and redraw prompt
            BUFFER=""
            zle reset-prompt
        else
            zle .accept-line
        fi
    }
    
    zle -N lyra-enter
    bindkey "^M" lyra-enter
fi

# Ensure local bin and Python bin are in PATH for lyra command
export PATH="$HOME/.local/bin:$HOME/Library/Python/3.14/bin:$PATH"

# 4. AI Mode Aliases & State
export LYRA_INPUT_MODE="off"

alias lyra-on='export LYRA_INPUT_MODE="agent"; printf "\r"'
alias lyra-off='export LYRA_INPUT_MODE="off"; printf "\r"'
