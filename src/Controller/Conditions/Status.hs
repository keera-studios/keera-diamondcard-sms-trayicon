module Controller.Conditions.Status where

import Control.Arrow
import Control.Monad
import Control.Monad.IfElse
import Graphics.UI.Gtk

import CombinedEnvironment
import Model.Model (Status(..))
import Model.ProtectedModel
import View
import View.MainWindow.Objects

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 let pm = model cenv
 onEvent pm StatusChanged $ condition cenv

 icon <- trayIcon $ mainWindowBuilder $ view cenv
 icon `on` statusIconActivate $ conditionClick cenv

condition :: CEnv -> IO()
condition cenv = onViewAsync $ do
  let (vw, pm) = (view &&& model) cenv
  icon     <- trayIcon $ mainWindowBuilder vw 
  status   <- getStatus pm

  let stView = lookup status statusImage
  awhen stView $ \(stockId, tooltip) -> do
    statusIconSetFromStock icon stockId
    statusIconSetTooltip   icon tooltip

conditionClick :: CEnv -> IO()
conditionClick cenv = onViewAsync $ void $ do
  let pm = model cenv
  status <- getStatus pm

  when (status `elem` [ StatusSentOk, StatusSentWrong ]) $ 
    setStatus pm StatusIdle

statusImage :: [(Status, (StockId, String))]
statusImage =
  [ ( StatusIdle      , ("gtk-add",     ""                                         ) )
  , ( StatusSending   , ("gtk-refresh", "Sending..."                               ) )
  , ( StatusSentOk    , ("gtk-ok",      "Request successfully sent to DiamondCard!") )
  , ( StatusSentWrong , ("gtk-cancel",  "The message could not be sent"            ) )
  ]
