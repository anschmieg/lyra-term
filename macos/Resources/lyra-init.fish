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
    # Ensure cursor is hidden here too as mode changes might reshow it
    printf "\e[?25l"
end

# Highlight the command input to make it distinct (e.g., cyan)
set -g fish_color_command cyan
set -g fish_color_param cyan
set -g fish_color_error red

# Aggressively disable Tide
# We remove the functions entirely to prevent them from being called
functions -e tide_prompt
functions -e _tide_item_os
functions -e _tide_item_pwd
functions -e _tide_item_git
functions -e _tide_item_status
functions -e _tide_item_cmd_duration
functions -e _tide_item_context
functions -e _tide_item_jobs
functions -e _tide_item_node
functions -e _tide_item_python
functions -e _tide_item_rust
functions -e _tide_item_go

# Disable Tide variables just in case
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

