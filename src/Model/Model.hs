-- |
-- Copyright   : (C) Keera Studios Ltd, 2015
-- License     : BSD3
-- Maintainer  : support@keera.co.uk
module Model.Model where

data Model = Model
 { sender      :: String
 , accountId   :: String
 , pincode     :: String
 , destination :: String
 , message     :: String
 , status      :: Status
 }
 deriving (Eq)

emptyBM :: Model
emptyBM = Model
 { sender      = ""
 , accountId   = ""
 , pincode     = ""
 , destination = ""
 , message     = ""
 , status      = StatusIdle
 }

data Status = StatusIdle
            | StatusSending
            | StatusSentOk
            | StatusSentWrong
 deriving (Eq, Ord)