-- | Updates the label with the number of remaining characters
--
-- View => View
module Controller.Conditions.InfoLabel where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment

-- | Updates the label when the message changes
installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 msgEntry <- messageEntry $ uiBuilder $ view cenv
 msgEntry `on` editableChanged $ condition cenv

-- | Updates the label using the length of the message in the entry
condition :: CEnv -> IO()
condition cenv = postGUIAsync $ void $ do
  lbl <- infoLbl $ uiBuilder $ view cenv

  -- Calculate current msg length
  msgEntry <- messageEntry $ uiBuilder $ view cenv
  msg <- get msgEntry entryText
  let len = length (msg :: String)

  -- Update label with new text
  let label = show (160 - len) ++ " characters left"
  labelSetText lbl label
