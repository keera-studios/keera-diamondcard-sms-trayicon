-- | Quits when the user selects the quit option in the popup menu.
module Controller.Conditions.Quit where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 menu <- mainMenuQuit $ uiBuilder $ view cenv
 menu `on` menuItemActivate $ mainQuit
