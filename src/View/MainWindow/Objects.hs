{-# LANGUAGE TemplateHaskell #-}
-- | This module contains operations to access the objects in the
-- interface, and one to obtain a builder from which they can be
-- accessed.
--
-- The code to generate the obBuilder's from the field name and the
-- type is 5 lines long. TH has linking problems on windows, but not
-- all OSs are so deficient, so we'll definitely use that code
-- here. It wouldn't be too hard to create a variant that takes the
-- type of the element from the glade file (and helds us avoid having
-- to provide the second string).
--
module View.MainWindow.Objects where

-- External imports
import Graphics.UI.Gtk

-- Internal imports
import Hails.Graphics.UI.Gtk.Builder           as HailsBuilder
import Hails.Graphics.UI.Gtk.THBuilderAccessor
import Paths_keera_diamondcard_sms_trayicon

-- | Returns a builder from which the objects in this part of the
-- interface can be accessed.
loadInterface :: IO Builder
loadInterface = HailsBuilder.loadDefaultInterface getDataFileName

-- | Main window and access icon
gtkBuilderAccessor "mainWindow"                "Window"
gtkBuilderAccessor "trayIcon"                  "StatusIcon"

-- | Message data
gtkBuilderAccessor "destinationEntry"          "Entry"
gtkBuilderAccessor "messageEntry"              "Entry"

-- | Send button
gtkBuilderAccessor "sendBtn" "Button"

-- | Popup menu
gtkBuilderAccessor "mainMenu"                  "Menu"
gtkBuilderAccessor "mainMenuPreferences"       "MenuItem"
gtkBuilderAccessor "mainMenuQuit"              "MenuItem"

-- | Preferences
gtkBuilderAccessor "preferencesDialog"         "Dialog"
gtkBuilderAccessor "preferencesAccountIDEntry" "Entry"
gtkBuilderAccessor "preferencesPincodeEntry"   "Entry"
gtkBuilderAccessor "preferencesSenderEntry"    "Entry"