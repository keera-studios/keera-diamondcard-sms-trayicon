-- | This module holds the functions to access and modify the project name
-- in a reactive model.
module Model.ProtectedModel.SMS
   ( getDestination
   , setDestination
   , getMessage
   , setMessage
   )
  where

-- Internal imports
import Model.ProtectedModel.ProtectedModelInternals
import qualified Model.ReactiveModel as RM

setDestination :: ProtectedModel -> String -> IO()
setDestination pm n = applyToReactiveModel pm (`RM.setDestination` n)

getDestination :: ProtectedModel -> IO String
getDestination = (`onReactiveModel` RM.getDestination)

setMessage :: ProtectedModel -> String -> IO()
setMessage pm n = applyToReactiveModel pm (`RM.setMessage` n)

getMessage :: ProtectedModel -> IO String
getMessage = (`onReactiveModel` RM.getMessage)