import CPP.Absyn.*;
import java.util.*;

public class TypeChecker {
    // Global signature of functions
    private Map<String, FunType> sig;

    // Stack of contexts
    private List<Map<String,Type>> cxt;

    // Return type of function we are checking
    private Type returnType;

    // Share type constants
    public final Type BOOL   = new Type_bool();
    public final Type INT    = new Type_int();
    public final Type DOUBLE = new Type_double();
    public final Type VOID   = new Type_void();

    // Entry point
    public void typecheck(Program p) {
        p.accept(new ProgramVisitor(), null);
    }

    ////////////////////////////// Program //////////////////////////////

    public class ProgramVisitor implements Program.Visitor<Void,Void> {
        public Void visit(CPP.Absyn.PDefs p, Void arg) {
            // Put primitive functions into signature
            sig = new TreeMap<String, FunType>();
            sig.put("printInt"   , new FunType(VOID, singleArg(INT)));
            sig.put("readInt"    , new FunType(INT, new ListArg()));
            sig.put("printDouble", new FunType(VOID, singleArg(DOUBLE)));
            sig.put("readDouble" , new FunType(DOUBLE, new ListArg()));
            // TODO: other primitive functions, DONE

            // Extend signature by all the definitions
            for (Def d: p.listdef_) {
                d.accept(new DefIntoSigVisitor(), null);
            }

            // Check definitions
            for (Def d: p.listdef_) {
                d.accept(new DefVisitor(), arg);
            }

            // TODO: Check for main, DONE
            if(!sig.containsKey("main"))
                throw new TypeException("The 'main' function is missing!");

            return null;
        }
    }

    public ListArg singleArg (Type t) {
        ListArg l = new ListArg();
        l.add(new ADecl(t, "x"));
        return l;
    }

    ////////////////////////////// Function //////////////////////////////

    public class DefIntoSigVisitor implements Def.Visitor<Void,Void> {
        public Void visit(CPP.Absyn.DFun p, Void arg) {
            // Check that name is not present already
            if (sig.get(p.id_) != null)
                throw new TypeException ("Function " + p.id_ + " already defined");

            // Add function to signature
            FunType ft = new FunType (p.type_, p.listarg_);
            sig.put(p.id_, ft);

            return null;
        }
    }

    // Type check a function definition.

    public class DefVisitor implements Def.Visitor<Void,Void> {
        public Void visit(CPP.Absyn.DFun p, Void arg) {
            // set return type and initial context
            returnType = p.type_;
            cxt = new LinkedList();
            cxt.add(new TreeMap());

            // add all function parameters to context
            for (Arg a: p.listarg_) {
                a.accept(new ArgVisitor(), arg);
            }

            // check function statements
            for (Stm s: p.liststm_) {
                s.accept(new StmVisitor(), arg);
            }

            return null;
        }
    }

    ///////////////////////// Function argument /////////////////////////

    // Add a type declaration to the context
    public class ArgVisitor implements Arg.Visitor<Void,Void> {
        public Void visit(CPP.Absyn.ADecl p, Void arg) {
            newVar (p.id_, p.type_);
            // // The variable should not be in the top block already.
            // if (cxt.get(0).containsKey(p.id_))
            //   throw new TypeException ("Local variable " + p.id_ + " already in current scope");
            // // Add it to the top block.
            // cxt.get(0).put (p.id_, p.type_);
            return null;
        }
    }

    ////////////////////////////// Statement //////////////////////////////

    public class StmVisitor implements Stm.Visitor<Void,Void> {
        public Void visit(CPP.Absyn.SExp p, Void arg) {
            Type t = p.exp_.accept(new ExpVisitor(), null);
            return null;
        }

        public Void visit(CPP.Absyn.SDecls p, Void arg) {
            if (p.type_ instanceof Type_void)
                throw new TypeException("Declarations can not have a void type");

            for (String id: p.listid_)
                newVar(id, p.type_);

            return null;
        }

        public Void visit(CPP.Absyn.SInit p, Void arg) {
            // p.id_ p.type_
            checkExpr(p.exp_, p.type_);
            newVar(p.id_, p.type_);
            return null;
        }

        public Void visit(CPP.Absyn.SReturn p, Void arg) {
            checkExpr(p.exp_, returnType);
            return null;
        }

        public Void visit(CPP.Absyn.SWhile p, Void arg) {
            //throw new TypeException ("not yet implemented");

            checkExpr(p.exp_, BOOL);

            enterScope();
            p.stm_.accept(this, arg);
            leaveScope();

            return null;
        }

        public Void visit(CPP.Absyn.SBlock p, Void arg) {
            //System.out.println("hello1");

            enterScope();
            for (Stm stm : p.liststm_)
                stm.accept(this, arg);
            leaveScope();
            return null;

            //throw new TypeException ("not yet implemented");
        }

        public Void visit(CPP.Absyn.SIfElse p, Void arg) {
            System.out.println("hello2");
            throw new TypeException ("not yet implemented2");
        }
    }

    ////////////////////////////// Expression //////////////////////////////

    public class ExpVisitor implements Exp.Visitor<Type,Void> {

        // Literals
        public Type visit(CPP.Absyn.ETrue p, Void arg) {
            return BOOL;
        }
        public Type visit(CPP.Absyn.EFalse p, Void arg) {
            return BOOL;
        }
        public Type visit(CPP.Absyn.EInt p, Void arg) {
            return INT;
        }
        public Type visit(CPP.Absyn.EDouble p, Void arg) {
            return DOUBLE;
        }

        // Variable
        public Type visit(CPP.Absyn.EId p, Void arg) {
            return lookupVar(p.id_);
        }

        // Function call
        public Type visit(CPP.Absyn.EApp p, Void arg) {
            FunType ft = sig.get(p.id_);
            if (ft == null) throw new TypeException ("undefined function " + p.id_);
            if (ft.args.size() != p.listexp_.size())
                throw new TypeException ("wrong number of arguments");
            // check types of arguments
            int i=0;
            for (Exp e : p.listexp_) {
                ADecl a = (ADecl) ft.args.get(i);
                checkExpr (e, a.type_);
                i++;
            }
            return ft.returnType;
        }

        // Increment, decrement

        public Type visit(CPP.Absyn.EPostIncr p, Void arg) {
            Type t = numericType(lookupVar(p.id_));
            return t;
        }

        public Type visit(CPP.Absyn.EPostDecr p, Void arg) {
            Type t = numericType(lookupVar(p.id_));
            return t;
        }

        public Type visit(CPP.Absyn.EPreIncr p, Void arg) {
            Type t = numericType(lookupVar(p.id_));
            return t;
        }

        public Type visit(CPP.Absyn.EPreDecr p, Void arg) {
            Type t = numericType(lookupVar(p.id_));
            return t;
        }

        // Arithmetical operators

        public Type visit(CPP.Absyn.ETimes p, Void arg) {
            System.out.println("hello6");
            throw new TypeException ("not yet implemented6");
        }

        public Type visit(CPP.Absyn.EDiv p, Void arg) {
            System.out.println("hello7");
            throw new TypeException ("not yet implemented7");
        }

        public Type visit(CPP.Absyn.EPlus p, Void arg) {
            System.out.println("hello8");
            throw new TypeException ("not yet implemented8");
        }

        public Type visit(CPP.Absyn.EMinus p, Void arg) {
            System.out.println("hello9");
            throw new TypeException ("not yet implemented9");
        }

        // Comparison operators

        public Type visit(CPP.Absyn.ELt p, Void arg) { // Left is smaller
            Type t1 = p.exp_1.accept(new ExpVisitor(), null);
            Type t2 = p.exp_2.accept(new ExpVisitor(), null);

            if (equalTypes(t1, t2)) {
                return voidCheck("<", t1, t2);
            }
            else {
                throw new TypeException("expected types " + t1 + " and " + t2 + " to be equal");
            }
        }

        public Type visit(CPP.Absyn.EGt p, Void arg) { // Right is smaller
            Type t1 = p.exp_1.accept(new ExpVisitor(), null);
            Type t2 = p.exp_2.accept(new ExpVisitor(), null);

            if (equalTypes(t1, t2)) {
                return voidCheck(">", t1, t2);
            }
            else {
                throw new TypeException("expected types " + t1 + " and " + t2 + " to be equal");
            }
        }

        public Type visit(CPP.Absyn.ELtEq p, Void arg) {
            System.out.println("hello12");
            throw new TypeException ("not yet implemented12");
        }

        public Type visit(CPP.Absyn.EGtEq p, Void arg) {
            System.out.println("hello13");
            throw new TypeException ("not yet implemented13");
        }

        // Equality operators

        public Type visit(CPP.Absyn.EEq p, Void arg) {
            Type t1 = p.exp_1.accept(new ExpVisitor(), null);
            Type t2 = p.exp_2.accept(new ExpVisitor(), null);

            if (equalTypes(t1, t2)) {
                return voidCheck("==", t1, t2);
            } else {
                throw new TypeException("expected types " + t1 + " and " + t2 + " to be equal");
            }
        }

        public Type visit(CPP.Absyn.ENEq p, Void arg) {
            System.out.println("hello15");
            throw new TypeException ("not yet implemented15");
        }

        // Logic operators

        public Type visit(CPP.Absyn.EAnd p, Void arg) {
            System.out.println("hello16");
            throw new TypeException ("not yet implemented16");
        }

        public Type visit(CPP.Absyn.EOr p, Void arg) {
            System.out.println("hello17");
            throw new TypeException ("not yet implemented17");
        }

        // Assignment
        public Type visit(CPP.Absyn.EAss p, Void arg) {
            System.out.println("hello18");
            throw new TypeException ("not yet implemented18");
        }
    }

    ///////////////////////// Context handling /////////////////////////

    public void newVar(String x, Type t) {
        // Get the top context block
        Map<String,Type> m = cxt.get(0);
        // Check that the variable is not declared already
        if (m.containsKey(x))
            throw new TypeException("duplicate variable binding " + x);
        // Add the binding
        m.put(x, t);
    }

    public Type lookupVar(String x) {
        for (Map<String,Type> m: cxt) {
            Type t = m.get(x);
            if (t != null) return t;
        }
        throw new TypeException("unbound variable " + x);
    }

    public void enterScope() { // sangseok
        cxt.add(0, new TreeMap());
    }

    public void leaveScope() { // sangseok
        //scopes.removeFirst();
        cxt.remove(0);
    }

    ////////////////////////////// Exp / Type shape //////////////////////////////

    public void checkExpr(Exp e, Type t) {
        Type t1 = e.accept (new ExpVisitor(), null);
        check(t, t1);
    }

    public void check(Type t, Type u) {
        if (!t.equals(u)) {
            throw new TypeException("Expected type " + t + ", but found type " + u);
        }
    }

    public Type numericType(Type t) {
        if (!t.equals(INT) && !t.equals(DOUBLE)) {
            throw new TypeException("expected expression of numeric type");
        }

        return t;
    }

    public boolean equalTypes(Type t1, Type t2) {
        return t1.equals(t2);
    }

    public Type voidCheck(String operand, Type code1, Type code2) {
        if (code1 instanceof Type_void || code2 instanceof Type_void) {
            throw new TypeException("Any type can't be void for " + operand);
        }
        else {
            return BOOL;   
        }
    }

    public Type booleanCheck(String operand, Type code1, Type code2) {
        if (code1 instanceof Type_bool && code2 instanceof Type_bool) {
            return BOOL;
        }
        else {
            throw new TypeException("The type must be boolean for " + operand);
        }
    }
}