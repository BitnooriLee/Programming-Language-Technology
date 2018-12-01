// Function types

import java.util.*;
import CPP.Absyn.*;

public class FunType {
  final Type returnType;
  final ListArg args;
  public FunType (Type t, ListArg l) {
    returnType = t;
    args = l;
  }
}
