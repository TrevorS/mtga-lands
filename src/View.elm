module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Land exposing (Land, landToImgUrl, landToString)
import LandModel exposing (Model)
import LandMsg exposing (Msg(..))
import Lands exposing (landsToList)


view : Model -> Html Msg
view model =
    div []
        (List.map (\l -> viewLandToDiv l) (landsToList model.lands))


viewLandToDiv : Land -> Html Msg
viewLandToDiv land =
    let
        disableDecrement =
            land.count == 0

        landUrl =
            landToImgUrl land
    in
    div []
        [ img [ src landUrl ] []
        , h1 [] [ text (landToString land) ]
        , button [ onClick (Increment land) ] [ text "Increment" ]
        , button [ onClick (Decrement land), disabled disableDecrement ] [ text "Decrement" ]
        ]
