module Main where

import Prelude

import App (Query(..), app)
import Data.Either (Either(..))
import Debug.Trace (trace)
import Effect (Effect)
import Effect.Aff (error, launchAff_)
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

    H.liftEffect $ router # matchesWith (\s -> case RD.parse pageRoute s of
      Left err -> trace err $ \_ -> Left err
      Right r -> Right r) \_ route ->
      launchAff_ $ app'.query (H.action $ RouteChange route)
