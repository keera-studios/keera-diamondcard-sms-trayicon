#!/usr/bin/env runhaskell
{-# LANGUAGE BangPatterns #-}

import Distribution.Simple
import Distribution.Simple.Setup
import Distribution.Simple.PreProcess
import Distribution.Simple.Program
import Distribution.Simple.Utils
import Distribution.PackageDescription
import Distribution.Simple.LocalBuildInfo
import Data.Char
import System.Exit
import System.IO
import System.Directory
import System.FilePath.Windows

main = let hooks = simpleUserHooks 
       in defaultMainWithHooks hooks { confHook = hailsConfigure }

-- This is a non-portable version of hails. It generates the
-- files inside the src dir.
hailsConfigure :: (GenericPackageDescription, HookedBuildInfo) -> ConfigFlags -> IO LocalBuildInfo
hailsConfigure (gpd, info) flags = do
  runProgramInvocation verbosity $ simpleProgramInvocation "hails" ["--init", "--output-dir=src"]
  (confHook simpleUserHooks) (gpd, info) flags 
 where verbosity = fromFlag $ configVerbosity flags

-- ppXpp :: BuildInfo -> LocalBuildInfo -> PreProcessor 
-- ppXpp build local =
--    PreProcessor {
--      platformIndependent = True,
--      runPreProcessor = mkSimplePreProcessor $ \inFile outFile verbosity ->
--        do info verbosity (inFile++" is being preprocessed to "++outFile)
--           let hscFile = replaceExtension inFile "hsc"
--           runSimplePreProcessor (ppCpp build local) inFile  hscFile verbosity
--           handle <- openFile hscFile ReadMode
--           source <- sGetContents handle
--           hClose handle
--           let newsource = unlines $ process $ lines source
--           writeFile hscFile newsource
--           runSimplePreProcessor (ppHsc2hs build local) hscFile outFile verbosity
--           removeFile hscFile
--           return ()
--      }
-- 
