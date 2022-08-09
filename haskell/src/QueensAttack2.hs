{-# LANGUAGE DuplicateRecordFields, FlexibleInstances, UndecidableInstances #-}

module QueensAttack2 where

import Data.List (foldl')
import Data.Text (pack, stripEnd, stripStart, unpack)
import System.Environment (getEnv)
import System.IO


data MinDirection = MinDirection {left, leftUp, up, upRight, right, rightDown, down, downLeft :: Int} deriving (Show)

queensAttack n k r_q c_q obstacles = left r + leftUp r + up r + upRight r + right r + rightDown r + down r + downLeft r where
  r = minDirection (r_q, c_q, n) obstacles

minDirection :: (Int, Int, Int) -> [[Int]] -> MinDirection
minDirection (rQ, cQ, n) = foldl' determineDirection minDirectionInit
  where
    determineDirection mD [r, c]
      | diffR == 0 && diffC > 0 =  mD {left = min (diffC - 1) (left mD) }
      | diffR < 0 && diffC > 0 && abs diffR == abs diffC =  mD {leftUp = min (diffC - 1) (leftUp mD) }
      | diffR < 0 && diffC == 0 =  mD {up = min (abs diffR - 1) (up mD) }
      | diffR < 0 && diffC < 0 && abs diffR == abs diffC =  mD {upRight = min (abs diffR - 1) (upRight mD) }
      | diffR == 0 && diffC < 0 =  mD {right = min (abs diffC - 1) (right mD) }
      | diffR > 0 && diffC < 0 && abs diffR == abs diffC =  mD {rightDown = min (diffR - 1) (rightDown mD) }
      | diffR > 0 && diffC == 0 =  mD {down = min (diffR - 1) (down mD) }
      | diffR > 0 && diffC > 0 && abs diffR == abs diffC = mD {downLeft = min (diffR - 1) (downLeft mD) }
      | otherwise = mD
      where
        diffR = rQ - r
        diffC = cQ - c
    minDirectionInit =
      MinDirection
        { left = cQ - 1,
          leftUp = min (cQ-1) (n - rQ),
          up = n - rQ,
          upRight = min (n - rQ) (n - cQ),
          right = n - cQ,
          rightDown = min (n - cQ) (rQ - 1),
          down = rQ - 1,
          downLeft = min (cQ - 1) (rQ - 1)
        }
  
  
lstrip = unpack . stripStart . pack

rstrip = unpack . stripEnd . pack

readMultipleLinesAsStringArray :: Int -> IO [String]
readMultipleLinesAsStringArray 0 = return []
readMultipleLinesAsStringArray n = do
  line <- getLine
  rest <- readMultipleLinesAsStringArray (n - 1)
  return (line : rest)

main :: IO ()
main = do
  stdout <- getEnv "OUTPUT_PATH"
  fptr <- openFile stdout WriteMode

  firstMultipleInputTemp <- getLine
  let firstMultipleInput = words $ rstrip firstMultipleInputTemp

  let n = read (firstMultipleInput !! 0) :: Int

  let k = read (firstMultipleInput !! 1) :: Int

  secondMultipleInputTemp <- getLine
  let secondMultipleInput = words $ rstrip secondMultipleInputTemp

  let r_q = read (secondMultipleInput !! 0) :: Int

  let c_q = read (secondMultipleInput !! 1) :: Int

  obstaclesTemp <- readMultipleLinesAsStringArray k
  let obstacles = map (\x -> map (read :: String -> Int) . words $ rstrip x) obstaclesTemp

  let result = queensAttack n k r_q c_q obstacles

  hPutStrLn fptr $ show result

  hFlush fptr
  hClose fptr
