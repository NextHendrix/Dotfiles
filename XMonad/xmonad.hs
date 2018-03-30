import           System.Exit
import           System.IO
import           XMonad
import qualified XMonad.Actions.Navigation2D        as N
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Layout.BinarySpacePartition
import           XMonad.Layout.Maximize
import           XMonad.Layout.NoBorders            (smartBorders)
import           XMonad.Prompt
import           XMonad.Prompt.Shell
import qualified XMonad.StackSet                    as W
import           XMonad.Util.EZConfig
import           XMonad.Util.Run                    (spawnPipe)
import           XMonad.Wallpaper

main :: IO ()
main = do
  setRandomWallpaper ["$HOME/Wallpapers"]
  xmproc <- spawnPipe "/usr/bin/xmobar /home/chris/.xmobarrc"
  xmonad $
    N.navigation2DP
      def
      ("k", "h", "j", "l")
      [("M-", N.windowGo), ("M-S-", N.windowSwap)]
      False $
    docks $
    def
    { manageHook = manageDocks <+> (isFullscreen --> doFullFloat) <+> manageHook def
    , layoutHook = smartBorders . avoidStruts $ myLayout
    , logHook =
        dynamicLogWithPP
          xmobarPP
          { ppOutput = hPutStrLn xmproc
          , ppTitle = xmobarColor "green" "" . shorten 70
          }
    , modMask = mod4Mask -- use windows key
    , terminal = myTerm
    , keys = myKeys
    , workspaces = myWorkspaces
    , normalBorderColor = "#000000"
    , focusedBorderColor = "#FFFFFF"
    }

myLayout = maximize emptyBSP ||| Full

launcherConfig :: XPConfig
launcherConfig =
  def
  { font =
      "xft:Input Mono:size=10:antialias=true:hinting=full"
  , height = 38
  , position = Bottom
  }

myKeys conf =
  mkKeymap conf
  [ ("M-<Return>", spawn (terminal conf))
  , ("M-<Space>", spawn editor)
  , ("<Print>", spawn "scrot -q100")
  , ("M-d", shellPrompt launcherConfig)
  , ("M-b", spawn browser)
  , ("M-S-b", spawn pBrowser)
  , ("M-S-<Space>", sendMessage ToggleStruts)
  , ("M-q", kill)
  , ("M-S-r", spawn "xmonad --recompile && xmonad --restart")
  , ("M-e", sendMessage NextLayout)
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
  , ("M-a", sendMessage Balance)
  , ("M-S-a", sendMessage Equalize)
  , ("M-C-h", sendMessage $ ExpandTowards L)
  , ("M-C-j", sendMessage $ ExpandTowards D)
  , ("M-C-k", sendMessage $ ExpandTowards U)
  , ("M-C-l", sendMessage $ ExpandTowards R)
  , ("M-s", sendMessage $ Swap)
  , ("M-m", withFocused (sendMessage . maximizeRestore))
  , ("M-S-q", io (exitWith ExitSuccess))
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
  ["Control Centre", "Home", "Emacs", "Music", "Steam"] ++ (fmap show [5 .. 9])

pBrowser :: String
pBrowser = "firefox --private-window"

browser :: String
browser = "firefox"

myTerm :: String
myTerm = "urxvtc"
