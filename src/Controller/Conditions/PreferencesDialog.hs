-- | Shows the popup menu when the user right-clicks the icon
module Controller.Conditions.PreferencesDialog where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment
import View
import View.MainWindow.Objects

installHandlers :: CRef -> IO()
installHandlers cref = void $ do
 menu <- mainMenuPreferences . mainWindowBuilder . view =<< readIORef cref
 menu `on` menuItemActivate $ condition cref

condition :: CRef -> IO()
condition cref = onViewAsync $ do
 dg <- preferencesDialog . mainWindowBuilder . view =<< readIORef cref
 _  <- dialogRun dg
 widgetHide dg
