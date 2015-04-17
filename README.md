# SimpleGrammarParser

## Motivation
Having a tool to automatically check whether or not a word is in the language of a regular/context free language would have been quite useful whilst I was studying them. A few months later, I decided to make one anyway. 

## What is a Grammar?
Essentially, it provides similar functionality to RegEx

## How to use

### Generating a Grammar

#### Encoding 
All instances of nonterminal have 'n' appended to them and terminals 't'. Example: 
Nonterminal S = `nS`
Terminal    a = `ta`

This looks ugly, but it makes parsing a lot easier, I plan to implement a way of abstracting this.

With this in mind, we can generate a grammar (regular or context free) as so 

```
rules :: [ProductionRule]
rules = [("nS", [["ta","nP"],["tb","nQ"]]), ("nP", [["ta"],["tc"]]), ("nQ", [["ta","nS"],["tc"]])]

grammar :: Grammar 
grammar = (["nS", "nP", "nQ", "nR"], ["ta","tb","tc"], rules, "nS")
```

#### Viewing
We can use `putStr (showGrammar grammar)` to produce: 
```
N = ["S","P","Q","R"]
T = ["a","b","c"]
P = 
	S -> aP | bQ
	P -> a | c
	Q -> aS | c
S = S
```

### Parsing a Grammar
Using `parse (genInput "aa") grammar` we can parse our grammar to any input String. You will notice this would produce `True` as it is indeed a valid word in the language of 'grammar'.



