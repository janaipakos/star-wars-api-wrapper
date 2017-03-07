--main: print JSON from website to data.json
--printNameMain: read data.json and print to command line the 'name' resource

module Main where

import Lib (request)
import Person

import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC 
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Lazy.Char8 as LC  --marked as BC
import GHC.Generics --Uses Derive Generic to have instances written for you
import Data.Aeson
import Data.Text as T
import Network.HTTP.Simple
import Control.Monad

main :: IO ()
main = do
    writeJson
    printMain

--state what resource to print in Lib.hs function `request`
writeJson :: IO ()
writeJson = do
    response <- httpLBS request
    let status = getResponseStatusCode response
    if status == 200
        then do
            print "saving request to file"
            let jsonBody = getResponseBody response 
            L.writeFile "data.json" jsonBody
        else print "request failed with error"

--prints out the Person object from Person.hs
printMain :: IO ()
printMain = do
    jsonData <- L.readFile "data.json"
    let starwarsResponse = decode jsonData :: Maybe StarWarsResponsePerson
    let starwarsResults = results <$> starwarsResponse
    printPerson starwarsResults
