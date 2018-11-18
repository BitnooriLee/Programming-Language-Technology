module L01B where
import Test.QuickCheck

--Algebraic data types
--2018-11-17

--The Suit
data Suit = Spades | Hearts | Diamonds | Clubs
     deriving (Show,Eq)
data Colour = Red | Black
     deriving Show
     
colour :: Suit -> Colour
colour Spades = Black
colour Clubs = Black
colour _ = Red --don't care or not using

data Rank = Numeric Int | Jack | Queen | King | Ace
     deriving (Show, Eq, Ord)  -- ? 

--data Value = Two | Three | 

rankBeats :: Rank -> Rank -> Bool
rankBeats  r1 r2 = r1 > r2
--rankBeats = (>)


prop_rankBeats r1 r2 = r1 == r2 |+| r1 `rankBeats`  r2
                                      |+| r2 `rankBeats` r1

infixr 2 |+|
True |+| False = True
False |+| True = True
_ |+| _ = False

 -- constructor not compulsory to use same name
--date Card = Card Rank Suit 
 --    deriving (Show, Eq) 
--rank ( Card r _ ) = r
--suit ( Card _ s ) = r 

data Card = Card { rank :: Rank, suit :: Suit }

cardBeats :: Card -> Card -> Bool
--cardBeats = undefined
--cardBeats c1 c2 = suit c1 == suit c2 && rank  c1 `rankBeats` rank c2
cardBeats (Card r1 s1) (Card r2 s2) = s1 == s2 && r1 `rankBeats` r2

data Hand = Empty | Add Card Hand
     deriving Show
      
exHand1 = Add (Card Ace Hearts) Empty
exHand2 = Add (Card Ace Spades) exHand1

handBeats :: Hand -> Card -> Bool
handBeats Empty         c = False 
handBeats (Add c' h)   c = c' `cardBeats` c || handBeats h c

chooseCard :: Card -> Hand -> Hand
chooseCard beat (Add c Empty) = c
chooseCard beat (Add c rest)
           | bnb c c' = c
           | bnb c' c = c'
           | tnt c c' = c
           | tnt c' c = c'
           | otherwise = rankMin c c'
           where
                bnb c1 c2 | c1 `cardBeats` beat &&  not (c2 `cardBeats` beat)
                 tnt c1 c2 = suit c1 == suit beat && suit c2 /= suit beat

                c' = chooseCard beat rest
                rankMin c1 c2
                        | rankBeats (rank c1) (rank c2) = c2
                        | otherwise                                    = c1

prop_win c h = isNonEmpty  h ==>
               h `handBeats` c == chooseCard c h `cardBeats` c
         where isNonEmpty Empty  = False
               isNonEmpty  _          = True  

instance Arbitrary Suit where
          arbitrary = elements [Spades, Hearts, Diamonds, Clubs]

instance Arbitrary Rank where
         arbitrary =
                   oneof
                        [ do return c
                        | c <- [Jack, Queen, King, Ace]
                        ] ++
                        [ do n <- choose (2,10)
                             return (Numeric n)
                        ]


instance Arbitrary Card where
         arbitrary =
                   do r <- arbitrary
                      s <- arbitrary
                      return (Card r s)
instance Arbitrary Hand where
         arbitrary =
                   do cs  <- arbitrary
                      let hand []       = Empty
                          hand (c : cs) = Add c (hand  [  c' | c'  <- cs, c' /= c  ])
                      return (hand cs)
         shrink Empty  = []
         shrink  (Add c h) = h : map (Add c) (shrink)