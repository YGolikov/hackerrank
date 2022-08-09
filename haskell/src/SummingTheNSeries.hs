{-# LANGUAGE FlexibleInstances, UndecidableInstances, DuplicateRecordFields #-}

module SummingTheNSeries where

import Control.Monad
import Data.List
import Data.List.Split
import System.Environment
import System.IO

main :: IO()
main = interact $ unlines . map (show . f . (read :: String -> Integer)) . tail . lines

f i = mod (i^2) (10^9 + 7)
