-- | This module contains oprations to access the objects in this
-- interface, and one to obtain a builder from which they can be
-- accessed.
--
-- The code to generate the obBuilder's from the field name and the
-- type is 5 lines long. TH has linking problems on windows, but not
-- all OSs are so definicient, so we should definitely use that code
-- here. It wouldn't be too hard to create a variant that takes the
-- type of the element from the glade file.
--
-- Also, part of this code is too similar to that of other projects.
-- In particular, the loadInterface and onBuilder functions could
-- be moved to other modules.
module View.MainWindow.Objects where

import Graphics.UI.Gtk
import Paths_keera_diamondcard_sms_trayicon

-- | Returns a builder from which the objects in this part of the interface
-- can be accessed.
loadInterface :: IO Builder
loadInterface = do
  builder <- builderNew
  builderPath <- getDataFileName "Interface.glade"
  builderAddFromFile builder builderPath
  return builder
  
onBuilder :: (GObjectClass cls) =>
               (GObject -> cls) -> String -> Builder -> IO cls
onBuilder f s b = builderGetObject b f s

-- | Returns the IDE's main window.
mainWindow :: Builder -> IO Window
mainWindow = onBuilder castToWindow "mainWindow"

destinationEntry :: Builder -> IO Entry
destinationEntry = onBuilder castToEntry "destinationEntry"

messageEntry :: Builder -> IO Entry
messageEntry = onBuilder castToEntry "messageEntry"

trayIcon :: Builder -> IO StatusIcon
trayIcon = onBuilder castToStatusIcon "trayIcon"

mainMenu :: Builder -> IO Menu
mainMenu = onBuilder castToMenu "mainMenu"

mainMenuPreferences :: Builder -> IO MenuItem
mainMenuPreferences = onBuilder castToMenuItem "mainMenuPreferences"

mainMenuQuit :: Builder -> IO MenuItem
mainMenuQuit = onBuilder castToMenuItem "mainMenuQuit"

preferencesDialog :: Builder -> IO Dialog
preferencesDialog = onBuilder castToDialog "preferencesDialog"

preferencesAccountIDEntry :: Builder -> IO Entry
preferencesAccountIDEntry = onBuilder castToEntry "preferencesAccountIDEntry"

preferencesPincodeEntry :: Builder -> IO Entry
preferencesPincodeEntry = onBuilder castToEntry "preferencesPincodeEntry"

preferencesSenderEntry :: Builder -> IO Entry
preferencesSenderEntry = onBuilder castToEntry "preferencesSenderEntry"

sendBtn :: Builder -> IO Button
sendBtn = onBuilder castToButton "sendBtn"