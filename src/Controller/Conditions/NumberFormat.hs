-- | Determines whether phone numbers have the right format
--
-- Copyright   : (C) Keera Studios Ltd, 2015
-- License     : BSD3
-- Maintainer  : support@keera.co.uk
module Controller.Conditions.NumberFormat where

import Data.Char (isDigit)
import Graphics.UI.Gtk.Entry.FormatEntry (formatEntrySetCheckFunction)

import CombinedEnvironment

-- | Sets the number checking function on the format entries.
--
-- It's possible that this function should be in the view, but it's not very
-- clear to me whether it should.
installHandlers :: CEnv -> IO()
installHandlers cenv = do
  let entry = destinationEntry $ view cenv
  formatEntrySetCheckFunction entry numberOk

-- | A number is ok if it's composed of just digits and does not begin with 00
numberOk :: String -> Bool
numberOk ('0':'0':_) = False
numberOk n = all isDigit n
