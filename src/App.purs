module App where

import Prelude

import Data.Maybe (Maybe(..))
import Effect.Aff (Aff)
import Halogen as H
import Halogen.HTML as HH
import PageRoute (PageRoute(..), Region(..))

data Query a
  = Init a
  | RouteChange PageRoute a

type State =
  { route :: PageRoute
  }

type HTML = H.ComponentHTML Query () Aff

type DSL = H.HalogenM State Query () Void Aff

initialState :: State
initialState =
  { route: RegionRoute East
  }

render :: State -> HTML
render state =
  HH.div_
  [ HH.text "hello world"
  , HH.div_
    [ case state.route of
        RegionRoute region -> case region of
          East -> HH.text "east route"
          West -> HH.text "west route"
    ]
  ]

app :: H.Component HH.HTML Query Unit Void Aff
app = H.component
  { initialState: const initialState
  , render
  , eval
  , receiver: const Nothing
  , initializer: Nothing
  , finalizer: Nothing
  }
  where
  eval :: Query ~> DSL
  eval (Init n) = n <$ do
    pure unit

  eval (RouteChange route n) = n <$ do
    H.modify_ $ _ { route = route }
