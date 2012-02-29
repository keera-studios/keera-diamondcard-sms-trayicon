module Controller.Conditions.Send where

import Control.Concurrent
import Control.Monad
import Graphics.UI.Gtk
import Network.SMS.DiamondCard

import CombinedEnvironment
import Model.Model
-- import Model.ProtectedModel
-- import View
-- import View.MainWindow.Objects

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 send <- sendBtn $ uiBuilder $ view cenv
 send `onClicked` condition cenv

condition :: CEnv -> IO()
condition cenv = onViewAsync $ void $ do

  -- Hide the window if it's shown
  mw <- mainWindow $ uiBuilder $ view cenv
  isWindowShown <- get mw widgetVisible
  when isWindowShown $ widgetHide mw

  -- Send the message asynchronously
  forkIO $ do 
    let pm = model cenv

    setStatus pm StatusSending

    accountId <- getAccountId pm
    pincode   <- getPincode pm
    message   <- getMessage pm
    from      <- getSender pm
    to        <- getDestination pm

    rs <- sendSMS accountId pincode message from [to]     
                 
    case rs of
      SMSApparentlySent -> setStatus pm StatusSentOk
      SMSNotSent result -> setStatus pm StatusSentWrong
