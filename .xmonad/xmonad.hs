--import XMonad hiding ( (|||) )
import XMonad
import Control.Monad
import XMonad.Layout.Spacing
import XMonad.Layout.SimplestFloat
import XMonad.Util.EZConfig

import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified GHC.IO.Handle.Types as H

import Data.Ratio
import System.IO
import System.Exit

-- <actions>
import XMonad.Actions.PerWorkspaceKeys
import XMonad.Actions.CycleWS (nextWS,prevWS,toggleWS,shiftToNext,shiftToPrev)
import XMonad.Actions.DwmPromote
import XMonad.Actions.RotSlaves (rotAllUp,rotAllDown,rotSlavesDown,rotSlavesUp)
import XMonad.Actions.GridSelect
import XMonad.Actions.WindowGo
import XMonad.Actions.SwapWorkspaces
import XMonad.Actions.FloatKeys (keysMoveWindow,keysResizeWindow)
import XMonad.Actions.WithAll
import XMonad.Actions.Submap


-- <hooks>
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks-- (avoidStruts,avoidStrutsOn,ToggleStruts(..))
import XMonad.Hooks.EwmhDesktops (ewmhDesktopsStartup)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook

-- <utilities>
import XMonad.Util.Cursor
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.Scratchpad (scratchpadManageHook,scratchpadSpawnActionCustom)
import XMonad.Util.SpawnOnce

-- <prompts>
import XMonad.Prompt
import qualified XMonad.Prompt as P
import XMonad.Prompt.XMonad
import XMonad.Prompt.Shell
import XMonad.Prompt.AppLauncher
import XMonad.Prompt.AppLauncher as AL
import XMonad.Prompt.AppendFile (appendFilePrompt)
import XMonad.Prompt.Man (manPrompt)
import XMonad.Prompt.Window (windowPromptBring,windowPromptGoto)

-- <layouts>
import XMonad.Layout
import XMonad.Layout.OneBig
import XMonad.Layout.TwoPane
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
--import XMonad.Layout.HintedTile

-- <layout helpers>
import XMonad.Layout.Minimize
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Combo
import XMonad.Layout.LimitWindows
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Layout.Reflect
import XMonad.Layout.Master
import XMonad.Layout.CenteredMaster
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Named
import XMonad.Layout.WindowNavigation

-- Constants
winMask = mod4Mask
myTerm  = "urxvtc"	

mySpace	:: [String]
mySpace	= (map dzenEscape) $ ["home", "web", "devel", "media", "play", "chat"]

warnaBG         = "#303030"
warnaPutih      = "#ebebeb"
warnaMerah      = "#c3134b"
warnaAbu        = "#545454"
warnaAbuGelap   = "#353535"

--myLayout = simplestFloat

startUp :: X()
startUp = do
	  --spawn "feh --bg-scale ~/Pictures/mclaren_650s.jpg &"
	  spawn "fehbg &"
	  spawn "urxvtd &"

main = do
	bar <- spawnPipe status
	bottom <- spawnPipe "sh /home/otiuz/scripts/dzenbottom.sh"
	corner <- spawnPipe "sh /home/otiuz/scripts/dzencorner.sh"
	top <- spawnPipe "sh /home/otiuz/scripts/dzentop.sh"
	xmonad $ defaultConfig
		--{ manageHook = manageDocks <+> manageHook defaultConfig
		{ manageHook = myManageHook <+> manageHook defaultConfig
 		, startupHook = startUp <+> setWMName "LG3D"
		, borderWidth = 2
		, focusedBorderColor = "#D27B4E"
		, normalBorderColor = "#404040"
		, workspaces = mySpace
		, modMask = mod1Mask
		--, layoutHook = smartBorders $ avoidStruts $ spacing 3 $ Tall 1 (3/100) (1/2)
		, layoutHook = myLayoutHook
		, logHook = myLogHook bar
		, keys = myKeys
		} where status = "dzen2 -ta l -fn '"
				  ++ font ++
				  "' -w 330 -bg '#101010' -h 22 -e 'button3='"
		        font	= "M+ 2p-7"	

--Manage hook: manage programs (float, workspace, borders etc)
myManageHook = (composeAll . concat $
	[  [className =? "MPlayer" --> doFloat]
    	--,  [className =? "URxvt" --> ]
	,  [className =? "Steam" --> doFloat]
	,  [className =? "Firefox" --> doShift (mySpace !! 1)]
	,  [className =? "Subl3" --> doShift "devel"]
	,  [className =? "Atom" --> doShift "devel"]
	,  [className =? "Spotify" --> doShift "media"]
	,  [className =? "Skype" --> doFloat]
	]) <+> manageDocks

myLayoutHook = spacing 3 $ avoidStruts $ smartBorders $ tiled 
	where
	tiled   = Tall nmaster delta ratio
	nmaster = 1
	delta   = 3/100
	ratio   = 1/2

--play		= "^ca(1,mpc toggle)^i(/home/otiuz/.icons/xbm8x8/play.xbm)^ca()"
--next		= "^ca(1,mpc next)^i(/home/otiuz/.icons/xbm8x8/fwd.xbm)^ca()"
--prev		= "^ca(1,mpc prev)^i(/home/otiuz/.icons/xbm8x8/rwd.xbm)^ca()"
--stop		= "^ca(1,mpc stop)^i(/home/otiuz/.icons/xbm8x8/stop.xbm)^ca()"

myKeys conf@(XConfig {XMonad.modMask = altMask}) = M.fromList $
	[ ((altMask,	xK_Return),	spawn myTerm)
	, ((altMask,	xK_q),		kill)
	, ((altMask,	xK_x),		spawn "dmenush")
	, ((altMask,	xK_a),		spawn "atom")
	, ((altMask,	xK_s),		spawn "steam")
	, ((altMask,	xK_f),		spawn "firefox")
	, ((altMask,	xK_Print),	spawn "screenshot")

	, ((altMask,	xK_z),		sendMessage Expand)
	, ((altMask,	xK_c),		sendMessage Shrink)

-- Keybindings related to the system in some way
   	, ((altMask .|. controlMask,	xK_q),	spawn "xmonad --recompile; xmonad --restart")
   	 ]
   	 ++ -- view Nth workspace (modMask+Int) or send focused window to workspace (modMask+Shift+Int)
   	 [((m .|. altMask, k), windows $ f i)
      		| (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_6]
       		, (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
   	 ++ -- swap windows from current workspace with another (modMask+Control+Int)
   	 	[((altMask .|. controlMask, k), windows $ swapWithCurrent i)
     	   	| (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_6]]
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events --
myMouseBindings (XConfig {XMonad.modMask = altMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((altMask, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((altMask, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((altMask, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

myLogHook h = dynamicLogWithPP $ myDzenPP { ppOutput = hPutStrLn h }
--myLogHook h = dynamicLogWithPP { ppOutput = hPutStrLn h }

myDzenPP = dzenPP
	{ ppCurrent		= wrap cur end
	, ppHidden		= wrap cui end
	, ppHiddenNoWindows	= wrap cua end
	, ppSep		= "   ^fg(#FF6E86)^i(/home/otiuz/.icons/xbm8x8/arrow_mini_02.xbm)^fg() "
	, ppWsSep 		= ""
	--, ppTitle		= \t -> "^fg(#D27B4E) " ++ prev ++ " " ++ play ++ " " ++ stop ++ " " ++ next ++ " ^fg()"
	, ppTitle		= \t -> ""
	, ppLayout		= \l -> "" ++ "Full"
	, ppOrder		= \(ws:_:t:_) -> [ws,t]
	} where	cur	= " ^fg(#D27B4E)^r(48x19)^fg()^p(-44)^ib(1)^fg(#151515) "
		cua	= " ^fg(#444444)^r(48x19)^fg()^p(-44)^ib(1)^fg(#151515) "
		cui 	= " ^fg(#6D6D6D)^r(48x19)^fg()^p(-44)^ib(1)^fg(#fbfbfb) "
		end	= " ^fg() "
