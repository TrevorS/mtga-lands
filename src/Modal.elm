module Modal exposing (createModal)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg exposing (Msg(..))


createModal : String -> Bool -> Html Msg -> Html Msg
createModal title active html =
    let
        modalClass =
            case active of
                True ->
                    "modal is-active"

                False ->
                    "modal"

        modalBackgroundClass =
            "modal-background"

        modalCardClass =
            "modal-card"

        modalCardHeadClass =
            "modal-card-head"

        modalCardTitle =
            "modal-card-title"

        buttonCloseClass =
            "delete"

        buttonCloseMsg =
            HideModal

        modalCardBody =
            "modal-card-body"

        modalCardFoot =
            "modal-card-foot"

        buttonCopyClass =
            "button is-success"

        buttonCopyAttribute =
            "data-clipboard-copy"

        buttonCopyTarget =
            "#deck-string"

        buttonCopyText =
            "Copy To Clipboard"

        modalHeader =
            header [ class modalCardHeadClass ]
                [ p [ class modalCardTitle ] [ text title ]
                , button [ class buttonCloseClass, onClick buttonCloseMsg ] []
                ]

        modalBody =
            section [] [ html ]

        modalFooter =
            footer [ class modalCardFoot ]
                [ button
                    [ class buttonCopyClass
                    , attribute buttonCopyAttribute buttonCopyTarget
                    , onClick HideModal
                    ]
                    [ text buttonCopyText ]
                ]
    in
    div [ class modalClass ]
        [ div [ class modalBackgroundClass ] []
        , div [ class modalCardClass ]
            [ modalHeader
            , modalBody
            , modalFooter
            ]
        ]
