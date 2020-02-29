{-# LANGUAGE TemplateHaskell #-}
-- | This module holds the functions to access and modify the reactive
-- fields of a reactive model. It simply declares the names of the
-- fields in the basic model and their types.
--
-- Copyright   : (C) Keera Studios Ltd, 2015
-- License     : BSD3
-- Maintainer  : support@keera.co.uk
module Model.ProtectedModel.ProtectedFields where

-- Internal imports
import           Hails.MVC.Model.THFields
import           Hails.MVC.Model.ProtectedModel.Reactive
import           Model.Model
import           Model.ProtectedModel.ProtectedModelInternals
import           Model.ReactiveModel.ModelEvents
import qualified Model.ReactiveModel as RM

-- The system status
protectedField "Status"      [t|Status|] "Model" "ModelEvent"

-- The SMS contents and the destination number
protectedField "Destination" [t|String|] "Model" "ModelEvent"
protectedField "Message"     [t|String|] "Model" "ModelEvent"

-- The configuration data
protectedField "Sender"      [t|String|] "Model" "ModelEvent"
protectedField "AccountId"   [t|String|] "Model" "ModelEvent"
protectedField "Pincode"     [t|String|] "Model" "ModelEvent"
