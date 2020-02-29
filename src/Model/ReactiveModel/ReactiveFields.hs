{-# LANGUAGE TemplateHaskell #-}
-- | This module contains the reactive fields that the ReactiveModel lifts
-- from the BasicModel.
--
-- Copyright   : (C) Keera Studios Ltd, 2015
-- License     : BSD3
-- Maintainer  : support@keera.co.uk
module Model.ReactiveModel.ReactiveFields where

-- Semi-Internal imports
import qualified Hails.MVC.Model.ReactiveFields as RFs
import Hails.MVC.Model.ReactiveFields
         (fieldGetter, fieldSetter, preTrue)
import Hails.MVC.Model.THFields
-- import Hails.MVC.Model.ReactiveModel

-- Internal imports
import Model.Model
import Model.ReactiveModel.ReactiveModelInternals
import Model.ReactiveModel.ModelEvents

-- A Field of type A lets us access a reactive field of type a from
-- a Model, and it triggers a ModelEvent
type Field a = RFs.Field a Model ModelEvent

-- System status
reactiveField "Status"      [t|Status|]

-- Preferences
reactiveField "Sender"      [t|String|]
reactiveField "AccountId"   [t|String|]
reactiveField "Pincode"     [t|String|]

-- Message contents and destination number
reactiveField "Destination" [t|String|]
reactiveField "Message"     [t|String|]
