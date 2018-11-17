module L01B where
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


------ lecture L01B 6:01

