module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Land exposing (Land, landToHrefId, landToImgUrl, landToString)
import Lands exposing (Lands, firstLandOfType, landsToList, selectedLands)
import List.Extra exposing (greedyGroupsOf)
import Modal exposing (createModal)
import Model exposing (Model)
import Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ viewHeader
        , viewLands model.lands
        , viewDeckString model.modalOpen model.lands
        ]


viewHeader : Html Msg
viewHeader =
    nav [ class "navbar header" ]
        [ div [ class "navbar-brand" ] [ viewHeaderTitle, viewHeaderMana ]
        , div [ class "navbar-menu" ] [ div [ class "navbar-end" ] [ viewHeaderExport ] ]
        ]


viewHeaderTitle : Html Msg
viewHeaderTitle =
    let
        navbarItemClass =
            "navbar-item"

        titleClass =
            "title is-1"

        titleText =
            "MTGA Lands"
    in
    div [ class navbarItemClass ] [ h1 [ class titleClass ] [ text titleText ] ]


viewHeaderMana : Html Msg
viewHeaderMana =
    let
        colors =
            [ ( "black", "Swamp" )
            , ( "blue", "Island" )
            , ( "green", "Forest" )
            , ( "red", "Mountain" )
            , ( "white", "Plains" )
            ]

        navbarItemClass =
            "navbar-item manas"
    in
    div [ class navbarItemClass ] (List.map (\( c, lt ) -> viewManaLink c lt) colors)


viewHeaderExport : Html Msg
viewHeaderExport =
    let
        navbarItemClass =
            "navbar-item export-button"

        buttonClass =
            "button is-primary"

        buttonText =
            "Export"
    in
    div [ class navbarItemClass ] [ button [ class buttonClass ] [ text buttonText ] ]


viewManaLink : String -> String -> Html Msg
viewManaLink mana landType =
    let
        firstLand =
            firstLandOfType landType

        firstLandId =
            landToHrefId firstLand

        manaUrl =
            "#" ++ firstLandId

        imgUrl =
            "/images/mana/" ++ mana ++ "_mana.svg"

        manaClass =
            "mana"
    in
    a [ href manaUrl ] [ img [ src imgUrl, class manaClass ] [] ]


viewLands : Lands -> Html Msg
viewLands lands =
    let
        landRows =
            greedyGroupsOf 5 (landsToList lands)
    in
    div []
        (List.map (\landRow -> viewLandRow landRow) landRows)


viewLandRow : List Land -> Html Msg
viewLandRow landRow =
    let
        landsAsHtml =
            List.map (\l -> viewLand l) landRow

        landRowClass =
            "columns"
    in
    div [ class landRowClass ] landsAsHtml


viewLand : Land -> Html Msg
viewLand land =
    let
        landUrl =
            landToImgUrl land

        landHrefId =
            landToHrefId land

        columnClass =
            "column"

        landImgClass =
            "land-img"
    in
    div [ class columnClass ]
        [ img [ id landHrefId, src landUrl, class landImgClass ] []
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
        [ viewLandButton (Decrement land)
        , p [ class counterClass ] [ text (String.fromInt land.count) ]
        , viewLandButton (Increment land)
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


viewDeckString : Bool -> Lands -> Html Msg
viewDeckString active lands =
    let
        deckStringAsText =
            List.map (\l -> text (landToString l ++ "\n")) (selectedLands lands)

        fieldClass =
            "field"

        controlClass =
            "control"

        textareaClass =
            "textarea is-info is-family-code"

        modalTitle =
            "MTGA DeckString"

        deckStringTextArea =
            div [ class fieldClass ]
                [ div [ class controlClass ]
                    [ textarea [ class textareaClass ] deckStringAsText ]
                ]
    in
    createModal modalTitle active (div [] [ deckStringTextArea ])
