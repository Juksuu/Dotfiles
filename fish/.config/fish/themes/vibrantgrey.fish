# vibrantgrey Color Palette
set -l foreground d0d6d2
set -l comment 5c6773

set -l green 53ed75
set -l violet 7553ed
set -l orange cc9f1a
set -l red dd3033
set -l blue 128bae

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $green
set -g fish_color_keyword $blue
set -g fish_color_quote $green
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $blue
set -g fish_color_comment $comment
set -g fish_color_escape $violet
set -g fish_color_autosuggestion $comment

# Prompt colors
set -g fish_color_cwd $green
set -g fish_color_user $orange
set -g fish_color_host $orange
