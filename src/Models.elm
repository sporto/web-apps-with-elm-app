module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { players : WebData (List Player)
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { players = RemoteData.Loading
    , route = route
    , newName : String
    , filter : String
    }


type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }


initialPlayer : Player
initialPlayer  =
 {
    id = "0"
    , name = ""
    , level = 0
}

type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
    | AddPlayerRoute