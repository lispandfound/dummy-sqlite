module Main where

import Options.Applicative

data Options = Options
  { dbPath :: FilePath,
    command :: String
  }
  deriving (Show)

cli :: Parser Options
cli = Options <$> strArgument (help "Path to the database" <> metavar "DB") <*> strArgument (help "Query to execute" <> metavar "QUERY")

main :: IO ()
main = print =<< execParser opts
  where
    opts =
      info
        (cli <**> helper)
        (fullDesc <> progDesc "Toy SQlite reimplementation" <> header "dummy-sqlite - sqlite written by a dummy")
