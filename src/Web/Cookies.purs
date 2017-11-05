module Web.Cookies (
           setCookie
         , getCookie
         , deleteCookie
         , COOKIE (..)
         , CookiesOptions
         , path
         , domain
         , expires
         , secure
         ) where

import Prelude
import Control.Monad.Eff (Eff, kind Effect)
import Data.Maybe (Maybe(..))
import Data.Options (Option, Options, opt)
import Data.JSDate (JSDate)

foreign import data COOKIE :: Effect
foreign import data CookiesOptions :: Type

-- Following are the available cookies options
--

path :: Option CookiesOptions String
path = opt "path"

domain :: Option CookiesOptions String
domain = opt "domain"

expires :: Option CookiesOptions JSDate
expires = opt "expires"

secure :: Option CookiesOptions Boolean
secure = opt "secure"
       
       
foreign import _setCookie :: forall eff value opts. String -> value -> opts -> Eff (cookie :: COOKIE | eff) Unit

foreign import _getCookie :: forall eff value. String -> Eff (cookie :: COOKIE | eff) (Array value)

-- |  Get cookie with specified name.
getCookie :: forall eff value. String -> Eff (cookie :: COOKIE | eff) (Maybe value)
getCookie key = do
    cook <- _getCookie key
    prepare cook
    where prepare [value] = pure $ Just value
          prepare _ = pure Nothing

-- |  Delete cookie with specified name.
foreign import deleteCookie :: forall eff. String -> Eff (cookie :: COOKIE | eff) Unit

-- | Set cookie with specified name and value. Last argument (opts) is a map of optional arguments such as expiration time.
setCookie :: forall eff value. String -> value -> Maybe (Options CookiesOptions) -> Eff (cookie :: COOKIE | eff) Unit
setCookie name value Nothing = _setCookie name value unit
setCookie name value (Just opts) = _setCookie name value opts

-- | Set cookie with specified name and value. No options to the cookie are specified.
setSimpleCookie :: forall eff value. String -> value -> Eff (cookie :: COOKIE | eff) Unit
setSimpleCookie name value = _setCookie name value unit
