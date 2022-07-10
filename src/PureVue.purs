module PureVue where

import Prelude

import Effect (Effect)
-- import Data.Either (Either)

-- data CompilerError
-- data SyntaxError
data SFCScriptBlock
-- data SFCDescriptor
-- 
-- type SFCParseResult = Either (Either CompilerError SyntaxError) SFCDescriptor
-- 
-- compileScript :: String -> _ -> Effect SFCScriptBlock
-- compileScript src opt = compile <*> opt.parse src where
-- 	compile (Right descriptor) = purs descriptor
  
compileScript :: String -> _ -> Effect SFCScriptBlock
compileScript src opt = ?compileScript
