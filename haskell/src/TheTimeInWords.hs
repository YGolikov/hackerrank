{-# LANGUAGE FlexibleInstances, UndecidableInstances, DuplicateRecordFields #-}

module TheTimeInWords where


main :: IO()
main = getLine >>= \hours -> getLine >>= \minutes -> putStrLn $ timeInWords (read hours) (read minutes)

timeInWords h 0 = toWords h ++ " o' clock"
timeInWords h 1 = "one minute past " ++ toWords h
timeInWords h 15 = "quarter past " ++ toWords h
timeInWords h 30 = "half past " ++ toWords h
timeInWords h 45 = "quarter to " ++ toWords (h + 1)
timeInWords h m
  | m < 30 = toWords m ++ " minutes past " ++ toWords h
  | m > 30 = toWords (60-m) ++ " minutes to " ++ toWords (h + 1)

toWords n =  toWords2 (n `div` 10, n `mod` 10)
toWords2 :: (Int, Int) -> String
toWords2 (0,a) = toWords1 a
toWords2 (1,0) = "ten"
toWords2 (1,1) = "eleven"
toWords2 (1,2) = "twelve"
toWords2 (1,3) = "thirteen"
toWords2 (1,5) = "fifteen"
toWords2 (1,8) = "eighteen"
toWords2 (1,a) = toWords1 a ++ "teen"
toWords2 (2,a) = unwords ["twenty", toWords1 a]
toWords2 (3,a) = unwords ["thirty", toWords1 a]
toWords2 (4,a) = unwords ["forty",toWords1 a]
toWords2 (5,a) = unwords ["fifty", toWords1 a]
toWords2 (6,a) = unwords ["sixty", toWords1 a]
toWords2 (7,a) = unwords ["seventy", toWords1 a]
toWords2 (8,a) = unwords ["eighty", toWords1 a]
toWords2 (9,a) = unwords ["ninety", toWords1 a]

toWords1 :: Int -> String
toWords1 0 = ""
toWords1 1 = "one"
toWords1 2 = "two"
toWords1 3 = "three"
toWords1 4 = "four"
toWords1 5 = "five"
toWords1 6 = "six"
toWords1 7 = "seven"
toWords1 8 = "eight"
toWords1 9 = "nine"
