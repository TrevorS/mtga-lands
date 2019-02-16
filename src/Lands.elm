module Lands exposing (Lands, createLandsDict, landsToList, updateLands)

import Dict exposing (Dict)
import Land exposing (Land)
import LandMsg exposing (Msg(..))


type alias Lands =
    Dict Int Land


allLands =
    [ Land 264 "RNA" "Forest" 0 0
    , Land 264 "GRN" "Forest" 0 1
    , Land 277 "M19" "Forest" 0 2
    , Land 278 "M19" "Forest" 0 3
    , Land 279 "M19" "Forest" 0 4
    , Land 280 "M19" "Forest" 0 5
    , Land 196 "RIX" "Forest" 0 6
    , Land 276 "XLN" "Forest" 0 7
    , Land 277 "XLN" "Forest" 0 8
    , Land 278 "XLN" "Forest" 0 9
    , Land 279 "XLN" "Forest" 0 10
    , Land 266 "DAR" "Forest" 0 11
    , Land 267 "DAR" "Forest" 0 12
    , Land 268 "DAR" "Forest" 0 13
    , Land 269 "DAR" "Forest" 0 14
    , Land 261 "RNA" "Island" 0 15
    , Land 261 "GRN" "Island" 0 16
    , Land 265 "M19" "Island" 0 17
    , Land 266 "M19" "Island" 0 18
    , Land 267 "M19" "Island" 0 19
    , Land 268 "M19" "Island" 0 20
    , Land 193 "RIX" "Island" 0 21
    , Land 264 "XLN" "Island" 0 22
    , Land 265 "XLN" "Island" 0 23
    , Land 266 "XLN" "Island" 0 24
    , Land 267 "XLN" "Island" 0 25
    , Land 254 "DAR" "Island" 0 26
    , Land 255 "DAR" "Island" 0 27
    , Land 256 "DAR" "Island" 0 28
    , Land 257 "DAR" "Island" 0 29
    , Land 263 "RNA" "Mountain" 0 30
    , Land 263 "GRN" "Mountain" 0 31
    , Land 273 "M19" "Mountain" 0 32
    , Land 274 "M19" "Mountain" 0 33
    , Land 275 "M19" "Mountain" 0 34
    , Land 276 "M19" "Mountain" 0 35
    , Land 195 "RIX" "Mountain" 0 36
    , Land 272 "XLN" "Mountain" 0 37
    , Land 273 "XLN" "Mountain" 0 38
    , Land 274 "XLN" "Mountain" 0 39
    , Land 275 "XLN" "Mountain" 0 40
    , Land 262 "DAR" "Mountain" 0 41
    , Land 263 "DAR" "Mountain" 0 42
    , Land 264 "DAR" "Mountain" 0 43
    , Land 265 "DAR" "Mountain" 0 44
    , Land 260 "RNA" "Plains" 0 45
    , Land 260 "GRN" "Plains" 0 46
    , Land 261 "M19" "Plains" 0 47
    , Land 262 "M19" "Plains" 0 48
    , Land 263 "M19" "Plains" 0 49
    , Land 264 "M19" "Plains" 0 50
    , Land 192 "RIX" "Plains" 0 51
    , Land 260 "XLN" "Plains" 0 52
    , Land 261 "XLN" "Plains" 0 53
    , Land 262 "XLN" "Plains" 0 54
    , Land 263 "XLN" "Plains" 0 55
    , Land 250 "DAR" "Plains" 0 56
    , Land 251 "DAR" "Plains" 0 57
    , Land 252 "DAR" "Plains" 0 58
    , Land 253 "DAR" "Plains" 0 59
    , Land 262 "RNA" "Swamp" 0 60
    , Land 262 "GRN" "Swamp" 0 61
    , Land 269 "M19" "Swamp" 0 62
    , Land 270 "M19" "Swamp" 0 63
    , Land 271 "M19" "Swamp" 0 64
    , Land 272 "M19" "Swamp" 0 65
    , Land 194 "RIX" "Swamp" 0 66
    , Land 268 "XLN" "Swamp" 0 67
    , Land 269 "XLN" "Swamp" 0 68
    , Land 270 "XLN" "Swamp" 0 69
    , Land 271 "XLN" "Swamp" 0 70
    , Land 258 "DAR" "Swamp" 0 71
    , Land 259 "DAR" "Swamp" 0 72
    , Land 260 "DAR" "Swamp" 0 73
    , Land 261 "DAR" "Swamp" 0 74
    ]


createLandsDict : Lands
createLandsDict =
    List.map (\l -> ( l.key, l )) allLands
        |> Dict.fromList


updateLands : Msg -> Lands -> Lands
updateLands msg lands =
    case msg of
        Increment land ->
            Dict.update land.key incrementCount lands

        Decrement land ->
            Dict.update land.key decrementCount lands


landsToList : Lands -> List Land
landsToList lands =
    Dict.values lands


incrementCount : Maybe Land -> Maybe Land
incrementCount land =
    case land of
        Just foundLand ->
            Just { foundLand | count = foundLand.count + 1 }

        Nothing ->
            Nothing


decrementCount : Maybe Land -> Maybe Land
decrementCount land =
    case land of
        Just foundLand ->
            Just { foundLand | count = foundLand.count - 1 }

        Nothing ->
            Nothing
