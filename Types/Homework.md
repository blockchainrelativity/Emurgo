---TYPES---
test in your REPL
	3^2
    2^3
    x=4^2
	x
	(^) 4 2
	((^)4) 2

bonus:
	(\x -> x^2) 3


Complete the type (non polymorphic).
	task :: 
	task dividend divisor = dividend / divisor
Test it
	task 3 4
	task 5 2
	task 5.5 3.3

How many positions after the decimal you get?

Now do it again, but with a polymorphic type

Complete the type (polymorphic).
	task :: 
	task dividend divisor = dividend / divisor
Test it
	task 3 4
	task 5 2

Compare results.

---LIST---

test in your REPL

	x=[1,2,3,4,5,6,7,8,9,10]
	y=1:2:3:4:5:6:7:8:9:10 

Did we miss something in the second example? (Fix it!)
After fixing it, try this

	x == y
	y == x
	x /= y
	
Do you feel you understand the answers?

Lets create a list
	g=1
	h=2
	i=100
	
	g:h:i:g:h:i:[]
	
	x + y

Now lets add some sugar

  x=[1..11]
  y=[10..100]
  x
  y
	



Now, some "flight withn instruments" (aviation analogy...)

1. Create a function that takes as inputs 2 numbers and gives as output the substraction of the SECOND number from the FIRST number

2. Create a function that takes as input 2 numbers and gives as output the FIRST number to the power of the SECOND number.

3. Create a function that takes as input 3 numbers and provides as output the adition of the 3

4. Create a  non polymorphic function that takes as input 4 strings and provides as output a LIST of them.

5. Create a polymorphic function that takes as inputs 5 numbers and provides as output a LIST of them.


 