import java.util.*;
import Fun.Absyn.*;

public class Interpreter {

  // Signature
  final Map<String,Exp> sig  = new TreeMap();

  // Strategy
  final boolean strategy;

  // Control debug printing.
  final boolean debug = false;

  public Interpreter (boolean strategy) {
    this.strategy = strategy;
  }

  public void interpret(Program p) {
    System.out.println(p.accept(new ProgramVisitor(), null).intValue());
  }

  public class ProgramVisitor implements Program.Visitor<Value,Void>
  {
    public Value visit(Fun.Absyn.Prog p, Void arg)
    {
      // build signature
      for (Def d: p.listdef_) d.accept(new DefVisitor(), null);
      // execute main expression
      return p.main_.accept(new MainVisitor(), null);
    }
  }

  public class MainVisitor implements Main.Visitor<Value,Void>
  {
    public Value visit(Fun.Absyn.DMain p, Void arg)
    {
      return p.exp_.accept(new EvalVisitor(), new Empty());
    }
  }

  // visit defs only to build the signature.
  public class DefVisitor implements Def.Visitor<Void,Void>
  {
    public Void visit(Fun.Absyn.DDef p, Void arg)
    {
      // abstract over arguments from right to left
      Exp e = p.exp_;

      Collections.reverse(p.listident_);
      for (String x: p.listident_) e = new EAbs(x, e);

      // Add to signature
      sig.put(p.ident_, e);
      return null;
    }
  }

  public class EvalVisitor implements Exp.Visitor<Value,Environment>
  {
    // variable
    public Value visit(Fun.Absyn.EVar p, Environment env)
    {
      todo("identifier");
      return null;
    }

    // literal
    public Value visit(Fun.Absyn.EInt p, Environment env)
    {
      todo("literal");
      return null;
    }

    // lambda
    public Value visit(Fun.Absyn.EAbs p, Environment env)
    {
      todo("lambda");
      return null;
    }

    // application
    public Value visit(Fun.Absyn.EApp p, Environment env)
    {
      todo("application");
      return null;
    }

    // plus
    public Value visit(Fun.Absyn.EAdd p, Environment env)
    {
      // p.exp_1.accept(new EvalVisitor(), env);
      // p.exp_2.accept(new EvalVisitor(), env);
      todo("plus");
      return null;
    }

    // minus
    public Value visit(Fun.Absyn.ESub p, Environment env)
    {
      // p.exp_1.accept(new EvalVisitor(), env);
      // p.exp_2.accept(new EvalVisitor(), env);
      todo("minus");
      return null;
    }

    // less-than
    public Value visit(Fun.Absyn.ELt p, Environment env)
    {
      // p.exp_1.accept(new EvalVisitor(), env);
      // p.exp_2.accept(new EvalVisitor(), env);
      todo("less-than");
      return null;
    }

    // if
    public Value visit(Fun.Absyn.EIf p, Environment env)
    {
      // p.exp_1.accept(new EvalVisitor(), env);
      // p.exp_2.accept(new EvalVisitor(), env);
      // p.exp_3.accept(new EvalVisitor(), env);
      todo("if");
      return null;
    }
  }

  // TODOs /////////////////////////////////////////////////////////////

  public void todo(String msg) {
    throw new RuntimeException ("TODO: " + msg);
  }

  // Environment ///////////////////////////////////////////////////////

  abstract class Environment {
    abstract Value lookup (String x);
  }

  class Empty extends Environment {
    Value lookup (String x) {
      throw new RuntimeException ("Unbound variable: " + x);
    }
  }

  class Extend extends Environment {
    final Environment env;
    final String y;
    final Entry entry;

    Extend (String y, Entry entry, Environment env) {
      this.env = env;
      this.y = y;
      this.entry = entry;
    }
    Value lookup (String x) {
      if (x.equals(y)) return entry.value();
      else return env.lookup(x);
    }
  }


  // Environment entries ////////////////////////////////////////////////

  abstract class Entry {
    abstract Value value();
  }

  class ValueEntry extends Entry {
    final Value v;
    ValueEntry (Value v) {
      this.v = v;
    }
    Value value() { return v; }
  }

  class ClosEntry extends Entry {
    final Exp exp;
    final Environment env;
    ClosEntry (Exp exp, Environment env) {
      this.exp = exp;
      this.env = env;
    }
    Value value() { return exp.accept (new EvalVisitor(), env); }
  }

  // Value /////////////////////////////////////////////////////////////

  abstract class Value {
    abstract public int intValue();
    abstract public Value apply(Entry e);
  }

  // Numeric values

  class VInt extends Value {

    final int val;
    public VInt (int i) { val = i; }

    public int intValue() {
      return val;
    }
    public Value apply (Entry e) {
      throw new RuntimeException ("cannot apply integer value to argument");
    }
  }

  // Function values

  class VFun extends Value {
    final String x;
    final Exp body;
    final Environment env;

    VFun (String x, Exp body, Environment env) {
      this.x = x;
      this.body = body;
      this.env = env;
    }

    public int intValue() {
      throw new RuntimeException ("VFun.intValue() is not possible");
    }
    public Value apply (Entry e) {
      return body.accept (new EvalVisitor(), new Extend(x, e, env));
    }
  }

}
