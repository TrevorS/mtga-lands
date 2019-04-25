module Lands exposing (Lands, createLandsDict, firstLandOfType, hasLandsSelected, landsToList, selectedLands)

import Dict exposing (Dict)
import Land exposing (Land)
import List.Extra exposing (find)
import Msg exposing (Msg(..))


type alias Lands =
    Dict Int Land


allLands =
    [ Land 256 "WAR" "Swamp" 0 0
    , Land 257 "WAR" "Swamp" 0 1
    , Land 258 "WAR" "Swamp" 0 2
    , Land 262 "RNA" "Swamp" 0 3
    , Land 262 "GRN" "Swamp" 0 4
    , Land 269 "M19" "Swamp" 0 5
    , Land 270 "M19" "Swamp" 0 6
    , Land 271 "M19" "Swamp" 0 7
    , Land 272 "M19" "Swamp" 0 8
    , Land 194 "RIX" "Swamp" 0 9
    , Land 268 "XLN" "Swamp" 0 10
    , Land 269 "XLN" "Swamp" 0 11
    , Land 270 "XLN" "Swamp" 0 12
    , Land 271 "XLN" "Swamp" 0 13
    , Land 258 "DAR" "Swamp" 0 14
    , Land 259 "DAR" "Swamp" 0 15
    , Land 260 "DAR" "Swamp" 0 16
    , Land 261 "DAR" "Swamp" 0 17
    , Land 253 "WAR" "Island" 0 18
    , Land 254 "WAR" "Island" 0 19
    , Land 255 "WAR" "Island" 0 20
    , Land 261 "RNA" "Island" 0 21
    , Land 261 "GRN" "Island" 0 22
    , Land 265 "M19" "Island" 0 23
    , Land 266 "M19" "Island" 0 24
    , Land 267 "M19" "Island" 0 25
    , Land 268 "M19" "Island" 0 26
    , Land 193 "RIX" "Island" 0 27
    , Land 264 "XLN" "Island" 0 28
    , Land 265 "XLN" "Island" 0 29
    , Land 266 "XLN" "Island" 0 30
    , Land 267 "XLN" "Island" 0 31
    , Land 254 "DAR" "Island" 0 32
    , Land 255 "DAR" "Island" 0 33
    , Land 256 "DAR" "Island" 0 34
    , Land 257 "DAR" "Island" 0 35
    , Land 262 "WAR" "Forest" 0 36
    , Land 263 "WAR" "Forest" 0 37
    , Land 264 "WAR" "Forest" 0 38
    , Land 264 "RNA" "Forest" 0 39
    , Land 264 "GRN" "Forest" 0 40
    , Land 277 "M19" "Forest" 0 41
    , Land 278 "M19" "Forest" 0 42
    , Land 279 "M19" "Forest" 0 43
    , Land 280 "M19" "Forest" 0 44
    , Land 196 "RIX" "Forest" 0 45
    , Land 276 "XLN" "Forest" 0 46
    , Land 277 "XLN" "Forest" 0 47
    , Land 278 "XLN" "Forest" 0 48
    , Land 279 "XLN" "Forest" 0 49
    , Land 266 "DAR" "Forest" 0 50
    , Land 267 "DAR" "Forest" 0 51
    , Land 268 "DAR" "Forest" 0 52
    , Land 269 "DAR" "Forest" 0 53
    , Land 259 "WAR" "Mountain" 0 54
    , Land 260 "WAR" "Mountain" 0 55
    , Land 261 "WAR" "Mountain" 0 56
    , Land 263 "RNA" "Mountain" 0 57
    , Land 263 "GRN" "Mountain" 0 58
    , Land 273 "M19" "Mountain" 0 59
    , Land 274 "M19" "Mountain" 0 60
    , Land 275 "M19" "Mountain" 0 61
    , Land 276 "M19" "Mountain" 0 62
    , Land 195 "RIX" "Mountain" 0 63
    , Land 272 "XLN" "Mountain" 0 64
    , Land 273 "XLN" "Mountain" 0 65
    , Land 274 "XLN" "Mountain" 0 66
    , Land 275 "XLN" "Mountain" 0 67
    , Land 262 "DAR" "Mountain" 0 68
    , Land 263 "DAR" "Mountain" 0 69
    , Land 264 "DAR" "Mountain" 0 70
    , Land 265 "DAR" "Mountain" 0 71
    , Land 250 "WAR" "Plains" 0 72
    , Land 251 "WAR" "Plains" 0 73
    , Land 252 "WAR" "Plains" 0 74
    , Land 260 "RNA" "Plains" 0 75
    , Land 260 "GRN" "Plains" 0 76
    , Land 261 "M19" "Plains" 0 77
    , Land 262 "M19" "Plains" 0 78
    , Land 263 "M19" "Plains" 0 79
    , Land 264 "M19" "Plains" 0 80
    , Land 192 "RIX" "Plains" 0 81
    , Land 260 "XLN" "Plains" 0 82
    , Land 261 "XLN" "Plains" 0 83
    , Land 262 "XLN" "Plains" 0 84
    , Land 263 "XLN" "Plains" 0 85
    , Land 250 "DAR" "Plains" 0 86
    , Land 251 "DAR" "Plains" 0 87
    , Land 252 "DAR" "Plains" 0 88
    , Land 253 "DAR" "Plains" 0 89
    ]


firstLandOfType : String -> Land
firstLandOfType landType =
    case find (\l -> l.landType == landType) allLands of
        Just land ->
            land

        _ ->
            -- TODO: Hack.
            Land 0 "" "" 0 999


createLandsDict : Lands
createLandsDict =
    List.map (\l -> ( l.key, l )) allLands
        |> Dict.fromList


landsToList : Lands -> List Land
landsToList lands =
    Dict.values lands


selectedLands : Lands -> List Land
selectedLands lands =
    List.filter (\l -> l.count > 0) (landsToList lands)


hasLandsSelected : Lands -> Bool
hasLandsSelected lands =
    List.length (selectedLands lands) > 0
