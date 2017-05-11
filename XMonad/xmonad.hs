import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders (smartBorders)
import qualified XMonad.Layout.BinarySpacePartition as BSP
import XMonad.Prompt
import XMonad.Prompt.Shell
import qualified XMonad.StackSet as W
import qualified XMonad.Actions.Navigation2D as N
import System.IO

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/chris/.xmobarrc"
  xmonad $
    N.navigation2DP def ("k", "h", "j", "l")
                        [("M-", N.windowGo),
                         ("M-S-", N.windowSwap)]
                        False
    $ docks $
    def
    { manageHook = manageDocks <+> manageHook def
    , layoutHook = smartBorders (avoidStruts $ myLayout)
    , logHook =
        dynamicLogWithPP
          xmobarPP
          { ppOutput = hPutStrLn xmproc
          , ppTitle = xmobarColor "green" "" . shorten 50
          }
    , modMask = mod4Mask -- use windows key
    , terminal = myTerm
    , keys = myKeys
    , workspaces = myWorkspaces
    } --`additionalKeys`
  --  [ ((mod4Mask, xK_Return), spawn "termite")
  --  , ((controlMask, xK_Print), spawn "scrot -q100 -s")
  --  , ((0, xK_Print), spawn "scrot -q100")
  --  , ((mod4Mask, xK_space), spawn "emacsclient -c")
  --  , ((mod4Mask, xK_d), shellPrompt launcherConfig)
  --  , ((mod4Mask, xK_b), spawn "chromium")
  --  , ( (shiftMask .|. mod4Mask, xK_e)
  --    , spawn "xmonad --recompile && xmonad --restart")
  --  ]

myLayout = BSP.emptyBSP ||| Full
launcherConfig = def
  { font = "xft:DejaVu Sans Mono:pixelsize=11:antialias=true,xft:FontAwesome:pixelsize=11"
  , height = 15
  , position = Bottom
  }

myKeys conf = mkKeymap conf $
  [
    ("M-<Return>", spawn (terminal conf))
  , ("M-<Space>", spawn editor)
  , ("<Print>", spawn "scrot -q100")
  , ("M-d", shellPrompt launcherConfig)
  , ("M-b", spawn browser)
  , ("M-q", kill)
  , ("M-S-r", spawn "xmonad --recompile && xmonad --restart")
  , ("M-e", sendMessage NextLayout)
  , ("M-t", withFocused $ windows . W.sink)
  , ("M-`", windows $ W.greedyView "Control Centre")
  , ("M-1", windows $ W.greedyView "Home")
  , ("M-2", windows $ W.greedyView "Emacs")
  , ("M-3", windows $ W.greedyView "3")
  , ("M-4", windows $ W.greedyView "4")
  , ("M-5", windows $ W.greedyView "5")
  , ("M-6", windows $ W.greedyView "6")
  , ("M-7", windows $ W.greedyView "7")
  , ("M-8", windows $ W.greedyView "8")
  , ("M-9", windows $ W.greedyView "9")
  , ("M-S-`", windows $ W.shift "Control Centre")
  , ("M-S-1", windows $ W.shift "Home")
  , ("M-S-2", windows $ W.shift "Emacs")
  , ("M-S-3", windows $ W.shift "3")
  , ("M-S-4", windows $ W.shift "4")
  , ("M-S-5", windows $ W.shift "5")
  , ("M-S-6", windows $ W.shift "6")
  , ("M-S-7", windows $ W.shift "7")
  , ("M-S-8", windows $ W.shift "8")
  , ("M-S-9", windows $ W.shift "9")
  , ("M-r", sendMessage BSP.Rotate)
  , ("M-C-h", sendMessage $ BSP.ExpandTowards L)
  , ("M-C-j", sendMessage $ BSP.ExpandTowards D)
  , ("M-C-k", sendMessage $ BSP.ExpandTowards U)
  , ("M-C-l", sendMessage $ BSP.ExpandTowards R)
  ]

editor = "emacsclient -c"
myWorkspaces = [ "Control Centre"
               , "Home"
               , "Emacs"
               ] ++ (fmap show [3..9])
               
browser = "chromium"
myTerm = "urxvt"
