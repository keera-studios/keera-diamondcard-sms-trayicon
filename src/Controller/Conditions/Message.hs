-- | This module captures two conditions presented in the sms window:
-- * The text entry for the message field holds the same value as the
-- model's message field
-- * The text entry for the destination field holds the same value as the
-- model's destination field
module Controller.Conditions.Message where

import CombinedEnvironment
import Data.ReactiveValue
import Graphics.UI.Gtk.Reactive
import Hails.MVC.Model.ProtectedModel.Reactive

installHandlers :: CEnv -> IO()
installHandlers cenv = do
  -- View
  messageEntryText     <- fmap entryTextReactive $ messageEntry $ ui $ view cenv
  let destinationEntryText = entryTextReactive $ destinationEntry $ view cenv

  -- Model
  let messageField'     = mkFieldAccessor messageField $ model cenv
      destinationField' = mkFieldAccessor destinationField $ model cenv

  -- Conditions
  messageField'     =:= messageEntryText
  destinationField' =:= destinationEntryText
