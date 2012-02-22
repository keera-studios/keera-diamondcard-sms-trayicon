-- | Contains basic operations related to the GUI
--
-- | FIXME: In a very rails-like move, this module will likely be
-- exactly the same for all programs, so we should try to put
-- a "Convention-over-configuration" policy in place and remove this
-- unless it must be adapted by the user.
module View where

-- External libraries
import Control.Monad
import Graphics.UI.Gtk
import Graphics.UI.Gtk.GtkView (GtkGUI(..))
import qualified Graphics.UI.Gtk.GtkView as GtkView

-- Internal libraries
import View.MainWindow.Objects

-- | Initialises the GUI. This must be called before
-- any other GUI operation.
initView :: IO ()
initView = void initGUI

-- | Starts a thread for the view.
startView :: IO ()
startView = mainGUI

-- | Executes an operation on the view thread synchronously
onViewSync :: IO a -> IO a
onViewSync = postGUISync

-- | Executes an operation on the view thread asynchronously
onViewAsync :: IO () -> IO ()
onViewAsync = postGUIAsync

-- | Destroys the view thread
destroyView :: IO ()
destroyView = mainQuit

-- | Add all initialisers to the initialise operation and store
-- everything we'll need in the view.
instance GtkGUI View where
  initialise = fmap View loadInterface 

-- | This datatype should hold the elements that we must track in the
-- future (for instance, treeview models)
data View = View
  { mainWindowBuilder :: Builder }