{-# OPTIONS_GHC -Wunused-top-binds #-}

{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE LambdaCase #-}

module Compiler where

import Control.Monad
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.RWS

import Data.Maybe
import Data.Map (Map)
import Data.List
import qualified Data.Map as Map

import CPP.Abs
import CPP.Print (printTree)




data St = St
  { context       :: Context   -- ^ Context.
  , limitLocals   :: Int   -- ^ Maximal size for locals encountered.
  , currentStack  :: Int   -- ^ Current stack size.
  , limitStack    :: Int   -- ^ Maximal stack size encountered.
  , nextLabel     :: Label -- ^ Next jump label (persistent part of state)
  }

type Sig = Map Id Fun

-- | Function names bundled with their type
data Fun = Fun { funId :: Id, funFunType :: FunType }
    deriving (Show)
data FunType = FunType { funRet :: Type, funPars :: [Type] }
    deriving (Show)

type Context = [Block]
type Block = [(Id, (Type, Addr))]

newtype Label = L { theLabel :: Int }
  deriving (Eq, Enum, Show)

initSt :: St
initSt = St
  { context = [[]]
  , limitLocals   = 0
  , currentStack  = 0
  , limitStack    = 0
  , nextLabel     = L 0
  }

type Output = [String]

type Compile = RWS Sig Output St

-- | Builtin-functions
builtin :: [(Id, Fun)]
builtin =
  [ (Id "printInt"   , Fun (Id "Runtime/printInt"   ) $ FunType Type_void [Type_int])
  , (Id "readInt"   , Fun (Id "Runtime/readInt"   ) $ FunType Type_void [])
  ]

-- | Entry point.

compile
  :: String  -- ^ Class name.
  -> Program -- ^ Type-annotated program.
  -> String  -- ^ Generated jasmin source file content.
compile name prg@(PDefs defs) = unlines w
  where
  sigEntry def@(DFun _ f@(Id x) _ _ ) = (f, Fun (Id $ name ++ "/" ++ x) $ funType def)
  sig = Map.fromList $ builtin ++ map sigEntry defs
  w   = snd $ evalRWS (compileProgram name prg) sig initSt

compileProgram :: String -> Program -> Compile ()
compileProgram name (PDefs defs) = do
  tell header
  mapM_ compileFun defs
  where
  header =
    [ ";; BEGIN HEADER"
    , ""
    , ".class public " ++ name
    , ".super java/lang/Object"
    , ""
    , ".method public <init>()V"
    , "  .limit locals 1"
    , ""
    , "  aload_0"
    , "  invokespecial java/lang/Object/<init>()V"
    , "  return"
    , ""
    , ".end method"
    , ""
    , ".method public static main([Ljava/lang/String;)V"
    , "  .limit locals 1"
    , "  .limit stack  1"
    , ""
    , "  invokestatic " ++ name ++ "/main()I"
    , "  pop"
    , "  return"
    , ""
    , ".end method"
    , ""
    , ";; END HEADER"
    ]



compileFun :: Def -> Compile ()
compileFun def@(DFun t f args ss) = do
  -- function header
    tell [ "", ".method public static " ++ toJVM (Fun f $ funType def) ]

    -- prepare environment
    lab <- gets nextLabel
    put initSt{ nextLabel = lab }
    mapM_ (\ (ADecl t' x) -> newVar x t') args

    -- compile statements
    w <- grabOutput $ do
        mapM_ compileStm ss

    -- output limits
    ll <- gets limitLocals
    ls <- gets limitStack
    tell [ "  .limit locals " ++ show ll
        , "  .limit stack  " ++ show ls
        , ""
        ]

    -- output code, indented by 2
    tell $ map (\ s -> if null s then s else "  " ++ s) w

    if ((\(FunType typ typs) -> typ) (funType def)) == Type_void
        then
            tell ["  return"]
    else
        tell[""] 

    -- function footer
    tell [ "", ".end method"]


compileStm :: Stm -> Compile ()
compileStm s = do

  -- Printing a comment
    let top = stmTop s
    unless (null top) $ do
        tell [""]
        tell $ map (";; " ++) $ lines top
        case s of
            SDecls{} -> return()
            _ -> tell [""]

    -- message for NYI
    let nyi = error $ "TODO: " ++ top

    case s of

        SInit t x e -> do
            compileExp e
            newVar x t
            ctx <- gets context
            let a = lookupVar x ctx
            emit $ IStore a 

        SExp e -> do
            compileExp e 
            emit $ IPop e 

        SDecls typ x ->     
            helper typ x

        SReturn e -> do
            compileExp e
            emit $ IReturn

        SBlock ss -> do
            inNewBlock $ mapM_ compileStm ss
            popBlock

        SWhile e s1 -> do
            start <- newLabel
            done  <- newLabel
            emit $ Label start
            compileExp e
            emit $ IIfZ done
            inNewBlock $ compileStm s1
            emit $ Goto start
            emit $ Label done
            emit $ INop
            popBlock

        SIfElse e s1 s2 -> do
            false  <- newLabel
            done <- newLabel
            compileExp e
            emit $ IIfZ false
            inNewBlock $ compileStm s1
            popBlock
            emit $ Goto done
            emit $ Label false
            inNewBlock $ compileStm s2
            popBlock
            emit $ Label done
            emit $ INop

    where
        helper :: Type -> [Id] -> Compile ()
        helper _ [] = return ()
        helper t (id:ids) = do
            newVar id t
            helper t ids



compileExp :: Exp -> Compile ()
compileExp e = do
    -- message for NYI
    let nyi = error $ "TODO: " ++ show e
    case e of
        EInt i -> do
            emit $ IConst i

        ETrue -> do
            emit $ IConst 1


        EFalse -> do
            emit $ IConst 0


        EId x -> do
            ctx <- gets context
            let a = lookupVar x ctx
            emit $ ILoad a

        EApp f es -> do
            mapM_ compileExp es
            sig <- ask
            let fun = fromMaybe (error "unbound function") $  Map.lookup f sig
            emit $ Call fun

        EPlus e1 e2 -> do
            compileExp e1
            compileExp e2
            emit $ IAdd

        ELt e1 e2 -> do
            compileExp e1
            compileExp e2
            yes  <- newLabel
            done <- newLabel
            emit $ IIfLt yes
            emit $ IConst 0
            emit $ Goto done
            emit $ Label yes
            emit $ IConst 1
            emit $ Label done

        EGt e1 e2 -> do
            compileExp e1
            compileExp e2
            yes  <- newLabel
            done <- newLabel
            emit $ IIfGt yes
            emit $ IConst 0
            emit $ Goto done 
            emit $ Label yes
            emit $ IConst 1
            emit $ Label done

        EGtEq e1 e2 -> do
            compileExp e1
            compileExp e2
            yes  <- newLabel
            done <- newLabel
            emit $ IIfGe yes
            emit $ IConst 0
            emit $ Goto done
            emit $ Label yes
            emit $ IConst 1
            emit $ Label done


        EEq e1 e2 -> do
            compileExp e1
            compileExp e2
            yes  <- newLabel
            done <- newLabel
            emit $ IIEEq yes
            emit $ IConst 0
            emit $ Goto done
            emit $ Label yes
            emit $ IConst 1
            emit $ Label done

        ENEq e1 e2 -> do
            compileExp e1
            compileExp e2
            yes  <- newLabel
            done <- newLabel
            emit $ IINEq yes
            emit $ IConst 0
            emit $ Goto done
            emit $ Label yes
            emit $ IConst 1
            emit $ Label done

        ELtEq e1 e2 -> do
            compileExp e1
            compileExp e2
            yes  <- newLabel
            done <- newLabel
            emit $ IEltEq yes
            emit $ IConst 0
            emit $ Goto done
            emit $ Label yes
            emit $ IConst 1
            emit $ Label done

        EOr e1 e2 -> do
            done <- newLabel
            true <- newLabel
            compileExp e1
            emit $ IConst 1
            emit $ IIEEq true
            compileExp e2
            emit $ IConst 1
            emit $ IIEEq true
            emit $ IConst 0
            emit $ Goto done
            emit $ Label true
            emit $ IConst 1
            emit $ Label done


        EAnd e1 e2 -> do
            done <- newLabel
            false <- newLabel
            compileExp e1
            emit $ IConst 0
            emit $ IIEEq false
            compileExp e2
            emit $ IConst 0
            emit $ IIEEq false
            emit $ IConst 1
            emit $ Goto done
            emit $ Label false
            emit $ IConst 0
            emit $ Label done


        EAss x e1 -> do
            ctx <- gets context
            let a = lookupVar x ctx 
            compileExp e1
            emit $ IStore a
            emit $ ILoad a

        EPreIncr id -> do
            ctx <- gets context
            let a = lookupVar id ctx
            emit $ ILoad a
            emit $ IConst 1
            emit $ IAdd
            emit $ IStore a
            emit $ ILoad a

        EPostIncr id -> do
            ctx <- gets context
            let a = lookupVar id ctx
            emit $ ILoad a
            emit $ IDup
            emit $ IConst 1
            emit $ IAdd
            emit $ IStore a

        EPreDecr id -> do
            ctx <- gets context
            let a = lookupVar id ctx
            emit $ ILoad a
            emit $ IConst 1
            emit $ ISub
            emit $ IStore a
            emit $ ILoad a


        EPostDecr id -> do
            ctx <- gets context
            let a = lookupVar id ctx
            emit $ ILoad a
            emit $ IDup
            emit $ IConst 1
            emit $ ISub
            emit $ IStore a

        ETimes e1 e2 -> do
            compileExp e1
            compileExp e2
            emit $ IMul

        EDiv e1 e2 -> do
            compileExp e1
            compileExp e2
            emit $ IDiv

        EMinus e1 e2 -> do
            compileExp e1
            compileExp e2
            emit $ ISub




--TODO
inNewBlock :: Compile () -> Compile ()
inNewBlock x = do
    newBlock
    x


newBlock :: Compile ()
newBlock = do
    ctx <- gets context
    let ctx' = []:ctx
    modify $ \ st -> st { context=ctx'}


popBlock :: Compile ()
popBlock = do
    ctx <- gets context
    let ctx' = tail ctx
    modify $ \ st -> st { context=ctx'}




lookupVar :: Id -> Context -> Addr
lookupVar id' [] = error $ "variable " ++ printTree id' ++ " is not declared"
lookupVar id' ctx = do
    snd $ helperVar id' ctx
    where
        helperVar :: Id -> Context -> (Type, Addr)
        helperVar id' [] = error $ "variable " ++ printTree id' ++ " is not declared"
        helperVar id' (c:cs) = do 
            case lookup id' c of
                Nothing -> helperVar id' cs
                Just x -> x


newVar :: Id -> Type -> Compile ()
newVar i t = do
    let nyi = error $ "TODO: newVar" ++ show i
    a <- gets limitLocals
    ctx <- gets context
    let ctx' = (\(c:cs) x -> ((c ++ x):cs)) ctx [(i,(t,a))]
    modify $ \ st -> st { context=ctx'}
    modify $ \ st -> st { limitLocals = succ a }

    
-- * Instructions and emitting
toJVM :: Fun -> String
toJVM (Fun (Id fid) (FunType typ typs)) = do
    let tokenList = ""
    let fStr = fid ++ "(" ++ transList typs tokenList ++ ")"
    case typ of
        Type_void -> fStr ++ "V"
        Type_int  -> fStr ++ "I"
        Type_bool -> fStr ++ "B"

    


type Addr = Int

data Code
  = IStore Addr  -- ^ Store stack content of type @Type@ in local variable @Addr@.
  | ILoad  Addr  -- ^ Push stack content of type @Type@ from local variable @Addr@.

  | IConst Integer   -- ^ Put integer constant on the stack.
  | IPop Exp        -- ^ Pop something of type @Type@ from the stack.
  | INop
  | IReturn      -- ^ Return from method of type @Type@.
  | Return
  | IAdd         -- ^ Add 2 top values of stack.
  | IMul
  | IDiv
  | ISub
  | IDup

  | Call Fun         -- ^ Call function.

  | Label Label      -- ^ Define label.
  | Goto Label       -- ^ Jump to label.
  | IIfZ Label        -- ^ If top of stack is 0, jump to label.
  | IIfLt Label  -- ^ If prev <  top, jump.
  | IIEEq Label
  | IIfGt Label
  | IEltEq Label
  | IINEq Label
  | IIfGe Label
  deriving (Show)



-- | Print a single instruction.  Also update stack limits
emit :: Code -> Compile ()
emit x = do 
    -- message for NYI
    let nyi = error $ "TODO: " ++ show x
    case x of
        IConst i -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = succ li }
            if ((i>(-128)) && (i<128))
                then
                    if i==(-1)
                        then
                            tell ["iconst_" ++ (show i)]
                    else if (i>=0 && i<5)
                        then
                            tell ["iconst_" ++ (show i)]
                    else 
                        tell ["bipush " ++ (show i)]
            else
                tell["ldc " ++ (show i)]


        IPop e -> do
            case e of
                EApp f _ -> do
                    sig <- ask
                    let fun = fromMaybe (error "unbound function") $  Map.lookup f sig
                    if ((\(Fun (Id _) (FunType funRet funPars)) -> funRet) fun) == Type_void
                        then 
                            tell ["nop"]
                    else do
                        tell ["pop"]
                        li <- gets currentStack
                        modify $ \ st -> st { currentStack = pred li }
                _ -> do 
                    tell ["pop"]
                    li <- gets currentStack
                    modify $ \ st -> st { currentStack = pred li }



        INop -> do
            tell ["nop"]
        Call (Fun fid ftype) -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = succ li }
            let tokenList = ""
            let postArg = ("invokestatic " ++ (\(Id i) -> i)fid ++"(" ++ 
                           (transList ((\(FunType funRet funPars) -> funPars) ftype)
                            tokenList) ++")")
            case fid of
                Id "Runtime/printInt" -> do 
                    tell ["invokestatic Runtime/printInt(I)V"]
                Id "Runtime/readInt"  -> tell ["invokestatic Runtime/readInt()I"]
                _ -> case ((\(FunType funRet funPars) -> funRet) ftype) of
                    Type_int -> do
                        tell [postArg ++ "I"]
                    Type_bool -> do
                        tell [postArg ++ "B"]
                    Type_void -> do
                        tell [postArg ++ "V"]
        IReturn -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = pred li }
            tell ["ireturn"]

        IStore n -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = pred li }
            if ((n>=0) && (n<=3))
                then
                    tell ["istore_" ++ (show n)]
            else
                tell ["istore " ++ (show n)]

        Label (L l) -> do
            tell ["L" ++ show l ++ ":"]

        Goto (L l) -> do
            tell ["goto L" ++ show l]

        IAdd -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = pred li }
            tell ["iadd"]

        ISub -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = pred li }
            tell ["isub"]

        IMul -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = pred li }
            tell ["imul"]

        IDiv -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = pred li }
            tell ["idiv"]

        IDup -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = succ li }
            tell ["dup"]

        IIfZ (L l) -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = li - 1 }
            tell ["ifeq " ++ "L" ++ (show l)]

        IIfLt (L l) -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = li - 2 }
            tell ["if_icmplt " ++ "L" ++ (show l)]

        IIEEq (L l) -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = li - 2 }
            tell ["if_icmpeq " ++ "L" ++ (show l)]

        IINEq (L l) -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = li - 2 }
            tell ["if_icmpne " ++ "L" ++ (show l)]

        IEltEq (L l) -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = li - 2 }
            tell ["if_icmple " ++ "L" ++ (show l)]

        IIfGt (L l) -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = li - 2 }
            tell ["if_icmpgt " ++ "L" ++ (show l)]

        IIfGe (L l) -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = li - 2 }
            tell ["if_icmpge " ++ "L" ++ (show l)]

        ILoad a -> do
            li <- gets currentStack
            modify $ \ st -> st { currentStack = succ li }
            if ((a>=0) && (a<=3))
                then
                    tell ["iload_" ++ (show a)]
            else
                tell ["iload " ++ (show a)]

    limSt <- gets limitStack
    curSt <- gets currentStack
    if (limSt < curSt)
        then
            modify $ \ st -> st { limitStack=curSt}
    else
        modify $ \ st -> st { limitStack=limSt}



transList :: [Type] -> String -> String
transList [] str = str
transList (t:ts) str = do
    let retStr = str
    case t of
        Type_void -> transList ts (retStr ++ "V")
        Type_int -> transList ts (retStr ++ "I")
        Type_bool -> transList ts (retStr ++ "Z")


-- * Labels

newLabel :: Compile Label
newLabel = do
  l <- gets nextLabel
  modify $ \ st -> st { nextLabel = succ l }
  return $ l

-- | Print top part of statement (for comments)

stmTop :: Stm -> String
stmTop s =
  case s of
    SWhile e _ -> "while (" ++ printTree e ++ ")"
    SIfElse e _ _  -> "if (" ++ printTree e ++ ")"
    SBlock _   -> ""
    _ -> printTree s


-- * Auxiliary functions

grabOutput :: Compile () -> Compile Output
grabOutput m = do
  r <- ask
  s  <- get
  let ((), s', w) = runRWS m r s
  put s'
  return w

-- * Auxiliary functions

funType :: Def -> FunType
funType (DFun t _ args _) = FunType t $ map (\ (ADecl t' _) -> t') args
