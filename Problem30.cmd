@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 30
:: Find the sum of all the numbers that can be written as the sum of 
:: fifth powers of their digits.

:: First, let's get the fifth power of each digit...
SET _0=0
SET _1=1
FOR /L %%G IN (2,1,9) DO (
	SET _%%G=%%G
	FOR /L %%H IN (2,1,5) DO SET /A _%%G*=%%G
)

:: This question asks for what values...

::		a*10^4 + b*10^3 + c*10^2 + d*10^1 + e*10^0 = 
::			a^5 + b^5 + c^5 + d^5 + e^5

:: We can rule out seven-digit numbers because 9^5=59049, and
:: 59049*7=413343, which is less than 1000000 - it's mathematically
:: impossible to represent a 7-digit number as a sum of seven powers
:: of five. Additionally, six powers of five can only go up to (9^5)*6,
:: or 354294. The problem also says it has to be a sum, so it has to be
:: at least two digits, so that gives us a range of 10-354294.

SET _Answer=0
FOR /L %%G IN (10,1,354294) DO (
	SET _SumFive=0
	SET _Int=%%G
	FOR %%H IN (0,1,2,3,4,5,6,7,8,9) DO SET _Int=!_Int:%%H=%%H !
	FOR %%H IN (!_Int!) DO SET /A _SumFive+=_%%H
	IF !_SumFive! EQU %%G (
		ECHO:Found a match: !_SumFive!
		SET /A _Answer+=!_SumFive!
	)
)

ECHO:The answer is %_Answer%

ENDLOCAL
GOTO :EOF