## Module Web.Cookies

#### `setCookie`

``` purescript
setCookie :: forall eff value opts. String -> value -> opts -> Eff (cookie :: COOKIE | eff) Unit
```

Set cookie with specified name and value. Last argument (opts) is a map of optional arguments such as expiration time

#### `getCookie`

``` purescript
getCookie :: forall eff value. String -> Eff (cookie :: COOKIE | eff) value
```

 Get cookie with specified name

#### `deleteCookie`

``` purescript
deleteCookie :: forall eff. String -> Eff (cookie :: COOKIE | eff) Unit
```

 Delete cookie with specified name


