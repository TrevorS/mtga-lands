module Update exposing (update)

import Lands exposing (updateLands)
import Model exposing (Model)
import Msg exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        lands =
            updateLands msg model.lands
    in
    ( { model | lands = lands }, Cmd.none )
