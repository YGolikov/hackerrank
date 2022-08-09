{-# LANGUAGE FlexibleInstances, UndecidableInstances, DuplicateRecordFields #-}

module SpecialMultiple where

import Control.Monad
import Data.List
import Data.List.Split
import System.Environment
import System.IO
import Numeric (showIntAtBase)

main = interact $ unlines . map (show . f . (read :: String -> Integer)) . tail . lines


nineAsBin :: Integer -> Integer
nineAsBin i = read $ showIntAtBase 2 helper i "" where
  helper 0 = '0'
  helper 1 = '9'

nineList = map nineAsBin [1..]

f i = case find (\x -> x `rem` i == 0) nineList of (Just x) -> x
