module Person where

import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC 
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Lazy.Char8 as LC  --marked as BC
import GHC.Generics --Uses Derive Generic to have instances written for you
import Data.Aeson
import Data.Text as T
import Network.HTTP.Simple
import Control.Monad

data StarWarsResultPerson = StarWarsResultPerson
                    { name :: T.Text
                    , height :: T.Text
                    , mass :: T.Text
                    , hair_color :: T.Text
                    , skin_color :: T.Text
                    , eye_color :: T.Text
                    , birth_year :: T.Text
                    , gender :: T.Text
                    , homeworld :: T.Text } 
                    deriving (Show, Generic) --derive generic to write instance automatically

instance FromJSON StarWarsResultPerson

data StarWarsResponsePerson = StarWarsResponsePerson
                        { results :: [StarWarsResultPerson] } 
                        deriving (Show,Generic)

instance FromJSON StarWarsResponsePerson

printPerson :: Maybe [StarWarsResultPerson] -> IO ()
printPerson Nothing = print "error loading data"
printPerson (Just results) = forM_ results $ \result -> do
                             let dataName = name result
                             let dataHeight = height result  
                             let dataMass = mass result 
                             print (T.concat [T.pack "name: ", dataName
                                             ,T.pack ", height: ", dataHeight
                                             ,T.pack ", mass: ", dataMass
                                             ])