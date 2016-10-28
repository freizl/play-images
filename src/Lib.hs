{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}

module Lib
    ( someFunc
    ) where

--import Data.Typeable
import Diagrams.Prelude
--import Diagrams.Backend.SVG.CmdLine
import Diagrams.Backend.Rasterific.CmdLine


-- someFunc :: (TypeableFloat n, Typeable a, Renderable (DImage n a) b) => IO (QDiagram b V2 n Any)
someFunc :: IO ()
someFunc = do
  img <- loadImageIO
  defaultMain ((img ||| img ) === (img ||| img ) :: Diagram B)

-- TODO: ImageEmb .v.s loadImageExt
--
loadImageIO = do
  res <- loadImageEmb "/Users/haisheng.wu/git/play-images/data/hw.jpg"
  return $ case res of
     Left err    -> mempty
     Right phone -> image phone
