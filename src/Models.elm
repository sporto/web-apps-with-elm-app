module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { players : WebData (List Player)
    , route : Route
     , newName : String
    , filter : String
    }


initialModel : Route -> Model
initialModel route =
    { players = RemoteData.Loading
    , route = route
    , newName = ""
    , filter = ""
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