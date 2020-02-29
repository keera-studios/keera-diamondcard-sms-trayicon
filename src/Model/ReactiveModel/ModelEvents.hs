{-# LANGUAGE DeriveDataTypeable #-}
-- | This module contains all the events in our program.
--
-- FIXME: Because we want events to be comparable, we need to use the
-- same datatype. It remains to be checked whether using an instance
-- of Typeable and an existential type will be enough to have a good
-- instance of Eq and therefore a heterogeneous model (wrt. events).
--
-- Copyright   : (C) Keera Studios Ltd, 2015
-- License     : BSD3
-- Maintainer  : support@keera.co.uk
module Model.ReactiveModel.ModelEvents
  ( ModelEvent ( SenderChanged
               , AccountIdChanged
               , PincodeChanged
               , DestinationChanged
               , MessageChanged
               , StatusChanged
               , Initialised
               )
  ) where

-- import GenericModel.GenericModelEvent
import qualified Hails.MVC.Model.ReactiveModel as GRM
import Hails.MVC.Model.ReactiveModel.Events
-- import Data.Typeable

data ModelEvent = UncapturedEvent
                | SenderChanged
                | AccountIdChanged
                | PincodeChanged
                | DestinationChanged
                | MessageChanged
                | StatusChanged
                | Initialised
 deriving (Eq,Ord,Show)

instance GRM.Event ModelEvent where
  undoStackChangedEvent = UncapturedEvent

instance InitialisedEvent ModelEvent where
  initialisedEvent = Initialised
