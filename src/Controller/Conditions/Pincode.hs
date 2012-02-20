module Controller.Conditions.Pincode where

import CombinedEnvironment
import Model.ProtectedModel
import View.MainWindow.Objects
import qualified Graphics.UI.Simplify.EntryBasic as Extra

installHandlers :: CEnv -> IO()
installHandlers =
  Extra.installHandlers [ PincodeChanged ] preferencesPincodeEntry
    setPincode getPincode
