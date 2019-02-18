module Msg exposing (Msg(..))

import Land exposing (Land)


type Msg
    = Increment Land
    | Decrement Land
    | ShowModal
    | HideModal
    | Clear
