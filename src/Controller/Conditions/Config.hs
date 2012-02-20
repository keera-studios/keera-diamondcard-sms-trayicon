module Controller.Conditions.Config where

import qualified Control.Exception    as E
import           Control.Monad
import           System.FilePath
import           System.Directory

import CombinedEnvironment
import Model.ProtectedModel

installHandlers :: CEnv -> IO()
installHandlers cenv = do
  let pm = model cenv
  onEvent pm Initialised      $ conditionRead cenv
  onEvent pm SenderChanged    $ conditionSave cenv
  onEvent pm AccountIdChanged $ conditionSave cenv
  onEvent pm PincodeChanged   $ conditionSave cenv

conditionSave :: CEnv -> IO()
conditionSave cenv = void $ E.handle (anyway (return ())) $ do
  dir <- getAppUserDataDirectory "diamondcard-sms"
  createDirectoryIfMissing True dir
  let file = dir </> "config"
  let pm   = model cenv
  acc  <- getAccountId pm
  pin  <- getPincode   pm
  from <- getSender    pm
  writeFile file $ show (acc, pin, from)

conditionRead :: CEnv -> IO()
conditionRead cenv = void $ E.handle (anyway (return ())) $ do
  dir <- getAppUserDataDirectory "diamondcard-sms"
  let file = dir </> "config"

  let pm = model cenv
  c  <- readFile file
  let [((acc, pin, from), _)] = reads c
  setAccountId pm acc
  setPincode   pm pin
  setSender    pm from

anyway :: IO a -> E.SomeException -> IO a
anyway f _ = f
