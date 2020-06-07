------------------------------------------------------------------------
-- IMPORTS
------------------------------------------------------------------------

-- Basic
import XMonad
import XMonad.Config.Desktop
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce

-- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.

-- Actions
import XMonad.Actions.Promote
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.CycleWS (shiftNextScreen, shiftPrevScreen, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.MouseResize

-- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows)
import XMonad.Layout.MultiToggle (mkToggle, EOT(EOT), Toggle(..), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Layout.Spacing
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))

-- Layouts
import XMonad.Layout.OneBig
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns

------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------

-- Super key
myModMask :: KeyMask
myModMask = mod4Mask

-- Alt key
myAltMask :: KeyMask
myAltMask = mod1Mask

-- Font
myFont :: [Char]
myFont = "xft:Code New Roman:regular:pixelsize=11"

-- Terminal
myTerminal :: [Char]
myTerminal = "kitty"

-- Border width
myBorderWidth :: Dimension
myBorderWidth = 2

-- Border color of normal windows
myBorderNormColor :: [Char]
myBorderNormColor   = "#292d3e"

-- Border color of focused windows
myBorderFocusColor :: [Char]
myBorderFocusColor  = "#bbc5ff"

-- Get monitor count
windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = True

-- Workspaces
myWorkspaces    = ["code","web1", "web2", "files", "dev-env"] ++ map show [6..9]


------------------------------------------------------------------------
-- LAYOUTS
------------------------------------------------------------------------

-- Makes setting the spacingRaw simpler to write. The spacingRaw
-- module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

tall     = renamed [Replace "Tiled"]
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []

monocle  = renamed [Replace "Full"]
           $ limitWindows 20
           $ Full

threeCol = renamed [Replace "ThreeCol"]
           $ limitWindows 7
           $ mySpacing 4
           $ ThreeCol 1 (3/100) (1/2)

threeRow = renamed [Replace "ThreeRow"]
           $ limitWindows 7
           $ mySpacing 4
           -- Mirror takes a layout and rotates it by 90 degrees.
           -- So we are applying Mirror to the ThreeCol layout.
           $ Mirror
           $ ThreeCol 1 (3/100) (1/2)


myLayoutHook = avoidStruts $ mouseResize $ windowArrange $
               mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ myDefaultLayout
             where
               myDefaultLayout = tall ||| noBorders monocle ||| threeCol ||| threeRow

------------------------------------------------------------------------
-- KEYBINDINGS
------------------------------------------------------------------------

myKeys :: [([Char], X ())]
myKeys = [
    -- xmonad
    ("M-C-r", spawn "xmonad --recompile"),      -- Recompiles xmonad
    ("M-S-r", spawn "xmonad --restart"),        -- Restarts xmonad
    ("M-S-q", io exitSuccess),                  -- Quits xmonad

    -- Windows
    ("M-S-c", kill1),                           -- Kill the currently focused client
    ("M-S-a", killAll),                         -- Kill all the windows on current workspace
    ("M-t", withFocused $ windows . W.sink),    -- Push floating window back to tile.
    ("M-S-t", sinkAll),                         -- Push ALL floating windows back to tile.

    -- Windows navigation
    ("M-m", windows W.focusMaster),             -- Move focus to the master window
    ("M-j", windows W.focusDown),               -- Move focus to the next window
    ("M-k", windows W.focusUp),                 -- Move focus to the prev window
    ("M-C-j", windows W.swapDown),              -- Swap the focused window with the next window
    ("M-C-k", windows W.swapUp),                -- Swap the focused window with the prev window
    ("M-S-m", promote),                         -- Moves focused window to master, all others maintain order

    -- Layouts
    ("M-<Space>", sendMessage NextLayout),                               -- Switch to next layout
    ("M-S-n", sendMessage $ Toggle NOBORDERS),                           -- Toggles noborder
    ("M-S-f", sendMessage (Toggle NBFULL) >> sendMessage ToggleStruts),  -- Toggles noborder/full
    ("M-h", sendMessage Shrink),                                         -- Decrease split size
    ("M-l", sendMessage Expand),                                         -- Increase split size

    -- Workspaces
    ("M-M1-l", nextScreen),         -- Switch focus to next monitor
    ("M-M1-h", prevScreen),         -- Switch focus to prev monitor
    ("M-S-l", shiftNextScreen >> nextScreen),     -- Shifts focused window to next screen
    ("M-S-h", shiftPrevScreen >> prevScreen),     -- Shifts focused window to previous screen

    -- My Applications (Super+Alt+Key)
    -- ("M-M1-n", spawn (myTerminal ++ " -e nvim"))

    -- Multimedia Keys
    ("<XF86AudioLowerVolume>", spawn "$HOME/.xmonad/adjustVolume.sh 5%-"),
    ("<XF86AudioRaiseVolume>", spawn "$HOME/.xmonad/adjustVolume.sh 5%+")

    ]

------------------------------------------------------------------------
-- WINDOW RULES
------------------------------------------------------------------------

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- STARTUP
------------------------------------------------------------------------

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "dunst &"
    spawnOnce "pasystray &"
    spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --iconspacing 5 --SetDockType true --SetPartialStrut true --expand true --monitor 0 --transparent true --alpha 70 --tint 0x000000 --height 20 &"

------------------------------------------------------------------------
-- MAIN
------------------------------------------------------------------------

main :: IO ()
main = do
    xmproc0 <- spawnPipe "/home/frans/.cabal/bin/xmobar -x 0 /home/frans/.config/xmobar/xmobarrc0"
    xmproc1 <- spawnPipe "/home/frans/.cabal/bin/xmobar -x 1 /home/frans/.config/xmobar/xmobarrc1"
    xmonad $ ewmh desktopConfig
        { manageHook = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageHook desktopConfig <+> manageDocks
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myBorderNormColor
        , focusedBorderColor = myBorderFocusColor
        , focusFollowsMouse  = myFocusFollowsMouse
        , clickJustFocuses   = myClickJustFocuses
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = \x -> hPutStrLn xmproc0 x  >> hPutStrLn xmproc1 x
                        , ppCurrent = xmobarColor "#c3e88d" "" . wrap "[" "]" -- Current workspace in xmobar
                        , ppVisible = xmobarColor "#c3e88d" ""                -- Visible but not current workspace
                        , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor "#F07178" ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor "#d0d0d0" "" . shorten 60     -- Title of active window in xmobar
                        , ppSep =  "<fc=#666666> | </fc>"                     -- Separators in xmobar
                        , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                        , ppExtras  = [windowCount]                           -- # of windows current workspace
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }
        } `additionalKeysP` myKeys
