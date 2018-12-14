.class public good03
.super java/lang/Object

.method public <init>()V
  .limit locals 1
	.limit stack 1

  aload_0
  invokespecial java/lang/Object/<init>()V
  return

.end method

.method public static main([Ljava/lang/String;)V
  .limit locals 1
  .limit stack  1

  invokestatic good03/main()I
  pop
  return

.end method


.method public static main()I
  .limit locals 3
  .limit stack 3

  
  ;; int arg = readInt ();
  invokestaticRuntime/readInt(I)I
  istore_0
  
  ;; int ret = 1;
  iconst_1
  istore_1
  
  ;; int i = 1;
  iconst_1
  istore_2
  
  ;; test while-condition (i < arg + 1)
  
  ;; while (i < arg + 1) do:
  L0:
  iload_2
  iload_0
  iconst_1
  iadd
  if_icmplt  L2
  iconst_0
  goto L3
  L2:
  iconst_1
  L3:
  iconst_0
  if_icmpeq  L1
  
  ;; ret = i * ret;
  iload_2
  iload_1
  imul
  istore_1
  iload_1
  pop
  
  ;; ++ i;
  iload_2
  iconst_1
  iadd
  istore_2
  iload_2
  pop
  goto L0
  L1:
  
  ;; printInt (ret);
  iload_1
  invokestaticRuntime/printInt(I)V
  pop
  
  ;; return 0;
  iconst_0
  ireturn
.end method
