{-# LANGUAGE TemplateHaskell #-}

module PostHello (PostHello (name)) where

import Data.Aeson.TH (deriveJSON, defaultOptions)
import Data.Text (Text)

data PostHello = HelloPost { name :: Text }

$(deriveJSON defaultOptions ''PostHello)
