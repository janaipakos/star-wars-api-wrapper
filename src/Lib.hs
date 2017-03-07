module Lib (request) where

import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC 
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Lazy.Char8 as LC  --marked as BC
import GHC.Generics --Uses Derive Generic to have instances written for you
import Data.Aeson
import Data.Text as T
import Network.HTTP.Simple
import Control.Monad

starWarsHost :: BC.ByteString
starWarsHost = BC.pack "www.swapi.co" --make sure this is www and not http://

apiPath :: BC.ByteString
apiPath = BC.pack "/api/"

--convert strings to byte paths
peopleUrl = BC.pack "people/"
planetUrl = BC.pack "planets/"
filmUrl = BC.pack "films/"
speciesUrl = BC.pack "species/"
vehicleUrl = BC.pack "vehicles/"
starshipUrl = BC.pack "starships/"

--builders for api Paths of one item. Pass these to request
buildPath url id = BC.concat [apiPath, url, BC.pack id, BC.pack "/"]

getPerson id = buildPath peopleUrl id
getPlanet id = buildPath planetUrl id
getFilm id = buildPath filmUrl id
getSpecies id = buildPath speciesUrl id
getVehicle id = buildPath vehicleUrl id
getStarship id = buildPath starshipUrl id

--getPeople from page 3. Number with no '/'
--is there a way to recursively change the 3?
getPeople = BC.concat [apiPath, peopleUrl]
getPlanets = BC.concat [apiPath, planetUrl]
getFilms = BC.concat [apiPath, filmUrl]
getSpecie = BC.concat [apiPath, speciesUrl]
getVehicles = BC.concat [apiPath, vehicleUrl]
getStarships = BC.concat [apiPath, starshipUrl]

--combine to fetch
buildRequest :: BC.ByteString -> BC.ByteString -> BC.ByteString -> Request
buildRequest host method path = setRequestMethod method
                                $ setRequestHost host
                                $ setRequestPath path
                                $ setRequestSecure True
                                $ setRequestPort 443
                                $ defaultRequest

--replace `getPeople` with methods above to change data
request :: Request
request = buildRequest starWarsHost (BC.pack "GET") getPeople


