{-# LANGUAGE TemplateHaskell #-}
-- | This module holds the functions to access and modify the project name
-- in a reactive model.
module Model.ProtectedModel.Status
   ( getStatus
   , setStatus
   )
  where

-- Internal imports
import           Control.Concurrent.Model.THAccessors
import           Model.Model
import           Model.ProtectedModel.ProtectedModelInternals
import qualified Model.ReactiveModel as RM

$( protectedModelAccessors "Status" "Status" )