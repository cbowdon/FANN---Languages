module CompileTraining
( letterFreq
, Dict
, empty
, trainingFile
) where

import qualified Data.Map as Map
import qualified Data.Char as Char
import Control.Monad

type Dict = Map.Map Char Int

english :: FilePath
english = "data/English.txt"

francais :: FilePath
francais = "data/Francais.txt"

norske :: FilePath
norske = "data/Norske.txt"

svensk :: FilePath
svensk = "data/Svensk.txt"

trainingFile :: FilePath
trainingFile = "data/languages.data"

empty :: Dict
empty = Map.fromList $ zip ['a'..'z'] $ repeat 0

countLetters :: String -> Dict
countLetters  = foldl inc empty
    where
        inc d c = Map.update (\a -> Just (a + 1)) (Char.toLower c) d

normalize :: [Int] -> [Double]
normalize lst = map ((/m) . fromIntegral) lst
    where
        m = fromIntegral $ sum lst

letterFreq :: String -> [Double]
letterFreq = normalize . Map.elems . countLetters

countFile :: FilePath -> IO [[Double]]
countFile path = liftM (map letterFreq . lines) (readFile path)

addClass :: [Double] -> [[Double]] -> [[Double]]
addClass cls = (>>= \s -> [s, cls])

addHeader :: [Int] -> [[Double]] -> [String]
addHeader hdr dat = h:d
    where
        h = unwords . map show $ hdr
        d = map (unwords . map show) dat

writeTraining :: FilePath -> [String] -> IO ()
writeTraining path dat = writeFile path . unlines $ dat

main :: IO ()
main =  countFile english >>= \e ->
        countFile francais >>= \f ->
        countFile norske >>= \n ->
        countFile svensk >>= \s ->
        let trainingData =
                addHeader [100, 26, 4] $
                addClass [1, 0, 0, 0] e ++
                addClass [0, 1, 0, 0] f ++
                addClass [0, 0, 1, 0] n ++
                addClass [0, 0, 0, 1] s
        in writeTraining trainingFile trainingData
