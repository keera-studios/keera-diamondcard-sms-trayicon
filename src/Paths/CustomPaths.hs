{-# LANGUAGE CPP #-}
-- |
-- Copyright   : (C) Keera Studios Ltd, 2015
-- License     : BSD3
-- Maintainer  : support@keera.co.uk
module Paths.CustomPaths
  (module Paths_keera_diamondcard_sms_trayicon
#ifndef linux_HOST_OS
  , module Paths.CustomPaths
#endif
  )
 where

import Paths_keera_diamondcard_sms_trayicon

#ifndef linux_HOST_OS
vendorKey :: String
vendorKey = ""

programKey :: String
programKey = ""
#endif
