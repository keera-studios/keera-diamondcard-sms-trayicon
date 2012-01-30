{-# LANGUAGE PackageImports #-}
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
