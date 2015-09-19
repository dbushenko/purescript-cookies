module Web.Cookies (
           setCookie
         , getCookie
         , deleteCookie
         ) where

import Prelude
import Control.Monad.Eff

foreign import data COOKIE :: !

-- | Set cookie with specified name and value. Last argument (opts) is a map of optional arguments such as expiration time
foreign import setCookie :: forall eff value opts. String -> value -> opts -> Eff (cookie :: COOKIE | eff) Unit

-- |  Get cookie with specified name
foreign import getCookie :: forall eff value. String -> Eff (cookie :: COOKIE | eff) value

-- |  Delete cookie with specified name
foreign import deleteCookie :: forall eff. String -> Eff (cookie :: COOKIE | eff) Unit
