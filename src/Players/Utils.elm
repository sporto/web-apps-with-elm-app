module Players.Utils (..) where

import Players.Models exposing (Id)
import Perks.Models exposing (Perk)
import PerksPlayers.Models exposing (PerkPlayer)


bonusesForPlayerId : List PerkPlayer -> List Perk -> Id -> Int
bonusesForPlayerId perksPlayers perks playerId =
  perksForPlayerId perksPlayers perks playerId
    |> List.foldl (\perk acc -> acc + perk.bonus) 0


perksForPlayerId : List PerkPlayer -> List Perk -> Id -> List Perk
perksForPlayerId perksPlayers perks playerId =
  let
    perkIds =
      perkIdsForPlayerId perksPlayers playerId
  in
    perks
      |> List.filter (\perk -> List.any (\id -> id == perk.id) perkIds)


perkIdsForPlayerId : List PerkPlayer -> Id -> List Int
perkIdsForPlayerId perksPlayers playerId =
  perksPlayers
    |> List.filter (\perkPlayer -> perkPlayer.playerId == playerId)
    |> List.map (\perkPlayer -> perkPlayer.perkId)