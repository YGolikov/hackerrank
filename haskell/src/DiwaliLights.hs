{-# LANGUAGE FlexibleInstances, UndecidableInstances, DuplicateRecordFields #-}

module DiwaliLights where

import Control.Monad
import Data.List
import Data.List.Split
import Data.Set
import System.Environment
import System.IO

--
-- Complete the lights function below.
--
lights n = mod ((2^n) - 1) 100000
    --
    -- Write your code here.
    --

main :: IO()
main = do
    stdout <- getEnv "OUTPUT_PATH"
    fptr <- openFile stdout WriteMode

    t <- readLn :: IO Int

    forM_ [1..t] $ \tItr -> do
        n <- readLn :: IO Int

        let result = lights n

        hPutStrLn fptr $ show result

    hFlush fptr
    hClose fptr
