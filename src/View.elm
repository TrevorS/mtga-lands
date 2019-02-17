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
    div [ class "container" ]
        [ viewHeader
        , viewLands model.lands
        , viewDeckString model.lands
        ]


viewHeader : Html Msg
viewHeader =
    nav [ class "navbar header" ]
        [ div [ class "navbar-brand" ]
            [ span [ class "navbar-item" ]
                [ h1
                    [ class "title is-1" ]
                    [ text "MTGA Lands" ]
                ]
            , viewHeaderMana
            ]
        ]


viewHeaderMana : Html Msg
viewHeaderMana =
    let
        colors =
            [ "black"
            , "blue"
            , "green"
            , "red"
            , "white"
            ]

        manaClass =
            "mana"
    in
    div [ class "navbar-item" ]
        (List.map
            (\c -> img [ src ("/images/mana/" ++ c ++ "_mana.svg"), class manaClass ] [])
            colors
        )


viewLands : Lands -> Html Msg
viewLands lands =
    let
        landsAsHtml =
            List.map (\l -> viewLand l) (landsToList lands)

        landRows =
            greedyGroupsOf 5 landsAsHtml

        landRowClass =
            "columns"
    in
    div []
        (List.map
            (\landRow -> div [ class landRowClass ] landRow)
            landRows
        )


viewLand : Land -> Html Msg
viewLand land =
    let
        landUrl =
            landToImgUrl land

        columnClass =
            "column"

        landImgClass =
            "land-img"
    in
    div [ class columnClass ]
        [ img [ src landUrl, class landImgClass ] []
        , viewLandButtons land
        ]


viewLandButtons : Land -> Html Msg
viewLandButtons land =
    let
        buttonsClass =
            "buttons"

        counterClass =
            "counter is-size-3 has-text-weight-bold"
    in
    div [ class buttonsClass ]
        [ viewLandButton (Increment land)
        , p [ class counterClass ] [ text (String.fromInt land.count) ]
        , viewLandButton (Decrement land)
        ]


viewLandButton : Msg -> Html Msg
viewLandButton msg =
    let
        divClass =
            "control"

        buttonClass =
            "button button is-info is-small counter-button"

        plusClass =
            "fas fa-plus-circle"

        minusClass =
            "fas fa-minus-circle"

        ( iconClass, buttonDisabled ) =
            case msg of
                Increment land ->
                    ( plusClass, False )

                Decrement land ->
                    ( minusClass, land.count == 0 )
    in
    div [ class divClass ]
        [ button [ class buttonClass, onClick msg, disabled buttonDisabled ] [ i [ class iconClass ] [] ] ]


viewDeckString : Lands -> Html Msg
viewDeckString lands =
    let
        deckStringAsText =
            List.map (\l -> text (landToString l ++ "\n")) (selectedLands lands)

        columnsClass =
            "columns"

        textareaClass =
            "textarea is-family-code"

        numberColumns =
            50
    in
    div [ class columnsClass ]
        [ textarea [ class textareaClass, cols numberColumns ] deckStringAsText ]
