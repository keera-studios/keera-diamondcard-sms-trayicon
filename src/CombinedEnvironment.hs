-- | The environment that contains both the view and the model.
--
-- | FIXME: In a very rails-like move, this module will likely be
-- exactly the same for all programs, so we should try to put
-- a "Convention-over-configuration" policy in place and remove this
-- unless it must be adapted by the user.
module CombinedEnvironment
   ( view
   , CEnv
   , GEnv.model
   , GEnv.createCEnv
   , GEnv.installCondition
   , GEnv.installConditions
   , updateView
   , onViewAsync
   )
  where

-- Internal libraries
import qualified Graphics.UI.Gtk.GtkView                as GtkView
import qualified Control.MVC.GenericCombinedEnvironment as GEnv

import View
import Model.ReactiveModel.ModelEvents
import Model.Model

type CEnv = GEnv.CEnv View Model ModelEvent

view :: CEnv -> View
view = GtkView.getGUI . GEnv.view

updateView :: CEnv -> View -> CEnv
updateView cenv v = cenv { GEnv.view = GtkView.GtkView v }
