module Controller.Conditions.AccountID where

import CombinedEnvironment
import Model.ProtectedModel
import View.MainWindow.Objects
import qualified Graphics.UI.Simplify.EntryBasic as Extra

installHandlers :: CRef -> IO()
installHandlers =
  Extra.installHandlers [ AccountIdChanged ] preferencesAccountIDEntry
    setAccountId getAccountId
