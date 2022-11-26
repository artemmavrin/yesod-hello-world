{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.Hello
  ( getHelloR
  , postHelloR
  , getHelloNamedR
  ) where

import Data.Aeson (object, Value, (.=))
import Data.Maybe (fromMaybe)
import Data.Text (Text)
import Yesod
  ( defaultLayout
  , lookupGetParam
  , provideRep
  , requireCheckJsonBody
  , selectRep
  , Html
  , TypedContent
  , whamlet
  )

import Foundation (Handler)
import qualified Model.PostHello as PostHello (name)

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

getHelloR :: Handler TypedContent
getHelloR = lookupGetParam "name" >>= greet . fromMaybe "World"

postHelloR :: Handler TypedContent
postHelloR = requireCheckJsonBody >>= greet . PostHello.name

getHelloNamedR :: Text -> Handler TypedContent
getHelloNamedR = greet
