-- | Shows the popup menu when the user right-clicks the icon
module Controller.Conditions.Quit where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment
import View
import View.MainWindow.Objects

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 menu <- mainMenuQuit $ mainWindowBuilder $ view cenv
 menu `on` menuItemActivate $ mainQuit
