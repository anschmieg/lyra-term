# Lyra Terminal Initialization Script for Fish Shell

# 1. Hide Cursor (DECTCEM)
# We emit this immediately to ensure the cursor is hidden during startup
printf "\e[?25l"

# 2. Set Environment Variable
set -gx LYRA_TERM 1

# 3. Hide Prompt & Style
# We override the prompt functions to be minimal but visible for history
function fish_prompt --description 'Lyra minimal prompt'
    # Ensure cursor is hidden every time prompt is drawn
    printf "\e[?25l"
    # Print the prompt marker in a subtle color (e.g., green)
    set_color green
    printf "❯ "
    set_color normal
end

function fish_right_prompt
    # Empty right prompt
end

function fish_mode_prompt
    # Empty mode prompt (vi mode)
end

# Highlight the command input to make it distinct (e.g., cyan)
set -g fish_color_command cyan
set -g fish_color_param cyan
set -g fish_color_error red

# Disable Tide if it's loaded
set -g tide_prompt_transient_enabled false
set -g tide_left_prompt_items
set -g tide_right_prompt_items

# Force repaint to apply changes immediately
commandline -f repaint

# 4. AI Mode Aliases & State
if not set -q LYRA_INPUT_MODE
    set -gx LYRA_INPUT_MODE off
end

alias lyra-on="set -gx LYRA_INPUT_MODE agent; commandline -f repaint"
alias lyra-off="set -gx LYRA_INPUT_MODE off; commandline -f repaint"

