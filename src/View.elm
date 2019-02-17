module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Land exposing (Land, landToImgUrl, landToString)
import LandModel exposing (Model)
import LandMsg exposing (Msg(..))
import Lands exposing (Lands, landsToList, selectedLands)
import List.Extra exposing (greedyGroupsOf)


view : Model -> Html Msg
view model =
    div []
        [ viewLands model.lands
        , viewDeckString model.lands
        ]


viewLands : Lands -> Html Msg
viewLands lands =
    let
        landsAsHtml =
            List.map (\l -> viewLand l) (landsToList lands)

        landRows =
            greedyGroupsOf 5 landsAsHtml
    in
    div [ class "columns" ]
        (List.map
            (\ls -> div [ class "column" ] ls)
            landRows
        )


viewLand : Land -> Html Msg
viewLand land =
    let
        disableDecrement =
            land.count == 0

        landUrl =
            landToImgUrl land
    in
    div []
        [ img [ src landUrl ] []
        , h1 [] [ text (String.fromInt land.count) ]
        , button [ onClick (Increment land) ] [ text "+" ]
        , button [ onClick (Decrement land), disabled disableDecrement ] [ text "-" ]
        ]


viewDeckString : Lands -> Html Msg
viewDeckString lands =
    let
        deckStringAsText =
            List.map (\l -> text (landToString l ++ "\n")) (selectedLands lands)
    in
    div []
        [ textarea [ cols 50 ] deckStringAsText ]
