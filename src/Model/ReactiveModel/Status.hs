module Model.ReactiveModel.Status
   ( getStatus
   , setStatus
   )
  where

-- Internal imports
import Model.Model
import Model.ReactiveModel.ReactiveModelInternals
import Model.ReactiveModel.ModelEvents

setStatus :: ReactiveModel -> Status -> ReactiveModel
setStatus rm n = triggerEvent rm' ev
  where rm' = rm `onBasicModel` (\b -> b { status = n })
        ev  = StatusChanged

getStatus :: ReactiveModel -> Status
getStatus = status . basicModel
