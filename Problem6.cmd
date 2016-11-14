@ECHO OFF
:: Project Euler Problem 6

SETLOCAL EnableDelayedExpansion
SET _SumOfSquares=0
FOR /L %%G IN (1,1,100) DO (
	SET /A _square=%%G*%%G
	SET /A _SumOfSquares+=_square
)

SET _Sum=0
FOR /L %%H IN (1,1,100) DO SET /A _Sum+=%%H
SET /A _SquareSum=_Sum*_Sum

SET /A _Difference=_SquareSum-_SumOfSquares
ECHO:%_Difference%
