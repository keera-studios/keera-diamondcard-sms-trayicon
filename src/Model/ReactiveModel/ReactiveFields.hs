{-# LANGUAGE TemplateHaskell #-}
-- | This module contains the reactive fields that the ReactiveModel lifts
-- from the BasicModel.
module Model.ReactiveModel.ReactiveFields where

-- Internal imports
import qualified Hails.MVC.Model.ReactiveFields as RFs
import Hails.MVC.Model.ReactiveFields 
         (fieldGetter, fieldSetter, preTrue)
import Hails.MVC.Model.THFields
import Model.Model
import Model.ReactiveModel.ReactiveModelInternals
import Model.ReactiveModel.ModelEvents

-- A Field of type A lets us access a reactive field of type a from
-- a Model, and it triggers a ModelEvent
type Field a = RFs.Field a Model ModelEvent

-- System status
reactiveField "Status"      "Status"

-- Preferences
reactiveField "Sender"      "String"
reactiveField "AccountId"   "String"
reactiveField "Pincode"     "String"

-- Message contents and destination number
reactiveField "Destination" "String"
reactiveField "Message"     "String"