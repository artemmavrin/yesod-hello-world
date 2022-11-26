{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ViewPatterns #-}

module HelloWorld (main) where

import Data.Maybe (fromMaybe)
import Data.Text (Text)
import Yesod

data HelloWorld = HelloWorld

mkYesod "HelloWorld" $(parseRoutesFile "config/routes.yesodroutes")

instance Yesod HelloWorld

getHelloR :: Handler TypedContent
getHelloR = lookupGetParam "name" >>= greet . fromMaybe "World"

getHelloNamedR :: Text -> Handler TypedContent
getHelloNamedR = greet

greet :: Text -> Handler TypedContent
greet name = selectRep $ do
  provideRep greetJson
  provideRep greetHtml
  where
    greetJson :: Handler Value
    greetJson = return $ object ["name" .= name]

    greetHtml :: Handler Html
    greetHtml = defaultLayout [whamlet|Hello, #{name}!|]

main :: IO ()
main = do
  putStrLn "Serving application on http://localhost:3000"
  warp 3000 HelloWorld
