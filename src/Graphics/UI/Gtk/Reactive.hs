-- | Contains functions to define fields from Gtk widgets. In reality,
-- most widgets have different properties, all of which can be treated
-- as different fields. This module oversimplifies that vision and
-- provides one field for the most "important" of those attributes: a string
-- field for a text-box, a bool field for a checkbox, etc.
-- 
-- This module is deeply incomplete. Feel free to add other definitions
-- in you find them useful.
--
-- Also, it should not be here at all. Instead, it should be moved
-- to a separate library.
module Graphics.UI.Gtk.Reactive
   ( module Graphics.UI.Gtk.Reactive
   , module Exported
   )
  where

-- External libraries
import Control.Monad
import Graphics.UI.Gtk

-- Internal libraries
import CombinedEnvironment
import Graphics.UI.Simplify.Basic
import Graphics.UI.Simplify.Reactive as Exported
import Graphics.UI.Gtk.Helpers.Combo
import View

-- | Accesses a Reactive View Field from a CEnv
cenvReactiveField :: (a -> ReactiveViewField b) -> Accessor a
                  -> CEnv -> IO (ReactiveViewField b)
cenvReactiveField f entryF cenv = 
  fmap f $ entryF $ mainWindowBuilder $ view cenv

-- An Entry's main reactive view field is a string with the contents
-- of the text box
type ReactiveViewEntry = ReactiveViewField String

cenvReactiveEntry :: Accessor Entry -> CEnv -> IO ReactiveViewEntry
cenvReactiveEntry = cenvReactiveField reactiveEntry

reactiveEntry :: Entry -> ReactiveViewEntry
reactiveEntry entry = ReactiveViewField
 { onChange = void . (onEditableChanged entry)
 , rvfGet   = get entry entryText
 , rvfSet   = \t -> set entry [ entryText := t ]
 }

-- A Menu Item's reactive view is a boolean that represents whether
-- the item is active or not
cenvReactiveCheckMenuItem :: Accessor CheckMenuItem -> CEnv -> IO (ReactiveViewField Bool)
cenvReactiveCheckMenuItem = cenvReactiveField reactiveCheckMenuItem

reactiveCheckMenuItem :: CheckMenuItem -> ReactiveViewField Bool
reactiveCheckMenuItem item = ReactiveViewField
 { onChange = void . (on item checkMenuItemToggled)
 , rvfGet   = checkMenuItemGetActive item
 , rvfSet   = checkMenuItemSetActive item
 }

-- A Toggle Button's reactive view is a boolean that represents whether
-- the item is active or not
cenvReactiveToggleButton :: ToggleButtonClass a => Accessor a -> CEnv -> IO (ReactiveViewField Bool)
cenvReactiveToggleButton = cenvReactiveField reactiveToggleButton

reactiveToggleButton :: ToggleButtonClass a => a -> ReactiveViewField Bool
reactiveToggleButton item = ReactiveViewField
 { onChange = void . (on item toggled)
 , rvfGet   = toggleButtonGetActive item
 , rvfSet   = toggleButtonSetActive item
 }

-- A spin button's reactive view is an integer with the value represented
-- by the text it holds
cenvReactiveSpinButton :: SpinButtonClass a => Accessor a -> CEnv -> IO (ReactiveViewField Int)
cenvReactiveSpinButton = cenvReactiveField reactiveSpinButton

reactiveSpinButton :: SpinButtonClass a => a -> ReactiveViewField Int
reactiveSpinButton item = ReactiveViewField
 { onChange = void . (onValueSpinned item)
 , rvfGet   = spinButtonGetValueAsInt item
 , rvfSet   = spinButtonSetValue item . fromIntegral
 }

-- A Combo box's reactive view is the selected element.
-- Because there's no guarantee that the liststore corresponds
-- to the given combo box, this function is unsafe.
cenvReactiveTypedComboBoxUnsafe :: (Eq a) => ListStore a -> Accessor ComboBox
                                -> CEnv -> IO (ReactiveViewField a)
cenvReactiveTypedComboBoxUnsafe ls = cenvReactiveField (reactiveTypedComboBoxUnsafe ls)

reactiveTypedComboBoxUnsafe :: (Eq a) => ListStore a -> ComboBox -> ReactiveViewField a
reactiveTypedComboBoxUnsafe ls item = ReactiveViewField
 { onChange = void . (on item changed)
 , rvfGet   = typedComboBoxGetSelectedUnsafe (item, ls)
 , rvfSet   = typedComboBoxSetSelected (item, ls)
 }
