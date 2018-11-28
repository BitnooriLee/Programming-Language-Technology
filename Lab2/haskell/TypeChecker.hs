module TypeChecker where

import Control.Monad
import Control.Monad.Except
import Control.Monad.Reader
import Control.Monad.State

import Data.Functor
import Data.Maybe
import Data.Map (Map)
import qualified Data.Map as Map
import qualified Data.Set as Set

import CPP.Abs
import CPP.Print        (printTree)
import CPP.ErrM        (Err(Ok,Bad))

type Sig               = Map Id FunType
data FunType           = FunType { funRet :: Type, fucPars :: [Type] }

data St = St
     { stCxt :: Cxt
     , stRet :: Type
     }

type Cxt = [Block]
type Block = Map Id Type

type TypeError = String

type Check = ReaderT Sig (StateT St (Except TypeError))

builtin :: [(Id, FunType)]
builtin =
        [ (Id "readInt"                  , FunType Type_int      [])
        , (Id "readDouble"         , FunType Type_double [])
        , (Id "printInt"                  , FunType Type_void [Type_int])
        , (id "printDouble"          , FunType Type_void [Type_double])
        ]
        
typecheck :: Program -> Err ()
typecheck prg@(PDefs defs) = do
          let sig = builtin ++ map mkF defs
               mkF (DFun  t  f   arg _ss) = ( f, FunType t $ map (\ (ADecl t _) -> t) args)
          --Check for duplicate function definitions.
          --TODO ! 
          let st = undefined
          case runExcept (evalStateT    (runReaderT (checkProgram prg) $ Map.fromList sig) st) of
               Left s -> Bad s
               Right () -> return ()

checkProgram :: Program -> Check ()
checkProgram (PDefs defs) = do
             mapM



compile :: String -> IO ()
compile s = case pProgram (myLexer s) of
Bad err -> do
putStrLn "SYNTAX ERROR"
putStrLn err
exitFailure
Ok tree -> case typecheck tree of
Bad err -> do
putStrLn "TYPE ERROR"
putStrLn err
exitFailure
Ok _ -> putStrLn "OK" -- or go to next compiler phase

data Err a = Ok a | Bad String

checkExp :: Env -> Exp -> Type -> Err ()

do checkExp env exp1 typ
checkExp env exp2 typ

do typ1 <- inferExp env exp1
checkExp env exp2 typ1
return typ1

type Env = (Sig,[Context]) -- functions and context stack
type Sig = Map Id ([Type],Type) -- function type signature
type Context = Map Id Type -- variables with their types

lookupVar :: Env -> Id -> Err Type
lookupFun :: Env -> Id -> Err ([Type],Type)
updateVar :: Env -> Id -> Type -> Err Env
updateFun :: Env -> Id -> ([Type],Type) -> Err Env
newBlock :: Env -> Env
emptyEnv :: Env

inferExp :: Env -> Exp -> Err Type
inferExp env x = case x of
ETrue -> return Type_bool
EFlase->return Type_bool --1
EInt n -> return Type_int
EDouble -> return Type_double --1 
EId id -> lookupVar env id

--EApp id -> 

EPostIncr id -> --1
inferBin [Type_int, Type_double] lookupVar env id
EPostDecr id -> --1
inferBin [Type_int, Type_double] lookupVar env id

EPreIncr id -> --1
inferBin [Type_int, Type_double] lookupVar env id
EPreDecr id -> --1
inferBin [Type_int, Type_double] lookupVar env id

ETimes exp1 exp2 -> --1
inferBin [Type_int, Type_double] env exp1 exp2
EDiv exp1 exp2 -> --1
inferBin [Type_int, Type_double] env exp1 exp2

EPlus exp1 exp2 -> --1
inferBin [Type_int, Type_double] env exp1 exp2
EMinus exp1 exp2 -> --1
inferBin [Type_int, Type_double] env exp1 exp2

ELt exp1 exp2->
inferBin [Type_int, Type_double] env exp1 exp2

EAnd. exp1 exp2->
inferBin [Type_bool] env exp1 exp2 




inferBin :: [Type] -> Env -> Exp -> Exp -> Err Type
inferBin types env exp1 exp2 = do
typ <- inferExp env exp1
if elem typ types
then
checkExp env exp2 typ
else
fail $ "wrong type of expression " ++ printTree exp1

printTree :: a -> String

checkExp :: Env -> Type -> Exp -> Err ()
checkExp env typ exp = do
         typ2 <- inferExp env exp
         if (typ2 == typ) then
                  return ()
            else
                  fail $         "type of " ++ printTree exp ++
                                   "expected " ++ printTree typ ++
                                   "but found " ++ printTree typ2

checkStm :: Env -> Type -> Stm -> Err Env
checkStm env val x = case x of
         SExp exp -> do
              inferExp env exp
              return env
         SDecl typ x ->
              updateVar env id typ
         SWhile exp stm -> do
                checkExp env Type_bool exp
                checkStm env val stm

checkStm :: Env -> [Stm] -> Err Env
checkStms env stms = case stms of
         []  -> return env
         x : rest -> do
           env' <- checkStm env x
           checkStms env' rest                  -- check env' rest
           



