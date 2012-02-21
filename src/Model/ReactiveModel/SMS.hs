{-# LANGUAGE TemplateHaskell #-}
module Model.ReactiveModel.SMS
   ( getDestination
   , setDestination
   , getMessage
   , setMessage
   )
  where

-- Internal imports
import Control.Concurrent.Model.THAccessors
import Model.Model
import Model.ReactiveModel.ReactiveModelInternals
import Model.ReactiveModel.ModelEvents

$( reactiveModelAccessors "Destination" "String" )

-- setDestination :: ReactiveModel -> String -> ReactiveModel
-- setDestination rm n = triggerEvent rm' ev
--   where rm' = rm `onBasicModel` (\b -> b { destination = n })
--         ev  = DestinationChanged

-- getDestination :: ReactiveModel -> String
-- getDestination = destination . basicModel

$( reactiveModelAccessors "Message" "String" )

-- setMessage :: ReactiveModel -> String -> ReactiveModel
-- setMessage rm n = triggerEvent rm' ev
--   where rm' = rm `onBasicModel` (\b -> b { message = n })
--         ev  = MessageChanged

-- getMessage :: ReactiveModel -> String
-- getMessage = message . basicModel