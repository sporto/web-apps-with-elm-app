module Update exposing (..)

import Commands exposing (savePlayerCmd, addPlayerCmd)
import Models exposing (Model, Player, initialPlayer)
import Msgs exposing (Msg)
import Routing exposing (parseLocation)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        Msgs.ChangeLevel player howMuch ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch }
            in
                ( model, savePlayerCmd updatedPlayer )

        Msgs.OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        Msgs.OnPlayerSave (Err error) ->
            ( model, Cmd.none )
        Msgs.Setfilter fltr ->
            ( { model | filter = fltr }, Cmd.none )
        Msgs.UpdateName name ->
          ({model | newName = name}, Cmd.none)
        Msgs.AddNew  ->
         let
            newPlayer =
              { initialPlayer | name = model.newName, id =  (nextid model.players) }
         in
              ( model, addPlayerCmd newPlayer )
        Msgs.OnPlayerAdd  (Ok player) ->
             ((addPlayerToModel model player), Cmd.none )
        Msgs.OnPlayerAdd (Err error) ->
            ( {model | filter = (toString error)}, Cmd.none )

updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }

addPlayerToModel : Model  -> Player -> Model
addPlayerToModel model newplayer= 
  case model.players of
    RemoteData.Success  playerlist ->
      {model | players = (RemoteData.succeed (newplayer::playerlist)) }
    _  ->
      model

greatestid : Player -> Int -> Int
greatestid  curplayer gid =
   let
     playerid = Result.withDefault 0 (String.toInt curplayer.id)
   in
     if (playerid > gid) then
       playerid
     else
       gid

nextid :  RemoteData.RemoteData e (List Player) -> String
nextid rd =
  case rd of
    RemoteData.Success  playerlist ->
      1 + (playerlist |> List.foldr greatestid 0 ) |> toString 
    _  ->
       "0"
