-- | Send the current message to the currently selected phone number
--
-- Copyright   : (C) Keera Studios Ltd, 2015
-- License     : BSD3
-- Maintainer  : support@keera.co.uk
module Controller.Conditions.Send where

import Control.Concurrent
import Control.Monad
import Graphics.UI.Gtk
import Network.SMS.DiamondCard

import CombinedEnvironment
import Model.Model

-- | Send when the send button is pressed
installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 send <- sendBtn $ uiBuilder $ view cenv
 send `onClicked` condition cenv

-- | Send the message
condition :: CEnv -> IO()
condition cenv = postGUIAsync $ void $ do

  -- Hide the window if it's shown
  mw <- mainWindow $ uiBuilder $ view cenv
  isWindowShown <- get mw widgetVisible
  when isWindowShown $ widgetHide mw

  -- Send the message asynchronously
  forkIO $ do
    let pm = model cenv

    -- Update model status
    setStatus pm StatusSending

    -- Get necessary fields from model
    accountId <- getAccountId pm
    pincode   <- getPincode pm
    message   <- getMessage pm
    from      <- getSender pm
    to        <- getDestination pm

    -- Send and get result
    rs <- sendSMS accountId pincode message from [to]

    -- Update model with result of sending
    case rs of
      SMSApparentlySent -> setStatus pm StatusSentOk
      SMSNotSent result -> setStatus pm StatusSentWrong
