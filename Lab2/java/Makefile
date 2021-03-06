# Makefile for lab2 in java1.5

JAVAC = javac
JAVAC_FLAGS = -sourcepath .

JAVA = java

# Name of generated .cup file for bnfc 2.8
# Was CPP/CPP.cup for older versions of bnfc
CUPFILE = CPP/_cup.cup

.PHONY: bnfc lab2 clean distclean vclean test

# current: FunType.class TypeChecker.class lab2 VInt.class VDouble.class VBool.class VNull.class

all: bnfc lab2 test

test: lab2
	./lab2 test/test.cc

%.class : %.java
	javac $<

lab2: TypeChecker.class Interpreter.class
	${JAVAC} ${JAVAC_FLAGS} lab2.java
	chmod a+x lab2

bnfc:
	bnfc -java1.5 CPP.cf
	${JAVA} ${JAVA_FLAGS} JLex.Main CPP/Yylex
	${JAVA} ${JAVA_FLAGS} java_cup.Main -nopositions -expect 100 $(CUPFILE)
	mv sym.java parser.java CPP

clean:
	 -rm -f CPP/Absyn/*.class CPP/*.class
	 -rm -f .dvi CPP.aux CPP.log CPP.ps  *.class

distclean: vclean

vclean: clean
	 -rm -f CPP/Absyn/*.java
	 -rmdir CPP/Absyn/
	 -rm -f CPP.tex CPP.dvi CPP.aux CPP.log CPP.ps
	 -rm -f CPP/Yylex $(CUPFILE) CPP/Yylex.java CPP/VisitSkel.java CPP/ComposVisitor.java CPP/AbstractVisitor.java CPP/FoldVisitor.java CPP/AllVisitor.java CPP/PrettyPrinter.java CPP/Skeleton.java CPP/Test.java CPP/sym.java CPP/parser.java CPP/*.class
	 -rmdir -p CPP/

# EOF
