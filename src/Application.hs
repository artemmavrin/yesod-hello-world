{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ViewPatterns #-}

module Application (main) where

import Yesod (mkYesodDispatch, warp)

import Foundation
import Handler.Hello

mkYesodDispatch "HelloWorld" resourcesHelloWorld

main :: IO ()
main = do
  putStrLn "Serving application on http://localhost:3000"
  warp 3000 HelloWorld
