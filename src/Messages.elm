module Messages exposing (..)

import Players.Messages
import Navigation


type Msg
    = PlayersMsg Players.Messages.Msg
    | UrlChange Navigation.Location
