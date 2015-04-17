--------------------------------------------------------------------
-- Simple Grammar Parser 
-- Created: April 2015, Samy Narrainen                      
-------------------------------------------------------------------- 

module Grammar where 
import Char

type NonTerminal     = String
type Terminal        = String
type Rule            = [String] --Encoded as [ta,nR,tb]
type ProductionRule  = (NonTerminal, [Rule]) --Encoded as ("S", [[ta,nR,tb], ["tb","nQ"]])
type Grammar         = ([NonTerminal], [Terminal], [ProductionRule], NonTerminal)

lambda :: Terminal
lambda = "tLAMBDA"

addPRule :: ProductionRule -> [ProductionRule] -> [ProductionRule]
addPRule rule rules = rule : rules 


{- Verification Functions -}

--The non/terms need to be present in the grammar to be a valid rule
verifyRule :: Rule -> Grammar -> Bool
verifyRule [] g = True
verifyRule (rule:rules) (nTerm, term, p, s)
	| head rule == 'n' && contains (tail rule) nTerm = verifyRule rules (nTerm, term, p, s)
	| head rule == 't' && contains (tail rule) term  = verifyRule rules (nTerm, term, p, s)
	| otherwise                                      = False
--verifyRule ["ta","nS","tb"] g1


{- Show Functions -}
-------------------------------------------------------------------- 
showPRule :: ProductionRule -> String
showPRule (nTerm, [r]) = nTerm ++ " -> " ++ showRule r
showPRule (nTerm, rs) = nTerm ++ " -> " ++ showRules rs
--showPRule ("P", [["ta","nS","tb"], [lambda])
--map showPRule [("P", [["ta","nS","tb"]]), ("Q", [["ta","nS","tb"]])]

showPRules :: [ProductionRule] -> String
showPRules [r]    = "\t" ++ showPRule r
showPRules (r:rs) = "\t" ++ showPRule r ++ "\n" ++ showPRules rs
showPRules _      = ""

showRule :: Rule -> String
showRule [r]    = tail r
showRule (r:rs) = tail r ++ showRule rs
showRule _      = ""

showRules :: [Rule] -> String 
showRules [r] = showRule r
showRules (r:rs) = showRule r ++ " | " ++ showRules rs
showRules _      = ""

showGrammar :: Grammar -> String
showGrammar (nTerm, term, p, s) = "N = " ++ show nTerm ++ "\n" ++ "T = " ++ show term ++ "\n"
                                  ++ "P = \n" ++ showPRules p ++ "\n" ++ "S = " ++ s
{- Test Input -}
-------------------------------------------------------------------- 
g1 :: Grammar 
g1 = (["S", "P", "Q", "R"], ["a","b","c"], pRules1, "S")

pRules1 :: [ProductionRule]
pRules1 = [("S", [["ta","nP"],["tb","nQ"]]), ("P", [["ta"],["tc"]]), ("Q", [["ta","nS"],["tc"]])]

{- Indirect Functionality -}
-------------------------------------------------------------------- 
contains :: Eq a => a -> [a] -> Bool
contains a []     = False
contains a (x:xs) = if a == x then True else contains a xs
