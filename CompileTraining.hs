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
type LangData = [[Double]]

dataFiles :: [FilePath]
dataFiles = ["data/English.txt", "data/Francais.txt", "data/Norske.txt", "data/Svenska.txt"]

dataClasses :: LangData
dataClasses = [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]

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

countFile :: FilePath -> IO LangData
countFile path = liftM (map letterFreq . lines) (readFile path)

addClass :: [Double] -> LangData -> LangData
addClass cls = (>>= \s -> [s, cls])

addHeader :: [Int] -> LangData -> [String]
addHeader hdr dat = h:d
    where
        h = unwords . map show $ hdr
        d = map (unwords . map show) dat

readData :: [FilePath] -> LangData -> IO LangData
readData files classes = liftM concat $ mapM mkData $ zip files classes
    where
        mkData (f,c) = liftM (addClass c) $ countFile f

writeTraining :: FilePath -> [String] -> IO ()
writeTraining path dat = writeFile path . unlines $ dat

main :: IO ()
main =  readData dataFiles dataClasses >>= \f ->
        let nExamples   = quot (length f) 2
            nInput      = length dataFiles
            nOutput     = Map.size empty
            hdr         = [nExamples, nInput, nOutput]
        in writeTraining trainingFile (addHeader hdr f)
