@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 4
:: Find the largest palindrome made from the product of two 3-digit numbers

SET _mul=0
SET _res=0
FOR /L %%G IN (999,-1,100) DO (
	FOR /L %%H IN (%%G,-1,100) DO (
		SET /A _mul=%%G*%%H
		IF !_mul! GEQ 100001 (
			SET _mull=!_mul:~0,3!
			SET _mulr=!_mul:~-1,1!!_mul:~-2,1!!_mul:~-3,1!
			IF !_mull! EQU !_mulr! (
				IF !_mul! GTR !_res! SET _res=!_mul!
			)
		)
	)
)

ECHO:%_res%
