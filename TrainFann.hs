module TrainFann
( annFile
) where

import HFANN
import CompileTraining

annFile :: FilePath
annFile = "data/languages.ann"

fannDef :: [Int]
fannDef = [26,13,4]

saveLanFann :: FilePath -> FilePath -> FannPtr -> IO ()
saveLanFann trainingFile saveFile fann =
       trainOnFile fann trainingFile 200 10 0.0001 >>
       saveFann fann saveFile

main :: IO ()
main = withStandardFann fannDef $ saveLanFann trainingFile annFile
