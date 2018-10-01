module Main where

import Prelude

import Effect.Aff (launchAff_)
import Effect (Effect)

import App (Query(..), app)
import PageRoute (pageRoute)
import Halogen as H
import Halogen.Aff (awaitBody, runHalogenAff)
import Halogen.VDom.Driver (runUI)
import Routing.PushState (makeInterface, matches)

main :: Effect Unit
main = do
  router <- makeInterface
  runHalogenAff do
    body <- awaitBody
    app' <- runUI app unit body

    H.liftEffect $ router # matches pageRoute \_ route ->
      launchAff_ $ app'.query (H.action $ RouteChange route)
