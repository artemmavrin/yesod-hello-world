{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ViewPatterns #-}

module HelloWorld (main) where

import Data.Maybe (fromMaybe)
import Data.Text (Text)
import Yesod

import qualified PostHello (name)

data HelloWorld = HelloWorld

mkYesod "HelloWorld" $(parseRoutesFile "config/routes.yesodroutes")

instance Yesod HelloWorld

getHelloR :: Handler TypedContent
getHelloR = lookupGetParam "name" >>= greet . fromMaybe "World"

postHelloR :: Handler TypedContent
postHelloR = requireCheckJsonBody >>= greet . PostHello.name

getHelloNamedR :: Text -> Handler TypedContent
getHelloNamedR = greet

greet :: Text -> Handler TypedContent
greet name = selectRep $ do
  provideRep greetJson
  provideRep greetHtml
  where
    greeting :: Text
    greeting = "Hello, " <> name <> "!"

    greetJson :: Handler Value
    greetJson = return $ object ["greeting" .= greeting]

    greetHtml :: Handler Html
    greetHtml = defaultLayout [whamlet|#{greeting}|]

main :: IO ()
main = do
  putStrLn "Serving application on http://localhost:3000"
  warp 3000 HelloWorld
