{-# LANGUAGE FlexibleInstances, UndecidableInstances, DuplicateRecordFields #-}

module DieHard3 where

import Control.Monad
import Data.List
import Data.List.Split
import System.Environment
import System.IO

main =
  readLn >>= \i ->
    forM_ [1 .. i] $ \_ ->
      getLine >>=
      (\[a, b, c] ->
         putStrLn
           (if handle (read a) (read b) (read c)
              then "YES"
              else "NO")) .
      words

handle :: Integer -> Integer -> Integer -> Bool
handle a b c
  | (c == a) || (c == b) = True
  | (c > a) && (c > b) = False
  | a == b = c == a
  | a > b = case f'' a b c of r -> last r == c 
  | otherwise = case f'' b a  c of r -> last r == c 

f'' big small c = helper big small firstX 0 where
  firstX = big - small
  helper big small x i = x : (if x == c || (x == firstX && i > 0) then [] else (if x < small then helper big small (big - (small - x)) (i+1) else helper big small (x - small) (i+1)))

