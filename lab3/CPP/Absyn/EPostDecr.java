package CPP.Absyn; // Java Package generated by the BNF Converter.

public class EPostDecr  extends Exp {
  public final String id_;
  public EPostDecr(String p1) { id_ = p1; }

  public <R,A> R accept(CPP.Absyn.Exp.Visitor<R,A> v, A arg) { return v.visit(this, arg); }

  public boolean equals(Object o) {
    if (this == o) return true;
    if (o instanceof CPP.Absyn.EPostDecr) {
      CPP.Absyn.EPostDecr x = (CPP.Absyn.EPostDecr)o;
      return this.id_.equals(x.id_);
    }
    return false;
  }

  public int hashCode() {
    return this.id_.hashCode();
  }


}
