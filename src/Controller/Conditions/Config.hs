module Controller.Conditions.Config where

import Hails.MVC.Controller.Conditions.Config
import CombinedEnvironment

installHandlers :: CEnv -> IO()
installHandlers cenv = do
  onEvent pm Initialised $ defaultRead  myConfigIO app cenv
  onEvents pm [ SenderChanged, AccountIdChanged, PincodeChanged ] $
    defaultWrite myConfigIO app cenv
 where pm  = model cenv
       app = "diamondcard-sms"

myConfigIO :: ConfigIO CEnv
myConfigIO = (myConfigRead, myConfigShow)

myConfigRead :: Maybe String -> CEnv -> IO()
myConfigRead Nothing  _    = return ()
myConfigRead (Just c) cenv = do
   setAccountId pm acc
   setPincode   pm pin
   setSender    pm from
  where pm = model cenv
        [((acc, pin, from), _)] = reads c

myConfigShow :: CEnv -> IO String
myConfigShow cenv = do
   acc  <- getAccountId pm
   pin  <- getPincode   pm
   from <- getSender    pm
   return $ show (acc, pin, from)
  where pm = model cenv
