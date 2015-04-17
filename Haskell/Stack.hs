--------------------------------------------------------------------
-- Simple Grammar Parser 
-- Created: April 2015, Samy Narrainen                      
-------------------------------------------------------------------- 

module Stack where 
import Char

push :: a -> [a] -> [a]
push a stack = a : stack 

pop :: [a] -> (a, [a])
pop []    = error "Out of bounds: the stack is empty."
pop stack = (head stack, tail stack)
