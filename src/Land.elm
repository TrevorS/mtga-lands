module Land exposing (Land, landToString)


type alias Land =
    { id : Int
    , set : String
    , landType : String
    , count : Int
    , key : Int
    }


landToString : Land -> String
landToString land =
    let
        landId =
            String.fromInt land.id

        landCount =
            String.fromInt land.count
    in
    String.fromInt land.count ++ " " ++ land.landType ++ " (" ++ land.set ++ ") " ++ landId
