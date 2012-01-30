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

installHandlers :: CRef -> IO()
installHandlers cref = void $ do
 pm <- fmap model $ readIORef cref
 onEvent pm StatusChanged $ condition cref

 icon <- trayIcon . mainWindowBuilder . view =<< readIORef cref
 icon `on` statusIconActivate $ conditionClick cref

condition :: CRef -> IO()
condition cref = onViewAsync $ do
  (vw, pm) <- fmap (view &&& model) $ readIORef cref
  icon     <- trayIcon $ mainWindowBuilder vw 
  status   <- getStatus pm

  let stView = lookup status statusImage
  awhen stView $ \(stockId, tooltip) -> do
    statusIconSetFromStock icon stockId
    statusIconSetTooltip   icon tooltip

conditionClick :: CRef -> IO()
conditionClick cref = onViewAsync $ void $ do
  pm <- fmap model $ readIORef cref
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
