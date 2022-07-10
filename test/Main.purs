module Test.Main where

import Prelude

import Effect (Effect)
import Test.Assert (assertEqual)
import PureVue (compileScript)

main :: Effect Unit
main = do
  let expCode = "return { foo: \"bar\" }"  
  { content } <- compileScript """
    <script lang="purescript">
      import Prelude
      import Effect (Effect)
      import PureVue (UnwrapRef (never), expose)

      foo :: UnwrapRef String String
      foo = never "foo" "bar"

      setup :: Effect Unit
      setup = expose foo
    </script>
      """ { parse = \_ -> pure unit }
  assertEqual { expected = expCode, actual = content }
