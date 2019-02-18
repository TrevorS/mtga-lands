module Main exposing (init, main)

import Browser
import Land exposing (Land, landToString)
import LandMsg exposing (Msg(..))
import Lands exposing (Lands, createLandsDict, landsToList, updateLands)
import Model exposing (Model)
import View exposing (view)


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \s -> Sub.none
        , view = view
        }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        model =
            Model createLandsDict False

        cmd =
            Cmd.none
    in
    ( model, cmd )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        lands =
            updateLands msg model.lands
    in
    ( { model | lands = lands }, Cmd.none )
