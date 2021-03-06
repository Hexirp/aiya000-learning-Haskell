{-# LANGUAGE TemplateHaskell #-}

import Lens.Micro
import Lens.Micro.TH (makeLenses)
import Lens.Micro.Mtl ((.=))
import Control.Monad.State.Lazy (State, execState)

data Str = Str
  { _x :: Int
  , _y :: String
  } deriving (Show)

data BigStr = BigStr
  { _str    :: Str
  , _number :: Int
  } deriving (Show)

makeLenses ''Str
makeLenses ''BigStr


main :: IO ()
main = do
  let a  = Str 10 "ahoge"
      a' = execState context a
  print a
  print a'
  let big = BigStr (Str 1 "chinchin") 2
  print $ big ^. str . y

context :: State Str ()
context = do
  x .= 20
  y .= "baka"
