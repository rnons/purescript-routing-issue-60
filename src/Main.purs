module Main where

import Prelude

import App (Query(..), app)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Halogen as H
import Halogen.Aff (awaitBody, runHalogenAff)
import Halogen.VDom.Driver (runUI)
import PageRoute (pageRoute)
import Routing.Duplex as RD
import Routing.PushState (makeInterface, matchesWith)

main :: Effect Unit
main = do
  router <- makeInterface
  runHalogenAff do
    body <- awaitBody
    app' <- runUI app unit body

    H.liftEffect $ router # matchesWith (RD.parse pageRoute) \_ route ->
      launchAff_ $ app'.query (H.action $ RouteChange route)
