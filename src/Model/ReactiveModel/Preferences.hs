{-# LANGUAGE TemplateHaskell #-}
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
import Control.Concurrent.Model.THAccessors
import Model.Model
import Model.ReactiveModel.ReactiveModelInternals
import Model.ReactiveModel.ModelEvents

$( reactiveModelAccessors "Sender" "String" )
-- setSender :: ReactiveModel -> String -> ReactiveModel
-- setSender rm n = triggerEvent rm' ev
--   where rm' = rm `onBasicModel` (\b -> b { sender = n })
--         ev  = SenderChanged

-- getSender :: ReactiveModel -> String
-- getSender = sender . basicModel

$( reactiveModelAccessors "AccountId" "String" )
-- setAccountId :: ReactiveModel -> String -> ReactiveModel
-- setAccountId rm n = triggerEvent rm' ev
--   where rm' = rm `onBasicModel` (\b -> b { accountId = n })
--         ev  = AccountIdChanged

-- getAccountId :: ReactiveModel -> String
-- getAccountId = accountId . basicModel

$( reactiveModelAccessors "Pincode" "String" )
-- setPincode :: ReactiveModel -> String -> ReactiveModel
-- setPincode rm n = triggerEvent rm' ev
--   where rm' = rm `onBasicModel` (\b -> b { pincode = n })
--         ev  = PincodeChanged

-- getPincode :: ReactiveModel -> String
-- getPincode = pincode . basicModel
