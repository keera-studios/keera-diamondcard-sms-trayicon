-- | Shows the popup menu when the user right-clicks the icon
module Controller.Conditions.Quit where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment
import View
import View.MainWindow.Objects

installHandlers :: CRef -> IO()
installHandlers cref = void $ do
 menu <- mainMenuQuit . mainWindowBuilder . view =<< readIORef cref
 menu `on` menuItemActivate $ mainQuit
