# purescript-cookies

Library allows setting, getting and deleting cookies.

Examples:

    import Web.Cookies

    setcook :: forall a b eff. a -> b -> Control.Monad.Eff.Eff (cookie :: COOKIE | eff) Prelude.Unit
    setcook event element = do
        setCookie "mycookie" 123 unit

    getcook :: forall a b eff. a -> b -> Control.Monad.Eff.Eff (cookie :: COOKIE, console :: Control.Monad.Eff.Console.CONSOLE | eff) Prelude.Unit
    getcook event element = do
        cook <- getCookie "mycookie"
        log cook
