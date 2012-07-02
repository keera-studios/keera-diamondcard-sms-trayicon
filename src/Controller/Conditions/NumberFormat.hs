module Controller.Conditions.NumberFormat where

import Data.Char (isDigit)
import Graphics.UI.Gtk.Entry.FormatEntry (formatEntrySetCheckFunction)

import CombinedEnvironment

installHandlers :: CEnv -> IO()
installHandlers cenv = do
  let entry = destinationEntry $ view cenv
  formatEntrySetCheckFunction entry numberOk

numberOk :: String -> Bool
numberOk ('0':'0':_) = False
numberOk n = all isDigit n
