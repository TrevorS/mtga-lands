module Main exposing (init, main)

import Browser
import Lands exposing (createLandsDict)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Update exposing (update)
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
