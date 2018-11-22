module Interpreter where

import Control.Monad

import Data.Map (Map)
import qualified Data.Map as Map

import CPP.Abs
import CPP.Print
import CPP.ErrM

interpret :: Program -> IO ()
interpret p = putStrLn "no interpreter yet"

eval env (EMul a b) = do
u <- eval env a
v <- eval env b
return (u * v)

execStm :: Env -> Stm -> IO Env
evalExp :: Env -> Exp -> IO (Val,Env)


inferExp :: Env -> Exp -> Err Type
inferExp env x = case x of
    ETrue      -> return Type_bool
    EInt n     -> return Type_int
    EId id     -> lookVar env id
    EPIncr exp -> inferNumeric env exp
    ETimes exp0 exp -> inferNumericBin env exp0 exp
  
inferNumeric :: Env -> Exp -> Err Type
inferNumeric env exp = do
typ <- inferExp env exp
      if elem typ [Type_int, Type_double] then
          return typ
        else
          fail $ "type of expression " ++ printTree exp -- ...
  
inferNumericBin :: Env -> Exp -> Exp -> Err Type