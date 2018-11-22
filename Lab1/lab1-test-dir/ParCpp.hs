{-# OPTIONS_GHC -w #-}
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParCpp where
import AbsCpp
import LexCpp
import ErrM
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn29 (Integer)
	| HappyAbsSyn30 (Double)
	| HappyAbsSyn31 (Id)
	| HappyAbsSyn32 (Program)
	| HappyAbsSyn33 ([Def])
	| HappyAbsSyn34 (Def)
	| HappyAbsSyn35 ([Arg])
	| HappyAbsSyn36 ([Stm])
	| HappyAbsSyn37 (Arg)
	| HappyAbsSyn38 (Stm)
	| HappyAbsSyn39 ([Id])
	| HappyAbsSyn40 (Exp)
	| HappyAbsSyn56 ([Exp])
	| HappyAbsSyn57 (Type)

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111,
 action_112,
 action_113,
 action_114,
 action_115,
 action_116,
 action_117,
 action_118,
 action_119,
 action_120,
 action_121,
 action_122,
 action_123,
 action_124,
 action_125,
 action_126,
 action_127,
 action_128,
 action_129,
 action_130,
 action_131,
 action_132,
 action_133,
 action_134,
 action_135,
 action_136,
 action_137,
 action_138,
 action_139,
 action_140,
 action_141,
 action_142,
 action_143,
 action_144,
 action_145,
 action_146,
 action_147,
 action_148,
 action_149,
 action_150,
 action_151,
 action_152,
 action_153,
 action_154,
 action_155,
 action_156,
 action_157,
 action_158,
 action_159,
 action_160,
 action_161,
 action_162,
 action_163,
 action_164,
 action_165,
 action_166,
 action_167,
 action_168,
 action_169,
 action_170,
 action_171,
 action_172,
 action_173,
 action_174,
 action_175,
 action_176,
 action_177,
 action_178,
 action_179,
 action_180,
 action_181,
 action_182,
 action_183,
 action_184,
 action_185,
 action_186,
 action_187,
 action_188,
 action_189,
 action_190,
 action_191,
 action_192,
 action_193,
 action_194 :: () => Int -> ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54,
 happyReduce_55,
 happyReduce_56,
 happyReduce_57,
 happyReduce_58,
 happyReduce_59,
 happyReduce_60,
 happyReduce_61,
 happyReduce_62,
 happyReduce_63,
 happyReduce_64,
 happyReduce_65,
 happyReduce_66,
 happyReduce_67,
 happyReduce_68,
 happyReduce_69,
 happyReduce_70,
 happyReduce_71,
 happyReduce_72,
 happyReduce_73,
 happyReduce_74,
 happyReduce_75,
 happyReduce_76,
 happyReduce_77,
 happyReduce_78,
 happyReduce_79,
 happyReduce_80,
 happyReduce_81,
 happyReduce_82,
 happyReduce_83,
 happyReduce_84,
 happyReduce_85,
 happyReduce_86,
 happyReduce_87,
 happyReduce_88,
 happyReduce_89,
 happyReduce_90,
 happyReduce_91,
 happyReduce_92,
 happyReduce_93,
 happyReduce_94,
 happyReduce_95,
 happyReduce_96,
 happyReduce_97,
 happyReduce_98,
 happyReduce_99,
 happyReduce_100,
 happyReduce_101,
 happyReduce_102,
 happyReduce_103,
 happyReduce_104,
 happyReduce_105,
 happyReduce_106 :: () => ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,1211) ([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17920,4,0,0,0,0,0,2188,0,0,0,0,0,0,0,0,0,0,0,0,8752,0,0,0,32768,2216,24576,6655,0,0,0,0,0,0,64,0,0,0,32,0,24708,0,0,0,16384,0,2048,193,0,0,0,35464,0,33296,1,0,0,4096,277,8192,772,0,0,0,10784,2,2112,6,0,0,16384,1108,32768,3088,0,0,0,43136,8,8448,24,0,0,0,4433,0,12354,0,0,0,41472,34,33792,96,0,0,0,17732,0,49416,0,0,0,34816,138,4096,386,0,0,0,5392,1,1568,3,0,0,8192,554,16384,1548,0,0,0,21568,4,4224,12,0,0,32768,2216,0,6177,0,0,0,20736,17,16896,48,0,0,0,8866,0,24772,0,0,0,0,0,8960,2,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6690,512,0,0,0,0,0,0,0,0,0,0,0,32802,0,0,0,0,0,32768,8,0,0,0,0,0,0,2080,0,0,0,0,0,40960,12,0,0,0,0,16,1024,0,0,0,0,32768,0,0,0,0,0,0,16384,2052,32769,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,554,16384,1544,0,0,0,21568,4,6272,12,0,0,32768,2216,0,6177,0,0,0,20736,17,16896,48,0,0,0,8866,0,24708,0,0,0,0,0,0,0,0,0,0,35464,0,33552,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,1,0,0,0,0,0,128,8192,0,0,0,0,0,0,404,0,0,0,0,0,4096,4,0,0,0,0,4352,0,0,0,0,0,4096,1025,0,0,0,0,0,0,0,0,0,0,0,0,3345,256,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,512,0,0,0,256,0,0,0,0,0,8192,554,16384,1548,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,17408,69,64256,207,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,17504,0,0,0,0,0,0,0,0,0,0,0,0,4480,1,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,2188,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,2216,24576,7679,0,0,0,20736,17,25088,48,0,0,0,0,8,0,0,0,0,17408,69,34816,193,0,0,0,8192,544,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,16384,1108,32768,3096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,33792,96,0,0,0,64,0,49416,0,0,0,32768,0,4096,386,0,0,0,5392,1,1056,3,0,0,8192,554,16384,1544,0,0,0,21568,4,4224,12,0,0,32768,2216,0,6177,0,0,0,20736,17,16896,48,0,0,0,8866,0,24708,0,0,0,17408,69,2048,193,0,0,0,35464,0,33296,1,0,0,4096,277,8192,772,0,0,0,10784,2,2112,6,0,0,16384,1108,32768,3088,0,0,0,43136,8,8448,24,0,0,0,4433,0,12354,0,0,0,41472,34,33792,96,0,0,0,17732,0,49416,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,8866,0,24772,0,0,0,17408,69,2048,193,0,0,0,35464,0,33296,1,0,0,4096,277,8192,772,0,0,0,10784,2,2112,6,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,51712,0,0,0,0,0,0,404,0,0,0,0,0,4096,4,0,0,0,0,0,2080,0,0,0,0,0,16384,16,0,0,0,0,0,8320,0,0,0,0,0,136,0,0,0,0,0,4096,1,0,0,0,0,0,16401,0,0,0,0,0,8704,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,17408,69,34816,193,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,136,0,0,0,16384,0,0,0,0,0,0,17732,0,53243,0,0,0,34816,138,62976,415,0,0,0,0,64,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20736,17,16896,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,4433,49152,13310,0,0,0,0,0,0,0,0,0,0,17732,0,61435,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgram","%start_pListDef","%start_pDef","%start_pListArg","%start_pListStm","%start_pArg","%start_pStm","%start_pListId","%start_pExp15","%start_pExp14","%start_pExp13","%start_pExp12","%start_pExp11","%start_pExp10","%start_pExp9","%start_pExp8","%start_pExp4","%start_pExp3","%start_pExp2","%start_pExp1","%start_pExp","%start_pExp5","%start_pExp6","%start_pExp7","%start_pListExp","%start_pType","Integer","Double","Id","Program","ListDef","Def","ListArg","ListStm","Arg","Stm","ListId","Exp15","Exp14","Exp13","Exp12","Exp11","Exp10","Exp9","Exp8","Exp4","Exp3","Exp2","Exp1","Exp","Exp5","Exp6","Exp7","ListExp","Type","'!'","'!='","'%'","'&&'","'('","')'","'*'","'+'","'++'","'+='","','","'-'","'--'","'-='","'->'","'.'","'/'","':'","';'","'<'","'<<'","'<='","'='","'=='","'>'","'>='","'>>'","'?'","'['","']'","'bool'","'double'","'else'","'false'","'if'","'int'","'return'","'throw'","'true'","'void'","'while'","'{'","'||'","'}'","L_integ","L_doubl","L_Id","%eof"]
        bit_start = st * 105
        bit_end = (st + 1) * 105
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..104]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (32) = happyGoto action_95
action_0 (33) = happyGoto action_96
action_0 _ = happyReduce_30

action_1 (33) = happyGoto action_94
action_1 _ = happyReduce_30

action_2 (88) = happyShift action_29
action_2 (89) = happyShift action_30
action_2 (93) = happyShift action_31
action_2 (97) = happyShift action_32
action_2 (34) = happyGoto action_92
action_2 (57) = happyGoto action_93
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (88) = happyShift action_29
action_3 (89) = happyShift action_30
action_3 (93) = happyShift action_31
action_3 (97) = happyShift action_32
action_3 (35) = happyGoto action_90
action_3 (37) = happyGoto action_91
action_3 (57) = happyGoto action_88
action_3 _ = happyReduce_33

action_4 (36) = happyGoto action_89
action_4 _ = happyReduce_36

action_5 (88) = happyShift action_29
action_5 (89) = happyShift action_30
action_5 (93) = happyShift action_31
action_5 (97) = happyShift action_32
action_5 (37) = happyGoto action_87
action_5 (57) = happyGoto action_88
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (58) = happyShift action_52
action_6 (62) = happyShift action_53
action_6 (64) = happyShift action_54
action_6 (66) = happyShift action_55
action_6 (70) = happyShift action_56
action_6 (88) = happyShift action_29
action_6 (89) = happyShift action_30
action_6 (91) = happyShift action_57
action_6 (92) = happyShift action_83
action_6 (93) = happyShift action_31
action_6 (94) = happyShift action_84
action_6 (95) = happyShift action_58
action_6 (96) = happyShift action_59
action_6 (97) = happyShift action_32
action_6 (98) = happyShift action_85
action_6 (99) = happyShift action_86
action_6 (102) = happyShift action_27
action_6 (103) = happyShift action_60
action_6 (29) = happyGoto action_33
action_6 (30) = happyGoto action_34
action_6 (38) = happyGoto action_80
action_6 (40) = happyGoto action_35
action_6 (41) = happyGoto action_36
action_6 (42) = happyGoto action_37
action_6 (43) = happyGoto action_38
action_6 (44) = happyGoto action_39
action_6 (45) = happyGoto action_40
action_6 (46) = happyGoto action_41
action_6 (47) = happyGoto action_42
action_6 (48) = happyGoto action_43
action_6 (49) = happyGoto action_44
action_6 (50) = happyGoto action_45
action_6 (51) = happyGoto action_46
action_6 (52) = happyGoto action_81
action_6 (53) = happyGoto action_48
action_6 (54) = happyGoto action_49
action_6 (55) = happyGoto action_50
action_6 (57) = happyGoto action_82
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (104) = happyShift action_79
action_7 (31) = happyGoto action_77
action_7 (39) = happyGoto action_78
action_7 _ = happyReduce_47

action_8 (62) = happyShift action_53
action_8 (91) = happyShift action_57
action_8 (96) = happyShift action_59
action_8 (102) = happyShift action_27
action_8 (103) = happyShift action_60
action_8 (29) = happyGoto action_33
action_8 (30) = happyGoto action_34
action_8 (40) = happyGoto action_76
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (62) = happyShift action_53
action_9 (91) = happyShift action_57
action_9 (96) = happyShift action_59
action_9 (102) = happyShift action_27
action_9 (103) = happyShift action_60
action_9 (29) = happyGoto action_33
action_9 (30) = happyGoto action_34
action_9 (40) = happyGoto action_35
action_9 (41) = happyGoto action_75
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (58) = happyShift action_52
action_10 (62) = happyShift action_53
action_10 (64) = happyShift action_54
action_10 (66) = happyShift action_55
action_10 (70) = happyShift action_56
action_10 (91) = happyShift action_57
action_10 (96) = happyShift action_59
action_10 (102) = happyShift action_27
action_10 (103) = happyShift action_60
action_10 (29) = happyGoto action_33
action_10 (30) = happyGoto action_34
action_10 (40) = happyGoto action_35
action_10 (41) = happyGoto action_36
action_10 (42) = happyGoto action_74
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (58) = happyShift action_52
action_11 (62) = happyShift action_53
action_11 (64) = happyShift action_54
action_11 (66) = happyShift action_55
action_11 (70) = happyShift action_56
action_11 (91) = happyShift action_57
action_11 (96) = happyShift action_59
action_11 (102) = happyShift action_27
action_11 (103) = happyShift action_60
action_11 (29) = happyGoto action_33
action_11 (30) = happyGoto action_34
action_11 (40) = happyGoto action_35
action_11 (41) = happyGoto action_36
action_11 (42) = happyGoto action_37
action_11 (43) = happyGoto action_73
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (58) = happyShift action_52
action_12 (62) = happyShift action_53
action_12 (64) = happyShift action_54
action_12 (66) = happyShift action_55
action_12 (70) = happyShift action_56
action_12 (91) = happyShift action_57
action_12 (96) = happyShift action_59
action_12 (102) = happyShift action_27
action_12 (103) = happyShift action_60
action_12 (29) = happyGoto action_33
action_12 (30) = happyGoto action_34
action_12 (40) = happyGoto action_35
action_12 (41) = happyGoto action_36
action_12 (42) = happyGoto action_37
action_12 (43) = happyGoto action_38
action_12 (44) = happyGoto action_72
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (58) = happyShift action_52
action_13 (62) = happyShift action_53
action_13 (64) = happyShift action_54
action_13 (66) = happyShift action_55
action_13 (70) = happyShift action_56
action_13 (91) = happyShift action_57
action_13 (96) = happyShift action_59
action_13 (102) = happyShift action_27
action_13 (103) = happyShift action_60
action_13 (29) = happyGoto action_33
action_13 (30) = happyGoto action_34
action_13 (40) = happyGoto action_35
action_13 (41) = happyGoto action_36
action_13 (42) = happyGoto action_37
action_13 (43) = happyGoto action_38
action_13 (44) = happyGoto action_39
action_13 (45) = happyGoto action_71
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (58) = happyShift action_52
action_14 (62) = happyShift action_53
action_14 (64) = happyShift action_54
action_14 (66) = happyShift action_55
action_14 (70) = happyShift action_56
action_14 (91) = happyShift action_57
action_14 (96) = happyShift action_59
action_14 (102) = happyShift action_27
action_14 (103) = happyShift action_60
action_14 (29) = happyGoto action_33
action_14 (30) = happyGoto action_34
action_14 (40) = happyGoto action_35
action_14 (41) = happyGoto action_36
action_14 (42) = happyGoto action_37
action_14 (43) = happyGoto action_38
action_14 (44) = happyGoto action_39
action_14 (45) = happyGoto action_40
action_14 (46) = happyGoto action_70
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (58) = happyShift action_52
action_15 (62) = happyShift action_53
action_15 (64) = happyShift action_54
action_15 (66) = happyShift action_55
action_15 (70) = happyShift action_56
action_15 (91) = happyShift action_57
action_15 (96) = happyShift action_59
action_15 (102) = happyShift action_27
action_15 (103) = happyShift action_60
action_15 (29) = happyGoto action_33
action_15 (30) = happyGoto action_34
action_15 (40) = happyGoto action_35
action_15 (41) = happyGoto action_36
action_15 (42) = happyGoto action_37
action_15 (43) = happyGoto action_38
action_15 (44) = happyGoto action_39
action_15 (45) = happyGoto action_40
action_15 (46) = happyGoto action_41
action_15 (47) = happyGoto action_69
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (58) = happyShift action_52
action_16 (62) = happyShift action_53
action_16 (64) = happyShift action_54
action_16 (66) = happyShift action_55
action_16 (70) = happyShift action_56
action_16 (91) = happyShift action_57
action_16 (96) = happyShift action_59
action_16 (102) = happyShift action_27
action_16 (103) = happyShift action_60
action_16 (29) = happyGoto action_33
action_16 (30) = happyGoto action_34
action_16 (40) = happyGoto action_35
action_16 (41) = happyGoto action_36
action_16 (42) = happyGoto action_37
action_16 (43) = happyGoto action_38
action_16 (44) = happyGoto action_39
action_16 (45) = happyGoto action_40
action_16 (46) = happyGoto action_41
action_16 (47) = happyGoto action_42
action_16 (48) = happyGoto action_68
action_16 (53) = happyGoto action_48
action_16 (54) = happyGoto action_49
action_16 (55) = happyGoto action_50
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (58) = happyShift action_52
action_17 (62) = happyShift action_53
action_17 (64) = happyShift action_54
action_17 (66) = happyShift action_55
action_17 (70) = happyShift action_56
action_17 (91) = happyShift action_57
action_17 (96) = happyShift action_59
action_17 (102) = happyShift action_27
action_17 (103) = happyShift action_60
action_17 (29) = happyGoto action_33
action_17 (30) = happyGoto action_34
action_17 (40) = happyGoto action_35
action_17 (41) = happyGoto action_36
action_17 (42) = happyGoto action_37
action_17 (43) = happyGoto action_38
action_17 (44) = happyGoto action_39
action_17 (45) = happyGoto action_40
action_17 (46) = happyGoto action_41
action_17 (47) = happyGoto action_42
action_17 (48) = happyGoto action_43
action_17 (49) = happyGoto action_67
action_17 (53) = happyGoto action_48
action_17 (54) = happyGoto action_49
action_17 (55) = happyGoto action_50
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (58) = happyShift action_52
action_18 (62) = happyShift action_53
action_18 (64) = happyShift action_54
action_18 (66) = happyShift action_55
action_18 (70) = happyShift action_56
action_18 (91) = happyShift action_57
action_18 (96) = happyShift action_59
action_18 (102) = happyShift action_27
action_18 (103) = happyShift action_60
action_18 (29) = happyGoto action_33
action_18 (30) = happyGoto action_34
action_18 (40) = happyGoto action_35
action_18 (41) = happyGoto action_36
action_18 (42) = happyGoto action_37
action_18 (43) = happyGoto action_38
action_18 (44) = happyGoto action_39
action_18 (45) = happyGoto action_40
action_18 (46) = happyGoto action_41
action_18 (47) = happyGoto action_42
action_18 (48) = happyGoto action_43
action_18 (49) = happyGoto action_44
action_18 (50) = happyGoto action_66
action_18 (53) = happyGoto action_48
action_18 (54) = happyGoto action_49
action_18 (55) = happyGoto action_50
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (58) = happyShift action_52
action_19 (62) = happyShift action_53
action_19 (64) = happyShift action_54
action_19 (66) = happyShift action_55
action_19 (70) = happyShift action_56
action_19 (91) = happyShift action_57
action_19 (95) = happyShift action_58
action_19 (96) = happyShift action_59
action_19 (102) = happyShift action_27
action_19 (103) = happyShift action_60
action_19 (29) = happyGoto action_33
action_19 (30) = happyGoto action_34
action_19 (40) = happyGoto action_35
action_19 (41) = happyGoto action_36
action_19 (42) = happyGoto action_37
action_19 (43) = happyGoto action_38
action_19 (44) = happyGoto action_39
action_19 (45) = happyGoto action_40
action_19 (46) = happyGoto action_41
action_19 (47) = happyGoto action_42
action_19 (48) = happyGoto action_43
action_19 (49) = happyGoto action_44
action_19 (50) = happyGoto action_45
action_19 (51) = happyGoto action_65
action_19 (53) = happyGoto action_48
action_19 (54) = happyGoto action_49
action_19 (55) = happyGoto action_50
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (58) = happyShift action_52
action_20 (62) = happyShift action_53
action_20 (64) = happyShift action_54
action_20 (66) = happyShift action_55
action_20 (70) = happyShift action_56
action_20 (91) = happyShift action_57
action_20 (95) = happyShift action_58
action_20 (96) = happyShift action_59
action_20 (102) = happyShift action_27
action_20 (103) = happyShift action_60
action_20 (29) = happyGoto action_33
action_20 (30) = happyGoto action_34
action_20 (40) = happyGoto action_35
action_20 (41) = happyGoto action_36
action_20 (42) = happyGoto action_37
action_20 (43) = happyGoto action_38
action_20 (44) = happyGoto action_39
action_20 (45) = happyGoto action_40
action_20 (46) = happyGoto action_41
action_20 (47) = happyGoto action_42
action_20 (48) = happyGoto action_43
action_20 (49) = happyGoto action_44
action_20 (50) = happyGoto action_45
action_20 (51) = happyGoto action_46
action_20 (52) = happyGoto action_64
action_20 (53) = happyGoto action_48
action_20 (54) = happyGoto action_49
action_20 (55) = happyGoto action_50
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (58) = happyShift action_52
action_21 (62) = happyShift action_53
action_21 (64) = happyShift action_54
action_21 (66) = happyShift action_55
action_21 (70) = happyShift action_56
action_21 (91) = happyShift action_57
action_21 (96) = happyShift action_59
action_21 (102) = happyShift action_27
action_21 (103) = happyShift action_60
action_21 (29) = happyGoto action_33
action_21 (30) = happyGoto action_34
action_21 (40) = happyGoto action_35
action_21 (41) = happyGoto action_36
action_21 (42) = happyGoto action_37
action_21 (43) = happyGoto action_38
action_21 (44) = happyGoto action_39
action_21 (45) = happyGoto action_40
action_21 (46) = happyGoto action_41
action_21 (47) = happyGoto action_42
action_21 (53) = happyGoto action_63
action_21 (54) = happyGoto action_49
action_21 (55) = happyGoto action_50
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (58) = happyShift action_52
action_22 (62) = happyShift action_53
action_22 (64) = happyShift action_54
action_22 (66) = happyShift action_55
action_22 (70) = happyShift action_56
action_22 (91) = happyShift action_57
action_22 (96) = happyShift action_59
action_22 (102) = happyShift action_27
action_22 (103) = happyShift action_60
action_22 (29) = happyGoto action_33
action_22 (30) = happyGoto action_34
action_22 (40) = happyGoto action_35
action_22 (41) = happyGoto action_36
action_22 (42) = happyGoto action_37
action_22 (43) = happyGoto action_38
action_22 (44) = happyGoto action_39
action_22 (45) = happyGoto action_40
action_22 (46) = happyGoto action_41
action_22 (47) = happyGoto action_42
action_22 (54) = happyGoto action_62
action_22 (55) = happyGoto action_50
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (58) = happyShift action_52
action_23 (62) = happyShift action_53
action_23 (64) = happyShift action_54
action_23 (66) = happyShift action_55
action_23 (70) = happyShift action_56
action_23 (91) = happyShift action_57
action_23 (96) = happyShift action_59
action_23 (102) = happyShift action_27
action_23 (103) = happyShift action_60
action_23 (29) = happyGoto action_33
action_23 (30) = happyGoto action_34
action_23 (40) = happyGoto action_35
action_23 (41) = happyGoto action_36
action_23 (42) = happyGoto action_37
action_23 (43) = happyGoto action_38
action_23 (44) = happyGoto action_39
action_23 (45) = happyGoto action_40
action_23 (46) = happyGoto action_41
action_23 (47) = happyGoto action_42
action_23 (55) = happyGoto action_61
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (58) = happyShift action_52
action_24 (62) = happyShift action_53
action_24 (64) = happyShift action_54
action_24 (66) = happyShift action_55
action_24 (70) = happyShift action_56
action_24 (91) = happyShift action_57
action_24 (95) = happyShift action_58
action_24 (96) = happyShift action_59
action_24 (102) = happyShift action_27
action_24 (103) = happyShift action_60
action_24 (29) = happyGoto action_33
action_24 (30) = happyGoto action_34
action_24 (40) = happyGoto action_35
action_24 (41) = happyGoto action_36
action_24 (42) = happyGoto action_37
action_24 (43) = happyGoto action_38
action_24 (44) = happyGoto action_39
action_24 (45) = happyGoto action_40
action_24 (46) = happyGoto action_41
action_24 (47) = happyGoto action_42
action_24 (48) = happyGoto action_43
action_24 (49) = happyGoto action_44
action_24 (50) = happyGoto action_45
action_24 (51) = happyGoto action_46
action_24 (52) = happyGoto action_47
action_24 (53) = happyGoto action_48
action_24 (54) = happyGoto action_49
action_24 (55) = happyGoto action_50
action_24 (56) = happyGoto action_51
action_24 _ = happyReduce_100

action_25 (88) = happyShift action_29
action_25 (89) = happyShift action_30
action_25 (93) = happyShift action_31
action_25 (97) = happyShift action_32
action_25 (57) = happyGoto action_28
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (102) = happyShift action_27
action_26 _ = happyFail (happyExpListPerState 26)

action_27 _ = happyReduce_26

action_28 (105) = happyAccept
action_28 _ = happyFail (happyExpListPerState 28)

action_29 _ = happyReduce_103

action_30 _ = happyReduce_104

action_31 _ = happyReduce_105

action_32 _ = happyReduce_106

action_33 _ = happyReduce_50

action_34 _ = happyReduce_51

action_35 _ = happyReduce_61

action_36 (62) = happyShift action_109
action_36 (66) = happyShift action_110
action_36 (70) = happyShift action_111
action_36 (72) = happyShift action_112
action_36 (73) = happyShift action_113
action_36 (86) = happyShift action_114
action_36 _ = happyReduce_66

action_37 _ = happyReduce_70

action_38 (60) = happyShift action_115
action_38 (64) = happyShift action_116
action_38 (74) = happyShift action_117
action_38 _ = happyReduce_73

action_39 (65) = happyShift action_118
action_39 (69) = happyShift action_119
action_39 _ = happyReduce_76

action_40 (78) = happyShift action_120
action_40 (84) = happyShift action_121
action_40 _ = happyReduce_81

action_41 (77) = happyShift action_122
action_41 (79) = happyShift action_123
action_41 (82) = happyShift action_124
action_41 (83) = happyShift action_125
action_41 _ = happyReduce_84

action_42 (59) = happyShift action_126
action_42 (81) = happyShift action_127
action_42 _ = happyReduce_99

action_43 (61) = happyShift action_128
action_43 _ = happyReduce_88

action_44 (67) = happyShift action_137
action_44 (71) = happyShift action_138
action_44 (80) = happyShift action_139
action_44 (85) = happyShift action_140
action_44 (100) = happyShift action_129
action_44 _ = happyReduce_93

action_45 _ = happyReduce_95

action_46 _ = happyReduce_96

action_47 (68) = happyShift action_136
action_47 _ = happyReduce_101

action_48 _ = happyReduce_86

action_49 _ = happyReduce_97

action_50 _ = happyReduce_98

action_51 (105) = happyAccept
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (58) = happyShift action_52
action_52 (62) = happyShift action_53
action_52 (64) = happyShift action_54
action_52 (66) = happyShift action_55
action_52 (70) = happyShift action_56
action_52 (91) = happyShift action_57
action_52 (96) = happyShift action_59
action_52 (102) = happyShift action_27
action_52 (103) = happyShift action_60
action_52 (29) = happyGoto action_33
action_52 (30) = happyGoto action_34
action_52 (40) = happyGoto action_35
action_52 (41) = happyGoto action_36
action_52 (42) = happyGoto action_135
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (58) = happyShift action_52
action_53 (62) = happyShift action_53
action_53 (64) = happyShift action_54
action_53 (66) = happyShift action_55
action_53 (70) = happyShift action_56
action_53 (91) = happyShift action_57
action_53 (95) = happyShift action_58
action_53 (96) = happyShift action_59
action_53 (102) = happyShift action_27
action_53 (103) = happyShift action_60
action_53 (29) = happyGoto action_33
action_53 (30) = happyGoto action_34
action_53 (40) = happyGoto action_35
action_53 (41) = happyGoto action_36
action_53 (42) = happyGoto action_37
action_53 (43) = happyGoto action_38
action_53 (44) = happyGoto action_39
action_53 (45) = happyGoto action_40
action_53 (46) = happyGoto action_41
action_53 (47) = happyGoto action_42
action_53 (48) = happyGoto action_43
action_53 (49) = happyGoto action_44
action_53 (50) = happyGoto action_45
action_53 (51) = happyGoto action_46
action_53 (52) = happyGoto action_134
action_53 (53) = happyGoto action_48
action_53 (54) = happyGoto action_49
action_53 (55) = happyGoto action_50
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (58) = happyShift action_52
action_54 (62) = happyShift action_53
action_54 (64) = happyShift action_54
action_54 (66) = happyShift action_55
action_54 (70) = happyShift action_56
action_54 (91) = happyShift action_57
action_54 (96) = happyShift action_59
action_54 (102) = happyShift action_27
action_54 (103) = happyShift action_60
action_54 (29) = happyGoto action_33
action_54 (30) = happyGoto action_34
action_54 (40) = happyGoto action_35
action_54 (41) = happyGoto action_36
action_54 (42) = happyGoto action_133
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (58) = happyShift action_52
action_55 (62) = happyShift action_53
action_55 (64) = happyShift action_54
action_55 (66) = happyShift action_55
action_55 (70) = happyShift action_56
action_55 (91) = happyShift action_57
action_55 (96) = happyShift action_59
action_55 (102) = happyShift action_27
action_55 (103) = happyShift action_60
action_55 (29) = happyGoto action_33
action_55 (30) = happyGoto action_34
action_55 (40) = happyGoto action_35
action_55 (41) = happyGoto action_36
action_55 (42) = happyGoto action_132
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (58) = happyShift action_52
action_56 (62) = happyShift action_53
action_56 (64) = happyShift action_54
action_56 (66) = happyShift action_55
action_56 (70) = happyShift action_56
action_56 (91) = happyShift action_57
action_56 (96) = happyShift action_59
action_56 (102) = happyShift action_27
action_56 (103) = happyShift action_60
action_56 (29) = happyGoto action_33
action_56 (30) = happyGoto action_34
action_56 (40) = happyGoto action_35
action_56 (41) = happyGoto action_36
action_56 (42) = happyGoto action_131
action_56 _ = happyFail (happyExpListPerState 56)

action_57 _ = happyReduce_53

action_58 (58) = happyShift action_52
action_58 (62) = happyShift action_53
action_58 (64) = happyShift action_54
action_58 (66) = happyShift action_55
action_58 (70) = happyShift action_56
action_58 (91) = happyShift action_57
action_58 (95) = happyShift action_58
action_58 (96) = happyShift action_59
action_58 (102) = happyShift action_27
action_58 (103) = happyShift action_60
action_58 (29) = happyGoto action_33
action_58 (30) = happyGoto action_34
action_58 (40) = happyGoto action_35
action_58 (41) = happyGoto action_36
action_58 (42) = happyGoto action_37
action_58 (43) = happyGoto action_38
action_58 (44) = happyGoto action_39
action_58 (45) = happyGoto action_40
action_58 (46) = happyGoto action_41
action_58 (47) = happyGoto action_42
action_58 (48) = happyGoto action_43
action_58 (49) = happyGoto action_44
action_58 (50) = happyGoto action_45
action_58 (51) = happyGoto action_130
action_58 (53) = happyGoto action_48
action_58 (54) = happyGoto action_49
action_58 (55) = happyGoto action_50
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_52

action_60 _ = happyReduce_27

action_61 (105) = happyAccept
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (105) = happyAccept
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (105) = happyAccept
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (105) = happyAccept
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (105) = happyAccept
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (105) = happyAccept
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (100) = happyShift action_129
action_67 (105) = happyAccept
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (61) = happyShift action_128
action_68 (105) = happyAccept
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (59) = happyShift action_126
action_69 (81) = happyShift action_127
action_69 (105) = happyAccept
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (77) = happyShift action_122
action_70 (79) = happyShift action_123
action_70 (82) = happyShift action_124
action_70 (83) = happyShift action_125
action_70 (105) = happyAccept
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (78) = happyShift action_120
action_71 (84) = happyShift action_121
action_71 (105) = happyAccept
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (65) = happyShift action_118
action_72 (69) = happyShift action_119
action_72 (105) = happyAccept
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (60) = happyShift action_115
action_73 (64) = happyShift action_116
action_73 (74) = happyShift action_117
action_73 (105) = happyAccept
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (105) = happyAccept
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (62) = happyShift action_109
action_75 (66) = happyShift action_110
action_75 (70) = happyShift action_111
action_75 (72) = happyShift action_112
action_75 (73) = happyShift action_113
action_75 (86) = happyShift action_114
action_75 (105) = happyAccept
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (105) = happyAccept
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (68) = happyShift action_108
action_77 _ = happyReduce_48

action_78 (105) = happyAccept
action_78 _ = happyFail (happyExpListPerState 78)

action_79 _ = happyReduce_28

action_80 (105) = happyAccept
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (76) = happyShift action_107
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (104) = happyShift action_79
action_82 (31) = happyGoto action_106
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (62) = happyShift action_105
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (58) = happyShift action_52
action_84 (62) = happyShift action_53
action_84 (64) = happyShift action_54
action_84 (66) = happyShift action_55
action_84 (70) = happyShift action_56
action_84 (91) = happyShift action_57
action_84 (95) = happyShift action_58
action_84 (96) = happyShift action_59
action_84 (102) = happyShift action_27
action_84 (103) = happyShift action_60
action_84 (29) = happyGoto action_33
action_84 (30) = happyGoto action_34
action_84 (40) = happyGoto action_35
action_84 (41) = happyGoto action_36
action_84 (42) = happyGoto action_37
action_84 (43) = happyGoto action_38
action_84 (44) = happyGoto action_39
action_84 (45) = happyGoto action_40
action_84 (46) = happyGoto action_41
action_84 (47) = happyGoto action_42
action_84 (48) = happyGoto action_43
action_84 (49) = happyGoto action_44
action_84 (50) = happyGoto action_45
action_84 (51) = happyGoto action_46
action_84 (52) = happyGoto action_104
action_84 (53) = happyGoto action_48
action_84 (54) = happyGoto action_49
action_84 (55) = happyGoto action_50
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (62) = happyShift action_103
action_85 _ = happyFail (happyExpListPerState 85)

action_86 (36) = happyGoto action_102
action_86 _ = happyReduce_36

action_87 (105) = happyAccept
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (104) = happyShift action_79
action_88 (31) = happyGoto action_101
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (58) = happyShift action_52
action_89 (62) = happyShift action_53
action_89 (64) = happyShift action_54
action_89 (66) = happyShift action_55
action_89 (70) = happyShift action_56
action_89 (88) = happyShift action_29
action_89 (89) = happyShift action_30
action_89 (91) = happyShift action_57
action_89 (92) = happyShift action_83
action_89 (93) = happyShift action_31
action_89 (94) = happyShift action_84
action_89 (95) = happyShift action_58
action_89 (96) = happyShift action_59
action_89 (97) = happyShift action_32
action_89 (98) = happyShift action_85
action_89 (99) = happyShift action_86
action_89 (102) = happyShift action_27
action_89 (103) = happyShift action_60
action_89 (105) = happyAccept
action_89 (29) = happyGoto action_33
action_89 (30) = happyGoto action_34
action_89 (38) = happyGoto action_100
action_89 (40) = happyGoto action_35
action_89 (41) = happyGoto action_36
action_89 (42) = happyGoto action_37
action_89 (43) = happyGoto action_38
action_89 (44) = happyGoto action_39
action_89 (45) = happyGoto action_40
action_89 (46) = happyGoto action_41
action_89 (47) = happyGoto action_42
action_89 (48) = happyGoto action_43
action_89 (49) = happyGoto action_44
action_89 (50) = happyGoto action_45
action_89 (51) = happyGoto action_46
action_89 (52) = happyGoto action_81
action_89 (53) = happyGoto action_48
action_89 (54) = happyGoto action_49
action_89 (55) = happyGoto action_50
action_89 (57) = happyGoto action_82
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (105) = happyAccept
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (68) = happyShift action_99
action_91 _ = happyReduce_34

action_92 (105) = happyAccept
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (104) = happyShift action_79
action_93 (31) = happyGoto action_98
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (88) = happyShift action_29
action_94 (89) = happyShift action_30
action_94 (93) = happyShift action_31
action_94 (97) = happyShift action_32
action_94 (105) = happyAccept
action_94 (34) = happyGoto action_97
action_94 (57) = happyGoto action_93
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (105) = happyAccept
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (88) = happyShift action_29
action_96 (89) = happyShift action_30
action_96 (93) = happyShift action_31
action_96 (97) = happyShift action_32
action_96 (34) = happyGoto action_97
action_96 (57) = happyGoto action_93
action_96 _ = happyReduce_29

action_97 _ = happyReduce_31

action_98 (62) = happyShift action_175
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (88) = happyShift action_29
action_99 (89) = happyShift action_30
action_99 (93) = happyShift action_31
action_99 (97) = happyShift action_32
action_99 (35) = happyGoto action_174
action_99 (37) = happyGoto action_91
action_99 (57) = happyGoto action_88
action_99 _ = happyReduce_33

action_100 _ = happyReduce_37

action_101 _ = happyReduce_38

action_102 (58) = happyShift action_52
action_102 (62) = happyShift action_53
action_102 (64) = happyShift action_54
action_102 (66) = happyShift action_55
action_102 (70) = happyShift action_56
action_102 (88) = happyShift action_29
action_102 (89) = happyShift action_30
action_102 (91) = happyShift action_57
action_102 (92) = happyShift action_83
action_102 (93) = happyShift action_31
action_102 (94) = happyShift action_84
action_102 (95) = happyShift action_58
action_102 (96) = happyShift action_59
action_102 (97) = happyShift action_32
action_102 (98) = happyShift action_85
action_102 (99) = happyShift action_86
action_102 (101) = happyShift action_173
action_102 (102) = happyShift action_27
action_102 (103) = happyShift action_60
action_102 (29) = happyGoto action_33
action_102 (30) = happyGoto action_34
action_102 (38) = happyGoto action_100
action_102 (40) = happyGoto action_35
action_102 (41) = happyGoto action_36
action_102 (42) = happyGoto action_37
action_102 (43) = happyGoto action_38
action_102 (44) = happyGoto action_39
action_102 (45) = happyGoto action_40
action_102 (46) = happyGoto action_41
action_102 (47) = happyGoto action_42
action_102 (48) = happyGoto action_43
action_102 (49) = happyGoto action_44
action_102 (50) = happyGoto action_45
action_102 (51) = happyGoto action_46
action_102 (52) = happyGoto action_81
action_102 (53) = happyGoto action_48
action_102 (54) = happyGoto action_49
action_102 (55) = happyGoto action_50
action_102 (57) = happyGoto action_82
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (58) = happyShift action_52
action_103 (62) = happyShift action_53
action_103 (64) = happyShift action_54
action_103 (66) = happyShift action_55
action_103 (70) = happyShift action_56
action_103 (91) = happyShift action_57
action_103 (95) = happyShift action_58
action_103 (96) = happyShift action_59
action_103 (102) = happyShift action_27
action_103 (103) = happyShift action_60
action_103 (29) = happyGoto action_33
action_103 (30) = happyGoto action_34
action_103 (40) = happyGoto action_35
action_103 (41) = happyGoto action_36
action_103 (42) = happyGoto action_37
action_103 (43) = happyGoto action_38
action_103 (44) = happyGoto action_39
action_103 (45) = happyGoto action_40
action_103 (46) = happyGoto action_41
action_103 (47) = happyGoto action_42
action_103 (48) = happyGoto action_43
action_103 (49) = happyGoto action_44
action_103 (50) = happyGoto action_45
action_103 (51) = happyGoto action_46
action_103 (52) = happyGoto action_172
action_103 (53) = happyGoto action_48
action_103 (54) = happyGoto action_49
action_103 (55) = happyGoto action_50
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (76) = happyShift action_171
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (58) = happyShift action_52
action_105 (62) = happyShift action_53
action_105 (64) = happyShift action_54
action_105 (66) = happyShift action_55
action_105 (70) = happyShift action_56
action_105 (91) = happyShift action_57
action_105 (95) = happyShift action_58
action_105 (96) = happyShift action_59
action_105 (102) = happyShift action_27
action_105 (103) = happyShift action_60
action_105 (29) = happyGoto action_33
action_105 (30) = happyGoto action_34
action_105 (40) = happyGoto action_35
action_105 (41) = happyGoto action_36
action_105 (42) = happyGoto action_37
action_105 (43) = happyGoto action_38
action_105 (44) = happyGoto action_39
action_105 (45) = happyGoto action_40
action_105 (46) = happyGoto action_41
action_105 (47) = happyGoto action_42
action_105 (48) = happyGoto action_43
action_105 (49) = happyGoto action_44
action_105 (50) = happyGoto action_45
action_105 (51) = happyGoto action_46
action_105 (52) = happyGoto action_170
action_105 (53) = happyGoto action_48
action_105 (54) = happyGoto action_49
action_105 (55) = happyGoto action_50
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (68) = happyShift action_167
action_106 (76) = happyShift action_168
action_106 (80) = happyShift action_169
action_106 _ = happyFail (happyExpListPerState 106)

action_107 _ = happyReduce_39

action_108 (104) = happyShift action_79
action_108 (31) = happyGoto action_77
action_108 (39) = happyGoto action_166
action_108 _ = happyReduce_47

action_109 (58) = happyShift action_52
action_109 (62) = happyShift action_53
action_109 (64) = happyShift action_54
action_109 (66) = happyShift action_55
action_109 (70) = happyShift action_56
action_109 (91) = happyShift action_57
action_109 (95) = happyShift action_58
action_109 (96) = happyShift action_59
action_109 (102) = happyShift action_27
action_109 (103) = happyShift action_60
action_109 (29) = happyGoto action_33
action_109 (30) = happyGoto action_34
action_109 (40) = happyGoto action_35
action_109 (41) = happyGoto action_36
action_109 (42) = happyGoto action_37
action_109 (43) = happyGoto action_38
action_109 (44) = happyGoto action_39
action_109 (45) = happyGoto action_40
action_109 (46) = happyGoto action_41
action_109 (47) = happyGoto action_42
action_109 (48) = happyGoto action_43
action_109 (49) = happyGoto action_44
action_109 (50) = happyGoto action_45
action_109 (51) = happyGoto action_46
action_109 (52) = happyGoto action_47
action_109 (53) = happyGoto action_48
action_109 (54) = happyGoto action_49
action_109 (55) = happyGoto action_50
action_109 (56) = happyGoto action_165
action_109 _ = happyReduce_100

action_110 _ = happyReduce_59

action_111 _ = happyReduce_60

action_112 (62) = happyShift action_53
action_112 (91) = happyShift action_57
action_112 (96) = happyShift action_59
action_112 (102) = happyShift action_27
action_112 (103) = happyShift action_60
action_112 (29) = happyGoto action_33
action_112 (30) = happyGoto action_34
action_112 (40) = happyGoto action_164
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (62) = happyShift action_53
action_113 (91) = happyShift action_57
action_113 (96) = happyShift action_59
action_113 (102) = happyShift action_27
action_113 (103) = happyShift action_60
action_113 (29) = happyGoto action_33
action_113 (30) = happyGoto action_34
action_113 (40) = happyGoto action_163
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (62) = happyShift action_53
action_114 (91) = happyShift action_57
action_114 (96) = happyShift action_59
action_114 (102) = happyShift action_27
action_114 (103) = happyShift action_60
action_114 (29) = happyGoto action_33
action_114 (30) = happyGoto action_34
action_114 (40) = happyGoto action_162
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (58) = happyShift action_52
action_115 (62) = happyShift action_53
action_115 (64) = happyShift action_54
action_115 (66) = happyShift action_55
action_115 (70) = happyShift action_56
action_115 (91) = happyShift action_57
action_115 (96) = happyShift action_59
action_115 (102) = happyShift action_27
action_115 (103) = happyShift action_60
action_115 (29) = happyGoto action_33
action_115 (30) = happyGoto action_34
action_115 (40) = happyGoto action_35
action_115 (41) = happyGoto action_36
action_115 (42) = happyGoto action_161
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (58) = happyShift action_52
action_116 (62) = happyShift action_53
action_116 (64) = happyShift action_54
action_116 (66) = happyShift action_55
action_116 (70) = happyShift action_56
action_116 (91) = happyShift action_57
action_116 (96) = happyShift action_59
action_116 (102) = happyShift action_27
action_116 (103) = happyShift action_60
action_116 (29) = happyGoto action_33
action_116 (30) = happyGoto action_34
action_116 (40) = happyGoto action_35
action_116 (41) = happyGoto action_36
action_116 (42) = happyGoto action_160
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (58) = happyShift action_52
action_117 (62) = happyShift action_53
action_117 (64) = happyShift action_54
action_117 (66) = happyShift action_55
action_117 (70) = happyShift action_56
action_117 (91) = happyShift action_57
action_117 (96) = happyShift action_59
action_117 (102) = happyShift action_27
action_117 (103) = happyShift action_60
action_117 (29) = happyGoto action_33
action_117 (30) = happyGoto action_34
action_117 (40) = happyGoto action_35
action_117 (41) = happyGoto action_36
action_117 (42) = happyGoto action_159
action_117 _ = happyFail (happyExpListPerState 117)

action_118 (58) = happyShift action_52
action_118 (62) = happyShift action_53
action_118 (64) = happyShift action_54
action_118 (66) = happyShift action_55
action_118 (70) = happyShift action_56
action_118 (91) = happyShift action_57
action_118 (96) = happyShift action_59
action_118 (102) = happyShift action_27
action_118 (103) = happyShift action_60
action_118 (29) = happyGoto action_33
action_118 (30) = happyGoto action_34
action_118 (40) = happyGoto action_35
action_118 (41) = happyGoto action_36
action_118 (42) = happyGoto action_37
action_118 (43) = happyGoto action_158
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (58) = happyShift action_52
action_119 (62) = happyShift action_53
action_119 (64) = happyShift action_54
action_119 (66) = happyShift action_55
action_119 (70) = happyShift action_56
action_119 (91) = happyShift action_57
action_119 (96) = happyShift action_59
action_119 (102) = happyShift action_27
action_119 (103) = happyShift action_60
action_119 (29) = happyGoto action_33
action_119 (30) = happyGoto action_34
action_119 (40) = happyGoto action_35
action_119 (41) = happyGoto action_36
action_119 (42) = happyGoto action_37
action_119 (43) = happyGoto action_157
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (58) = happyShift action_52
action_120 (62) = happyShift action_53
action_120 (64) = happyShift action_54
action_120 (66) = happyShift action_55
action_120 (70) = happyShift action_56
action_120 (91) = happyShift action_57
action_120 (96) = happyShift action_59
action_120 (102) = happyShift action_27
action_120 (103) = happyShift action_60
action_120 (29) = happyGoto action_33
action_120 (30) = happyGoto action_34
action_120 (40) = happyGoto action_35
action_120 (41) = happyGoto action_36
action_120 (42) = happyGoto action_37
action_120 (43) = happyGoto action_38
action_120 (44) = happyGoto action_156
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (58) = happyShift action_52
action_121 (62) = happyShift action_53
action_121 (64) = happyShift action_54
action_121 (66) = happyShift action_55
action_121 (70) = happyShift action_56
action_121 (91) = happyShift action_57
action_121 (96) = happyShift action_59
action_121 (102) = happyShift action_27
action_121 (103) = happyShift action_60
action_121 (29) = happyGoto action_33
action_121 (30) = happyGoto action_34
action_121 (40) = happyGoto action_35
action_121 (41) = happyGoto action_36
action_121 (42) = happyGoto action_37
action_121 (43) = happyGoto action_38
action_121 (44) = happyGoto action_155
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (58) = happyShift action_52
action_122 (62) = happyShift action_53
action_122 (64) = happyShift action_54
action_122 (66) = happyShift action_55
action_122 (70) = happyShift action_56
action_122 (91) = happyShift action_57
action_122 (96) = happyShift action_59
action_122 (102) = happyShift action_27
action_122 (103) = happyShift action_60
action_122 (29) = happyGoto action_33
action_122 (30) = happyGoto action_34
action_122 (40) = happyGoto action_35
action_122 (41) = happyGoto action_36
action_122 (42) = happyGoto action_37
action_122 (43) = happyGoto action_38
action_122 (44) = happyGoto action_39
action_122 (45) = happyGoto action_154
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (58) = happyShift action_52
action_123 (62) = happyShift action_53
action_123 (64) = happyShift action_54
action_123 (66) = happyShift action_55
action_123 (70) = happyShift action_56
action_123 (91) = happyShift action_57
action_123 (96) = happyShift action_59
action_123 (102) = happyShift action_27
action_123 (103) = happyShift action_60
action_123 (29) = happyGoto action_33
action_123 (30) = happyGoto action_34
action_123 (40) = happyGoto action_35
action_123 (41) = happyGoto action_36
action_123 (42) = happyGoto action_37
action_123 (43) = happyGoto action_38
action_123 (44) = happyGoto action_39
action_123 (45) = happyGoto action_153
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (58) = happyShift action_52
action_124 (62) = happyShift action_53
action_124 (64) = happyShift action_54
action_124 (66) = happyShift action_55
action_124 (70) = happyShift action_56
action_124 (91) = happyShift action_57
action_124 (96) = happyShift action_59
action_124 (102) = happyShift action_27
action_124 (103) = happyShift action_60
action_124 (29) = happyGoto action_33
action_124 (30) = happyGoto action_34
action_124 (40) = happyGoto action_35
action_124 (41) = happyGoto action_36
action_124 (42) = happyGoto action_37
action_124 (43) = happyGoto action_38
action_124 (44) = happyGoto action_39
action_124 (45) = happyGoto action_152
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (58) = happyShift action_52
action_125 (62) = happyShift action_53
action_125 (64) = happyShift action_54
action_125 (66) = happyShift action_55
action_125 (70) = happyShift action_56
action_125 (91) = happyShift action_57
action_125 (96) = happyShift action_59
action_125 (102) = happyShift action_27
action_125 (103) = happyShift action_60
action_125 (29) = happyGoto action_33
action_125 (30) = happyGoto action_34
action_125 (40) = happyGoto action_35
action_125 (41) = happyGoto action_36
action_125 (42) = happyGoto action_37
action_125 (43) = happyGoto action_38
action_125 (44) = happyGoto action_39
action_125 (45) = happyGoto action_151
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (58) = happyShift action_52
action_126 (62) = happyShift action_53
action_126 (64) = happyShift action_54
action_126 (66) = happyShift action_55
action_126 (70) = happyShift action_56
action_126 (91) = happyShift action_57
action_126 (96) = happyShift action_59
action_126 (102) = happyShift action_27
action_126 (103) = happyShift action_60
action_126 (29) = happyGoto action_33
action_126 (30) = happyGoto action_34
action_126 (40) = happyGoto action_35
action_126 (41) = happyGoto action_36
action_126 (42) = happyGoto action_37
action_126 (43) = happyGoto action_38
action_126 (44) = happyGoto action_39
action_126 (45) = happyGoto action_40
action_126 (46) = happyGoto action_150
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (58) = happyShift action_52
action_127 (62) = happyShift action_53
action_127 (64) = happyShift action_54
action_127 (66) = happyShift action_55
action_127 (70) = happyShift action_56
action_127 (91) = happyShift action_57
action_127 (96) = happyShift action_59
action_127 (102) = happyShift action_27
action_127 (103) = happyShift action_60
action_127 (29) = happyGoto action_33
action_127 (30) = happyGoto action_34
action_127 (40) = happyGoto action_35
action_127 (41) = happyGoto action_36
action_127 (42) = happyGoto action_37
action_127 (43) = happyGoto action_38
action_127 (44) = happyGoto action_39
action_127 (45) = happyGoto action_40
action_127 (46) = happyGoto action_149
action_127 _ = happyFail (happyExpListPerState 127)

action_128 (58) = happyShift action_52
action_128 (62) = happyShift action_53
action_128 (64) = happyShift action_54
action_128 (66) = happyShift action_55
action_128 (70) = happyShift action_56
action_128 (91) = happyShift action_57
action_128 (96) = happyShift action_59
action_128 (102) = happyShift action_27
action_128 (103) = happyShift action_60
action_128 (29) = happyGoto action_33
action_128 (30) = happyGoto action_34
action_128 (40) = happyGoto action_35
action_128 (41) = happyGoto action_36
action_128 (42) = happyGoto action_37
action_128 (43) = happyGoto action_38
action_128 (44) = happyGoto action_39
action_128 (45) = happyGoto action_40
action_128 (46) = happyGoto action_41
action_128 (47) = happyGoto action_42
action_128 (53) = happyGoto action_148
action_128 (54) = happyGoto action_49
action_128 (55) = happyGoto action_50
action_128 _ = happyFail (happyExpListPerState 128)

action_129 (58) = happyShift action_52
action_129 (62) = happyShift action_53
action_129 (64) = happyShift action_54
action_129 (66) = happyShift action_55
action_129 (70) = happyShift action_56
action_129 (91) = happyShift action_57
action_129 (96) = happyShift action_59
action_129 (102) = happyShift action_27
action_129 (103) = happyShift action_60
action_129 (29) = happyGoto action_33
action_129 (30) = happyGoto action_34
action_129 (40) = happyGoto action_35
action_129 (41) = happyGoto action_36
action_129 (42) = happyGoto action_37
action_129 (43) = happyGoto action_38
action_129 (44) = happyGoto action_39
action_129 (45) = happyGoto action_40
action_129 (46) = happyGoto action_41
action_129 (47) = happyGoto action_42
action_129 (48) = happyGoto action_147
action_129 (53) = happyGoto action_48
action_129 (54) = happyGoto action_49
action_129 (55) = happyGoto action_50
action_129 _ = happyFail (happyExpListPerState 129)

action_130 _ = happyReduce_94

action_131 _ = happyReduce_63

action_132 _ = happyReduce_62

action_133 _ = happyReduce_64

action_134 (63) = happyShift action_146
action_134 _ = happyFail (happyExpListPerState 134)

action_135 _ = happyReduce_65

action_136 (58) = happyShift action_52
action_136 (62) = happyShift action_53
action_136 (64) = happyShift action_54
action_136 (66) = happyShift action_55
action_136 (70) = happyShift action_56
action_136 (91) = happyShift action_57
action_136 (95) = happyShift action_58
action_136 (96) = happyShift action_59
action_136 (102) = happyShift action_27
action_136 (103) = happyShift action_60
action_136 (29) = happyGoto action_33
action_136 (30) = happyGoto action_34
action_136 (40) = happyGoto action_35
action_136 (41) = happyGoto action_36
action_136 (42) = happyGoto action_37
action_136 (43) = happyGoto action_38
action_136 (44) = happyGoto action_39
action_136 (45) = happyGoto action_40
action_136 (46) = happyGoto action_41
action_136 (47) = happyGoto action_42
action_136 (48) = happyGoto action_43
action_136 (49) = happyGoto action_44
action_136 (50) = happyGoto action_45
action_136 (51) = happyGoto action_46
action_136 (52) = happyGoto action_47
action_136 (53) = happyGoto action_48
action_136 (54) = happyGoto action_49
action_136 (55) = happyGoto action_50
action_136 (56) = happyGoto action_145
action_136 _ = happyReduce_100

action_137 (58) = happyShift action_52
action_137 (62) = happyShift action_53
action_137 (64) = happyShift action_54
action_137 (66) = happyShift action_55
action_137 (70) = happyShift action_56
action_137 (91) = happyShift action_57
action_137 (96) = happyShift action_59
action_137 (102) = happyShift action_27
action_137 (103) = happyShift action_60
action_137 (29) = happyGoto action_33
action_137 (30) = happyGoto action_34
action_137 (40) = happyGoto action_35
action_137 (41) = happyGoto action_36
action_137 (42) = happyGoto action_37
action_137 (43) = happyGoto action_38
action_137 (44) = happyGoto action_39
action_137 (45) = happyGoto action_40
action_137 (46) = happyGoto action_41
action_137 (47) = happyGoto action_42
action_137 (48) = happyGoto action_43
action_137 (49) = happyGoto action_44
action_137 (50) = happyGoto action_144
action_137 (53) = happyGoto action_48
action_137 (54) = happyGoto action_49
action_137 (55) = happyGoto action_50
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (58) = happyShift action_52
action_138 (62) = happyShift action_53
action_138 (64) = happyShift action_54
action_138 (66) = happyShift action_55
action_138 (70) = happyShift action_56
action_138 (91) = happyShift action_57
action_138 (96) = happyShift action_59
action_138 (102) = happyShift action_27
action_138 (103) = happyShift action_60
action_138 (29) = happyGoto action_33
action_138 (30) = happyGoto action_34
action_138 (40) = happyGoto action_35
action_138 (41) = happyGoto action_36
action_138 (42) = happyGoto action_37
action_138 (43) = happyGoto action_38
action_138 (44) = happyGoto action_39
action_138 (45) = happyGoto action_40
action_138 (46) = happyGoto action_41
action_138 (47) = happyGoto action_42
action_138 (48) = happyGoto action_43
action_138 (49) = happyGoto action_44
action_138 (50) = happyGoto action_143
action_138 (53) = happyGoto action_48
action_138 (54) = happyGoto action_49
action_138 (55) = happyGoto action_50
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (58) = happyShift action_52
action_139 (62) = happyShift action_53
action_139 (64) = happyShift action_54
action_139 (66) = happyShift action_55
action_139 (70) = happyShift action_56
action_139 (91) = happyShift action_57
action_139 (96) = happyShift action_59
action_139 (102) = happyShift action_27
action_139 (103) = happyShift action_60
action_139 (29) = happyGoto action_33
action_139 (30) = happyGoto action_34
action_139 (40) = happyGoto action_35
action_139 (41) = happyGoto action_36
action_139 (42) = happyGoto action_37
action_139 (43) = happyGoto action_38
action_139 (44) = happyGoto action_39
action_139 (45) = happyGoto action_40
action_139 (46) = happyGoto action_41
action_139 (47) = happyGoto action_42
action_139 (48) = happyGoto action_43
action_139 (49) = happyGoto action_44
action_139 (50) = happyGoto action_142
action_139 (53) = happyGoto action_48
action_139 (54) = happyGoto action_49
action_139 (55) = happyGoto action_50
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (58) = happyShift action_52
action_140 (62) = happyShift action_53
action_140 (64) = happyShift action_54
action_140 (66) = happyShift action_55
action_140 (70) = happyShift action_56
action_140 (91) = happyShift action_57
action_140 (96) = happyShift action_59
action_140 (102) = happyShift action_27
action_140 (103) = happyShift action_60
action_140 (29) = happyGoto action_33
action_140 (30) = happyGoto action_34
action_140 (40) = happyGoto action_35
action_140 (41) = happyGoto action_36
action_140 (42) = happyGoto action_37
action_140 (43) = happyGoto action_38
action_140 (44) = happyGoto action_39
action_140 (45) = happyGoto action_40
action_140 (46) = happyGoto action_41
action_140 (47) = happyGoto action_42
action_140 (48) = happyGoto action_43
action_140 (49) = happyGoto action_44
action_140 (50) = happyGoto action_141
action_140 (53) = happyGoto action_48
action_140 (54) = happyGoto action_49
action_140 (55) = happyGoto action_50
action_140 _ = happyFail (happyExpListPerState 140)

action_141 (75) = happyShift action_183
action_141 _ = happyFail (happyExpListPerState 141)

action_142 _ = happyReduce_89

action_143 _ = happyReduce_91

action_144 _ = happyReduce_90

action_145 _ = happyReduce_102

action_146 _ = happyReduce_54

action_147 (61) = happyShift action_128
action_147 _ = happyReduce_87

action_148 _ = happyReduce_85

action_149 (77) = happyShift action_122
action_149 (79) = happyShift action_123
action_149 (82) = happyShift action_124
action_149 (83) = happyShift action_125
action_149 _ = happyReduce_82

action_150 (77) = happyShift action_122
action_150 (79) = happyShift action_123
action_150 (82) = happyShift action_124
action_150 (83) = happyShift action_125
action_150 _ = happyReduce_83

action_151 (78) = happyShift action_120
action_151 (84) = happyShift action_121
action_151 _ = happyReduce_80

action_152 (78) = happyShift action_120
action_152 (84) = happyShift action_121
action_152 _ = happyReduce_78

action_153 (78) = happyShift action_120
action_153 (84) = happyShift action_121
action_153 _ = happyReduce_79

action_154 (78) = happyShift action_120
action_154 (84) = happyShift action_121
action_154 _ = happyReduce_77

action_155 (65) = happyShift action_118
action_155 (69) = happyShift action_119
action_155 _ = happyReduce_75

action_156 (65) = happyShift action_118
action_156 (69) = happyShift action_119
action_156 _ = happyReduce_74

action_157 (60) = happyShift action_115
action_157 (64) = happyShift action_116
action_157 (74) = happyShift action_117
action_157 _ = happyReduce_72

action_158 (60) = happyShift action_115
action_158 (64) = happyShift action_116
action_158 (74) = happyShift action_117
action_158 _ = happyReduce_71

action_159 _ = happyReduce_68

action_160 _ = happyReduce_67

action_161 _ = happyReduce_69

action_162 (87) = happyShift action_182
action_162 _ = happyFail (happyExpListPerState 162)

action_163 _ = happyReduce_58

action_164 _ = happyReduce_57

action_165 (63) = happyShift action_181
action_165 _ = happyFail (happyExpListPerState 165)

action_166 _ = happyReduce_49

action_167 (104) = happyShift action_79
action_167 (31) = happyGoto action_77
action_167 (39) = happyGoto action_180
action_167 _ = happyReduce_47

action_168 _ = happyReduce_40

action_169 (58) = happyShift action_52
action_169 (62) = happyShift action_53
action_169 (64) = happyShift action_54
action_169 (66) = happyShift action_55
action_169 (70) = happyShift action_56
action_169 (91) = happyShift action_57
action_169 (95) = happyShift action_58
action_169 (96) = happyShift action_59
action_169 (102) = happyShift action_27
action_169 (103) = happyShift action_60
action_169 (29) = happyGoto action_33
action_169 (30) = happyGoto action_34
action_169 (40) = happyGoto action_35
action_169 (41) = happyGoto action_36
action_169 (42) = happyGoto action_37
action_169 (43) = happyGoto action_38
action_169 (44) = happyGoto action_39
action_169 (45) = happyGoto action_40
action_169 (46) = happyGoto action_41
action_169 (47) = happyGoto action_42
action_169 (48) = happyGoto action_43
action_169 (49) = happyGoto action_44
action_169 (50) = happyGoto action_45
action_169 (51) = happyGoto action_46
action_169 (52) = happyGoto action_179
action_169 (53) = happyGoto action_48
action_169 (54) = happyGoto action_49
action_169 (55) = happyGoto action_50
action_169 _ = happyFail (happyExpListPerState 169)

action_170 (63) = happyShift action_178
action_170 _ = happyFail (happyExpListPerState 170)

action_171 _ = happyReduce_43

action_172 (63) = happyShift action_177
action_172 _ = happyFail (happyExpListPerState 172)

action_173 _ = happyReduce_45

action_174 _ = happyReduce_35

action_175 (88) = happyShift action_29
action_175 (89) = happyShift action_30
action_175 (93) = happyShift action_31
action_175 (97) = happyShift action_32
action_175 (35) = happyGoto action_176
action_175 (37) = happyGoto action_91
action_175 (57) = happyGoto action_88
action_175 _ = happyReduce_33

action_176 (63) = happyShift action_189
action_176 _ = happyFail (happyExpListPerState 176)

action_177 (58) = happyShift action_52
action_177 (62) = happyShift action_53
action_177 (64) = happyShift action_54
action_177 (66) = happyShift action_55
action_177 (70) = happyShift action_56
action_177 (88) = happyShift action_29
action_177 (89) = happyShift action_30
action_177 (91) = happyShift action_57
action_177 (92) = happyShift action_83
action_177 (93) = happyShift action_31
action_177 (94) = happyShift action_84
action_177 (95) = happyShift action_58
action_177 (96) = happyShift action_59
action_177 (97) = happyShift action_32
action_177 (98) = happyShift action_85
action_177 (99) = happyShift action_86
action_177 (102) = happyShift action_27
action_177 (103) = happyShift action_60
action_177 (29) = happyGoto action_33
action_177 (30) = happyGoto action_34
action_177 (38) = happyGoto action_188
action_177 (40) = happyGoto action_35
action_177 (41) = happyGoto action_36
action_177 (42) = happyGoto action_37
action_177 (43) = happyGoto action_38
action_177 (44) = happyGoto action_39
action_177 (45) = happyGoto action_40
action_177 (46) = happyGoto action_41
action_177 (47) = happyGoto action_42
action_177 (48) = happyGoto action_43
action_177 (49) = happyGoto action_44
action_177 (50) = happyGoto action_45
action_177 (51) = happyGoto action_46
action_177 (52) = happyGoto action_81
action_177 (53) = happyGoto action_48
action_177 (54) = happyGoto action_49
action_177 (55) = happyGoto action_50
action_177 (57) = happyGoto action_82
action_177 _ = happyFail (happyExpListPerState 177)

action_178 (58) = happyShift action_52
action_178 (62) = happyShift action_53
action_178 (64) = happyShift action_54
action_178 (66) = happyShift action_55
action_178 (70) = happyShift action_56
action_178 (88) = happyShift action_29
action_178 (89) = happyShift action_30
action_178 (91) = happyShift action_57
action_178 (92) = happyShift action_83
action_178 (93) = happyShift action_31
action_178 (94) = happyShift action_84
action_178 (95) = happyShift action_58
action_178 (96) = happyShift action_59
action_178 (97) = happyShift action_32
action_178 (98) = happyShift action_85
action_178 (99) = happyShift action_86
action_178 (102) = happyShift action_27
action_178 (103) = happyShift action_60
action_178 (29) = happyGoto action_33
action_178 (30) = happyGoto action_34
action_178 (38) = happyGoto action_187
action_178 (40) = happyGoto action_35
action_178 (41) = happyGoto action_36
action_178 (42) = happyGoto action_37
action_178 (43) = happyGoto action_38
action_178 (44) = happyGoto action_39
action_178 (45) = happyGoto action_40
action_178 (46) = happyGoto action_41
action_178 (47) = happyGoto action_42
action_178 (48) = happyGoto action_43
action_178 (49) = happyGoto action_44
action_178 (50) = happyGoto action_45
action_178 (51) = happyGoto action_46
action_178 (52) = happyGoto action_81
action_178 (53) = happyGoto action_48
action_178 (54) = happyGoto action_49
action_178 (55) = happyGoto action_50
action_178 (57) = happyGoto action_82
action_178 _ = happyFail (happyExpListPerState 178)

action_179 (76) = happyShift action_186
action_179 _ = happyFail (happyExpListPerState 179)

action_180 (76) = happyShift action_185
action_180 _ = happyFail (happyExpListPerState 180)

action_181 _ = happyReduce_56

action_182 _ = happyReduce_55

action_183 (58) = happyShift action_52
action_183 (62) = happyShift action_53
action_183 (64) = happyShift action_54
action_183 (66) = happyShift action_55
action_183 (70) = happyShift action_56
action_183 (91) = happyShift action_57
action_183 (96) = happyShift action_59
action_183 (102) = happyShift action_27
action_183 (103) = happyShift action_60
action_183 (29) = happyGoto action_33
action_183 (30) = happyGoto action_34
action_183 (40) = happyGoto action_35
action_183 (41) = happyGoto action_36
action_183 (42) = happyGoto action_37
action_183 (43) = happyGoto action_38
action_183 (44) = happyGoto action_39
action_183 (45) = happyGoto action_40
action_183 (46) = happyGoto action_41
action_183 (47) = happyGoto action_42
action_183 (48) = happyGoto action_43
action_183 (49) = happyGoto action_44
action_183 (50) = happyGoto action_184
action_183 (53) = happyGoto action_48
action_183 (54) = happyGoto action_49
action_183 (55) = happyGoto action_50
action_183 _ = happyFail (happyExpListPerState 183)

action_184 _ = happyReduce_92

action_185 _ = happyReduce_41

action_186 _ = happyReduce_42

action_187 (90) = happyShift action_191
action_187 _ = happyFail (happyExpListPerState 187)

action_188 _ = happyReduce_44

action_189 (99) = happyShift action_190
action_189 _ = happyFail (happyExpListPerState 189)

action_190 (36) = happyGoto action_193
action_190 _ = happyReduce_36

action_191 (58) = happyShift action_52
action_191 (62) = happyShift action_53
action_191 (64) = happyShift action_54
action_191 (66) = happyShift action_55
action_191 (70) = happyShift action_56
action_191 (88) = happyShift action_29
action_191 (89) = happyShift action_30
action_191 (91) = happyShift action_57
action_191 (92) = happyShift action_83
action_191 (93) = happyShift action_31
action_191 (94) = happyShift action_84
action_191 (95) = happyShift action_58
action_191 (96) = happyShift action_59
action_191 (97) = happyShift action_32
action_191 (98) = happyShift action_85
action_191 (99) = happyShift action_86
action_191 (102) = happyShift action_27
action_191 (103) = happyShift action_60
action_191 (29) = happyGoto action_33
action_191 (30) = happyGoto action_34
action_191 (38) = happyGoto action_192
action_191 (40) = happyGoto action_35
action_191 (41) = happyGoto action_36
action_191 (42) = happyGoto action_37
action_191 (43) = happyGoto action_38
action_191 (44) = happyGoto action_39
action_191 (45) = happyGoto action_40
action_191 (46) = happyGoto action_41
action_191 (47) = happyGoto action_42
action_191 (48) = happyGoto action_43
action_191 (49) = happyGoto action_44
action_191 (50) = happyGoto action_45
action_191 (51) = happyGoto action_46
action_191 (52) = happyGoto action_81
action_191 (53) = happyGoto action_48
action_191 (54) = happyGoto action_49
action_191 (55) = happyGoto action_50
action_191 (57) = happyGoto action_82
action_191 _ = happyFail (happyExpListPerState 191)

action_192 _ = happyReduce_46

action_193 (58) = happyShift action_52
action_193 (62) = happyShift action_53
action_193 (64) = happyShift action_54
action_193 (66) = happyShift action_55
action_193 (70) = happyShift action_56
action_193 (88) = happyShift action_29
action_193 (89) = happyShift action_30
action_193 (91) = happyShift action_57
action_193 (92) = happyShift action_83
action_193 (93) = happyShift action_31
action_193 (94) = happyShift action_84
action_193 (95) = happyShift action_58
action_193 (96) = happyShift action_59
action_193 (97) = happyShift action_32
action_193 (98) = happyShift action_85
action_193 (99) = happyShift action_86
action_193 (101) = happyShift action_194
action_193 (102) = happyShift action_27
action_193 (103) = happyShift action_60
action_193 (29) = happyGoto action_33
action_193 (30) = happyGoto action_34
action_193 (38) = happyGoto action_100
action_193 (40) = happyGoto action_35
action_193 (41) = happyGoto action_36
action_193 (42) = happyGoto action_37
action_193 (43) = happyGoto action_38
action_193 (44) = happyGoto action_39
action_193 (45) = happyGoto action_40
action_193 (46) = happyGoto action_41
action_193 (47) = happyGoto action_42
action_193 (48) = happyGoto action_43
action_193 (49) = happyGoto action_44
action_193 (50) = happyGoto action_45
action_193 (51) = happyGoto action_46
action_193 (52) = happyGoto action_81
action_193 (53) = happyGoto action_48
action_193 (54) = happyGoto action_49
action_193 (55) = happyGoto action_50
action_193 (57) = happyGoto action_82
action_193 _ = happyFail (happyExpListPerState 193)

action_194 _ = happyReduce_32

happyReduce_26 = happySpecReduce_1  29 happyReduction_26
happyReduction_26 (HappyTerminal (PT _ (TI happy_var_1)))
	 =  HappyAbsSyn29
		 ((read ( happy_var_1)) :: Integer
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  30 happyReduction_27
happyReduction_27 (HappyTerminal (PT _ (TD happy_var_1)))
	 =  HappyAbsSyn30
		 ((read ( happy_var_1)) :: Double
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  31 happyReduction_28
happyReduction_28 (HappyTerminal (PT _ (T_Id happy_var_1)))
	 =  HappyAbsSyn31
		 (Id (happy_var_1)
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  32 happyReduction_29
happyReduction_29 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn32
		 (AbsCpp.PDefs (reverse happy_var_1)
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_0  33 happyReduction_30
happyReduction_30  =  HappyAbsSyn33
		 ([]
	)

happyReduce_31 = happySpecReduce_2  33 happyReduction_31
happyReduction_31 (HappyAbsSyn34  happy_var_2)
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_31 _ _  = notHappyAtAll 

happyReduce_32 = happyReduce 8 34 happyReduction_32
happyReduction_32 (_ `HappyStk`
	(HappyAbsSyn36  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn35  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn31  happy_var_2) `HappyStk`
	(HappyAbsSyn57  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn34
		 (AbsCpp.DFun happy_var_1 happy_var_2 happy_var_4 (reverse happy_var_7)
	) `HappyStk` happyRest

happyReduce_33 = happySpecReduce_0  35 happyReduction_33
happyReduction_33  =  HappyAbsSyn35
		 ([]
	)

happyReduce_34 = happySpecReduce_1  35 happyReduction_34
happyReduction_34 (HappyAbsSyn37  happy_var_1)
	 =  HappyAbsSyn35
		 ((:[]) happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  35 happyReduction_35
happyReduction_35 (HappyAbsSyn35  happy_var_3)
	_
	(HappyAbsSyn37  happy_var_1)
	 =  HappyAbsSyn35
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_0  36 happyReduction_36
happyReduction_36  =  HappyAbsSyn36
		 ([]
	)

happyReduce_37 = happySpecReduce_2  36 happyReduction_37
happyReduction_37 (HappyAbsSyn38  happy_var_2)
	(HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn36
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_37 _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_2  37 happyReduction_38
happyReduction_38 (HappyAbsSyn31  happy_var_2)
	(HappyAbsSyn57  happy_var_1)
	 =  HappyAbsSyn37
		 (AbsCpp.ADecl happy_var_1 happy_var_2
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_2  38 happyReduction_39
happyReduction_39 _
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn38
		 (AbsCpp.SExp happy_var_1
	)
happyReduction_39 _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  38 happyReduction_40
happyReduction_40 _
	(HappyAbsSyn31  happy_var_2)
	(HappyAbsSyn57  happy_var_1)
	 =  HappyAbsSyn38
		 (AbsCpp.SDecl happy_var_1 happy_var_2
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happyReduce 5 38 happyReduction_41
happyReduction_41 (_ `HappyStk`
	(HappyAbsSyn39  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn31  happy_var_2) `HappyStk`
	(HappyAbsSyn57  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn38
		 (AbsCpp.SDecls happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_42 = happyReduce 5 38 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyAbsSyn40  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn31  happy_var_2) `HappyStk`
	(HappyAbsSyn57  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn38
		 (AbsCpp.SInit happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_43 = happySpecReduce_3  38 happyReduction_43
happyReduction_43 _
	(HappyAbsSyn40  happy_var_2)
	_
	 =  HappyAbsSyn38
		 (AbsCpp.SReturn happy_var_2
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happyReduce 5 38 happyReduction_44
happyReduction_44 ((HappyAbsSyn38  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn40  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn38
		 (AbsCpp.SWhile happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_45 = happySpecReduce_3  38 happyReduction_45
happyReduction_45 _
	(HappyAbsSyn36  happy_var_2)
	_
	 =  HappyAbsSyn38
		 (AbsCpp.SBlock (reverse happy_var_2)
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happyReduce 7 38 happyReduction_46
happyReduction_46 ((HappyAbsSyn38  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn40  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn38
		 (AbsCpp.SIfElse happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_47 = happySpecReduce_0  39 happyReduction_47
happyReduction_47  =  HappyAbsSyn39
		 ([]
	)

happyReduce_48 = happySpecReduce_1  39 happyReduction_48
happyReduction_48 (HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn39
		 ((:[]) happy_var_1
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  39 happyReduction_49
happyReduction_49 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn39
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  40 happyReduction_50
happyReduction_50 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EInt happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  40 happyReduction_51
happyReduction_51 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EDouble happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  40 happyReduction_52
happyReduction_52 _
	 =  HappyAbsSyn40
		 (AbsCpp.ETrue
	)

happyReduce_53 = happySpecReduce_1  40 happyReduction_53
happyReduction_53 _
	 =  HappyAbsSyn40
		 (AbsCpp.EFalse
	)

happyReduce_54 = happySpecReduce_3  40 happyReduction_54
happyReduction_54 _
	(HappyAbsSyn40  happy_var_2)
	_
	 =  HappyAbsSyn40
		 (happy_var_2
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happyReduce 4 41 happyReduction_55
happyReduction_55 (_ `HappyStk`
	(HappyAbsSyn40  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn40  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn40
		 (AbsCpp.EIndex happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_56 = happyReduce 4 41 happyReduction_56
happyReduction_56 (_ `HappyStk`
	(HappyAbsSyn56  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn40  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn40
		 (AbsCpp.EFuncall happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_57 = happySpecReduce_3  41 happyReduction_57
happyReduction_57 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EProject happy_var_1 happy_var_3
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  41 happyReduction_58
happyReduction_58 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EStruc happy_var_1 happy_var_3
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_2  41 happyReduction_59
happyReduction_59 _
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EPIncr happy_var_1
	)
happyReduction_59 _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_2  41 happyReduction_60
happyReduction_60 _
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EPDecr happy_var_1
	)
happyReduction_60 _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  41 happyReduction_61
happyReduction_61 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_2  42 happyReduction_62
happyReduction_62 (HappyAbsSyn40  happy_var_2)
	_
	 =  HappyAbsSyn40
		 (AbsCpp.EIncr happy_var_2
	)
happyReduction_62 _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_2  42 happyReduction_63
happyReduction_63 (HappyAbsSyn40  happy_var_2)
	_
	 =  HappyAbsSyn40
		 (AbsCpp.EDecr happy_var_2
	)
happyReduction_63 _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_2  42 happyReduction_64
happyReduction_64 (HappyAbsSyn40  happy_var_2)
	_
	 =  HappyAbsSyn40
		 (AbsCpp.EDefren happy_var_2
	)
happyReduction_64 _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_2  42 happyReduction_65
happyReduction_65 (HappyAbsSyn40  happy_var_2)
	_
	 =  HappyAbsSyn40
		 (AbsCpp.ENegat happy_var_2
	)
happyReduction_65 _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_1  42 happyReduction_66
happyReduction_66 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_66 _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  43 happyReduction_67
happyReduction_67 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.ETimes happy_var_1 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_3  43 happyReduction_68
happyReduction_68 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EDiv happy_var_1 happy_var_3
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  43 happyReduction_69
happyReduction_69 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EDRemd happy_var_1 happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_1  43 happyReduction_70
happyReduction_70 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_70 _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_3  44 happyReduction_71
happyReduction_71 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EPlus happy_var_1 happy_var_3
	)
happyReduction_71 _ _ _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_3  44 happyReduction_72
happyReduction_72 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EMinus happy_var_1 happy_var_3
	)
happyReduction_72 _ _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_1  44 happyReduction_73
happyReduction_73 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_73 _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_3  45 happyReduction_74
happyReduction_74 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EShiftLeft happy_var_1 happy_var_3
	)
happyReduction_74 _ _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  45 happyReduction_75
happyReduction_75 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EShiftRight happy_var_1 happy_var_3
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  45 happyReduction_76
happyReduction_76 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_76 _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_3  46 happyReduction_77
happyReduction_77 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.ELt happy_var_1 happy_var_3
	)
happyReduction_77 _ _ _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_3  46 happyReduction_78
happyReduction_78 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EGt happy_var_1 happy_var_3
	)
happyReduction_78 _ _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_3  46 happyReduction_79
happyReduction_79 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.ELtEq happy_var_1 happy_var_3
	)
happyReduction_79 _ _ _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_3  46 happyReduction_80
happyReduction_80 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EGtWq happy_var_1 happy_var_3
	)
happyReduction_80 _ _ _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_1  46 happyReduction_81
happyReduction_81 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_81 _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_3  47 happyReduction_82
happyReduction_82 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EEq happy_var_1 happy_var_3
	)
happyReduction_82 _ _ _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_3  47 happyReduction_83
happyReduction_83 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.ENEq happy_var_1 happy_var_3
	)
happyReduction_83 _ _ _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  47 happyReduction_84
happyReduction_84 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_3  48 happyReduction_85
happyReduction_85 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EAnd happy_var_1 happy_var_3
	)
happyReduction_85 _ _ _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  48 happyReduction_86
happyReduction_86 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_3  49 happyReduction_87
happyReduction_87 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EOr happy_var_1 happy_var_3
	)
happyReduction_87 _ _ _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_1  49 happyReduction_88
happyReduction_88 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_88 _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_3  50 happyReduction_89
happyReduction_89 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EAss happy_var_1 happy_var_3
	)
happyReduction_89 _ _ _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_3  50 happyReduction_90
happyReduction_90 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EAssP happy_var_1 happy_var_3
	)
happyReduction_90 _ _ _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_3  50 happyReduction_91
happyReduction_91 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (AbsCpp.EAssM happy_var_1 happy_var_3
	)
happyReduction_91 _ _ _  = notHappyAtAll 

happyReduce_92 = happyReduce 5 50 happyReduction_92
happyReduction_92 ((HappyAbsSyn40  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn40  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn40  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn40
		 (AbsCpp.ECond happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_93 = happySpecReduce_1  50 happyReduction_93
happyReduction_93 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_93 _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_2  51 happyReduction_94
happyReduction_94 (HappyAbsSyn40  happy_var_2)
	_
	 =  HappyAbsSyn40
		 (AbsCpp.EThrow happy_var_2
	)
happyReduction_94 _ _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_1  51 happyReduction_95
happyReduction_95 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_95 _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_1  52 happyReduction_96
happyReduction_96 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_96 _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_1  53 happyReduction_97
happyReduction_97 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_97 _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_1  54 happyReduction_98
happyReduction_98 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_98 _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_1  55 happyReduction_99
happyReduction_99 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_99 _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_0  56 happyReduction_100
happyReduction_100  =  HappyAbsSyn56
		 ([]
	)

happyReduce_101 = happySpecReduce_1  56 happyReduction_101
happyReduction_101 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn56
		 ((:[]) happy_var_1
	)
happyReduction_101 _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_3  56 happyReduction_102
happyReduction_102 (HappyAbsSyn56  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn56
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_102 _ _ _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_1  57 happyReduction_103
happyReduction_103 _
	 =  HappyAbsSyn57
		 (AbsCpp.Tbool
	)

happyReduce_104 = happySpecReduce_1  57 happyReduction_104
happyReduction_104 _
	 =  HappyAbsSyn57
		 (AbsCpp.Tdouble
	)

happyReduce_105 = happySpecReduce_1  57 happyReduction_105
happyReduction_105 _
	 =  HappyAbsSyn57
		 (AbsCpp.Tint
	)

happyReduce_106 = happySpecReduce_1  57 happyReduction_106
happyReduction_106 _
	 =  HappyAbsSyn57
		 (AbsCpp.Tvoid
	)

happyNewToken action sts stk [] =
	action 105 105 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 58;
	PT _ (TS _ 2) -> cont 59;
	PT _ (TS _ 3) -> cont 60;
	PT _ (TS _ 4) -> cont 61;
	PT _ (TS _ 5) -> cont 62;
	PT _ (TS _ 6) -> cont 63;
	PT _ (TS _ 7) -> cont 64;
	PT _ (TS _ 8) -> cont 65;
	PT _ (TS _ 9) -> cont 66;
	PT _ (TS _ 10) -> cont 67;
	PT _ (TS _ 11) -> cont 68;
	PT _ (TS _ 12) -> cont 69;
	PT _ (TS _ 13) -> cont 70;
	PT _ (TS _ 14) -> cont 71;
	PT _ (TS _ 15) -> cont 72;
	PT _ (TS _ 16) -> cont 73;
	PT _ (TS _ 17) -> cont 74;
	PT _ (TS _ 18) -> cont 75;
	PT _ (TS _ 19) -> cont 76;
	PT _ (TS _ 20) -> cont 77;
	PT _ (TS _ 21) -> cont 78;
	PT _ (TS _ 22) -> cont 79;
	PT _ (TS _ 23) -> cont 80;
	PT _ (TS _ 24) -> cont 81;
	PT _ (TS _ 25) -> cont 82;
	PT _ (TS _ 26) -> cont 83;
	PT _ (TS _ 27) -> cont 84;
	PT _ (TS _ 28) -> cont 85;
	PT _ (TS _ 29) -> cont 86;
	PT _ (TS _ 30) -> cont 87;
	PT _ (TS _ 31) -> cont 88;
	PT _ (TS _ 32) -> cont 89;
	PT _ (TS _ 33) -> cont 90;
	PT _ (TS _ 34) -> cont 91;
	PT _ (TS _ 35) -> cont 92;
	PT _ (TS _ 36) -> cont 93;
	PT _ (TS _ 37) -> cont 94;
	PT _ (TS _ 38) -> cont 95;
	PT _ (TS _ 39) -> cont 96;
	PT _ (TS _ 40) -> cont 97;
	PT _ (TS _ 41) -> cont 98;
	PT _ (TS _ 42) -> cont 99;
	PT _ (TS _ 43) -> cont 100;
	PT _ (TS _ 44) -> cont 101;
	PT _ (TI happy_dollar_dollar) -> cont 102;
	PT _ (TD happy_dollar_dollar) -> cont 103;
	PT _ (T_Id happy_dollar_dollar) -> cont 104;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 105 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = (thenM)
happyReturn :: () => a -> Err a
happyReturn = (returnM)
happyThen1 m k tks = (thenM) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (returnM) a
happyError' :: () => ([(Token)], [String]) -> Err a
happyError' = (\(tokens, _) -> happyError tokens)
pProgram tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn32 z -> happyReturn z; _other -> notHappyAtAll })

pListDef tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_1 tks) (\x -> case x of {HappyAbsSyn33 z -> happyReturn z; _other -> notHappyAtAll })

pDef tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_2 tks) (\x -> case x of {HappyAbsSyn34 z -> happyReturn z; _other -> notHappyAtAll })

pListArg tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_3 tks) (\x -> case x of {HappyAbsSyn35 z -> happyReturn z; _other -> notHappyAtAll })

pListStm tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_4 tks) (\x -> case x of {HappyAbsSyn36 z -> happyReturn z; _other -> notHappyAtAll })

pArg tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_5 tks) (\x -> case x of {HappyAbsSyn37 z -> happyReturn z; _other -> notHappyAtAll })

pStm tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_6 tks) (\x -> case x of {HappyAbsSyn38 z -> happyReturn z; _other -> notHappyAtAll })

pListId tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_7 tks) (\x -> case x of {HappyAbsSyn39 z -> happyReturn z; _other -> notHappyAtAll })

pExp15 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_8 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp14 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_9 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp13 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_10 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp12 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_11 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp11 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_12 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp10 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_13 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp9 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_14 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp8 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_15 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp4 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_16 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp3 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_17 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp2 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_18 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp1 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_19 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_20 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp5 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_21 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp6 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_22 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pExp7 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_23 tks) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

pListExp tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_24 tks) (\x -> case x of {HappyAbsSyn56 z -> happyReturn z; _other -> notHappyAtAll })

pType tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_25 tks) (\x -> case x of {HappyAbsSyn57 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    t:_ -> " before `" ++ id(prToken t) ++ "'"

myLexer = tokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 15 "<built-in>" #-}
{-# LINE 1 "/usr/local/Cellar/ghc/8.4.4/lib/ghc-8.4.4/include/ghcversion.h" #-}
















{-# LINE 16 "<built-in>" #-}
{-# LINE 1 "/var/folders/mt/qrqp6c_s57bf8gt7k2fh64wc0000gn/T/ghc9115_0/ghc_2.h" #-}





















































































































































































{-# LINE 17 "<built-in>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 










{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList








{-# LINE 65 "templates/GenericTemplate.hs" #-}


{-# LINE 75 "templates/GenericTemplate.hs" #-}










infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action


{-# LINE 137 "templates/GenericTemplate.hs" #-}


{-# LINE 147 "templates/GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

