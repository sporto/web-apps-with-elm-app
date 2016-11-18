module Routing exposing (..)

import Navigation
import UrlParser exposing (..)
import Players.Models exposing (PlayerId)


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute (s "")
        , map PlayerRoute (s "players" </> int)
        , map PlayersRoute (s "players")
        ]


hashParser : Navigation.Location -> Route
hashParser location =
    let
        maybeRoute =
            parseHash matchers location
    in
        case maybeRoute of
            Just route ->
                route

            Nothing ->
                NotFoundRoute
