-- | Shows the popup menu when the user right-clicks the icon
module Controller.Conditions.PopupMenu where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment
import View
import View.MainWindow.Objects

installHandlers :: CRef -> IO()
installHandlers cref = void $ do
  icon <- trayIcon . mainWindowBuilder . view =<< readIORef cref
  icon `on` statusIconPopupMenu $ condition cref

condition :: CRef -> Maybe MouseButton -> TimeStamp -> IO()
condition cref m t = do
  ui <- fmap (mainWindowBuilder . view) $ readIORef cref

  mw   <- mainWindow ui
  menu <- mainMenu ui

  isWindowShown <- get mw widgetVisible

  if isWindowShown
   then widgetHide mw
   else menuPopup menu $ fmap (\m' -> (m', t)) m
