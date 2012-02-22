-- | This module captures three conditions presented in the preferences dialog: 
-- * The text entry for the Account ID field holds the same value as the
-- model's accountId field
-- * The text entry for the Pincode field holds the same value as the
-- model's pincode field
-- * The text entry for the Sender field holds the same value as the
-- model's sender field
module Controller.Conditions.Preferences where

import CombinedEnvironment
import Model.ProtectedModel
import Graphics.UI.Gtk.Reactive
import View.MainWindow.Objects

installHandlers :: CEnv -> IO()
installHandlers cenv = do
  senderEntry    <- cenvReactiveEntry preferencesSenderEntry    cenv
  accountIdEntry <- cenvReactiveEntry preferencesAccountIDEntry cenv
  pincodeEntry   <- cenvReactiveEntry preferencesPincodeEntry   cenv
  installConditions cenv $
    [ senderEntry    =:= senderField
    , accountIdEntry =:= accountIdField
    , pincodeEntry   =:= pincodeField
    ]