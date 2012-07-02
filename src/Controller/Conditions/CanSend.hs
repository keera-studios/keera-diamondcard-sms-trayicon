module Controller.Conditions.CanSend where

import Control.Monad
import Graphics.UI.Gtk
import Graphics.UI.Gtk.Entry.FormatEntry

import CombinedEnvironment

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 msgEntry <- messageEntry $ uiBuilder $ view cenv
 let destEntry = destinationEntry $ view cenv

 msgEntry `on` editableChanged $ condition cenv
 destEntry `on` editableChanged $ condition cenv
 
 send <- sendBtn $ uiBuilder $ view cenv
 widgetSetSensitive send False

condition :: CEnv -> IO()
condition cenv = postGUIAsync $ void $ do
  msgEntry <- messageEntry $ uiBuilder $ view cenv
  let destEntry = destinationEntry $ view cenv

  msg <- get msgEntry entryText
  let msgOk = length msg <= 160

  num <- get destEntry entryText
  numOk1 <- formatEntryHasCorrectFormat destEntry
  let numOk2 = length num >= 6
      numOk  = numOk1 && numOk2

  send <- sendBtn $ uiBuilder $ view cenv
  widgetSetSensitive send (msgOk && numOk)
