module CompileTraining
( letterFreq
, Dict
, empty
) where

import qualified Data.Map as Map
import qualified Data.Char as Char

type Dict = Map.Map Char Int

english :: FilePath
english = "data/English.txt"

francais :: FilePath
francais = "data/Francais.txt"

norske :: FilePath
norske = "data/Norske.txt"

svensk :: FilePath
svensk = "data/Svensk.txt"

dataFile :: FilePath
dataFile = "data/languages.data"

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
countFile path = readFile path >>= return . map letterFreq . lines

addClass :: [Double] -> [[Double]] -> [[Double]]
addClass cls = (>>= \s -> [s, cls])

addHeader :: [Double] -> [[Double]] -> [[Double]]
addHeader hdr = (hdr:)

writeTraining :: FilePath -> [[Double]] -> IO ()
writeTraining path dat = writeFile path . unlines . map (unwords . map show) $ dat

main :: IO ()
main =  countFile english >>= \e ->
        countFile francais >>= \f ->
        countFile norske >>= \n ->
        countFile svensk >>= \s ->
        let fileData =
                addHeader [25, 26, 4] $
                addClass [1, 0, 0, 0] e ++
                addClass [0, 1, 0, 0] f ++
                addClass [0, 0, 1, 0] n ++
                addClass [0, 0, 0, 1] s
        in return fileData >>= writeTraining dataFile
