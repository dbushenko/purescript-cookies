# purescript-cookies

Library allows setting, getting and deleting cookies.

Examples:

    import Web.Cookies
    import Data.Options (options, (:=))
    import Data.DateTime (DateTime(..), Month(..), Time(..), canonicalDate)
    import Data.JSDate (fromDateTime)
    import Control.Monad.Eff (Eff)
    import Control.Monad.Eff.Console (CONSOLE, log)
    import Data.Enum (toEnum)
    import Data.Maybe (Maybe(..), fromJust)
    import Partial.Unsafe (unsafePartial)

    setcook :: forall a b eff. a -> b -> Control.Monad.Eff.Eff (cookie :: COOKIE | eff) Prelude.Unit
    setcook event element = do
      let enumYear = unsafePartial fromJust <<< toEnum
          enumDay = unsafePartial fromJust <<< toEnum
          enumHour = unsafePartial fromJust <<< toEnum
          enumMin = unsafePartial fromJust <<< toEnum
          enumSec = unsafePartial fromJust <<< toEnum
          enumMilis = unsafePartial fromJust <<< toEnum

      -- Options for the cookies.
      -- See details here: https://github.com/paf31/24-days-of-purescript-2014/blob/master/21.markdown
      let opts = path := "mypath"
              <> domain := "mydomain"
              <> secure := true
              <> expires := fromDateTime (DateTime (canonicalDate (enumYear 2017) March (enumDay 26))
                                                   (Time (enumHour 12) (enumMin 0) (enumSec 0) (enumMilis 0)))

      setCookie "mycookie" 123 (Just opts)
      setSimpleCookie "simpleCookie" "NoOptions"

    getcook :: forall a b eff. a -> b -> Control.Monad.Eff.Eff (cookie :: COOKIE, console :: Control.Monad.Eff.Console.CONSOLE | eff) Prelude.Unit
    getcook event element = do
      cook <- getCookie "mycookie"
      log cook
      cook2 <- getCookie "simpleCookie"
      log cook2

Purescript-cookies version 0.2.0 was stable enough. Version 0.3.0 is work in progress. The API will not change, but bugs have to be found and fixed.