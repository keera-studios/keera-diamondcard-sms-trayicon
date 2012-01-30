-- | This module contains a series of conditions that must hold between
-- the view and the model. Most of these conditions can be separated in
-- two conditions: one that must be checked only when the model changes
-- (and updates the view accordingly), and another that must be checked
-- when the view receives an event (and updates the model accordingly).

module Controller.Conditions
   ( installHandlers )
  where

-- Internal libraries
import CombinedEnvironment

-- Internal libraries: specific conditions
import qualified Controller.Conditions.Config                   as Config
import qualified Controller.Conditions.AccountID                as AccountID
import qualified Controller.Conditions.Pincode                  as Pincode
import qualified Controller.Conditions.Sender                   as Sender
import qualified Controller.Conditions.Destination              as Destination
import qualified Controller.Conditions.Message                  as Message
import qualified Controller.Conditions.PreferencesDialog        as PreferencesDialog
import qualified Controller.Conditions.PreferencesDialogDestroy as PreferencesDialogDestroy
import qualified Controller.Conditions.PopupMenu                as PopupMenu
import qualified Controller.Conditions.Send                     as Send
import qualified Controller.Conditions.SmsWindow                as SmsWindow
import qualified Controller.Conditions.Status                   as Status
import qualified Controller.Conditions.Quit                     as Quit

installHandlers :: CRef -> IO()
installHandlers cref = do
  Config.installHandlers                   cref
  AccountID.installHandlers                cref
  Pincode.installHandlers                  cref
  Sender.installHandlers                   cref
  PreferencesDialog.installHandlers        cref
  PreferencesDialogDestroy.installHandlers cref
  PopupMenu.installHandlers                cref
  SmsWindow.installHandlers                cref
  Destination.installHandlers              cref
  Message.installHandlers                  cref
  Quit.installHandlers                     cref
  Send.installHandlers                     cref
  Status.installHandlers                   cref
