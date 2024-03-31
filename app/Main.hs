module Main where

import Options.Applicative hiding (command)
import Data.ByteString.Lazy as BS
import Data.Binary.Get
import Data.Word

data Options = Options
  { dbPath :: FilePath,
    command :: String
  }
  deriving (Show)

cli :: Parser Options
cli = Options <$> strArgument (help "Path to the database" <> metavar "DB") <*> strArgument (help "Query to execute" <> metavar "QUERY")

pagesize :: Get Word16
pagesize = skip 16 *> getWord16be

main :: IO ()
main = do
  options <- execParser opts
  if command options == ".dbinfo" then do 
    db <- BS.readFile (dbPath options)
    putStrLn $ "Database page size " <> show (runGet pagesize db)
  else putStrLn $ "unrecoginsed command " <> command options
  where
    opts =
      info
        (cli <**> helper)
        (fullDesc <> progDesc "Toy SQlite reimplementation" <> header "dummy-sqlite - sqlite written by a dummy")
