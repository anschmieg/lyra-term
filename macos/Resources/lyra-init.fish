# Lyra Terminal Initialization Script for Fish Shell

# 1. Hide Cursor (DECTCEM)
# We emit this immediately to ensure the cursor is hidden during startup
echo -ne "\e[?25l"

# 2. Set Environment Variable
set -gx LYRA_TERM 1

# 3. Hide Prompt
# We override the prompt functions to be empty.
# We also disable tide transient prompt if present to avoid overrides.
set -g tide_prompt_transient_enabled false

function fish_prompt
    # Ensure cursor is hidden every time prompt is drawn
    echo -ne "\e[?25l"
end

function fish_right_prompt
    # Empty right prompt
end

function fish_mode_prompt
    # Empty mode prompt (vi mode)
end

# 4. AI Mode Aliases & State
if not set -q LYRA_INPUT_MODE
    set -gx LYRA_INPUT_MODE off
end

alias lyra-on="set -gx LYRA_INPUT_MODE agent; commandline -f repaint"
alias lyra-off="set -gx LYRA_INPUT_MODE off; commandline -f repaint"

# 5. Key Bindings (Optional, if not handled by global config)
# We rely on the global lyra.fish for bindings usually, but we can enforce them here if needed.
