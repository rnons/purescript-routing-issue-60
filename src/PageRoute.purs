module PageRoute where

import Prelude

import Data.Generic.Rep (class Generic)
import Routing.Duplex (RouteDuplex', root)
import Routing.Duplex.Generic (noArgs)
import Routing.Duplex.Generic as RDG

data Region = East | West
derive instance eqRegion :: Eq Region
derive instance genericRegion :: Generic Region _

data PageRoute
  = Root
  | RegionRoute Region

derive instance eqPageRoute :: Eq PageRoute
derive instance genericPageRoute :: Generic PageRoute _

pageRoute :: RouteDuplex' PageRoute
pageRoute =
  root $ RDG.sum
    { "Root": noArgs
    , "RegionRoute": regionRoute
    }
  where
  regionRoute :: RouteDuplex' Region
  regionRoute = RDG.sum
    { "East": noArgs
    , "West": noArgs
    }
