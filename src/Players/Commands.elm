module Players.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import Json.Encode as Encode
import Players.Messages exposing (..)
import Players.Models exposing (PlayerId, Player)
import Players.Models exposing (PlayerId, Player)


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"


saveUrl : PlayerId -> String
saveUrl playerId =
    "http://localhost:4000/players/" ++ (toString playerId)


saveRequest : Player -> Http.Request Player
saveRequest player =
    Http.request
        { body = memberEncoded player |> Http.jsonBody
        , expect = Http.expectJson memberDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = saveUrl player.id
        , withCredentials = False
        }


save : Player -> Cmd Msg
save player =
    saveRequest player
        |> Http.send OnSave



-- DECODERS


collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Player
memberDecoder =
    let
        stringToIntDecoder =
            Decode.map (\s -> Result.withDefault 0 (String.toInt s)) Decode.string
    in
        Decode.map3 Player
            (field "id" stringToIntDecoder)
            (field "name" Decode.string)
            (field "level" Decode.int)


memberEncoded : Player -> Encode.Value
memberEncoded player =
    let
        list =
            [ ( "id", Encode.int player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        list
            |> Encode.object
