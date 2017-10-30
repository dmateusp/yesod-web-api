{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
module Handler.Comment where

import Import

type Message = Text
data Comment =
  Comment Message
  deriving(Show)

instance ToJSON Comment where
    toJSON (Comment message) = object
        [ "message" .= message ]
instance FromJSON Comment where
  parseJSON (Object o) = Comment
    <$> o .: "message"
  parseJSON _ = mzero

getCommentR :: Handler Value
getCommentR = do
  returnJson x where
    x = [Comment "Hello World", Comment "Foo"]

postCommentR :: Handler Value
postCommentR = do
  comment <- (requireJsonBody :: Handler Comment)
  returnJson comment