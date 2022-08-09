{-# LANGUAGE FlexibleInstances, UndecidableInstances, DuplicateRecordFields #-}

module ThePowerSum where

import Control.Monad
import Data.Array
import Data.Bits
import Data.List
import Data.List.Split
import Data.Set
import Debug.Trace
import System.Environment
import System.IO
import System.IO.Unsafe

-- Complete the powerSum function below.
powerSum x n cur = powerSum'
  where r = x - cur ^ n
        powerSum'
          | r == 0 = 1
          | r < 0 = 0
          | otherwise = powerSum r n (cur+1) + powerSum x n (cur+1)

main :: IO()
main = do
    stdout <- getEnv "OUTPUT_PATH"
    fptr <- openFile stdout WriteMode

    x <- readLn :: IO Int

    n <- readLn :: IO Int

    let result = powerSum x n 1

    hPutStrLn fptr $ show result

    hFlush fptr
    hClose fptr
