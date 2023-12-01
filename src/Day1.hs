module Day1 (p1, p2) where
import qualified Data.Text.Lazy as T (Text, filter, head, last, lines)
import Data.Char ( isDigit )
import Data.List
import Data.Maybe

p1 :: T.Text -> String
p1 = show . sum . map (getValue . show) . T.lines 

p2 :: T.Text -> String
p2 =  show . sum . map ( getValueWithLiteral . show) . T.lines 

getValue :: String -> Int
getValue line = read [head . getNbs $ line, last . getNbs $  line]
getValueWithLiteral :: Read a => String -> a
getValueWithLiteral line = read [head . getNbsWithLiteral $ line, last . getNbsWithLiteral $  line]

getNbs = filter isDigit
getNbsWithLiteral = catMaybes . custFold []

custFold :: [Maybe Char] -> String -> [Maybe Char]
custFold acc ""  = reverse acc
custFold acc string  = custFold (literalToDigit string:acc) (tail string)


literalToDigit :: String -> Maybe Char
literalToDigit string 
    | isDigit . head $ string = Just $ head string
    | "one" `isPrefixOf` string = Just '1'
    | "two" `isPrefixOf` string = Just '2'
    | "three" `isPrefixOf` string = Just '3'
    | "four" `isPrefixOf` string = Just '4'
    | "five" `isPrefixOf` string = Just '5'
    | "six" `isPrefixOf` string = Just '6'
    | "seven" `isPrefixOf` string = Just '7'
    | "eight" `isPrefixOf` string = Just '8'
    | "nine" `isPrefixOf` string = Just '9'
    | otherwise = Nothing