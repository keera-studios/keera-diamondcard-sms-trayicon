-- | Shows the preferences dialog when the user requests it.
-- 
-- (View => View)
module Controller.Conditions.PreferencesDialog where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment

-- | Detect when the user activates the preferences menu item
installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 menu <- mainMenuPreferences $ uiBuilder $ view cenv
 menu `on` menuItemActivate $ condition cenv

-- | Shows the dialog and hides it once it's closed
condition :: CEnv -> IO()
condition cenv = postGUIAsync $ do
 dg <- preferencesDialog $ uiBuilder $ view cenv
 _  <- dialogRun dg
 widgetHide dg
