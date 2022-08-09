{-# LANGUAGE DuplicateRecordFields, FlexibleInstances, UndecidableInstances #-}

module NonDivisibleSubset where

import Control.Monad
import Data.Array
import Data.Bits
import Data.List
import Data.List.Split
import Data.Set
import Data.Text
import Debug.Trace
import System.Environment
import System.IO
import System.IO.Unsafe

--
-- Complete the 'nonDivisibleSubset' function below.
--
-- The function is expected to return an INTEGER.
-- The function accepts following parameters:
--  1. INTEGER k
--  2. INTEGER_ARRAY s
--

nonDivisibleSubset :: Int -> [Int] -> Int
nonDivisibleSubset k l = resolve (div k 2)  where
  resolve 0
      | arrWithRem ! 0 == 0 = 0
      | otherwise = 1
  resolve i
    | k - i == i = 1 + resolve (i-1)
    | otherwise = max (arrWithRem ! i) (arrWithRem ! (k-i)) + resolve (i-1)
  arrWithRem = Data.List.foldl' (\a x -> let r = rem x k in a // [(r, a!r + 1)]) arr l
  arr = array (0,k-1) [(i, 0) | i <- [0..k-1]]

lstrip = Data.Text.unpack . Data.Text.stripStart . Data.Text.pack
rstrip = Data.Text.unpack . Data.Text.stripEnd . Data.Text.pack

main :: IO()
main = do
    stdout <- getEnv "OUTPUT_PATH"
    fptr <- openFile stdout WriteMode

    firstMultipleInputTemp <- getLine
    let firstMultipleInput = Data.List.words $ rstrip firstMultipleInputTemp

    let n = read (firstMultipleInput !! 0) :: Int

    let k = read (firstMultipleInput !! 1) :: Int

    sTemp <- getLine

    let s = Data.List.map (read :: String -> Int) . Data.List.words $ rstrip sTemp

    let result = nonDivisibleSubset k s

    hPutStrLn fptr $ show result

    hFlush fptr
    hClose fptr
