module SkelCpp where

-- Haskell module generated by the BNF converter

import AbsCpp
import ErrM
type Result = Err String

failure :: Show a => a -> Result
failure x = Bad $ "Undefined case: " ++ show x

transId :: Id -> Result
transId x = case x of
  Id string -> failure x
transProgram :: Program -> Result
transProgram x = case x of
  PDefs defs -> failure x
transDef :: Def -> Result
transDef x = case x of
  DFun type_ id args stms -> failure x
transArg :: Arg -> Result
transArg x = case x of
  ADecl type_ id -> failure x
transStm :: Stm -> Result
transStm x = case x of
  SExp exp -> failure x
  SDecl type_ id -> failure x
  SDecls type_ id ids -> failure x
  SInit type_ id exp -> failure x
  SReturn exp -> failure x
  SWhile exp stm -> failure x
  SBlock stms -> failure x
  SIfElse exp stm1 stm2 -> failure x
transExp :: Exp -> Result
transExp x = case x of
  EInt integer -> failure x
  EDouble double -> failure x
  ETrue -> failure x
  EFalse -> failure x
  EIndex exp1 exp2 -> failure x
  EFuncall exp exps -> failure x
  EProject exp1 exp2 -> failure x
  EStruc exp1 exp2 -> failure x
  EPIncr exp -> failure x
  EPDecr exp -> failure x
  EIncr exp -> failure x
  EDecr exp -> failure x
  EDefren exp -> failure x
  ENegat exp -> failure x
  ETimes exp1 exp2 -> failure x
  EDiv exp1 exp2 -> failure x
  EDRemd exp1 exp2 -> failure x
  EPlus exp1 exp2 -> failure x
  EMinus exp1 exp2 -> failure x
  EShiftLeft exp1 exp2 -> failure x
  EShiftRight exp1 exp2 -> failure x
  ELt exp1 exp2 -> failure x
  EGt exp1 exp2 -> failure x
  ELtEq exp1 exp2 -> failure x
  EGtWq exp1 exp2 -> failure x
  EEq exp1 exp2 -> failure x
  ENEq exp1 exp2 -> failure x
  EAnd exp1 exp2 -> failure x
  EOr exp1 exp2 -> failure x
  EAss exp1 exp2 -> failure x
  EAssP exp1 exp2 -> failure x
  EAssM exp1 exp2 -> failure x
  ECond exp1 exp2 exp3 -> failure x
  EThrow exp -> failure x
transType :: Type -> Result
transType x = case x of
  Tbool -> failure x
  Tdouble -> failure x
  Tint -> failure x
  Tvoid -> failure x
