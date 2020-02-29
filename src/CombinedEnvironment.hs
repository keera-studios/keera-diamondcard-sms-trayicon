-- | The environment that contains both the view and the model.
--
-- Copyright   : (C) Keera Studios Ltd, 2015
-- License     : BSD3
-- Maintainer  : support@keera.co.uk
module CombinedEnvironment
   ( CEnv
   , module Exported
   )
  where

-- Generic libraries
import qualified Hails.MVC.GenericCombinedEnvironment as GEnv
import Hails.MVC.DefaultGtkEnvironment                as Exported

-- Internal libraries
import Model.ReactiveModel.ModelEvents                as Exported
import Model.ProtectedModel                           as Exported
import Model.Model
import View                                           as Exported
import View.Objects                                   as Exported

-- The simplest definition: a view, a model, and a set of events
type CEnv = GEnv.CEnv View Model ModelEvent
