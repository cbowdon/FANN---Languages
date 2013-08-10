module TrainANN
where

import HFANN
import CompileTraining

annFile :: FilePath
annFile = "data/languages.ann"

fannDef :: [Int]
fannDef = [26,13,4]

saveANN :: FilePath -> FilePath -> FannPtr -> IO ()
saveANN trainingFile saveFile fann =
       trainOnFile fann trainingFile 200000 100 0.001 >>
       saveFann fann saveFile

main :: IO ()
main = withStandardFann fannDef $ saveANN trainingFile annFile
