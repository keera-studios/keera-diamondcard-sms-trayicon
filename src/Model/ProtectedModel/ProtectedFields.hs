{-# LANGUAGE TemplateHaskell #-}
-- | This module holds the functions to access and modify the reactive
-- fields of a reactive model. It simply declares the names of the
-- fields in the basic model and their types.
module Model.ProtectedModel.ProtectedFields where

-- Internal imports
import           Hails.MVC.Model.THFields
import           Hails.MVC.Model.ProtectedModel.Reactive
import           Model.Model
import           Model.ProtectedModel.ProtectedModelInternals
import           Model.ReactiveModel.ModelEvents
import qualified Model.ReactiveModel as RM

-- The system status
protectedField "Status"      "Status" "Model" "ModelEvent"

-- The SMS contents and the destination number
protectedField "Destination" "String" "Model" "ModelEvent"
protectedField "Message"     "String" "Model" "ModelEvent"
 
-- The configuration data
protectedField "Sender"      "String" "Model" "ModelEvent"
protectedField "AccountId"   "String" "Model" "ModelEvent"
protectedField "Pincode"     "String" "Model" "ModelEvent"
