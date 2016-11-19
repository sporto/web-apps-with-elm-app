# An example SPA in Elm

An example Elm single page application built for http://www.elm-tutorial.org/

## This application demonstrates

- The Elm architecture
- Routing
- Ajax requests and Json parsing
- External CSS

## This application uses

- [Html](http://package.elm-lang.org/packages/elm-lang/html) for structure
- [Navigation](http://package.elm-lang.org/packages/elm-lang/navigation) for routing
- [Webpack](https://webpack.github.io/) for building
- [Basscss](http://www.basscss.com/) for css styles
- [JsonServer](https://github.com/typicode/json-server) for fake api

## Setup

- [Install Elm](http://elm-lang.org/install)
- [Install Node](https://nodejs.org/en/download/)

Install global packages

```
npm install -g foreman
```

Foreman is a package that allows running several servers with one command.

Install the local node packages:

```
npm install
```

## Running the application:

```
nf start
```

Open `http://localhost:3000`

## Possible improvements

- Add player
- Delete players
- Change player name
- Show error messages
- Optimistic updates
- List of perks
- Show perks for player
- Validation for player name when empty
- Search box for perks
- Tests
- When deleting a player delete associated perksPlayers

