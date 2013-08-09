module CompileTraining
where

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

countFile :: FilePath -> IO [[Double]]
countFile path = readFile path >>= return . map (normalize . Map.elems . countLetters) . lines

{-
addHeader :: [Int] -> [String] -> [String]
addHeader header = (:) . unwords . map show $ header

addClass :: [Int] -> [String] -> [String]
addClass cls = (>>= addO)
    where
        addO i  = [i, unwords . map show $ cls]
-}

writeTraining :: FilePath -> [[Double]] -> IO ()
writeTraining path dat = writeFile path . unlines . map (unwords . map show) $ dat

main :: IO ()
main =  countFile english >>= \e ->
        countFile francais >>= \f ->
        writeTraining dataFile $ e ++ f
