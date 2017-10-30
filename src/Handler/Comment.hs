{-# LANGUAGE OverloadedStrings #-}
module Handler.Comment where

import Import

type Message = Text
data Comment =
  Comment Message
  deriving(Show)

instance ToJSON Comment where
    toJSON (Comment message) = object
        [ "content" .= message ]

getCommentR :: Handler TypedContent
getCommentR = selectRep $ do
  provideJson $ object ["result" .= x] where
    x = Comment "Hello world"

