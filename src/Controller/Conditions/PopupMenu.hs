-- | Shows the popup menu when the user right-clicks the icon
module Controller.Conditions.PopupMenu where

-- External imports
import Control.Monad
import Graphics.UI.Gtk

-- Internal imports
import CombinedEnvironment

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
  icon <- trayIcon $ uiBuilder $ view cenv
  icon `on` statusIconPopupMenu $ condition cenv

-- | Presents the popup menu, hiding the sms window if necessary
condition :: CEnv -> Maybe MouseButton -> TimeStamp -> IO()
condition cenv m t = do
  let ui = uiBuilder $ view cenv

  mw   <- mainWindow ui
  menu <- mainMenu ui

  isWindowShown <- get mw widgetVisible

  if isWindowShown
   then widgetHide mw
   else menuPopup menu $ fmap (\m' -> (m', t)) m
