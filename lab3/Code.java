// Code.java
// Originally created by github.com/andreasabel/java-adt

import CPP.Absyn.*;

class Fun {
    public String id;
    public FunType funType;
    public Fun (String id, FunType funType) {
        this.id = id;
        this.funType = funType;
    }
    public String toJVM() {
      return id + funType.toJVM();
    }
}

class Label {
    public int label;
    public Label (int label) {
        this.label = label;
    }
    public String toJVM() {
      return "L" + label;
    }
}

abstract class Code {
    public abstract <R> R accept (CodeVisitor<R> v);
}

class Comment extends Code {
  public String comment;
  public Comment (String c) { comment = c; }
  public <R> R accept (CodeVisitor<R> v) {
    return v.visit(this);
  }
}

class Store extends Code {
    public Type type;
    public Integer addr;
    public Store (Type type, Integer addr) {
        this.type = type;
        this.addr = addr;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class Load extends Code {
    public Type type;
    public Integer addr;
    public Load (Type type, Integer addr) {
        this.type = type;
        this.addr = addr;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class IConst extends Code {
    public Integer immed;
    public IConst (Integer immed) {
        this.immed = immed;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class DConst extends Code {
    public Integer immed;
    public DConst (Integer immed) {
        this.immed = immed;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class Dup extends Code {
    public Type type;
    public Dup (Type type) {
        this.type = type;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class Pop extends Code {
    public Type type;
    public Pop (Type type) {
        this.type = type;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class Return extends Code {
    public Type type;
    public Return (Type type) {
        this.type = type;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class Call extends Code {
    public Fun fun;
    public Call (Fun fun) {
        this.fun = fun;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class Target extends Code {
    public Label label;
    public Target (Label label) {
        this.label = label;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class Goto extends Code {
    public Label label;
    public Goto (Label label) {
        this.label = label;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class IfZ extends Code {
    public Label label;
    public IfZ (Label label) {
        this.label = label;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class IfNZ extends Code {
    public Label label;
    public IfNZ (Label label) {
        this.label = label;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class IfEq extends Code {
    public Type type;
    public Label label;
    public IfEq (Type type, Label label) {
        this.type = type;
        this.label = label;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class IfNe extends Code {
    public Type type;
    public Label label;
    public IfNe (Type type, Label label) {
        this.type = type;
        this.label = label;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class IfEq extends Code {
    public Type type;
    public Label label;
    public IfEq (Type type, Label label) {
        this.type = type;
        this.label = label;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class IfLt extends Code {
    public Type type;
    public Label label;
    public IfLt (Type type, Label label) {
        this.type = type;
        this.label = label;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class IfGe extends Code {
    public Type type;
    public Label label;
    public IfGe (Type type, Label label) {
        this.type = type;
        this.label = label;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class IfGt extends Code {
    public Type type;
    public Label label;
    public IfGt (Type type, Label label) {
        this.type = type;
        this.label = label;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class IfLe extends Code {
    public Type type;
    public Label label;
    public IfLe (Type type, Label label) {
        this.type = type;
        this.label = label;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class Incr extends Code {
    public Type type;
    public Incr (Type type, Integer addr, Integer increment) {
        this.type = type;
        this.addr = addr;
        this.increment = increment;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class Add extends Code {
    public Type type;
    public Add (Type type) {
        this.type = type;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class Sub extends Code {
    public Type type;
    public Sub (Type type) {
        this.type = type;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
    }
}

class Mul extends Code {
    public Type type;
    public Mul (Type type) {
        this.type = type;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
}

class Div extends Code {
    public Type type;
    public Div (Type type) {
        this.type = type;
    }
    public <R> R accept (CodeVisitor<R> v) {
        return v.visit (this);
}

interface CodeVisitor<R> {
  

    public R visit (IConst c);
    public R visit (DConst c);
    public R visit (Target c);
        //done
    public R visit (Comment c);
    public R visit (Store c);
    public R visit (Load c);
    public R visit (Dup c);
    public R visit (Pop c);
    public R visit (Call c);
    public R visit (Goto c);
    public R visit (Return c);
    public R visit (IfEq c);
    public R visit (IfNe c);
    public R visit (IfLt c);
    public R visit (IfGe c);
    public R visit (IfLt c);
    public R visit (IfGt c);
    public R visit (IfZ c);
    public R visit (IfNZ c);
    public R visit (Incr c);
    public R visit (Add c);
    public R visit (Sub c);
    public R visit (Mul c);
    public R visit (Div c);
}

class CodeToJVM implements CodeVisitor<String> {

  public String visit (Comment c) {
      return "\n  ;; " + c.comment;
    }

  public String visit (Store c) {
      if(c.type instanceof Type_int||c.type instanceof Type_void)
        return (c.addr >=0 && c.addr <=3)? "istore_"+ c.addr : "istore" + c.addr;
      else if (c.type instanceof Type_double)
		return (c.addr >=0 && c.addr <=3)? "dstore_"+ c.addr : "dstore" + c.addr;
      throw new RuntimeException("Wrong Type for store!");
	}

  public String visit (Load c) {
      if(c.type instanceof Type_int||c.type instanceof Type_void)
        return (c.addr >=0 && c.addr <=3)? "iload_"+ c.addr : "iload" + c.addr;
      else if (c.type instanceof Type_double)
		return (c.addr >=0 && c.addr <=3)? "dload_"+ c.addr : "dload" + c.addr;
      throw new RuntimeException("Wrong Type for load!");
	}

  public String visit (Dup c) {
      if(c.type instanceof Type_int||c.type instanceof Type_void)
        return "dup";
      else if (c.type instanceof Type_double)
		return "dup2";
      return ""; // "nop"?????
	} 

  public String visit (Pop c) {
      if(c.type instanceof Type_int||c.type instanceof Type_void)
        return "pop";
      else if (c.type instanceof Type_double)
		return "pop2";
      return ""; // "nop"?????
	}    

  public String visit (Goto c) {
      return "invokestatic" + c.fun.toJVM();
	} 

  public String visit (Goto c) {
      return "goto" + c.label.label;
	} 

  public String visit (Return c) {
      if(c.type instanceof Type_int)
        return "ireturn";
      else if (c.type instanceof Type_double)
		return "dreturn";
      else if (c.type instanceof Type_void)
		return "return"; 
      throw new RuntimeException("Wrong Type for return!");
	}

  public String visit (IfEq c) {
      if(c.type instanceof Type_int)
        return "if_icmpeq " + c.label.label;
      else
		throw new RuntimeException("type must be int!");
	}
  
  public String visit (IfNe c) {
      if(c.type instanceof Type_int)
        return "if_icmpne " + c.label.label;
      else
		throw new RuntimeException("type must be int!");
	}

  public String visit (IfLt c) {
      if(c.type instanceof Type_int)
        return "if_icmplt " + c.label.label;
      else
		throw new RuntimeException("type must be int!");
	}

  public String visit (IfGe c) {
      if(c.type instanceof Type_int)
        return "if_icmpge " + c.label.label;
      else
		throw new RuntimeException("type must be int!");
	}

  public String visit (IfGt c) {
      if(c.type instanceof Type_int)
        return "if_icmpgt " + c.label.label;
      else
		throw new RuntimeException("type must be int!");
	}

  public String visit (IfLe c) {
      if(c.type instanceof Type_int)
        return "if_icmple " + c.label.label;
      else
		throw new RuntimeException("type must be int!");
	}

  public String visit (IfZ c) {
      return "ifeq" + c.label.label;
	} // ?

  public String visit (IfNZ c) {
      return "ifne" + c.label.label;
	} // ?

  public String visit (Incr c) {
      if(c.type instanceof Type_int)
		return "iinc " + c.addr + " " +c.increment;
      throw new RuntimeException("Internal error: type must be int to incr");
	}
  public String visit (Add c) {
      if(c.type instanceof Type_int)
        return "iadd";
      else if (c.type instanceof Type_double)
		return "dadd";
      throw new RuntimeException("Internal error: type must be numeric to add");
	}

  public String visit (Sub c) {
      if(c.type instanceof Type_int)
		return "isub";
      else if (c.type instanceof Type_double)
		return "dsub";
      throw new RuntimeException("Internal error: type must be numeric to sub");
	}

  public String visit (Mul c) {
      if(c.type instanceof Type_int)
		return "imul";
      else if (c.type instanceof Type_double)
		return "dmul";
      throw new RuntimeException("Internal error: type must be numeric to mul");
	}

  public String visit (Div c) {
	  if(c.type instanceof Type_int)
        return "idiv";
	  else if (c.type instanceof Type_double)
		return "ddiv";
      throw new RuntimeException("Internal error: type must be numeric to div");
	}

  // TODO should return Jasmin Instructions for each class

}
