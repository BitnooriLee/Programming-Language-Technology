import java.util.*;
import Fun.Absyn.*;

public class Interpreter {

  // Signature
  final Map<String,Exp> sig  = new TreeMap();

  // Strategy CBV / CBN
  final Strategy strategy; //type

  // Control debug printing.
  final boolean debug = false;

  public Interpreter (Strategy strategy) { // type
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
//DONE

//예외처리를 어케 해줄지? 근데 예외가 왜 들어가는 거져..
  public class EvalVisitor implements Exp.Visitor<Value,Environment>
  {
    // variable
    public Value visit(Fun.Absyn.EVar p, Environment env)
    {
      Value v = env.lookup(p.ident_); //local environment 
      if(v!=null){ //
        return v.apply(v).value;
      }
      else{ // global signature 
        Exp e = sig.get(p.ident_);
      }
    }

    // literal
    public Value visit(Fun.Absyn.EInt p, Environment env)
    {
      return new VInt(p.integer_);
    }

    // lambda
    public Value visit(Fun.Absyn.EAbs p, Environment env)
    {
      return new VFun(p.ident_, p.exp_, env);
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
      Value v1 =  p.exp_1.accept(new EvalVisitor(), env);
      Value v2 = p.exp_2.accept(new EvalVisitor(), env);
      return new VInt(v1.intValue() + v2.intValue());
    }

    // minus
    public Value visit(Fun.Absyn.ESub p, Environment env)
    {
      Value v1 =  p.exp_1.accept(new EvalVisitor(), env);
      Value v2 = p.exp_2.accept(new EvalVisitor(), env);
      return new VInt(v1.intValue() - v2.intValue());
    }

    // less-than
    public Value visit(Fun.Absyn.ELt p, Environment env)
    {
      Value v1 =  p.exp_1.accept(new EvalVisitor(), env);
      Value v2 = p.exp_2.accept(new EvalVisitor(), env);
      return new VInt(v1.intValue() < v2.intValue() ? 1 : 0);
  
    }

    // if else
    public Value visit(Fun.Absyn.EIf p, Environment env)
    {
      Value vCon =  p.exp_1.accept(new EvalVisitor(), env);
      if(vCon.intValue()!=0) return p.exp_2.accept(new EvalVisitor(), env);
      else     return p.exp_3.accept(new EvalVisitor(), env);
 
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
    final Entry entry; //call by name ???

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
    abstract public Value apply(Entry e); // Entry -> Value
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

  // Function values //VClos

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
