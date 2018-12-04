import java.util.*;
import CPP.Absyn.*;

public class Interpreter {

    // signature
    private Map<String, DFun> sig;

    // environment
    private List<Map<String, Value>> env;

    // type 
    public final Type BOOL   = new Type_bool();
    public final Type INT    = new Type_int();
    public final Type DOUBLE = new Type_double();
    public final Type VOID   = new Type_void();

    // For user input
    public Scanner scanner = new Scanner(System.in);

    // entrypoint
    public void interpret(Program p) {
        p.accept(new ProgramVisitor (), null);
    }

    public class ProgramVisitor implements Program.Visitor<Void, Void> {
        public Void visit(CPP.Absyn.PDefs p, Void arg) {
            /* Add all definitions to the signature */
            sig = new TreeMap();
            for (Def d: p.listdef_) {
                DFun d1 = (DFun) d;
                sig.put(d1.id_, d1);
            }

            /* Find main function */
            DFun main = sig.get("main");
            if (main == null) throw new RuntimeException("main function is missing");

            // Initialize environment
            env = new LinkedList();
            env.add(new TreeMap());

            for (Stm x: main.liststm_) {
                if (x.accept(new StmVisitor(), null) != null)
                    break;
            }
            return null;
        }
    }
    
    public class DefVisitor implements Def.Visitor<Void, Void> {
        public Void visit(CPP.Absyn.DFun p, Void arg) { /* Code For DFun Goes Here */
   
            enterScope();
            for (Arg x: p.listarg_) {
                addVar(x.accept(new ArgVisitor(), null));
            }

            for (Stm x: p.liststm_) {
                if (x.accept(new StmVisitor(), arg) != null)
                    break;
            }
            leaveScope();
            return arg;
        }
    }

    ////////////////////////////// Statements //////////////////////////////

    public class StmVisitor implements Stm.Visitor<Value, Void> {
        public Value visit(CPP.Absyn.SExp p, Void arg) { /* Code For SExp Goes Here */
            Value v = p.exp_.accept(new ExpVisitor(), arg);
            return null;
        }
        
        public Value visit(CPP.Absyn.SDecls p, Void arg) { /* Code For SDecls Goes Here */
            for (String id: p.listid_) {
                addVar(id);
            }
            return null;
        }

        public Value visit(CPP.Absyn.SInit p, Void arg) { /* Code For SInit Goes Here */
            // p.type_.accept(new TypeVisitor(), arg);
            //p.id_;
            Value v = p.exp_.accept(new ExpVisitor(), arg);
            newVar(p.id_, v);
            return null;
        }
       
        public Value visit(CPP.Absyn.SReturn p, Void arg) {  /*Code For SReturn Goes Here */
            
            return p.exp_.accept(new ExpVisitor(), arg);
        }

        public Value visit(CPP.Absyn.SWhile p, Void arg) { /* Code For SWhile Goes Here */
            Value v = p.exp_.accept(new ExpVisitor(), arg);
            if (((VBool)v).value) {
                enterScope();
                Value v1 = p.stm_.accept(new StmVisitor(), arg);
                leaveScope();
                if(v1!=null) {
                    return v1;
                }
                else {
                    p.accept(new StmVisitor(), arg);
                }
            }
            return null;
        }

        public Value visit(CPP.Absyn.SBlock p, Void arg) { /* Code For SBlock Goes Here */
            enterScope();
            for (Stm stm: p.liststm_) {
                Value val = stm.accept(new StmVisitor(), arg);
                if(val != null) {
                    leaveScope();
                    return val;
                }
            }
            leaveScope();
            return null;
        }

        public Value visit(CPP.Absyn.SIfElse p, Void arg) { 
            Value v = p.exp_.accept(new ExpVisitor(), arg);
            enterScope();
            if (((VBool)v).value) {
                Value v1 = p.stm_1.accept(new StmVisitor(), arg);
                leaveScope();
                return v1;
            }
            else {
                Value v2 = p.stm_2.accept(new StmVisitor(), arg);
                leaveScope();
                return v2;
            }
        } 
    }

    ////////////////////////////// Expressions //////////////////////////////

    public class ExpVisitor implements Exp.Visitor<Value,Void> {
        public Value visit(CPP.Absyn.ETrue p, Void arg) { /* Code For ETrue Goes Here */
            return new VBool(true);
        }

        public Value visit(CPP.Absyn.EFalse p, Void arg) { /* Code For EFalse Goes Here */
            return new VBool(false);
        }

        public Value visit(CPP.Absyn.EInt p, Void arg) { /* Code For EInt Goes Here */
            return new VInt(p.integer_);
        }

        public Value visit(CPP.Absyn.EDouble p, Void arg) { /* Code For EDouble Goes Here */
            return new VDouble(p.double_);
        }

        public Value visit(CPP.Absyn.EId p, Void arg) {
            return lookupVar(p.id_);
        }

        public Value visit(CPP.Absyn.EApp p, Void arg) { /* Code For EApp Goes Here */
            if (p.id_.equals("printInt")) {
                VInt v = (VInt)p.listexp_.get(0).accept(new ExpVisitor(), null);
                System.out.println(v.value);
            }
            else if (p.id_.equals("printDouble")) {
                VDouble v = (VDouble)p.listexp_.get(0).accept(new ExpVisitor(), null);
                System.out.println(v.value);
            }
            else if (p.id_.equals("readInt")) {
                int x = scanner.nextInt();
                return new VInt(x);
            }
            else if (p.id_.equals("readDouble")) {
                double x = scanner.nextDouble();
                return new VDouble(x);
            }
            else {

                DFun fun = sig.get(p.id_);

                LinkedList<Value> values = new LinkedList<Value>();
                for (Exp exp: p.listexp_) {
                    values.add(exp.accept(this, arg));
                }

                enterScope();
                for (int i=0; i<fun.listarg_.size(); i++) {
                    newVar(fun.listarg_.get(i).accept(new ArgVisitor(), null), values.get(i));
                }

                for (Stm stm: fun.liststm_) {
                    Value value = stm.accept(new StmVisitor(), arg);
                    if (value != null) {
                        leaveScope();
                        return value;
                    }
                }
                leaveScope();

                if(fun.type_ instanceof Type_void) {
                    return null;
                }

                throw new RuntimeException("no return statment"); // done
            }

            return new VVoid();
          
        }

        public Value visit(CPP.Absyn.EPostIncr p, Void arg) { /* Code For EPostIncr Goes Here */
            Value v  = lookupVar(p.id_);
            Value v1 = increment(v);
            assignVar(p.id_, v1);
            return v;
        }

        public Value visit(CPP.Absyn.EPostDecr p, Void arg) { /* Code For EPostDecr Goes Here */
            Value v  = lookupVar(p.id_);
            Value v1 = decrement(v);
            assignVar(p.id_, v1);
            return v;
        }

        public Value visit(CPP.Absyn.EPreIncr p, Void arg) { /* Code For EPreIncr Goes Here */
            Value v  = lookupVar(p.id_);
            Value v1 = increment(v);
            assignVar(p.id_, v1);
            return v1;
        }

        public Value visit(CPP.Absyn.EPreDecr p, Void arg) { /* Code For EPreDecr Goes Here */
            Value v  = lookupVar(p.id_);
            Value v1 = decrement(v);
            assignVar(p.id_, v1);
            return v1;
        }

        public Value visit(CPP.Absyn.ETimes p, Void arg) { /* Code For ETimes Goes Here */
            Value v1 = p.exp_1.accept(new ExpVisitor(), arg);
            Value v2 = p.exp_2.accept(new ExpVisitor(), arg);
            if (v1 instanceof VInt) {
                return new VInt(((VInt)v1).value * ((VInt)v2).value);
            }
            else if(v1 instanceof VDouble) {
                return new VDouble(((VDouble)v1).value * ((VDouble)v2).value);
            }
            else throw new TypeException ("value should be a numeric type");
        }

        public Value visit(CPP.Absyn.EDiv p, Void arg) { /* Code For EDiv Goes Here */
            Value v1 = p.exp_1.accept(new ExpVisitor(), arg);
            Value v2 = p.exp_2.accept(new ExpVisitor(), arg);
            if (v1 instanceof VInt) {
                return new VInt(((VInt)v1).value /((VInt)v2).value);
            }
            else if(v1 instanceof VDouble) {
                return new VDouble(((VDouble)v1).value / ((VDouble)v2).value);
            }
            else throw new TypeException ("value should be a numeric type");
        }

        public Value visit(CPP.Absyn.EPlus p, Void arg) { /* Code For EPlus Goes Here */
            Value v1 = p.exp_1.accept(new ExpVisitor(), arg);
            Value v2 = p.exp_2.accept(new ExpVisitor(), arg);
            if (v1 instanceof VInt) {
                return new VInt(((VInt)v1).value + ((VInt)v2).value);
            }
            else if(v1 instanceof VDouble) {
                return new VDouble(((VDouble)v1).value + ((VDouble)v2).value);
            }
            else throw new TypeException ("value should be a numeric type");
        }

        public Value visit(CPP.Absyn.EMinus p, Void arg) { /* Code For EMinus Goes Here */
            Value v1 = p.exp_1.accept(new ExpVisitor(), arg);
            Value v2 = p.exp_2.accept(new ExpVisitor(), arg);
            if (v1 instanceof VInt) {
                return new VInt(((VInt)v1).value - ((VInt)v2).value);
            }
            else if(v1 instanceof VDouble) {
                return new VDouble(((VDouble)v1).value - ((VDouble)v2).value);
            }
            else throw new TypeException ("value should be a numeric type");
        }

        public Value visit(CPP.Absyn.ELt p, Void arg) { /* Code For ELt Goes Here */
            Value v1 = p.exp_1.accept(new ExpVisitor(), arg);
            Value v2 = p.exp_2.accept(new ExpVisitor(), arg);
            if (v1 instanceof VInt) {
                return new VBool(((VInt)v1).value < ((VInt)v2).value);
            }
            else if(v1 instanceof VDouble) {
                return new VBool(((VDouble)v1).value < ((VDouble)v2).value);
            }
            else throw new TypeException ("value should be a numeric type");
        }

        public Value visit(CPP.Absyn.EGt p, Void arg) { /* Code For EGt Goes Here */
            Value v1 = p.exp_1.accept(new ExpVisitor(), arg);
            Value v2 = p.exp_2.accept(new ExpVisitor(), arg);
            if (v1 instanceof VInt) {
                return new VBool(((VInt)v1).value > ((VInt)v2).value);
            }
            else if(v1 instanceof VDouble) {
                return new VBool(((VDouble)v1).value > ((VDouble)v2).value);
            }
            else throw new TypeException ("value should be a numeric type");
        }

        public Value visit(CPP.Absyn.ELtEq p, Void arg) { /* Code For ELtEq Goes Here */
            Value v1 = p.exp_1.accept(new ExpVisitor(), arg);
            Value v2 = p.exp_2.accept(new ExpVisitor(), arg);
            if (v1 instanceof VInt) {
                return new VBool(((VInt)v1).value <= ((VInt)v2).value);
            }
            else if(v1 instanceof VDouble) {
                return new VBool(((VDouble)v1).value <=((VDouble)v2).value);
            }
            else throw new TypeException ("value should be a numeric type");
        }

        public Value visit(CPP.Absyn.EGtEq p, Void arg) { 
            Value v1 = p.exp_1.accept(new ExpVisitor(), arg);
            Value v2 = p.exp_2.accept(new ExpVisitor(), arg);
            if (v1 instanceof VInt) {
                return new VBool(((VInt)v1).value >= ((VInt)v2).value);
            }
            else if(v1 instanceof VDouble) {
                return new VBool(((VDouble)v1).value >= ((VDouble)v2).value);
            }
            else throw new TypeException ("value should be a numeric type");
        }

        public Value visit(CPP.Absyn.EEq p, Void arg) { /* Code For EEq Goes Here */
            Value v1 = p.exp_1.accept(new ExpVisitor(), arg);
            Value v2 = p.exp_2.accept(new ExpVisitor(), arg);
            if (v1 instanceof VInt) {
                return new VBool(((VInt)v1).value.equals(((VInt)v2).value));
            }
            else if(v1 instanceof VDouble) {
                return new VBool(((VDouble)v1).value.equals(((VDouble)v2).value));
            }
            else if(v1 instanceof VBool) {
                return new VBool(((VBool)v1).value == ((VBool)v2).value);
            }
            else throw new TypeException ("value should be a numeric type");
        }

        public Value visit(CPP.Absyn.ENEq p, Void arg) { /* Code For ENEq Goes Here */
            Value v1 = p.exp_1.accept(new ExpVisitor(), arg);
            Value v2 = p.exp_2.accept(new ExpVisitor(), arg);
            if (v1 instanceof VInt) {
                return new VBool(!((VInt)v1).value.equals(((VInt)v2).value));
            }
            else if(v1 instanceof VDouble) {
                return new VBool(!((VDouble)v1).value.equals(((VDouble)v2).value));
            }
            else if(v1 instanceof VBool) {
                return new VBool(((VBool)v1).value != ((VBool)v2).value);
            }
            else throw new TypeException ("value should be a numeric type");
        }


        public Value visit(CPP.Absyn.EAnd p, Void arg) { /* Code For EAnd Goes Here */
            Value v1 = p.exp_1.accept(new ExpVisitor(), arg);
            if (((VBool)v1).value) {
                Value v2 = p.exp_2.accept(new ExpVisitor(), arg);
                if (((VBool)v2).value) {
                    return new VBool(true);
                }
            }
            
            return new VBool(false);
        }

        public Value visit(CPP.Absyn.EOr p, Void arg) { /* Code For EOr Goes Here */
            Value v1 = p.exp_1.accept(new ExpVisitor(), arg);
            if (((VBool)v1).value) {
                return new VBool(true);
            }
            else {
                Value v2 = p.exp_2.accept(new ExpVisitor(), arg);
                if (((VBool)v2).value) {
                    return new VBool(true);
                }
            }
            return new VBool(false);
        }

     
        public Value visit(CPP.Absyn.EAss p, Void arg) { /* Code For EAss Goes Here */
            Value val = p.exp_.accept(new ExpVisitor(), arg);
            updateVar(p.id_, val);
            return val;
        }
    }

    public class ArgVisitor implements Arg.Visitor<String, Void> { // ?????????????????????
        public String visit(ADecl p, Void arg) {
            return p.id_;
        }
    }

    public Value lookupVar(String x) {
        for (Map<String, Value> b: env) {
            Value v = b.get(x);
            if (v != null) {
                return v;
            }
        }
        throw new RuntimeException ("unbound variable " + x);
    }

    public void assignVar(String x, Value v) {
        for (Map<String, Value> b: env) {
            Value v1 = b.get(x);
            if (v1 != null) {
                b.put(x,v);
                return;
            }
        }
        throw new RuntimeException ("unbound variable " + x);
    }

    public void newVar(String x, Value v) {
        Map<String,Value> b = env.get(0);
        b.put(x,v);
    }

    public void addVar(String id) {
        env.get(0).put(id, null);
    }

    public void updateVar(String id, Value v) {
        for (Map<String, Value> b: env) {
            if(b.containsKey(id)) {
                b.put(id, v);
                return;
            }
        }
    }

    public Value increment(Value v) {
        if (v instanceof VInt) {
            return new VInt(((VInt)v).value + 1);
        }
        else if(v instanceof VDouble) {
            return new VDouble(((VDouble)v).value + 1.0);
        }
        else throw new TypeException ("value should be a numeric type");
    }

    public Value decrement(Value v) {
        if (v instanceof VInt) {
            return new VInt(((VInt)v).value - 1);
        }
        else if(v instanceof VDouble) {
            return new VDouble(((VDouble)v).value - 1.0);
        }
        else throw new TypeException ("value should be a numeric type");
    }

    public void enterScope() {
        env.add(0, new TreeMap());
    }

    public void leaveScope(){
        env.remove(0);
    }

}