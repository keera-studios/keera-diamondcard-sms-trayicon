-- | The send button is enabled only when the text and the phone number
-- fulfill certain conditions.
--
-- The conditions are: message length is <= 160 characters, the number is at
-- least 6 digits long and has the correct format (doesn't begin with a 0, does
-- not contain letters, etc).
--
-- Copyright   : (C) Keera Studios Ltd, 2015
-- License     : BSD3
-- Maintainer  : support@keera.co.uk
module Controller.Conditions.CanSend where

import Control.Monad
import Graphics.UI.Gtk
import Graphics.UI.Gtk.Entry.FormatEntry

import CombinedEnvironment

-- | Detects changes to the text fields and updates the send button's
-- sensitive status
installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
  -- Obtain elements from the view
  msgEntry <- messageEntry $ uiBuilder $ view cenv
  let destEntry = destinationEntry $ view cenv

  -- Install handlers
  msgEntry `on` editableChanged $ condition cenv
  destEntry `on` editableChanged $ condition cenv

  -- Make button initially disabled
  send <- sendBtn $ uiBuilder $ view cenv
  widgetSetSensitive send False

-- | Determines whether the entries have the proper format and updates the
-- sensibility of the send button.
condition :: CEnv -> IO()
condition cenv = postGUIAsync $ void $ do

  -- Obtain elements from the view
  msgEntry <- messageEntry $ uiBuilder $ view cenv
  let destEntry = destinationEntry $ view cenv

  -- Determine whether the format is correct for both of them
  msg <- get msgEntry entryText
  let msgOk = length (msg :: String) <= 160

  num <- get destEntry entryText
  numOk1 <- formatEntryHasCorrectFormat destEntry
  let numOk2 = length (num :: String) >= 6
      numOk  = numOk1 && numOk2

  -- Update the button's sensibility
  send <- sendBtn $ uiBuilder $ view cenv
  widgetSetSensitive send (msgOk && numOk)
