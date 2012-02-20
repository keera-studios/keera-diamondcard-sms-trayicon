module Controller.Conditions.Message where

import CombinedEnvironment
import Model.ProtectedModel
import View.MainWindow.Objects
import qualified Graphics.UI.Simplify.EntryBasic as Extra

installHandlers :: CEnv -> IO()
installHandlers =
  Extra.installHandlers [ MessageChanged ] messageEntry
    setMessage getMessage
