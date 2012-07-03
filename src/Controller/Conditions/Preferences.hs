-- | This module captures three conditions presented in the
-- preferences dialog:
-- * The text entry for the Account ID field holds the same value as the
-- model's accountId field
-- * The text entry for the Pincode field holds the same value as the
-- model's pincode field
-- * The text entry for the Sender field holds the same value as the
-- model's sender field
module Controller.Conditions.Preferences where

import CombinedEnvironment
import Graphics.UI.Gtk.Reactive
import Data.ReactiveValue
import Hails.MVC.Model.ProtectedModel.Reactive
import Hails.MVC.View.GladeView

installHandlers :: CEnv -> IO()
installHandlers cenv = do
  -- We get each field from the model and the view
  senderEntry <- fmap entryTextReactive $ preferencesSenderEntry $ ui $ view cenv
  let senderField' = mkFieldAccessor senderField $ model cenv

  accountIdEntry <- fmap entryTextReactive $ preferencesAccountIDEntry $ ui $ view cenv
  let accountIdField' = mkFieldAccessor accountIdField $ model cenv

  pincodeEntry <- fmap entryTextReactive $ preferencesPincodeEntry $ ui $ view cenv
  let pincodeField' = mkFieldAccessor pincodeField $ model cenv

  -- We establish the equations (in this case, from model to view)
  senderEntry    =:= senderField'
  accountIdEntry =:= accountIdField'
  pincodeEntry   =:= pincodeField'
