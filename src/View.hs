-- | Contains basic operations related to the GUI
--
module View ( module View
            , module Exported
            )
  where

-- External libraries
import Graphics.UI.Gtk
import Graphics.UI.Gtk.Entry.FormatEntry

-- Internal libraries
import Hails.MVC.View.GtkView   as Exported
import Hails.MVC.View.GladeView as Exported
-- import Hails.MVC.View.DefaultViewGtk as Exported
import View.Objects

-- | Add all initialisers to the initialise operation and store
-- everything we'll need in the view. We need this operation here
-- because the URL to the glade file depends on the application
-- name.
instance GtkGUI View where
  initialise = createView

instance GladeView View where
  ui = uiBuilder

data View = View
  { uiBuilder        :: Builder
  , destinationEntry :: FormatEntry
  }

createView :: IO View
createView = do
  bldr     <- loadInterface

  align    <- destinationAlign bldr
  fmtEntry <- formatEntryNew

  containerAdd align fmtEntry

  return View { uiBuilder = bldr
              , destinationEntry = fmtEntry
              }
