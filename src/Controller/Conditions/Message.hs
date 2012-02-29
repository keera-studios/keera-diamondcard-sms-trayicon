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
import Graphics.UI.Gtk.Reactive
-- import Model.ProtectedModel
-- import View.MainWindow.Objects

installHandlers :: CEnv -> IO()
installHandlers cenv = do
  messageEntry     <- cenvReactiveEntry messageEntry     cenv
  destinationEntry <- cenvReactiveEntry destinationEntry cenv
  installConditions cenv
    [ messageEntry     =:= messageField
    , destinationEntry =:= destinationField
    ]
