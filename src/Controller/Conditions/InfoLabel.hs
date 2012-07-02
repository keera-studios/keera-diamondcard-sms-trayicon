module Controller.Conditions.InfoLabel where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 msgEntry <- messageEntry $ uiBuilder $ view cenv
 msgEntry `on` editableChanged $ condition cenv

condition :: CEnv -> IO()
condition cenv = postGUIAsync $ void $ do
  lbl <- infoLbl $ uiBuilder $ view cenv

  msgEntry <- messageEntry $ uiBuilder $ view cenv
  msg <- get msgEntry entryText
  let len = length msg
      label = show (160 - len) ++ " characters left"

  labelSetText lbl label
