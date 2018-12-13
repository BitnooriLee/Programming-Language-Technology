import java.util.*;
import CPP.Absyn.*;

public class Compiler
{
  // The output of the compiler is a list of strings.
  LinkedList<String> output;

  // Signature mapping function names to their JVM name and type.
  Map<String,Fun> sig;  //Fun은 Code.java에 정의된 class

  // Context mapping variable identifiers to their type and address.
  List<Map<String,CxtEntry>> cxt; // CxtEntry는 타입, 어드레스 정보를 가지고 있고, cxt는 이 맵들의 리스트! String: variable identifiers, CxtEntry: their type and address 

  // Next free address for local variable;
  int nextLocal = 0; //address 는 스택의 어드레스??

  // Number of locals needed for current function
  int limitLocals = 0;

  // Maximum stack size needed for current function
  int limitStack = 0;

  // Current stack size
  int currentStack = 0;

  // Global counter to get next label;
  int nextLabel = 0;

  // Variable information
  public class CxtEntry {
    final Type    type;
    final Integer addr;
    CxtEntry (Type t, Integer a) { type = t; addr = a; }
  }

  // Share type constants
  public final Type BOOL   = new Type_bool  ();
  public final Type INT    = new Type_int   ();
  public final Type DOUBLE = new Type_double();
  public final Type VOID   = new Type_void  ();

  // Compile C-- AST to a .j source file (returned as String).
  // name should be just the class name without file extension.
  public String compile(String name, CPP.Absyn.Program p) {
    // Initialize output
    output = new LinkedList();

    // Output boilerplate
    output.add(".class public " + name + "\n");
    output.add(".super java/lang/Object\n");
    output.add("\n");
    output.add(".method public <init>()V\n");
    output.add("  .limit locals 1\n");
    output.add("\n");
    output.add("  aload_0\n");
    output.add("  invokespecial java/lang/Object/<init>()V\n");
    output.add("  return\n");
    output.add("\n");
    output.add(".end method\n");
    output.add("\n");
    output.add(".method public static main([Ljava/lang/String;)V\n");
    output.add("  .limit locals 1\n");
    output.add("  .limit stack  1\n");
    output.add("\n");
    output.add("  invokestatic " + name + "/main()I\n");
    output.add("  pop\n");
    output.add("  return\n");
    output.add("\n");
    output.add(".end method\n");
    output.add("\n");

    // Create signature
    sig = new TreeMap();

    // Built-in functions
    ListArg intArg = new ListArg();
    intArg.add (new ADecl(INT , "x"));
    sig.put("printInt",    new Fun ("Runtime/printInt"   , new FunType (VOID  , intArg)));

    // User-defined functions
    for (Def d: ((PDefs)p).listdef_) {
      DFun def = (DFun)d;
      sig.put(def.id_,
        new Fun(name + "/" + def.id_, new FunType(def.type_, def.listarg_)));
    }

    // Run compiler
    p.accept(new ProgramVisitor(), null);

    // Concatenate strings in output to .j file content.
    StringBuilder jtext = new StringBuilder();
    for (String s: output) {
      jtext.append(s);
    }
    return jtext.toString();
  }

  // Compile program

  public class ProgramVisitor implements Program.Visitor<Void,Void>
  {
    public Void visit(CPP.Absyn.PDefs p, Void arg)
    {
      for (Def def: p.listdef_)
        def.accept(new DefVisitor(), null);
      return null;
    }
  }

  // Compile function definition.

  public class DefVisitor implements Def.Visitor<Void,Void>
  {
    public Void visit(CPP.Absyn.DFun p, Void arg)
    {
      // reset state for new function
      cxt = new LinkedList();
      cxt.add(new TreeMap());
      nextLocal    = 0;
      limitLocals  = 0;
      limitStack   = 0;
      currentStack = 0;

      // save output so far and reset output;
      LinkedList<String> savedOutput = output;
      output = new LinkedList();

      // Compile function

      // Add function parameters to context
      for (Arg x: p.listarg_)
        x.accept (new ArgVisitor(), null);
      for (Stm s: p.liststm_)
        s.accept (new StmVisitor(), null);

      // add new Output to old output
      LinkedList<String> newOutput = output;
      output = savedOutput;

      Fun f = new Fun(p.id_, new FunType(p.type_, p.listarg_));
      output.add("\n.method public static " + f.toJVM() + "\n");
      output.add("  .limit locals " + limitLocals + "\n");
      output.add("  .limit stack " + limitStack + "\n\n");
      for (String s: newOutput) {
        output.add("  " + s);
      }
      output.add("\n.end method\n");
      return null;
    }
  }

  // "Compiling" a function argument means adding it to the context.

  public class ArgVisitor implements Arg.Visitor<Void,Void>
  {
    public Void visit(CPP.Absyn.ADecl p, Void arg)
    {
      newVar (p.id_, p.type_); //update
      return null;
    }
  }

  // Compile single statement. TODO: Void인 경우를 생각할 필요가 없나??

  public class StmVisitor implements Stm.Visitor<Void,Void>
  {
    // e;
    public Void visit(CPP.Absyn.SExp p, Void arg)
    {
      emit (new Comment(CPP.PrettyPrinter.print(p)));
      p.exp_.accept (new ExpVisitor(), arg);
      emit (new Pop(new Type_int()));
      //emit (new Pop(p.exp_.getType()));
      return null;
    }

    // int x,y,z;
    public Void visit(CPP.Absyn.SDecls p, Void arg)
    {
      emit (new Comment(CPP.PrettyPrinter.print(p)));
      // for (String x: p.listid_) p.type_
      throw new RuntimeException ("TODO: compile " + CPP.PrettyPrinter.print(p));
    }

    // int x = e;
    public Void visit(CPP.Absyn.SInit p, Void arg)
    {
      // p.type_ p.id_ p.exp_
      emit (new Comment(CPP.PrettyPrinter.print(p)));
      p.exp_.accept (new ExpVisitor(), arg);
      int addr = newVar (p.id_, p.type_);
      emit (new Store (p.type_, addr));
      return null;
    }

    // return e; //Q1 Type_void()인 경우를 어떻게 처리??? TODO: 
    public Void visit(CPP.Absyn.SReturn p, Void arg)
    {
      // p.exp_getType()
      emit (new Comment(CPP.PrettyPrinter.print(p)));
      p.exp_.accept (new ExpVisitor(), arg);
      emit (new Return(new Type_int()));
      //System.out.println(p.exp_.getType());
      return null;
    }

    // while (e) s
    public Void visit(CPP.Absyn.SWhile p, Void arg)
    {
      // p.exp_ p.stm_
      emit (new Comment("test while-condition (" + CPP.PrettyPrinter.print(p.exp_) + ")\n"));
      Label start = new Label (nextLabel++);
      Label done  = new Label (nextLabel++);
      emit (new Target(start));
      p.exp_.accept (new ExpVisitor(), arg);
      emit (new IfZ(done));
      emit (new Comment("while (" + CPP.PrettyPrinter.print(p.exp_) + ") do:\n"));
      newBlock();
      p.stm_.accept (this, arg);
      popBlock();
      emit (new Goto(start));
      emit (new Target(done));
      return null;
    }

    // { ss }
    public Void visit(CPP.Absyn.SBlock p, Void arg)
    {
      newBlock();
      for (Stm s: p.liststm_) s.accept(this, arg);
      popBlock();
      return null;
    }

    // if (e) s else s'
    public Void visit(CPP.Absyn.SIfElse p, Void arg)
    {
      // p.exp_ p.stm_1 p.stm_2
      emit (new Comment("test if-condition (" + CPP.PrettyPrinter.print(p.exp_) + ")\n"));
      Label ifTrue = new Label (nextLabel++);
      Label ifFalse  = new Label (nextLabel++);
      p.exp_.accept (new ExpVisitor(), arg);
      emit (new IfZ(ifFalse));
      emit (new Comment("when (" + CPP.PrettyPrinter.print(p.exp_) + ") do: \n"));
      newBlock();
      p.stm_1.accept (this, arg);
      popBlock();
      emit (new Goto(ifTrue));
      emit (new Target(ifFalse));
      emit (new Comment("unless (" + CPP.PrettyPrinter.print(p.exp_) + ") do: \n"));
      newBlock();
      p.stm_2.accept (this, arg);
      popBlock();
      emit (new Target(ifTrue));
      return null;
    }
  }

  public class ExpVisitor implements Exp.Visitor<Void,Void>
  {
    // true
    public Void visit(CPP.Absyn.ETrue p, Void arg)
    {
      throw new RuntimeException ("TODO: compile " + CPP.PrettyPrinter.print(p));
    }

    // false
    public Void visit(CPP.Absyn.EFalse p, Void arg)
    {
      throw new RuntimeException ("TODO: compile " + CPP.PrettyPrinter.print(p));
    }

    // 5
    public Void visit(CPP.Absyn.EInt p, Void arg)
    {
      emit (new IConst (p.integer_)); //emit(Idc i)
      return null;
    }

    // 3.14
    public Void visit(CPP.Absyn.EDouble p, Void arg)
    {
      emit (new DConst (p.double_));
      return null;
    }

    // x
    public Void visit(CPP.Absyn.EId p, Void arg)
    {
      CxtEntry ce = lookupVar(p.id_);
      emit (new Load (ce.type, ce.addr));
      return null;
    }

    // f (e_1, ..., e_n)
    public Void visit(CPP.Absyn.EApp p, Void arg)
    {
      // p.id_
      for (Exp e: p.listexp_) e.accept (new ExpVisitor(), arg);
      Fun f = sig.get(p.id_);
      emit (new Call(f));
      return null;
    }

    // x++
    public Void visit(CPP.Absyn.EPostIncr p, Void arg)
    {
      // p.id_
      CxtEntry ce = lookupVar(p.id_);
      emit (new Incr (ce.type, ce.addr, 1));
      return null;
    }

    // x--
    public Void visit(CPP.Absyn.EPostDecr p, Void arg)
    {
      // p.id_
      CxtEntry ce = lookupVar(p.id_);
      emit (new Incr (ce.type, ce.addr, -1));
      return null;
    }
    
    //TODO
    // ++x
    public Void visit(CPP.Absyn.EPreIncr p, Void arg)
    {
      // p.id_
      CxtEntry ce = lookupVar(p.id_);
      emit (new Incr (ce.type, ce.addr, 1));
      return null;

      /*
      CxtEntry ce = lookupVar(p.id_);
      emit(new Load(ce.type, ce.addr));
      emit(new IConst(1));
      emit(new Add(p.getType()));
      emit(new Store(ce.type, ce.addr));
      emit(new Load(ce.type, ce.addr));
      */

    }

    // --x
    public Void visit(CPP.Absyn.EPreDecr p, Void arg)
    {
      // p.id_
      CxtEntry ce = lookupVar(p.id_);
      emit (new Incr (ce.type, ce.addr, -1));
      return null;
    }

    // e * e'
    public Void visit(CPP.Absyn.ETimes p, Void arg)
    {
      // p.exp_1 p.exp_2 p.getType()
      p.exp_1.accept (this, arg);
      p.exp_2.accept (this, arg);
      emit (new Mul(new Type_int()));
      return null;
    }

    // e / e'
    public Void visit(CPP.Absyn.EDiv p, Void arg)
    {
      // p.exp_1 p.exp_2 p.getType()
      p.exp_1.accept (this, arg);
      p.exp_2.accept (this, arg);
      emit (new Div(new Type_int()));
      return null;
    }

    //  e + e'
    public Void visit(CPP.Absyn.EPlus p, Void arg)
    {
      // p.exp_1 p.exp_2 p.getType()
      p.exp_1.accept (this, arg);
      p.exp_2.accept (this, arg);
      emit (new Add(new Type_int()));
      return null;
    }

    // e - e' (+)
    public Void visit(CPP.Absyn.EMinus p, Void arg)
    {
      // p.exp_1 p.exp_2 p.getType()
      p.exp_1.accept (this, arg);
      p.exp_2.accept (this, arg);
      emit (new Sub(new Type_int()));
      return null;
    }

    // e < e'
    public Void visit(CPP.Absyn.ELt p, Void arg)
    {
      // p.exp_1 p.exp_2
      p.exp_1.accept(new ExpVisitor(), arg);
      p.exp_2.accept(new ExpVisitor(), arg);
      Label yes  = new Label (nextLabel++);
      Label done = new Label (nextLabel++);
      emit (new IfLt(new Type_int(), yes));
      emit (new IConst(0)); //bipush 0?
      emit (new Goto(done));
      emit (new Target(yes));
      emit (new IConst(1)); //bipush 1?
      emit (new Target(done));
      return null;
    }

    // e > e' (+)
    public Void visit(CPP.Absyn.EGt p, Void arg)
    {
            // p.exp_1 p.exp_2
      p.exp_1.accept(new ExpVisitor(), arg);
      p.exp_2.accept(new ExpVisitor(), arg);
      Label yes  = new Label (nextLabel++);
      Label done = new Label (nextLabel++);
      emit (new IfGt(new Type_int(), yes));
      emit (new IConst(0));
      emit (new Goto(done));
      emit (new Target(yes));
      emit (new IConst(1));
      emit (new Target(done));
      return null;
    }

    // e <= e'
    public Void visit(CPP.Absyn.ELtEq p, Void arg)
    {
      p.exp_1.accept(new ExpVisitor(), arg);
      p.exp_2.accept(new ExpVisitor(), arg);
      Label yes  = new Label (nextLabel++);
      Label done = new Label (nextLabel++);
      emit (new IfLe(new Type_int(), yes));
      emit (new IConst(0));
      emit (new Goto(done));
      emit (new Target(yes));
      emit (new IConst(1));
      emit (new Target(done));
      return null;
    }

    // e >= e'
    public Void visit(CPP.Absyn.EGtEq p, Void arg)
    {
      p.exp_1.accept(new ExpVisitor(), arg);
      p.exp_2.accept(new ExpVisitor(), arg);
      Label yes  = new Label (nextLabel++);
      Label done = new Label (nextLabel++);
      emit (new IfGe(new Type_int(), yes));
      emit (new IConst(0));
      emit (new Goto(done));
      emit (new Target(yes));
      emit (new IConst(1));
      emit (new Target(done));
      return null;
    }

    // e == e'
    public Void visit(CPP.Absyn.EEq p, Void arg)
    {
      p.exp_1.accept(new ExpVisitor(), arg);
      p.exp_2.accept(new ExpVisitor(), arg);
      Label yes  = new Label (nextLabel++);
      Label done = new Label (nextLabel++);
      emit (new IfEq(new Type_int(), yes));
      emit (new IConst(0));
      emit (new Goto(done));
      emit (new Target(yes));
      emit (new IConst(1));
      emit (new Target(done));
      return null;
    }

    // e != e'
    public Void visit(CPP.Absyn.ENEq p, Void arg)
    {
      p.exp_1.accept(new ExpVisitor(), arg);
      p.exp_2.accept(new ExpVisitor(), arg);
      Label yes  = new Label (nextLabel++);
      Label done = new Label (nextLabel++);
      emit (new IfNe(new Type_int(), yes));
      emit (new IConst(0));
      emit (new Goto(done));
      emit (new Target(yes));
      emit (new IConst(1));
      emit (new Target(done));
      return null;
    }

    // e && e'
    public Void visit(CPP.Absyn.EAnd p, Void arg)
    {
      throw new RuntimeException ("TODO: compile " + CPP.PrettyPrinter.print(p));
    }

    // e || e'
    public Void visit(CPP.Absyn.EOr p, Void arg)
    {
      throw new RuntimeException ("TODO: compile " + CPP.PrettyPrinter.print(p));
    }

    // x = e
    public Void visit(CPP.Absyn.EAss p, Void arg)
    {
      // p.id_ ce.type ce.addr
      p.exp_.accept (this, arg);
      CxtEntry ce = lookupVar (p.id_);
      emit (new Store (ce.type, ce.addr));
      emit (new Load (ce.type, ce.addr));
      return null;
    }
    
  } // or Dup, Store

  void emit (Code c) {
		output.add(c.accept(new CodeToJVM()));
		updateStack(c);
	}

  Integer newVar(String x, Type t) {
		cxt.get(0).put(x, new CxtEntry(t,nextLocal));
		Integer size = t.accept(new Size(), null);
    Integer tmp = nextLocal;
		nextLocal = nextLocal + size;
		limitLocals = limitLocals + size;
    return tmp;
  }

  CxtEntry lookupVar(String x) {
    for (Map<String, CxtEntry> m: cxt) {
      CxtEntry v = m.get(x);
      if (v != null) return v;
    }
    return null;
  }


	// (copy) update limitStack, currentStack according to instruction
	void updateStack(Code c) {
		c.accept(new UpdateStack());
	}

	void incStack(Type t) {
		currentStack = currentStack + t.accept(new Size(), null);
		if (currentStack > limitStack) limitStack = currentStack;
	}

	void decStack(Type t) {
		currentStack = currentStack - t.accept(new Size(), null);
	}

  String newLabel(String prefix){
		return prefix + (nextLabel++);
	}

  void newBlock() {
    cxt.add(0, new TreeMap());
  }

  void popBlock() {
    cxt.remove(0);
  }
  
  //TODO
  class Size implements Type.Visitor<Integer,Void> {

    public Integer visit (Type_int t, Void arg) {
        return 1;
    }
    public Integer visit (Type_bool t, Void arg) {
        return 1;
    }
    public Integer visit (Type_void t, Void arg) {
        return 0;
    }
    public Integer visit (Type_double t, Void arg) {
          return 2;
    }
  }
  //TODO
	class UpdateStack implements CodeVisitor<Void> {
		public Void visit (Store c) {
			decStack(c.type);
			return null;
		}

		public Void visit (Load c) {
			incStack(c.type);
			return null;
		}

		public Void visit (Comment c) {
			return null;
		}

		public Void visit (IConst c) {
			incStack(new Type_int());
			return null;
		}

		public Void visit (DConst c) {
			incStack(new Type_double());
			return null;
		}

		public Void visit (Dup c) {
			incStack(c.type);
			return null;
		}

		public Void visit (Pop c) {
			decStack(c.type);
			return null;
		}

		public Void visit (Return c) {
			return null;
		}

		public Void visit (Call c) {
			incStack(c.fun.funType.returnType);
			return null;
		}

		public Void visit (Target c) {
			return null;
		}

		public Void visit (Goto c) {
			return null;
		}

		public Void visit (IfZ c) {
			decStack(INT);
			return null;
		}

		public Void visit (IfNZ c) {
			decStack(INT);
			return null;
		}

		public Void visit (IfEq c) {
			decStack(INT);
			decStack(INT);
			return null;
		}

		public Void visit (IfNe c) {
			decStack(INT);
			decStack(INT);
			return null;
		}

		public Void visit (IfLt c) {
			decStack(INT);
			decStack(INT);
			return null;
		}

		public Void visit (IfGt c) {
			decStack(INT);
			decStack(INT);
			return null;
		}

		public Void visit (IfLe c) {
			decStack(INT);
			decStack(INT);
			return null;
		}

		public Void visit (IfGe c) {
			decStack(INT);
			decStack(INT);
			return null;
		}

		public Void visit (Incr c) {
			return null;
		}

		public Void visit (Add c) {
			decStack(c.type);
			return null;
		}

		public Void visit (Sub c) {
			decStack(c.type);;
			return null;
		}

		public Void visit (Mul c) {
			decStack(c.type);
			return null;
		}

		public Void visit (Div c) {
			decStack(c.type);
			return null;
		}


	}

}

