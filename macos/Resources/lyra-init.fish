# Lyra Terminal Initialization Script for Fish Shell

# 2. Set Environment Variable
set -gx LYRA_TERM 1

# 3. Minimal Prompt for Debugging
function fish_prompt
    set_color green
    printf "Lyra-Fish> "
    set_color normal
end

# 4. AI Mode Aliases & State
if not set -q LYRA_INPUT_MODE
    set -gx LYRA_INPUT_MODE off
end

alias lyra-on="set -gx LYRA_INPUT_MODE agent; echo 'Lyra Mode: ON'"
alias lyra-off="set -gx LYRA_INPUT_MODE off; echo 'Lyra Mode: OFF'"

