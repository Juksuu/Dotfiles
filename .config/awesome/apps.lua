--       █████╗ ██████╗ ██████╗ ███████╗
--      ██╔══██╗██╔══██╗██╔══██╗██╔════╝
--      ███████║██████╔╝██████╔╝███████╗
--      ██╔══██║██╔═══╝ ██╔═══╝ ╚════██║
--      ██║  ██║██║     ██║     ███████║
--      ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝


local awful = require('awful')
local filesystem = require('gears.filesystem')


-- ===================================================================
-- App Declarations
-- ===================================================================


local apps = {
    terminal = "kitty",
    launcher = "rofi -normal-window -modi drun -show drun",
    lock = "i3lock",
    screenshot = "scrot -e 'mv $f ~/Pictures/ 2>/dev/null'",
    filebrowser = "nautilus",
    browser = "firefox",
    editor = "code",
    musicPlayer = "spotify",
    gameLauncher = "steam",
    imageEditor = "gimp",
}

-- List of apps to start once on start-up
local run_on_start_up = {
}


-- ===================================================================
-- Functionality
-- ===================================================================


-- Run all the apps listed in run_on_start_up when awesome starts
local function run_once(cmd)
   awful.spawn.with_shell(cmd)
end

for _, app in ipairs(run_on_start_up) do
    run_once(app)
end

-- return apps list
return apps
