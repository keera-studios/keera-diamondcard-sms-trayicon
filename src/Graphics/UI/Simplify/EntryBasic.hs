-- This is a generic helper that maintains the coherence
-- between an entry (text box) in a gtk view and
-- a String field in a Protected model.
--
-- NOTE: This way of building apps is outdated, the
-- new interface will include reactive fields in the protected
-- model. Fields will be RO, WO or WR, and the operations
-- will be derived for them automagically.
module Graphics.UI.Simplify.EntryBasic
    (installHandlers)
  where

-- External libraries
import Control.Arrow
import Control.Monad
import Graphics.UI.Gtk

-- Internal libraries
import CombinedEnvironment
import Controller.ConditionDirection
import View
import Model.ProtectedModel

type Accessor a = Builder -> IO a
type Setter a = ProtectedModel -> a -> IO()
type Getter a = ProtectedModel -> IO a

-- Install the handler for a field that has a setter and a getter
installHandlers :: [ ModelEvent ] -> Accessor Entry -> Setter String -> Getter String -> CRef -> IO()
installHandlers evs entryF setter getter cref = do
  -- Get view and model
  (vw, pm) <- fmap (view &&& model) $ readIORef cref

  -- Get view element
  entry <- entryF $ mainWindowBuilder vw
  entry `onEditableChanged` condition cref VM entryF setter getter

  -- Install handler
  mapM_ (\ev -> onEvent pm ev (condition cref MV entryF setter getter)) evs

-- | Enforces the condition
condition :: CRef -> ConditionDirection -> Accessor Entry -> Setter String -> Getter String ->IO()
condition cref cd entryF setter getter = onViewAsync $ do
  (vw, pm) <- fmap (view &&& model) $ readIORef cref
  entry            <- entryF $ mainWindowBuilder vw
  t                <- get entry entryText
  curModelValue    <- getter pm

  case cd of
   MV -> when (curModelValue /= t) $ set entry [ entryText := curModelValue ]
   VM -> when (curModelValue /= t) $ setter pm t