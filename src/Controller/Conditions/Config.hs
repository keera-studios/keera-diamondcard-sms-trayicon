module Controller.Conditions.Config where

import qualified Control.Exception    as E
import           Control.Monad
import           System.FilePath
import           System.Directory

import CombinedEnvironment
import Model.ProtectedModel

installHandlers :: CRef -> IO()
installHandlers cref = do
  pm <- fmap model $ readIORef cref
  onEvent pm Initialised      $ conditionRead cref
  onEvent pm SenderChanged    $ conditionSave cref
  onEvent pm AccountIdChanged $ conditionSave cref
  onEvent pm PincodeChanged   $ conditionSave cref

conditionSave :: CRef -> IO()
conditionSave cref = void $ E.handle (anyway (return ())) $ do
  dir <- getAppUserDataDirectory "diamondcard-sms"
  createDirectoryIfMissing True dir
  let file = dir </> "config"
  pm <- fmap model $ readIORef cref
  acc  <- getAccountId pm
  pin  <- getPincode   pm
  from <- getSender    pm
  writeFile file $ show (acc, pin, from)

conditionRead :: CRef -> IO()
conditionRead cref = void $ E.handle (anyway (return ())) $ do
  dir <- getAppUserDataDirectory "diamondcard-sms"
  let file = dir </> "config"

  pm <- fmap model $ readIORef cref
  c  <- readFile file
  let [((acc, pin, from), _)] = reads c
  setAccountId pm acc
  setPincode   pm pin
  setSender    pm from

anyway :: IO a -> E.SomeException -> IO a
anyway f _ = f
