module Handler.CommentSpec (spec) where

import TestImport

spec :: Spec
spec = withApp $ do
  describe "comments" $ do
    it "gives a 200" $ do
      get CommentR
      statusIs 200