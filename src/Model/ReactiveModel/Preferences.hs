-- | This module holds the functions to access and modify the project name
-- in a reactive model.
module Model.ReactiveModel.Preferences
   ( getSender
   , setSender
   , getAccountId
   , setAccountId
   , getPincode
   , setPincode
   )
  where

-- Internal imports
import Model.Model
import Model.ReactiveModel.ReactiveModelInternals
import Model.ReactiveModel.ModelEvents

setSender :: ReactiveModel -> String -> ReactiveModel
setSender rm n = triggerEvent rm' ev
  where rm' = rm `onBasicModel` (\b -> b { sender = n })
        ev  = SenderChanged

getSender :: ReactiveModel -> String
getSender = sender . basicModel

setAccountId :: ReactiveModel -> String -> ReactiveModel
setAccountId rm n = triggerEvent rm' ev
  where rm' = rm `onBasicModel` (\b -> b { accountId = n })
        ev  = AccountIdChanged

getAccountId :: ReactiveModel -> String
getAccountId = accountId . basicModel

setPincode :: ReactiveModel -> String -> ReactiveModel
setPincode rm n = triggerEvent rm' ev
  where rm' = rm `onBasicModel` (\b -> b { pincode = n })
        ev  = PincodeChanged

getPincode :: ReactiveModel -> String
getPincode = pincode . basicModel
