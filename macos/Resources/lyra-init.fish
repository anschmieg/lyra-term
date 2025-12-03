# Lyra Terminal Initialization Script for Fish Shell

# 1. Hide Cursor (DECTCEM)
# We emit this immediately to ensure the cursor is hidden during startup
echo -ne "\e[?25l"

# 2. Set Environment Variable
set -gx LYRA_TERM 1

# 3. Hide Prompt
# We override the prompt functions to be empty.
# We use --on-event fish_prompt to try and override other handlers if possible,
# though standard function definition usually wins.
function fish_prompt --description 'Lyra hidden prompt'
    # Ensure cursor is hidden every time prompt is drawn
    echo -ne "\e[?25l"
end

function fish_right_prompt
    # Empty right prompt
end

function fish_mode_prompt
    # Empty mode prompt (vi mode)
end

# Disable Tide if it's loaded
set -g tide_prompt_transient_enabled false
set -g tide_left_prompt_items
set -g tide_right_prompt_items

# 4. AI Mode Aliases & State
if not set -q LYRA_INPUT_MODE
    set -gx LYRA_INPUT_MODE off
end

alias lyra-on="set -gx LYRA_INPUT_MODE agent; commandline -f repaint"
alias lyra-off="set -gx LYRA_INPUT_MODE off; commandline -f repaint"

