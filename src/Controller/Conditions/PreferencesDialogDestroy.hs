-- | Shows the popup menu when the user right-clicks the icon
module Controller.Conditions.PreferencesDialogDestroy where

import Control.Monad
import Control.Monad.Reader (liftIO)
import Graphics.UI.Gtk

import CombinedEnvironment
import View
import View.MainWindow.Objects

installHandlers :: CRef -> IO()
installHandlers cref = void $ do
 dg <- preferencesDialog . mainWindowBuilder . view =<< readIORef cref
 dg `on` deleteEvent $ liftIO (widgetHide dg) >> return True
