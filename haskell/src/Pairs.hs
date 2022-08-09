module Pairs where


{-# LANGUAGE DuplicateRecordFields, FlexibleInstances, UndecidableInstances #-}


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
-- Complete the 'pairs' function below.
--
-- The function is expected to return an INTEGER.
-- The function accepts following parameters:
--  1. INTEGER k
--  2. INTEGER_ARRAY arr
--


solve [] _ = 0
solve l diff = sum where
  (sum, xs) = Prelude.foldl (\(sum, _:ys) x  -> if isDiff ys x then (sum+1, ys) else (sum, ys)) (0, sorted) sorted
  isDiff (y:ys) x
    | y > x + diff = False
    | y < x + diff = isDiff ys x
    | y == x + diff = True
  isDiff [] x = False
  sorted = sort l

pairs k arr = solve arr k

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

    arrTemp <- getLine

    let arr = Data.List.map (read :: String -> Int) . Data.List.words $ rstrip arrTemp

    let result = pairs k arr

    hPutStrLn fptr $ show result

    hFlush fptr
    hClose fptr

