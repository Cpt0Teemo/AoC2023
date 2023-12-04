module Day2 (p1, p2) where
import qualified Data.Text.Lazy as T
import Data.Char ( isDigit )
import Data.List
import Data.Maybe
import Data.List.NonEmpty (xor)

p1 :: T.Text -> String
p1 = show . sum . mapMaybe maybeGetId . T.lines

p2 :: T.Text -> String
p2 =  show . sum . map getPower . T.lines


maybeGetId :: T.Text -> Maybe Int
maybeGetId string = if isCorrect string then return id else Nothing
    where
        id = parseInt string
        isCorrect = all verifyQuantity . T.split (\x -> (x==';') || (x==',')) . stripStart
        stripStart = head . tail . T.splitOn (T.pack ":")

verifyQuantity :: T.Text -> Bool
verifyQuantity string
    | red `T.isSuffixOf` string && quantity <= 12 = True
    | green `T.isSuffixOf` string && quantity <= 13 = True
    | blue `T.isSuffixOf` string && quantity <= 14 = True
    | otherwise = False
    where
        quantity = parseInt string



getPower :: T.Text -> Int
getPower = productTriple . foldr updateMax (0, 0, 0) . splitIntoDraws
    where
        splitIntoDraws = T.split (\x -> (x==';') || (x==',')) . stripStart
        stripStart = head . tail . T.splitOn (T.pack ":")
        productTriple (x,y,z) = x*y*z


updateMax :: T.Text -> (Int, Int, Int)  -> (Int, Int, Int)
updateMax string (greenMax, redMax, blueMax)
    | red `T.isSuffixOf` string && quantity > redMax = (greenMax, quantity, blueMax)
    | green `T.isSuffixOf` string && quantity > greenMax = (quantity, redMax, blueMax)
    | blue `T.isSuffixOf` string && quantity > blueMax = (greenMax, redMax, quantity)
    | otherwise = (greenMax, redMax, blueMax)
    where
        quantity = parseInt string

green = T.pack "green"
red = T.pack "red"
blue = T.pack "blue"

parseInt = read . T.unpack . T.takeWhile isDigit . T.dropWhile (not . isDigit)
