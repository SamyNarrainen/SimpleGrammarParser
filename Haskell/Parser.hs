--------------------------------------------------------------------
-- Simple Grammar Parser 
-- Created: April 2015, Samy Narrainen               
-- Description: Parses a grammar using an abstracted version of a 
--              pushdown automata.       
-------------------------------------------------------------------- 

module Parser where 
import Char
import Grammar
import Stack

type Input = [String]

--Simple interface for providing a String the parser expects
genInput :: String -> Input
genInput []     = []
genInput (x:xs) = ('t':[x]) : genInput xs

--'Brute Force' attempt to parse an Input (String) according to a Grammar
parse :: Input -> Grammar -> Bool
parse i g = parseAux i g (push s [])

parseAux :: Input -> Grammar -> Stack -> Bool
parseAux [] _ [] = True
parseAux i (nTerm, term, p, s) stack
	--The stack is empty, but there is still input => False
	| isEmpty stack && not (isEmpty i) = False
	| isEmpty stack && isEmpty i       = True
	| not (isEmpty stack) && isEmpty i = False
	--It's a nonTerm, so find the rules for it
	| isNonTerm (fst (pop stack))              = parseAux2 i (nTerm, term, p, s) (snd (pop stack)) (findRules (head i) (getRules (getPRule (fst (pop stack)) p))) 
	| isNonTerm (fst (pop stack)) && isEmpty i = parseAux2 i (nTerm, term, p, s) (snd (pop stack)) (findRules "n" []) 
	--It's a terminal, so pop against the input and continue
	| isTerm (fst (pop stack))         = if (head i) == fst (pop stack) then parseAux (tail i) (nTerm, term, p, s) (snd (pop stack)) else False
	--TODO ADD CHECK FOR LAMBDA AT THE END OF INPUT ON PRODUCTION RULE

--Given a list of rules, attempts them
parseAux2 :: Input -> Grammar -> Stack -> [Rule] -> Bool
parseAux2 i g stack []     = False --Rules exausted 
parseAux2 i g stack (r:rs) = if parseAux i g (pushRule (reverse r) stack) 
	                         then True 
	                         else parseAux2 i g stack rs


findRules :: Terminal -> [Rule] -> [Rule] 
findRules term [] = []
findRules term (r:rs) 
	--If the first part of the rule is the terminaal term
	--If all the rules are nonTerminals then all are potentially viable
	| term == head r || not (contains False (map isNonTerm r)) = r : findRules term rs
	| otherwise                                                = findRules term rs
--findRules "ta" (getRules (getPRule "nS" pRules1))
