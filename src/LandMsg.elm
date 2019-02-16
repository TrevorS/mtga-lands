module LandMsg exposing (Msg(..))

import Land exposing (Land)


type Msg
    = Increment Land
    | Decrement Land
