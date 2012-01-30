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
import qualified Control.Concurrent.Model.ReactiveModel as GRM

data ModelEvent = UncapturedEvent
                | SenderChanged
                | AccountIdChanged
                | PincodeChanged
                | DestinationChanged
                | MessageChanged 
                | StatusChanged 
                | Initialised
 deriving (Eq,Ord)

instance GRM.Event ModelEvent where
  undoStackChangedEvent = UncapturedEvent
