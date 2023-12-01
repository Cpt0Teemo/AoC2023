module Main where

import qualified Data.Text.Lazy.IO as T (readFile)
import qualified Day1 (p1, p2)

main :: IO ()
main = do
  input <- T.readFile "data/day1.txt"
  putStrLn (Day1.p1 input)
  putStrLn (Day1.p2 input)
