# Lyra Terminal Initialization Script for POSIX Shells (bash, zsh)

# 1. Hide Cursor (DECTCEM)
printf "\033[?25l"

# 2. Set Environment Variable
export LYRA_TERM=1

# 3. Hide Prompt
# For Bash
if [ -n "$BASH_VERSION" ]; then
    export PS1=""
    export PROMPT_COMMAND="printf '\033[?25l'" # Ensure cursor stays hidden
fi

# For Zsh
if [ -n "$ZSH_VERSION" ]; then
    export PROMPT=""
    export RPROMPT=""
    precmd() {
        printf "\033[?25l"
    }
fi

# 4. AI Mode Aliases & State
export LYRA_INPUT_MODE="off"

alias lyra-on='export LYRA_INPUT_MODE="agent"; printf "\r"'
alias lyra-off='export LYRA_INPUT_MODE="off"; printf "\r"'
