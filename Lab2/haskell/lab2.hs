import System.Environment (getArgs)
import System.Exit (exitFailure)

import CPP.Lex
import CPP.Par
import CPP.ErrM

import TypeChecker
import Interpreter

-- | Parse, type check, and interpret a program given by the @String@.

--Monad set of types???

check :: String -> IO ()  --base name(Type)...printing or recieving input ??
check s = do
  case pProgram (myLexer s) of
    Bad err  -> do
      putStrLn "SYNTAX ERROR"
      putStrLn err
      exitFailure
    Ok  tree -> do
      case typecheck tree of
        Bad err -> do
          putStrLn "TYPE ERROR"
          putStrLn err
          exitFailure
        Ok _ -> interpret tree

-- | Main: read file passed by only command line argument and call 'check'.

main :: IO ()
main = do
  args <- getArgs -- extract monad and get the value
  case args of
    [file] -> (readFile file) >>= check -- >>= Bind operator, Monad m => m a -> (a -> m b) -> m b
    _      -> do
      putStrLn "Usage: lab2 <SourceFile>"
      exitFailure


