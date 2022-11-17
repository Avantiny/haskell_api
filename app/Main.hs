{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}

module Main where

import Data.Aeson
import Servant
import GHC.Generics
import Network.Wai.Handler.Warp

data PingResponse = PingResponse {
    message :: String,
    status :: String
} deriving Generic

type PingAPI = "ping" :> Get '[JSON] PingResponse

instance ToJSON PingResponse

server :: Server PingAPI
server = return PingResponse {
    message = "Milan je dobrej",
    status = "Milan"
}

pingAPI :: Proxy PingAPI
pingAPI = Proxy

app :: Application
app = serve pingAPI server

main :: IO ()
main =  putStrLn "Milan" *> run 8081 app
