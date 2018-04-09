import           System.Exit
import           System.IO
import           XMonad
import qualified XMonad.Actions.Navigation2D        as N
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.Place
import           XMonad.Layout.BinarySpacePartition
import           XMonad.Layout.Hidden
import           XMonad.Layout.Maximize
import           XMonad.Layout.NoBorders
import           XMonad.Prompt
import           XMonad.Prompt.Shell
import XMonad.Prompt.Unicode
import qualified XMonad.StackSet                    as W
import           XMonad.Util.EZConfig
import           XMonad.Util.Run               
import           XMonad.Util.SpawnOnce
import           XMonad.Wallpaper
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Renamed
import XMonad.Prompt.ConfirmPrompt

navConf = def {N.layoutNavigation = [("BSP", N.hybridNavigation)]}

main :: IO ()
main = do
  setRandomWallpaper ["$HOME/Wallpapers"]
  xmproc <- spawnPipe "/usr/bin/xmobar /home/chris/.xmobarrc"
  xmonad $
    N.withNavigation2DConfig navConf $
    N.additionalNav2DKeysP
      ("k", "h", "j", "l")
      [("M-", N.windowGo), ("M-S-", N.windowSwap)]
      False $
    docks $
    ewmh $
    def
      { manageHook =
          placeHook simpleSmart <+>
          manageDocks <+>
          (isFullscreen --> doFullFloat) <+>
          (isDialog --> doCenterFloat) <+> manageHook def
      , layoutHook = myLayout
      , startupHook =
          do spawn
               "setxkbmap gb -option compose:ralt && xmodmap ~/.Xmodmap && xset r rate 175 175"
             spawn "emacs --daemon &"
             spawn "compton --config=/home/chris/.config/compton/compton.conf &"
             spawn "urxvtd &"
             spawn "xrdb .Xresources"
      , logHook =
          dynamicLogWithPP
            xmobarPP
              { ppOutput = hPutStrLn xmproc
              , ppTitle = xmobarColor "green" "" . shorten 70
              -- , ppExtras = [loadAvg, battery]
              }
      , modMask = mod4Mask -- use windows key
      , terminal = myTerm
      , keys = myKeys
      , workspaces = myWorkspaces
      , normalBorderColor = "#000000"
      , focusedBorderColor = "#FFFFFF"
      , handleEventHook = handleEventHook def <+> fullscreenEventHook
      }

myLayout =
    renamed [Replace "BSP"] $ smartBorders . avoidStruts $ hiddenWindows $ mkToggle1 NBFULL $ maximize emptyBSP

launcherConfig :: XPConfig
launcherConfig =
  def
    { font = "xft:Input Sans Narrow:size=10:antialias=true:hinting=full:style=Extra Light"
  -- { font ="xft:Input Mono Narrow:size=10:antialias=true:hinting=full:style=Extra Light,xft:FontAwesome"
    , height = 38
    , position = Bottom
    }

myKeys conf =
  mkKeymap
    conf
    [ ("M-<Return>", spawn (terminal conf))
    , ("M-<Space>", spawn editor)
    , ("<Print>", spawn "scrot -q100")
    , ("M-d", shellPrompt launcherConfig)
    , ("M-b", spawn browser)
    , ("M-S-b", spawn pBrowser)
    , ("M-S-<Space>", sendMessage ToggleStruts)
    , ("M-q", kill)
    , ("M-S-r", spawn "xmonad --recompile && xmonad --restart")
    , ("M-f", sendMessage $ Toggle NBFULL)
    , ("M-t", withFocused $ windows . W.sink)
    , ("M-`", windows $ W.greedyView "Control Centre")
    , ("M-1", windows $ W.greedyView "Home")
    , ("M-2", windows $ W.greedyView "Emacs")
    , ("M-3", windows $ W.greedyView "Music")
    , ("M-4", windows $ W.greedyView "Steam")
    , ("M-5", windows $ W.greedyView "5")
    , ("M-6", windows $ W.greedyView "6")
    , ("M-7", windows $ W.greedyView "7")
    , ("M-8", windows $ W.greedyView "8")
    , ("M-9", windows $ W.greedyView "9")
    , ("M-S-`", windows $ W.shift "Control Centre")
    , ("M-S-1", windows $ W.shift "Home")
    , ("M-S-2", windows $ W.shift "Emacs")
    , ("M-S-3", windows $ W.shift "Music")
    , ("M-S-4", windows $ W.shift "Steam")
    , ("M-S-5", windows $ W.shift "5")
    , ("M-S-6", windows $ W.shift "6")
    , ("M-S-7", windows $ W.shift "7")
    , ("M-S-8", windows $ W.shift "8")
    , ("M-S-9", windows $ W.shift "9")
    , ("M-r", sendMessage Rotate)
    , ("M-p", sendMessage Balance)
    , ("M-S-a", sendMessage Equalize)
    , ("M-C-h", sendMessage $ ExpandTowards L)
    , ("M-C-j", sendMessage $ ExpandTowards D)
    , ("M-C-k", sendMessage $ ExpandTowards U)
    , ("M-C-l", sendMessage $ ExpandTowards R)
    , ("M-s", sendMessage Swap)
    , ("M-m", withFocused (sendMessage . maximizeRestore))
    , ("M-S-q", confirmPrompt launcherConfig "exit" $ io exitSuccess)
    , ("M-u", unicodePrompt launcherConfig)
    , ("M-o", withFocused hideWindow)
    , ("M-S-o", popNewestHiddenWindow)
    , ("<Print>", spawn "spectacle")
    , ("<XF86AudioRaiseVolume>", spawn "pamixer -u -i 5 --allow-boost")
    , ("<XF86AudioLowerVolume>", spawn "pamixer -d 5 --allow-boost")
    , ("<XF86AudioMute>", spawn "pamixer -t")
    , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10")
    , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10")
    ]

editor :: String
editor = "emacsclient -c"

myWorkspaces :: [String]
myWorkspaces =
  ["Control Centre", "Home", "Emacs", "Music", "Steam"] ++
  fmap show [5 .. 9 :: Integer]

pBrowser :: String
pBrowser = "firefox --private-window"

browser :: String
browser = "firefox"

myTerm :: String
myTerm = "urxvtc"
