.class public ass_in_arith
.super java/lang/Object

.method public <init>()V
  .limit locals 1

  aload_0
  invokespecial java/lang/Object/<init>()V
  return

.end method

.method public static main([Ljava/lang/String;)V
  .limit locals 1
  .limit stack  1

  invokestatic ass_in_arith/main()I
  pop
  return

.end method


.method public static main()I
  .limit locals 1
  .limit stack 2

  
  ;; int x = 50 + 5;
  bipush 50  iconst_5  iadd  istore_0  
  ;; return 0;
  iconst_0  ireturn
.end method
