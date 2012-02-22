-- | Contains only one operation to notify that the system's been
-- initialised.
--
-- FIXME: In a very rails-like move, this module will likely be
-- exactly the same for all programs, so we should try to put
-- a "Convention-over-configuration" policy in place and remove this
-- unless it must be adapted by the user.
module Model.ReactiveModel.Initialisation where

import Model.ReactiveModel.ReactiveModelInternals
import Model.ReactiveModel.ModelEvents

initialiseSystem :: ReactiveModel -> ReactiveModel
initialiseSystem = (`triggerEvent` Initialised)
