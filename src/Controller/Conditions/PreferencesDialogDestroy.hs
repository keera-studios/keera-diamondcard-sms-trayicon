-- | Hides the preferences dialog when the user closes it
--
-- Copyright   : (C) Keera Studios Ltd, 2015
-- License     : BSD3
-- Maintainer  : support@keera.co.uk
module Controller.Conditions.PreferencesDialogDestroy where

import Control.Monad
import Control.Monad.Reader (liftIO)
import Graphics.UI.Gtk

import CombinedEnvironment

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
  dg <- preferencesDialog $ uiBuilder $ view cenv
  dg `on` deleteEvent $ liftIO (widgetHide dg) >> return True
