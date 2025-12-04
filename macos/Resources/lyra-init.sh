# Lyra Terminal Initialization Script for POSIX Shells (bash, zsh)

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

    # Lyra Input Interception (DISABLED FOR DEBUGGING)
    # lyra-enter() {
    #     if [[ "$LYRA_INPUT_MODE" == "agent" ]]; then
    #         if [[ -z "$BUFFER" ]]; then
    #             zle .accept-line
    #             return
    #         fi
    #         echo
    #         if ! command -v lyra &> /dev/null; then
    #             echo "Error: 'lyra' command not found."
    #             BUFFER=""
    #             zle reset-prompt
    #             return
    #         fi
    #         lyra "$BUFFER"
    #         BUFFER=""
    #         zle reset-prompt
    #     else
    #         zle .accept-line
    #     fi
    # }
    # zle -N lyra-enter
    # bindkey "^M" lyra-enter
fi

# Ensure local bin and Python bin are in PATH for lyra command
export PATH="$HOME/.local/bin:$HOME/Library/Python/3.14/bin:$PATH"

# 4. AI Mode Aliases & State
export LYRA_INPUT_MODE="off"

alias lyra-on='export LYRA_INPUT_MODE="agent"; printf "\r"'
alias lyra-off='export LYRA_INPUT_MODE="off"; printf "\r"'

# 4. AI Mode Aliases & State
export LYRA_INPUT_MODE="off"

alias lyra-on='export LYRA_INPUT_MODE="agent"; printf "\r"'
alias lyra-off='export LYRA_INPUT_MODE="off"; printf "\r"'
