-- | The status icon in the program changes to reflect the internal
-- program status.
--
--  Resets the program status when the user clicks on the icon.
--
-- Copyright   : (C) Keera Studios Ltd, 2015
-- License     : BSD3
-- Maintainer  : support@keera.co.uk
module Controller.Conditions.Status where

import Control.Arrow
import Control.Monad
import Control.Monad.IfElse
import Graphics.UI.Gtk

import CombinedEnvironment
import Model.Model (Status(..))
import Paths

-- | Updates the icon when the system status changes.
--   Resets the program status when the user clicks on the icon.
installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 let (vw, pm) = (view &&& model) cenv
 onEvent pm StatusChanged $ condition cenv

 icon <- trayIcon $ uiBuilder vw
 icon `on` statusIconActivate $ conditionClick cenv

-- | Updates the icon based on the current status and the image associated to
-- that status.  The tooltip is also changed.
condition :: CEnv -> IO()
condition cenv = postGUIAsync $ do
  let (vw, pm) = (view &&& model) cenv
  icon     <- trayIcon $ uiBuilder vw
  status   <- getStatus pm

  let stView = lookup status statusImage
  awhen stView $ \(filename, tooltip) -> do
    statusIconSetFromFile icon =<< getDataFileName filename
    statusIconSetTooltip  icon tooltip

-- | Resets the program status when the user clicks the tray icon.
conditionClick :: CEnv -> IO()
conditionClick cenv = postGUIAsync $ void $ do
  let pm = model cenv
  status <- getStatus pm

  when (status `elem` [ StatusSentOk, StatusSentWrong ]) $
    setStatus pm StatusIdle

-- | A table that associates an icon and a tooltip to each possible status.
statusImage :: [(Status, (FilePath, String))]
statusImage =
  [ ( StatusIdle      , ("blue-mail-icon.png",      ""                                         ) )
  , ( StatusSending   , ("blue-mail-send-icon.png", "Sending..."                               ) )
  , ( StatusSentOk    , ("green-mail-icon.png",     "Request successfully sent to DiamondCard!") )
  , ( StatusSentWrong , ("red-mail-icon.png",       "The message could not be sent"            ) )
  ]
