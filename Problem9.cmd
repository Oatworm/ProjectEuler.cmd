@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 9
:: A Pythagorean triplet is a set of three natural numbers, a < b < c, for which a^2 + b^2 = c^2.
:: There exists exactly one Pythagorean triplet for which a + b + c = 1000. Find the product abc.
:: Level of difficulty: CMD doesn't have a sqrt function.

FOR /L %%G IN (1,1,997) DO (
	SET /A _sq%%G=%%G*%%G
)

SET _a=
SET _b=
SET _c=
SET _sum=

:: Aw shucks, let's brute force it.
FOR /L %%H IN (1,1,332) DO (
	SET _a=%%H
	SET /a _bcount=_a+1
	SET /a _bmax=1000-_a
	SET /a _bmax/=2
	SET /a _c=1000-_bmax
	SET /a _c-=_a
	IF !_c! EQU !_bmax! SET /a _bmax-=1
	FOR /L %%I IN (!_bcount!,1,!_bmax!) DO (
		SET _b=%%I 
		SET /a _c=1000-_b
		SET /a _c-=_a
		SET /a _sum=_sq!_a!+_sq!_b!
		SET /a _csq=_sq!_c!
		IF !_sum! EQU !_csq! GOTO Break
	)
)

:Break
ECHO:a = %_a%, b = %_b%, c = %_c%
SET /a _result=_a*_b*_c
ECHO:Result = %_result%
