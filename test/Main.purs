module Test.Main where

import Prelude (discard, ($), (<<<), (<>), Unit)
import Web.Cookies
import Data.Options (options, (:=))
import Data.DateTime (DateTime(..), Month(..), Time(..), canonicalDate)
import Data.JSDate (fromDateTime)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Enum (toEnum)
import Data.Maybe (Maybe(..), fromJust)
import Partial.Unsafe (unsafePartial)
-- import Test.Spec (describe, it)
-- import Test.Spec.Assertions (shouldEqual)
-- import Test.Spec.Reporter.Console (consoleReporter)
-- import Test.Spec.Runner (RunnerEffects, run)

foreign import stringify :: forall o. o -> String

main :: forall a. Eff (cookie :: COOKIE, console :: CONSOLE | a) Unit   
main = do
  let enumYear = unsafePartial fromJust <<< toEnum
      enumDay = unsafePartial fromJust <<< toEnum
      enumHour = unsafePartial fromJust <<< toEnum
      enumMin = unsafePartial fromJust <<< toEnum
      enumSec = unsafePartial fromJust <<< toEnum
      enumMilis = unsafePartial fromJust <<< toEnum
      
  let opts = path := "mypath"
          <> domain := "mydomain"
          <> secure := true
          <> expires := (fromDateTime (DateTime (canonicalDate (enumYear 2017) March (enumDay 26))
                                       (Time (enumHour 12) (enumMin 0) (enumSec 0) (enumMilis 0))))
  setCookie "key" "value" (Just opts)
  log $ stringify $ options opts

-- main :: Eff (RunnerEffects ()) Unit
-- main = run [consoleReporter] do
--   describe "Attributes" do
--     it "awesome" do
--       let isAwesome = true
--       (1 + 1) `shouldEqual` 2
