{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
module Handler.CommentSpec (spec) where

import TestImport
import Data.Aeson

spec :: Spec
spec = withApp $ do

  describe "GET api/v1/comments" $ do
    it "gives a 200" $ do
      get ("api/v1/comments" :: Text)
      statusIs 200

    it "returns [{\"message\": \"Hello World\"}, {\"message\": \"Foo\"}]" $ do
      request $ do
        setMethod "GET"
        setUrl ("api/v1/comments" :: Text)
        addRequestHeader ("Content-Type", "application/json")

      bodyEquals "[{\"message\":\"Hello World\"},{\"message\":\"Foo\"}]"

  describe "POST api/v1/comments" $ do
    it "400 when JSON body is invalid" $ do
      let body = object [ "foo" .= ("something" :: Value) ]
      request $ do
        setMethod "POST"
        setUrl ("api/v1/comments" :: Text)
        setRequestBody $ encode body
        addRequestHeader ("Content-Type", "application/json")
      statusIs 400

    it "returns the inserted object when valid" $ do
      let body = object [ "message" .= ("Hello!" :: Value) ]
      request $ do
        setMethod "POST"
        setUrl ("api/v1/comments" :: Text)
        setRequestBody $ encode body
        addRequestHeader ("Content-Type", "application/json")

      bodyEquals "{\"message\":\"Hello!\"}"

  describe "bad url" $ do
    it "gives a 404" $ do
      get ("api/v1/bad" :: Text)
      statusIs 404