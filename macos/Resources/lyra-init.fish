# Lyra Terminal Initialization Script for Fish Shell

# 2. Set Environment Variable
set -gx LYRA_TERM 1

# 3. Dynamic Prompt & Cursor
function fish_prompt
    if test "$LYRA_INPUT_MODE" = "agent"
        # Agent Mode: Hide Cursor and Prompt
        printf "\e[?25l"
        # We output nothing for the prompt
    else
        # Interactive Mode: Show Cursor and Prompt
        printf "\e[?25h"
        set_color green
        printf "Lyra-Fish> "
        set_color normal
    end
end

function fish_right_prompt
    if test "$LYRA_INPUT_MODE" = "agent"
        # Hide right prompt
    end
end

# 4. AI Mode Aliases & State
if not set -q LYRA_INPUT_MODE
    set -gx LYRA_INPUT_MODE off
end

alias lyra-on="set -gx LYRA_INPUT_MODE agent; commandline -f repaint"
alias lyra-off="set -gx LYRA_INPUT_MODE off; commandline -f repaint"

