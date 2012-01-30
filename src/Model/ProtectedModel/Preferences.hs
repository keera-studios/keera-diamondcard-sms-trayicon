-- | This module holds the functions to access and modify the project name
-- in a reactive model.
module Model.ProtectedModel.Preferences
   ( getSender
   , setSender
   , getAccountId
   , setAccountId
   , getPincode
   , setPincode
   )
  where

-- Internal imports
import Model.ProtectedModel.ProtectedModelInternals
import qualified Model.ReactiveModel as RM

setSender :: ProtectedModel -> String -> IO()
setSender pm n = applyToReactiveModel pm (`RM.setSender` n)

getSender :: ProtectedModel -> IO String
getSender = (`onReactiveModel` RM.getSender)

setAccountId :: ProtectedModel -> String -> IO()
setAccountId pm n = applyToReactiveModel pm (`RM.setAccountId` n)

getAccountId :: ProtectedModel -> IO String
getAccountId = (`onReactiveModel` RM.getAccountId)

setPincode :: ProtectedModel -> String -> IO()
setPincode pm n = applyToReactiveModel pm (`RM.setPincode` n)

getPincode :: ProtectedModel -> IO String
getPincode = (`onReactiveModel` RM.getPincode)
