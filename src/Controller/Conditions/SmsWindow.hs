-- | Toggles window visibility when the user clicks on the status icon.
module Controller.Conditions.SmsWindow where

import Control.Monad
import Control.Monad.IfElse
import Data.Maybe
import Graphics.UI.Gtk

import CombinedEnvironment

-- | Detects when the user activates the status icon
installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 icon <- trayIcon $ uiBuilder $ view cenv
 icon `on` statusIconActivate $ condition cenv

-- | Shows the window in the appropriate position or hides it, depending on its
-- current status
condition :: CEnv -> IO()
condition cenv = postGUIAsync $ do

  -- UI elements
  let ui = uiBuilder $ view cenv

  -- Window, hidden if currently shown, shown if currently hidden
  mw            <- mainWindow ui
  winSize       <- windowGetSize mw
  isWindowShown <- get mw widgetVisible

  -- TrayIcon, used to position the window as close to it as possible
  icon <- trayIcon ui

  if isWindowShown
   then widgetHide mw
   else awhenM (statusIconGetGeometry icon) $ \(rect, orient) -> do
          widgetShowAll mw
          -- If possible, it places the window next to icon, within
          -- the screen limits Otherwise, the window is centered on
          -- the screen
          screen <- screenGetDefault
          if isNothing screen
           then windowSetPosition mw WinPosCenter
           else do let screen' = fromJust screen
                   screenW <- screenGetWidth screen'
                   screenH <- screenGetHeight screen'
                   windowSetPosition mw WinPosNone
                   let pos = getWindowPosition winSize rect orient (screenW, screenH)
                   uncurry (windowMove mw) pos

-- | Given a window size, an icon rectangle and orientation, and a
-- screen size, returns the suggested window position if one can be
-- found, and nothing if a fixed position cannot be suggested.  In the
-- latter case, the best suggestion would be to center the window on
-- the screen.
getWindowPosition :: (Int, Int) -> Rectangle -> Orientation -> (Int, Int)
                     -> (Int, Int)
getWindowPosition win rect orient screen
 -- The icon is below
 | orient == OrientationHorizontal && plusOrMinus rectY rectH screenH winH
 = (adjustToSize rectX winW screenW, rectY - winH)
 -- The icon is above
 | orient == OrientationHorizontal
 = (adjustToSize rectX winW screenW, rectY + rectH)
 -- The icon is to the right
 | orient == OrientationVertical && plusOrMinus rectX rectW screenW winW
 = (rectX - winW, adjustToSize rectY winH screenH)
 -- The icon is above
 | otherwise -- orient == OrientationVertical
 = (rectX + rectW, adjustToSize rectY winH screenH)
  
  where (Rectangle rectX rectY rectW rectH) = rect
        (winW, winH)                        = win
        (screenW, screenH)                  = screen

-- Returns plus if the start and the size (with an error margin)
-- are greater than the limit, and minus otherwise
plusOrMinus :: Int -> Int -> Int -> Int -> Bool
plusOrMinus start size end margin = (start + size + margin) >= end

-- Returns a position such that the size fits between 0 and end.
-- The value must be as close to start as possible.
adjustToSize :: Int -> Int -> Int -> Int
adjustToSize start size end
 | (start + size) <= end = start
 | otherwise             = end - size
