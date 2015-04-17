--------------------------------------------------------------------
-- Simple Grammar Parser 
-- Created: April 2015, Samy Narrainen                      
-------------------------------------------------------------------- 

module Stack where 
import Char
import Grammar

type Stack = [String]

push :: a -> [a] -> [a]
push a stack = a : stack 

pop :: [a] -> (a, [a])
pop []    = error "Out of bounds: the stack is empty."
pop ((:) x xs) = (x, xs)

isEmpty :: [a] -> Bool
isEmpty []    = True
isEmpty stack = False

pushRule :: Rule -> Stack -> Stack
pushRule [] stack     = stack
pushRule (x:xs) stack = pushRule xs (push x stack) 


--pushRule (reverse (head (findRules "ta" (getRules (getPRule "nS" pRules1))))) (push "" [])

--Main> pushRule (head (findRules "ta" (getRules (getPRule "nS" pRules1))))