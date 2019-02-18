module Model exposing (Model)

import Lands exposing (Lands)


type alias Model =
    { lands : Lands
    , modalOpen : Bool
    }
