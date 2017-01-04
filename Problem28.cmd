@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 28
:: What is the sum of the numbers on the diagonals in a 1001x1001 spiral?

:: Don't need to create the entire spiral - just care about the four arms:
:: NE: +(8n)
:: NW: +(8n-2)
:: SW: +(8n-4)
:: SE: +(8n-6)
:: Each arm, in turn, is 500 numbers long. Once summed, add them all up, 
:: then add the middle.

SET _ne=1
SET _nw=1
SET _sw=1
SET _se=1
SET _Sum=1
FOR /L %%G IN (1,1,500) DO (
	SET /A _8n=8*%%G
	SET /A _ne=_ne+_8n
	SET /A _nw=_nw+_8n-2
	SET /A _sw=_sw+_8n-4
	SET /A _se=_se+_8n-6
	SET /A _Sum=_Sum+_ne+_nw+_sw+_se
)

ECHO:Answer is %_Sum%