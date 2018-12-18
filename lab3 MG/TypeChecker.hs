module TypeChecker where

import Control.Monad

import Data.Map (Map)
import qualified Data.Map as Map

import Data.Maybe

import CPP.Abs
import CPP.Print
import CPP.ErrM

type Env = (Sig, [Context]) -- functions and context stack
type Sig = Map Id ([Type], Type) -- function type signature
type Context = Map Id Type -- variables with their types

lookupVar :: Env -> Id -> Err Type
lookupVar (_sig,[]) x = fail $ "Unknown variable " ++ printTree x ++ "."
lookupVar (sig, scope:rest) x = case Map.lookup x scope of
    Nothing -> lookupVar (sig, rest) x
    Just t  -> return t

lookupFun :: Env -> Id -> Err ([Type],Type)
lookupFun (sig, _) x = case Map.lookup x sig of
    Nothing -> fail $ "Function " ++ printTree x ++ " is not declared."
    Just t  -> return t

                             
updateVar :: Env -> Id -> Type -> Err Env
updateVar (sig,cxt) id typ = do
  when (typ==Type_void) $ 
    fail "type void is illegal for variable"
  case cxt of
    [] -> fail "type checker: no context"
    scope:rest -> case Map.lookup id scope of
      Just a -> fail $ "variable " ++ printTree id ++ " declared already"
      Nothing -> return (sig, Map.insert id typ scope:rest)

newVar :: Env -> Id -> Type -> Err Env
newVar (sig, scope:rest) x t = case Map.lookup x scope of
    Nothing -> do
        when (t == Type_void) $
            fail $ "Type void of variable " ++ printTree x ++ " is illegal"
        return (sig, (Map.insert x t scope):rest)
    Just _  -> fail $"Variable " ++ printTree x ++ " already declared."

updateFun :: Env -> Id -> ([Type],Type) -> Err Env
updateFun (sig, ctx) x t = case Map.lookup x sig of
    Nothing -> return ((Map.insert x t sig), ctx)
    Just _ -> fail $ "Function " ++ printTree x ++ " is already declared."

        
newBlock :: Env -> Env
newBlock (sig,ctx) = (sig,Map.fromList [] : ctx)

emptyEnv :: Env
emptyEnv = (Map.empty, [Map.empty])


inferExp :: Env -> Exp -> Err Type
inferExp env x = case x of
  ETrue     -> return Type_bool
  EFalse    -> return Type_bool
  EInt _    -> return Type_int
  EDouble _ -> return Type_double
  EId id    -> lookupVar env id
  EApp id exps ->do
        (args, typ) <- lookupFun env id
        exps'     <- mapM (inferExp env) exps
        if (args == exps')
            then return typ
        else fail $ "The arguments (" ++ printTree exps' 
            ++ ") don't match parameters (" ++ printTree args ++ ")"
  EPostIncr id -> do
        typ <- lookupVar env id
        inferUn [Type_int, Type_double] env typ
  EPostDecr id -> do
        typ <- lookupVar env id
        inferUn [Type_int, Type_double] env typ
  EPreIncr id  -> do
        typ <- lookupVar env id
        inferUn [Type_int, Type_double] env typ
  EPreDecr id  -> do
        typ <- lookupVar env id
        inferUn [Type_int, Type_double] env typ
  ETimes e1 e2 -> inferBin [Type_int,Type_double] env e1 e2
  EDiv    e1 e2 -> inferBin [Type_int,Type_double] env e1 e2
  EPlus  e1 e2 -> inferBin [Type_int,Type_double] env e1 e2
  EMinus e1 e2 -> inferBin [Type_int,Type_double] env e1 e2
  ELt    e1 e2 -> inferBin [Type_int,Type_double] env e1 e2 >>
                              return Type_bool
  EGt    e1 e2 -> inferBin [Type_int,Type_double] env e1 e2 >>
                              return Type_bool
  ELtEq   e1 e2 -> inferBin [Type_int,Type_double] env e1 e2 >>
                              return Type_bool
  EGtEq   e1 e2 -> inferBin [Type_int,Type_double] env e1 e2 >>
                              return Type_bool
  EAnd   e1 e2 -> inferBin [Type_bool] env e1 e2
  EOr    e1 e2 -> inferBin [Type_bool] env e1 e2
  EEq    e1 e2 -> inferBin [Type_int,Type_double,Type_bool] env e1 e2 >>
                              return Type_bool
  ENEq   e1 e2 -> inferBin [Type_int,Type_double,Type_bool] env e1 e2 >>
                           return Type_bool
  EAss id exp -> do
    typ <- lookupVar env id
    checkExp env typ exp
    return typ


inferBin :: [Type] -> Env -> Exp -> Exp -> Err Type
inferBin types env exp1 exp2 = do
    typ <- inferExp env exp1
    if elem typ types
        then do
            checkExp env typ exp2
            return typ

    else
        fail $ "wrong type of expression " ++ printTree exp1


inferUn :: [Type] -> Env -> Type -> Err Type
inferUn types env typ = do
    if elem typ types
        then
            return typ
    else
        fail $ "Type " ++ show typ ++ " does not match"


checkExp :: Env -> Type -> Exp -> Err ()
checkExp env typ exp = do
    typ2 <- inferExp env exp
    if (typ2 == typ) then
        return ()
    else
        fail $ "Type of " ++ printTree exp ++
        "expected " ++ printTree typ ++
        "but found " ++ printTree typ2


checkStm :: Env -> Type -> Stm -> Err Env
checkStm env val x = case x of
    SExp exp -> do
        inferExp env exp
        return env
    SDecls typ x ->     
        foldM (\env id -> updateVar env id typ) env x
            
    SWhile exp stm -> do
        checkExp env Type_bool exp
        (sig,ctx) <- checkStm (newBlock env) val stm
        return (sig,(tail ctx))
    SInit typ id exp -> do
        expTyp <- inferExp env exp
        if (typ == expTyp) then
            updateVar env id typ
        else
            fail $ "Type " ++ show typ ++ "does not match"
                ++ printTree exp
    SBlock stms -> do
        checkStms (newBlock env) val stms
        return env
        
    SReturn exp -> do
        typ <- inferExp env exp
        if typ /= val then
            fail $ "Type " ++ show typ ++ "does not match " ++
            "expected type" ++ show val
        else
            return env
    SIfElse exp stm1 stm2 -> do
         checkExp env Type_bool exp
         checkStm (newBlock env) val stm1
         checkStm (newBlock env) val stm2
         return env

checkStms :: Env -> Type -> [Stm] -> Err Env
checkStms env typ stms = foldM (\env stm -> checkStm env typ stm) env stms

typecheck :: Program -> Err Program
typecheck (PDefs defs) = do
    env <- foldM (\env (id, (typ)) -> updateFun env id typ) emptyEnv builtin
    env' <- foldM (\env' (DFun typ id args _) -> updateFun env'
                    id (handleArgs args, typ)) env defs
    main <- checkMain env'
         
    mapM_ (checkDef env') defs
    return (PDefs defs)


checkArgs :: Env -> [Arg] -> Err Env
checkArgs env args = foldM (\env' (ADecl typ id) -> updateVar env' id typ) env args

checkMain :: Env -> Err Bool
checkMain env = do
    (args, typ) <- lookupFun env (Id "main")
    when (typ==Type_void) $
        fail "main function can't have void as return"
    case args of
        []-> return True
        _ -> fail "main function has arguments"


checkDef :: Env -> Def -> Err ()
checkDef env (DFun typ id args stms) = do
  env' <- checkArgs (newBlock env) args
  checkStms env' typ stms
  return ()

checkDefs :: Env -> [Def] -> Err ()
checkDefs env = foldM (\_ def -> checkDef env def) ()


builtin :: [(Id, ([Type],Type))]
builtin =
    [ (Id "readInt"    , ([], Type_int))
    , (Id "readDouble" , ([], Type_double))
    , (Id "printInt"   , ([Type_int], Type_void ))
    , (Id "printDouble", ([Type_double], Type_void))
    ]
handleArgs :: [Arg] -> [Type]
handleArgs xs = do
    tList <- map (\(ADecl typ id) -> typ) xs
    return tList
