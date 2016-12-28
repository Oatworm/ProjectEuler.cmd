@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 26
:: Find the value of d < 1000 for which 1/d contains the longest recurring
:: cycle in its decimal fraction part.

:: Prime numbers seem to be the ones with unique recurring cycles, and loops
:: are expensive, so let's get some primes first.

FOR /L %%G IN (3,2,999) DO (
	SET /A _Next=%%G*2
	IF NOT DEFINED _IsPrime%%G (
		FOR /L %%H IN (!_Next!,%%G,999) DO (
			SET _IsPrime%%H=0
		)
		SET _IsPrime%%G=1
	)
)

:: Next, going to use a slightly modified version of this algorithm...
:: http://www.mathblog.dk/project-euler-26-find-the-value-of-d-1000-for-which-1d-contains-the-longest-recurring-cycle/

SET _Length=0
SET _Answer=0
FOR /L %%G IN (999,-2,3) DO (
	IF !_Length! GEQ %%G GOTO Done
	IF !_IsPrime%%G! EQU 1 (
		SET _Val=1
		SET _Pos=0
		FOR /L %%H IN (%%G,-1,0) DO (
			IF NOT DEFINED _FoundRemainders_%%G_!_Val! IF !_Val! NEQ 0 (
				SET _FoundRemainders_%%G_!_Val!=!_Pos!
				SET /A _Val*=10
				SET /A _Val%%=%%G
				SET /A _Pos+=1
			)
		)
		SET /A _LengthChk=_Pos-_FoundRemainders_%%G_!_Val!
		IF !_LengthChk! GTR !_Length! (
			SET _Length=!_LengthChk!
			SET _Answer=%%G
		)
	)
)

:Done

ECHO:The answer is !_Answer!, with a length of !_Length!.

GOTO :EOF