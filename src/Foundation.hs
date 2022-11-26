{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ViewPatterns #-}

module Foundation where

import Data.Text (Text)
import Yesod (mkYesodData, parseRoutesFile, renderRoute, Yesod)

data HelloWorld = HelloWorld

mkYesodData "HelloWorld" $(parseRoutesFile "config/routes.yesodroutes")

instance Yesod HelloWorld
