module PageRoute where

import Prelude

import Data.Foldable (oneOf)
import Data.List (List(..))
import Data.Semiring.Free (free)
import Data.Tuple (Tuple(..))
import Data.Validation.Semiring (invalid)
import Routing.Match (Match(..), lit, root)
import Routing.Match.Error (MatchError(..))
import Routing.Types (RoutePart(..))

data Region = East | West
derive instance eqRegion :: Eq Region

data PageRoute = RegionRoute Region
derive instance eqPageRoute :: Eq PageRoute

pageRoute :: Match PageRoute
pageRoute =
  root *> oneOf
  [ RegionRoute <$> regionMatcher
  ]

regionMatcher :: Match Region
regionMatcher = Match \route ->
  case route of
    Cons (Path i) rs -> case i of
      "east" -> pure $ Tuple rs East
      "west" -> pure $ Tuple rs West
      _ -> invalid $ free $ Fail "Invalid region"
    _ -> invalid $ free ExpectedPathPart
