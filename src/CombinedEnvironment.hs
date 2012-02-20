module CombinedEnvironment
   ( view
   , CEnv
   , GEnv.model
   , GEnv.createCEnv
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
