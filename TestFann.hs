module TestFann where

import HFANN
import TrainFann
import CompileTraining

englishLn :: String
englishLn = "Hello, I am an English person living in England and I love to drink tea and eat biscuits all the time because I am so bloody British. The Queen, the Queen, the Queen! Sorry."

francaisLn :: String
francaisLn = "Au cours d'une conférence de presse, le président américain a promis une 'nouvelle ère' dans le renseignement avec davantage de supervision, 'davantage de transparence et de garde-fous'"

norskeLn :: String
norskeLn = "Så vidt jeg vet er det ikke et folkekrav å doble Oslos befolkning de neste 30 årene. Norge har de siste fem årene gitt opphold til ca 16 500 ikke-vestlige innvandrere i snitt. Dette er mennesker som ikke har råd til å kjøpe boliger til flere millioner."

svenskaLn :: String
svenskaLn = "Längre västerut fick sent på fredagen de flesta av de runt 1.000 personer som evakuerats återvända till sina hem – de som hade hem att återvända till. Över 70 kvadratkilometer har brunnit, och 26 bostadshus har förstörts."

testSentence :: String -> FannPtr -> IO ()
testSentence sentence fann = runFann fann (letterFreq sentence) >>= print

main :: IO ()
main = withSavedFann annFile testSentences
    where
        testSentences fann = do
            testSentence englishLn fann
            testSentence francaisLn fann
            testSentence norskeLn fann
            testSentence svenskaLn fann
