-- | Read and write the configuration to a config file. The file is located in
-- the $HOME dir in linux, and the application data directory in windows.
--
-- Copyright   : (C) Keera Studios Ltd, 2015
-- License     : BSD3
-- Maintainer  : support@keera.co.uk
module Controller.Conditions.Config where

import Hails.MVC.Controller.Conditions.Config
import CombinedEnvironment

-- | Reads the config when the program starts, saves it when the configuration
-- is changed.
installHandlers :: CEnv -> IO()
installHandlers cenv = do
  onEvent pm Initialised $ defaultRead  myConfigIO app cenv
  mapM_ (\e -> onEvent pm e (defaultWrite myConfigIO app cenv))
    [ SenderChanged, AccountIdChanged, PincodeChanged ]
 where pm  = model cenv
       app = "diamondcard-sms"

-- Contains the config reader/writer
myConfigIO :: ConfigIO CEnv
myConfigIO = (myConfigRead, myConfigShow)

-- | Reads a config from a String
myConfigRead :: Maybe String -> CEnv -> IO()
myConfigRead Nothing  _    = return ()
myConfigRead (Just c) cenv = do
   setAccountId pm acc
   setPincode   pm pin
   setSender    pm from
  where pm = model cenv
        [((acc, pin, from), _)] = reads c

-- | Writes the config to a string
myConfigShow :: CEnv -> IO String
myConfigShow cenv = do
   acc  <- getAccountId pm
   pin  <- getPincode   pm
   from <- getSender    pm
   return $ show (acc, pin, from)
  where pm = model cenv
