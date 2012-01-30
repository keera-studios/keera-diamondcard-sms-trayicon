module Controller.Conditions.Send where

import Control.Concurrent
import Control.Monad
import Graphics.UI.Gtk
import Network.SMS.DiamondCard

import CombinedEnvironment
import Model.Model
import Model.ProtectedModel
import View
import View.MainWindow.Objects

installHandlers :: CRef -> IO()
installHandlers cref = void $ do
 send <- sendBtn . mainWindowBuilder . view =<< readIORef cref
 send `onClicked` condition cref

condition :: CRef -> IO()
condition cref = onViewAsync $ void $ do

  -- Hide the window if it's shown
  mw <- mainWindow . mainWindowBuilder . view =<< readIORef cref
  isWindowShown <- get mw widgetVisible
  when isWindowShown $ widgetHide mw

  -- Send the message asynchronously
  forkIO $ do 
    pm <- fmap model $ readIORef cref

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
