module QueueUsingTwoStacks where

import Data.Char (toUpper)


import Control.Monad (forever)


data Queue a = Queue [a] [a] deriving Show

enqueue (Queue e d) el = Queue (el:e) d

dequeue q@(Queue _ []) = dequeue $ moveQueue q
dequeue (Queue e (el:d)) = Queue e d

getLastElement q@(Queue _ []) = getLastElement $ moveQueue q
getLastElement (Queue _ (el:d)) = el

moveQueue (Queue (e:es) d) = moveQueue $ Queue es (e:d)
moveQueue q@(Queue [] _) = q

dispatch :: [String] -> Queue Int -> (String, Queue Int)
dispatch ["1", el] q = ("", enqueue q (read el))
dispatch ["2"] q = ("", dequeue q)
dispatch ["3"] q = (show (getLastElement q ) ++ "\n", q)
dispatch _ q = ("not defined\n", q)

main = do 
  i <- getLine
  mainHelper (Queue [] []) (read i)

main :: IO (Queue Int)
mainHelper q 0 = return q
mainHelper queue i = do
  l <- getLine
  let (s, q) = dispatch (words l) queue
  putStr s
  mainHelper q (i-1)
