{-# LANGUAGE FlexibleInstances, UndecidableInstances, DuplicateRecordFields #-}

module Is3dSurfaceArea where

import Control.Monad
import Data.Array
import Data.Bits
import Data.List
import Data.List.Split
import Debug.Trace
import System.Environment
import System.IO
import System.IO.Unsafe


count :: [[Int]] -> Int

count lists = helper lists + helper (rotateLists lists) where
  helper lists = foldl (\sum x -> countList x + sum) 0 lists

countList l = head l + innerCount l where
  innerCount (a:b:l) = abs (a - b) + 1 + innerCount (b : l)
  innerCount [a] = a + 1

rotateLists lists = foldl (flip rotateList) [] lists

rotateList :: [a] -> [[a]] -> [[a]]
rotateList (a:l) (b:newLists) =  (a : b) : rotateList l newLists
rotateList (a:l) [] = [a] : rotateList l []
rotateList [] _ = []

-- Complete the surfaceArea function below.
surfaceArea a = count a

readMultipleLinesAsStringArray :: Int -> IO [String]
readMultipleLinesAsStringArray 0 = return []
readMultipleLinesAsStringArray n = do
    line <- getLine
    rest <- readMultipleLinesAsStringArray(n - 1)
    return (line : rest)

main :: IO()
main = do
    stdout <- getEnv "OUTPUT_PATH"
    fptr <- openFile stdout WriteMode

    hWTemp <- getLine
    let hW = words hWTemp

    let h = read (hW !! 0) :: Int

    let w = read (hW !! 1) :: Int

    aTemp <- readMultipleLinesAsStringArray h
    let a = Data.List.map (\x -> Data.List.map (read :: String -> Int) . words $ x) aTemp

    let result = surfaceArea a

    hPutStrLn fptr $ show result

    hFlush fptr
    hClose fptr
