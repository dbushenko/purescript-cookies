module Web.Cookies (
           setCookie
         , getCookie
         , deleteCookie
         , COOKIE (..)
         ) where

import Prelude
import Control.Monad.Eff
import Data.Maybe

foreign import data COOKIE :: !

-- | Set cookie with specified name and value. Last argument (opts) is a map of optional arguments such as expiration time
foreign import setCookie :: forall eff value opts. String -> value -> opts -> Eff (cookie :: COOKIE | eff) Unit

-- |  Get cookie with specified name
foreign import _getCookie :: forall eff value. String -> Eff (cookie :: COOKIE | eff) (Array value)

getCookie :: forall eff value. String -> Eff (cookie :: COOKIE | eff) (Maybe value)
getCookie key = do
    cook <- _getCookie key
    prepare cook
    where prepare [] = return Nothing
          prepare [value] = return $ Just value

-- |  Delete cookie with specified name
foreign import deleteCookie :: forall eff. String -> Eff (cookie :: COOKIE | eff) Unit
