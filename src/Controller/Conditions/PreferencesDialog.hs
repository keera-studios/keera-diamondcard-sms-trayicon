-- | Shows the popup menu when the user right-clicks the icon
module Controller.Conditions.PreferencesDialog where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment
import View
import View.MainWindow.Objects

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 menu <- mainMenuPreferences $ uiBuilder $ view cenv
 menu `on` menuItemActivate $ condition cenv

condition :: CEnv -> IO()
condition cenv = onViewAsync $ do
 dg <- preferencesDialog $ uiBuilder $ view cenv
 _  <- dialogRun dg
 widgetHide dg