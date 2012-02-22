{-# LANGUAGE TemplateHaskell #-}
-- | This module holds the functions to access and modify the reactive
-- fields of a reactive model. It simply declares the names of the
-- fields in the basic model and their types.
module Model.ProtectedModel.ProtectedFields where

-- Internal imports
import           Control.Concurrent.Model.THFields
import           Model.Model
import           Model.ProtectedModel.ProtectedModelInternals
import           Model.ProtectedModel.Reactive
import qualified Model.ReactiveModel as RM

-- The system status
protectedField "Status"      "Status"

-- The SMS contents and the destination number
protectedField "Destination" "String"
protectedField "Message"     "String"
 
-- The configuration data
protectedField "Sender"      "String"
protectedField "AccountId"   "String"
protectedField "Pincode"     "String"