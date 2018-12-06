-- | Function names bundled with their type
data Fun = Fun { id :: Id, funType :: FunType }

-- | JVM instructions, a bit abstractly.

data Code
  = Store  { type  :: Type, addr :: Integer }     -- ^ Store stack content of type @Type@ in local variable @Integer@.
  | Load   { type  :: Type, addr :: Integer }     -- ^ Push stack content of type @Type@ from local variable @Integer@
  | IConst { immed :: Integer }                   -- ^ Put integer constant on the stack.
  | DConst { immed :: Double  }                   -- ^ Put floating point constant on the stack.
  | Dup    { type  :: Type }                      -- ^ Duplicate top of stack.
  | Pop    { type  :: Type }                      -- ^ Pop something of type @Type@ from the stack.
  | Return { type  :: Type }                      -- ^ Return from method of type @Type@.
  | Call   { fun   :: Fun  }                      -- ^ Call function.

  | Label  { label :: Label }                     -- ^ Define label.
  | Goto   { label :: Label }                     -- ^ Jump to label.
  | IfZ    { label :: Label }                     -- ^ If top of stack is 0, jump to label.
  | IfNZ   { label :: Label }                     -- ^ If top of stack is not 0, jump to label.

  | IfEq   { type  :: Type, label :: Label }      -- ^ If prev == top, jump.
  | IfNe   { type  :: Type, label :: Label }      -- ^ If prev != top, jump.
  | IfLt   { type  :: Type, label :: Label }      -- ^ If prev <  top, jump.
  | IfGt   { type  :: Type, label :: Label }      -- ^ If prev >  top, jump.
  | IfLe   { type  :: Type, label :: Label }      -- ^ If prev <= top, jump.
  | IfGe   { type  :: Type, label :: Label }      -- ^ If prev >= top, jump.

  | DCmp                                          -- ^ If prev > top, then 1, if prev == top, 0, if prev < top, -1.

  | Inc    { type  :: Type
           , addr :: Integer, delta :: Integer  } -- ^ In/decrease variable by small number
  | Add    { type  :: Type }                      -- ^ Add 2 top values of stack.
  | Sub    { type  :: Type }                      -- ^ Subtract top of stack from previous of stack.
  | Mul    { type  :: Type }                      -- ^ Multiply 2 top values of stack.
  | Div    { type  :: Type }                      -- ^ Divide previous of stack by top of stack.
