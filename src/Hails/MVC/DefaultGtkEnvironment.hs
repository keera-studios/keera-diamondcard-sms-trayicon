-- | The environment that contains both the view and the model.
--
-- | FIXME: In a very rails-like move, this module will likely be
-- exactly the same for all programs, so we should try to put
-- a "Convention-over-configuration" policy in place and remove this
-- unless it must be adapted by the user.
module Hails.MVC.DefaultGtkEnvironment
   ( view
   , GEnv.model
   , GEnv.createCEnv
   , GEnv.installCondition
   , GEnv.installConditions
   )
  where

-- Internal libraries
import qualified Graphics.UI.Gtk.GtkView                as GtkView
import qualified Control.MVC.GenericCombinedEnvironment as GEnv
import Control.Concurrent.Model.ReactiveModel

view :: (Event c, GtkView.GtkGUI a) => GEnv.CEnv a b c -> a
view = GtkView.getGUI . GEnv.view