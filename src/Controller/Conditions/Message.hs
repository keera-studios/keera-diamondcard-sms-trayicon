-- | This module captures two conditions presented in the sms window:
-- * The text entry for the message field holds the same value as the
-- model's message field
-- * The text entry for the destination field holds the same value as the
-- model's destination field
module Controller.Conditions.Message where

-- import CombinedEnvironment
-- import Model.ProtectedModel
-- import View.MainWindow.Objects
-- import qualified Graphics.UI.Simplify.EntryBasic as Extra

import CombinedEnvironment
import Data.ReactiveValue
import Graphics.UI.Gtk.Reactive -- hiding ((=:=))
import Hails.MVC.Model.ProtectedModel.Reactive
import Hails.MVC.View.GladeView
-- import Model.ProtectedModel
-- import View.MainWindow.Objects

installHandlers :: CEnv -> IO()
installHandlers cenv = do
  messageEntryText     <- fmap entryTextReactive $ messageEntry $ ui $ view cenv
  destinationEntryText <- fmap entryTextReactive $ destinationEntry $ ui $ view cenv
  let messageField'     = mkFieldAccessor messageField $ model cenv
      destinationField' = mkFieldAccessor destinationField $ model cenv

  messageField'     =:= messageEntryText
  destinationField' =:= destinationEntryText
  
  -- installConditions cenv
  --   [ messageEntry     =:= messageField
  --   , destinationEntry =:= destinationField
  --   ]
