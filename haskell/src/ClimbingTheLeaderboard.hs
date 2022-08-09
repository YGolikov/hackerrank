{-# LANGUAGE DuplicateRecordFields, FlexibleInstances, UndecidableInstances #-}

module ClimbingTheLeaderboard where

import Control.Monad
import Data.Array
import Data.Bits
import Data.List
import Data.List.Split
import Debug.Trace
import System.Environment
import System.IO
import System.IO.Unsafe

main :: IO ()
main = do
    n_temp <- getLine
    let n = read n_temp :: Int
    scores_temp <- getLine
    let scores = map read $ words scores_temp :: [Int]
    m_temp <- getLine
    let m = read m_temp :: Int
    alice_temp <- getLine
    let alice = map read $ words alice_temp :: [Int]
    
    let os = reverse $ zip [1..] $ group scores
    
    --putStrLn $ show os
    forM_ (go alice os []) $ \i ->
        putStrLn $ show i
    -- your code goes here
    
go [] os res = reverse res
go (a:alice) [] res = go alice [] (1:res)
go (a:alice) ((r,(o:_)):os) res | a > o = go (a:alice) os res
go (a:alice) ost@((r,(o:_)):os) res | a == o = go alice ost (r:res)
go (a:alice) ost@((r,(o:_)):os) res | a < o = go alice ost ((r + 1):res)

getMultipleLines :: Int -> IO [String]

getMultipleLines n
    | n <= 0 = return []
    | otherwise = do          
        x <- getLine         
        xs <- getMultipleLines (n-1)    
        let ret = (x:xs)    
        return ret          
