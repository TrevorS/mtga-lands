module Main exposing (Model, init, main)

import Browser
import Html exposing (..)
import Html.Events exposing (..)


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Land =
    { id : Int
    , set : String
    , landType : String
    , count : Int
    }


landCountChange : Int -> Land -> Land
landCountChange amount land =
    { land | count = land.count + amount }


landToString : Land -> String
landToString land =
    let
        landId =
            String.fromInt land.id

        landCount =
            String.fromInt land.count
    in
    String.fromInt land.count ++ " " ++ land.landType ++ " (" ++ land.set ++ ") " ++ landId


type alias Lands =
    List Land


findLand : Int -> String -> String -> Lands -> Land
findLand id set landType lands =
    let
        foundLand =
            List.head (List.filter (\l -> l.id == id && l.set == set && l.landType == landType) lands)
    in
    case foundLand of
        Just land ->
            land

        Nothing ->
            Debug.todo "Could not find land!"


removeLand : Land -> Lands -> Lands
removeLand land lands =
    List.filter (\l -> l.id /= land.id && l.set /= land.set && l.landType /= land.landType) lands


type alias Model =
    { lands : Lands
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model
        [ Land 264 "RNA" "Forest" 0
        , Land 264 "GRN" "Forest" 0
        , Land 277 "M19" "Forest" 0
        , Land 278 "M19" "Forest" 0
        , Land 279 "M19" "Forest" 0
        , Land 280 "M19" "Forest" 0
        , Land 196 "RIX" "Forest" 0
        , Land 276 "XLN" "Forest" 0
        , Land 277 "XLN" "Forest" 0
        , Land 278 "XLN" "Forest" 0
        , Land 279 "XLN" "Forest" 0
        , Land 266 "DAR" "Forest" 0
        , Land 267 "DAR" "Forest" 0
        , Land 268 "DAR" "Forest" 0
        , Land 269 "DAR" "Forest" 0
        , Land 261 "RNA" "Island" 0
        , Land 261 "GRN" "Island" 0
        , Land 265 "M19" "Island" 0
        , Land 266 "M19" "Island" 0
        , Land 267 "M19" "Island" 0
        , Land 268 "M19" "Island" 0
        , Land 193 "RIX" "Island" 0
        , Land 264 "XLN" "Island" 0
        , Land 265 "XLN" "Island" 0
        , Land 266 "XLN" "Island" 0
        , Land 267 "XLN" "Island" 0
        , Land 254 "DAR" "Island" 0
        , Land 255 "DAR" "Island" 0
        , Land 256 "DAR" "Island" 0
        , Land 257 "DAR" "Island" 0
        , Land 263 "RNA" "Mountain" 0
        , Land 263 "GRN" "Mountain" 0
        , Land 273 "M19" "Mountain" 0
        , Land 274 "M19" "Mountain" 0
        , Land 275 "M19" "Mountain" 0
        , Land 276 "M19" "Mountain" 0
        , Land 195 "RIX" "Mountain" 0
        , Land 272 "XLN" "Mountain" 0
        , Land 273 "XLN" "Mountain" 0
        , Land 274 "XLN" "Mountain" 0
        , Land 275 "XLN" "Mountain" 0
        , Land 262 "DAR" "Mountain" 0
        , Land 263 "DAR" "Mountain" 0
        , Land 264 "DAR" "Mountain" 0
        , Land 265 "DAR" "Mountain" 0
        , Land 260 "RNA" "Plains" 0
        , Land 260 "GRN" "Plains" 0
        , Land 261 "M19" "Plains" 0
        , Land 262 "M19" "Plains" 0
        , Land 263 "M19" "Plains" 0
        , Land 264 "M19" "Plains" 0
        , Land 192 "RIX" "Plains" 0
        , Land 260 "XLN" "Plains" 0
        , Land 261 "XLN" "Plains" 0
        , Land 262 "XLN" "Plains" 0
        , Land 263 "XLN" "Plains" 0
        , Land 250 "DAR" "Plains" 0
        , Land 251 "DAR" "Plains" 0
        , Land 252 "DAR" "Plains" 0
        , Land 253 "DAR" "Plains" 0
        , Land 262 "RNA" "Swamp" 0
        , Land 262 "GRN" "Swamp" 0
        , Land 269 "M19" "Swamp" 0
        , Land 270 "M19" "Swamp" 0
        , Land 271 "M19" "Swamp" 0
        , Land 272 "M19" "Swamp" 0
        , Land 194 "RIX" "Swamp" 0
        , Land 268 "XLN" "Swamp" 0
        , Land 269 "XLN" "Swamp" 0
        , Land 270 "XLN" "Swamp" 0
        , Land 271 "XLN" "Swamp" 0
        , Land 258 "DAR" "Swamp" 0
        , Land 259 "DAR" "Swamp" 0
        , Land 260 "DAR" "Swamp" 0
        , Land 261 "DAR" "Swamp" 0
        ]
    , Cmd.none
    )


type Msg
    = Increment Int String String
    | Decrement Int String String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment id set landType ->
            let
                newLand =
                    findLand id set landType model.lands |> landCountChange 1

                newLands =
                    removeLand newLand model.lands

                lands =
                    newLand :: newLands
            in
            ( { model | lands = lands }
            , Cmd.none
            )

        Decrement id set landType ->
            let
                newLand =
                    findLand id set landType model.lands |> landCountChange -1

                newLands =
                    removeLand newLand model.lands

                lands =
                    newLand :: newLands
            in
            ( { model | lands = lands }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        (List.map (\l -> viewLandToDiv l) model.lands)


viewLandToDiv : Land -> Html Msg
viewLandToDiv land =
    div []
        [ h1 [] [ text (landToString land) ]
        , button [ onClick (Increment land.id land.set land.landType) ] [ text "Increment" ]
        , button [ onClick (Decrement land.id land.set land.landType) ] [ text "Decrement" ]
        ]
