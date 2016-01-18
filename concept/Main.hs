import Graphics.UI.Gtk

main :: IO ()
main = do
  initGUI
  builder <- builderNew
  builderAddFromFile builder "sms-1.glade"
  mw <- builderGetObject builder castToWindow "window1"
  widgetShowAll mw
  mainGUI
