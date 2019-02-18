module Update exposing (update)

import Dict exposing (Dict)
import Land exposing (Land)
import Lands exposing (createLandsDict)
import Model exposing (Model)
import Msg exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment land ->
            let
                lands =
                    Dict.update land.key incrementCount model.lands
            in
            ( { model | lands = lands }, Cmd.none )

        Decrement land ->
            let
                lands =
                    Dict.update land.key decrementCount model.lands
            in
            ( { model | lands = lands }, Cmd.none )

        ShowModal ->
            let
                modalOpen =
                    True
            in
            ( { model | modalOpen = modalOpen }, Cmd.none )

        HideModal ->
            let
                modalOpen =
                    False
            in
            ( { model | modalOpen = modalOpen }, Cmd.none )

        Clear ->
            let
                lands =
                    createLandsDict
            in
            ( { model | lands = lands }, Cmd.none )


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
