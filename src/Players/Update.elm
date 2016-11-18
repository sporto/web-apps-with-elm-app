module Players.Update exposing (..)

import Navigation
import Players.Commands exposing (save, changeLevelCommands)
import Players.Messages exposing (Msg(..))
import Players.Models exposing (Player, PlayerId)


update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        FetchAll (Ok newPlayers) ->
            ( newPlayers, Cmd.none )

        FetchAll (Err error) ->
            ( players, Cmd.none )

        ShowPlayers ->
            ( players, Navigation.newUrl "#players" )

        ShowPlayer id ->
            ( players, Navigation.newUrl <| (++) "#players/" <| toString id )

        ChangeLevel id howMuch ->
            ( players, changeLevelCommands id howMuch players |> Cmd.batch )

        Save (Ok updatedPlayer) ->
            ( updatePlayer updatedPlayer players, Cmd.none )

        Save (Err error) ->
            ( players, Cmd.none )


updatePlayer : Player -> List Player -> List Player
updatePlayer updatedPlayer players =
    let
        select existingPlayer =
            if existingPlayer.id == updatedPlayer.id then
                updatedPlayer
            else
                existingPlayer
    in
        List.map select players
