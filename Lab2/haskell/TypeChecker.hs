{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE LambdaCase #-}

module TypeChecker where

import Control.Monad

import Data.Map (Map)
import qualified Data.Map as Map
import qualified Data.List as List


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

{-updateVar :: Env -> Id -> Type -> Err Env
updateVar (sig, scope:rest) x t = case Map.lookup x scope of
    Nothing -> updateVar (sig, rest) x t
    Just t1 -> do
        when (t1 /= t) $
            fail $ "Type of " ++ printTree x ++ " does not match given type"
        return (sig, (Map.insert x t scope):rest)
updateVar (_,[]) x _ = fail $ ("Variable " ++ printTree x
                             ++ " is not declared.") -}
                             
updateVar :: Env -> Id -> Type -> Err Env
updateVar (sig,cxt) id typ = do
  when (typ==Type_void) $ fail "type void is illegal for variable"
  case cxt of
    [] -> fail "type checker: no context"
    c:cs -> case Map.lookup id c of
      Just a -> fail $ "variable " ++ printTree id ++ " declared already"
      Nothing -> return (sig, Map.insert id typ c :cs)

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

updateDefs :: Program -> Err Sig
updateDefs (PDefs ds) = do
  -- add function definitions to 
  let fs = map getDefType ds ++ builtin
      s  = Map.fromList fs
  -- check for duplicate function id:s
  let names = map fst fs
      dup = names List.\\ List.nub names
  unless (null dup) $ fail $
    "the following functions are defined several times: " ++
    List.intercalate ", " (map printTree dup)
  return s
  where getDefType (DFun t id as _) = (id, (map getArgType as,t))
        getArgType (ADecl t id)     =  t
        
newBlock :: Env -> Env
--newBlock (sig, ctx) = (sig, [])
newBlock (sig,cs) = (sig,Map.fromList [] : cs)

emptyEnv :: Env
emptyEnv = (Map.empty, [])

{-inferExp :: Env -> Exp -> Err Type
inferExp env x = case x of
    ETrue   -> return Type_bool
    EInt _  -> return Type_int
    EDouble _ -> return Type_double
    EId id  -> lookupVar env id
    EPlus exp1 exp2 ->
        inferBin[Type_int, Type_double] env exp1 exp2
    EMinus exp1 exp2 ->
        inferBin[Type_int, Type_double] env exp1 exp2
    EDiv exp1 exp2 ->
        inferBin[Type_int, Type_double] env exp1 exp2
    ETimes exp1 exp2 ->
        inferBin[Type_int, Type_double] env exp1 exp2
    EApp id exps -> do 
        (args, typ) <- lookupFun env id
        exps'     <- mapM (inferExp env) exps
        if (args == exps')
            then return typ
        else fail $ "The arguments (" ++ printTree exps' 
            ++ ") don't match parameters (" ++ printTree args ++ ")"
    EPostIncr id -> do
        typ <- lookupVar env id
        inferUn [Type_int, Type_double] env typ
    EPreIncr id -> do
        typ <- lookupVar env id
        inferUn [Type_int, Type_double] env typ
    EPostDecr id -> do
        typ <- lookupVar env id
        inferUn [Type_int, Type_double] env typ
    EPreDecr id -> do
        typ <- lookupVar env id
        inferUn [Type_int, Type_double] env typ
    ELt exp1 exp2 ->
        inferBin [Type_int, Type_double] env exp1 exp2
    EGt exp1 exp2 ->
        inferBin [Type_int, Type_double] env exp1 exp2
    ELtEq exp1 exp2 ->
        inferBin [Type_int, Type_double] env exp1 exp2
    EGtEq exp1 exp2 ->
        inferBin [Type_int, Type_double] env exp1 exp2
    EEq exp1 exp2 ->
        inferBin [Type_int, Type_double, Type_bool] env exp1 exp2
    ENEq exp1 exp2 ->
        inferBin [Type_int, Type_double, Type_bool] env exp1 exp2
    EAnd exp1 exp2 ->
        inferBin [Type_bool] env exp1 exp2
    EOr exp1 exp2 ->
        inferBin [Type_bool] env exp1 exp2
    EAss id exp -> do
 {-       typ <- lookupVar env id
        inferAss [Type_double, Type_bool, Type_int] env typ exp-}
       typ <- lookupVar env id
       checkExp env typ exp
       return typ-}

inferExp :: Env -> Exp -> Err Type
inferExp env exp = case exp of
  ETrue     -> return Type_bool
  EFalse    -> return Type_bool
  EInt _    -> return Type_int
  EDouble _ -> return Type_double
  EId id    -> lookupVar env id
  EApp id es ->
    do (typs,typ) <- lookupFun env id
       args <- mapM (inferExp env) es
       unless (typs == args)
         $ fail $ "types of: " ++
           List.intercalate ", " (map printTree typs) ++
           "\nexpected for function " ++ printTree id ++ 
           "\nbut found: " ++ List.intercalate ", " (map printTree args)
       return typ
  EPostIncr id -> incdec id
  EPostDecr id -> incdec id
  EPreIncr id  -> incdec id
  EPreDecr id  -> incdec id
  ETimes e1 e2 -> inferBin [Type_int,Type_double] env e1 e2
  EDiv   e1 e2 -> inferBin [Type_int,Type_double] env e1 e2
  EPlus  e1 e2 -> inferBin [Type_int,Type_double] env e1 e2
  EMinus e1 e2 -> inferBin [Type_int,Type_double] env e1 e2
  ELt    e1 e2 -> inferBin [Type_int,Type_double,Type_bool] env e1 e2 >>
                           return Type_bool
  EGt    e1 e2 -> inferBin [Type_int,Type_double,Type_bool] env e1 e2 >>
                           return Type_bool
  ELtEq  e1 e2 -> inferBin [Type_int,Type_double,Type_bool] env e1 e2 >>
                           return Type_bool
  EGtEq  e1 e2 -> inferBin [Type_int,Type_double,Type_bool] env e1 e2 >>
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
  where incdec id =
          do typ <- lookupVar env id
             unless (typ == Type_int || typ == Type_double)
               $ fail $ "type of int or double expected but found " ++
                        printTree typ
             return typ


inferBin :: [Type] -> Env -> Exp -> Exp -> Err Type
{-inferBin types env exp1 exp2 = do
    typ <- inferExp env exp1
    if elem typ types
        then do
            checkExp env typ exp2
            return typ

    else
        fail $ "wrong type of expression " ++ printTree exp1-}

inferBin typs env exp1 exp2 = do
  typ <- inferExp env exp1
  unless (elem typ typs) $ fail $ "wrong type of expression " ++ printTree exp1
  checkExp env typ exp2
  return typ

inferAss :: [Type] -> Env -> Type -> Exp -> Err Type
inferAss types env typ exp = do
    if elem typ types
        then do
            checkExp env typ exp
            return typ

    else
        fail $ "wrong type of expression " ++ printTree exp

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
 {-   SDecls typ xs -> do
        case xs of
            x:xs  -> do 
                env' <- updateVar env x typ
                checkStm env' typ (SDecls typ xs)
            []    -> fail $ "No more variables" ++ show typ -}
    SDecls typ x ->     
        foldM (\env id -> updateVar env id typ) env x
            
    SWhile exp stm -> do
        checkExp env Type_bool exp
        checkStm env val stm
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
 {-       checkExp env Type_bool exp
        checkStm env val stm1
        checkStm env val stm2 -}
                 checkExp env Type_bool exp
                 checkStm (newBlock env) val stm1
                 checkStm (newBlock env) val stm2
                 return env

checkStms :: Env -> Type -> [Stm] -> Err Env
checkStms env typ = foldM (\env stm -> checkStm env typ stm) env 
{-checkStms env typ stms = case stms of
    stm:stms -> do env' <- checkStm env typ stm
                   checkStms env' typ stms
    []       -> return env]-}

typecheck :: Program -> Err ()
typecheck (PDefs defs) = do
    env <- foldM (\env (id, (typ)) -> updateFun env id typ) emptyEnv builtin
    env' <- foldM (\env' (DFun typ id args _) -> updateFun env'
                    id (handleArgs args, typ)) env defs
    mapM_ (checkDef env') defs


{-checkDef :: Env -> Def -> Err ()
checkDef env (DFun t _ args stms) = do
    mapM_ (\ (ADecl t x) -> updateVar env x t) args
    mapM_ (checkStm env t) stms-}

checkArgs :: Env -> [Arg] -> Err Env
checkArgs = foldM updateArgs
  where updateArgs env arg = updateVar env id typ
          where (ADecl typ id) = arg


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

nyi = error "NOT YET IMPLEMENTED"