module Web.Cookies (
           setCookie
         , getCookie
         , deleteCookie
         , COOKIE (..)
         ) where

import Prelude
import Control.Monad.Eff (Eff, kind Effect)
import Data.Array (uncons)
import Data.Maybe (Maybe(Just, Nothing))

foreign import data COOKIE :: Effect

-- | Set cookie with specified name and value. Last argument (opts) is a map of optional arguments such as expiration time
foreign import setCookie :: forall eff value opts. String -> value -> opts -> Eff (cookie :: COOKIE | eff) Unit

-- |  Get cookie with specified name
foreign import _getCookie :: forall eff value. String -> Eff (cookie :: COOKIE | eff) (Array value)

getCookie :: forall eff value. String -> Eff (cookie :: COOKIE | eff) (Maybe value)
getCookie key = do
    cook <- _getCookie key
    prepare cook
    where prepare arr = case uncons arr of
            Just { head: value } -> pure $ Just value
            Nothing -> pure Nothing

-- |  Delete cookie with specified name
foreign import deleteCookie :: forall eff. String -> Eff (cookie :: COOKIE | eff) Unit
