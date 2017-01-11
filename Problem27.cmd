@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 27
:: Find the product of the coefficients, a and b, for the quadratic expression
:: that produces the maximum number of primes for consecutive values of n, 
:: starting with n=0.

:: Cheated a bit by using the insights found here:
:: http://code.jasonbhill.com/sage/project-euler-problem-27/
:: 
:: 1. When n=0, n^2+an+b must create at least one prime, so b 
:: must be prime. 
:: 2. The answer has to be less than b, so assuming half of b is a prime 
:: sequence, the max value is 500^2 + 1000*500 + 1000 = 751000.

:: Note - As Problem 10 proved, this takes a while. To speed things up
:: slightly, debug statements have been removed since we know the code
:: works.

SET _MaxPrime=751000
SET _IsPrime1=1
SET _IsPrime2=1
ECHO:Allocating memory...
FOR /L %%G IN (3,2,%_MaxPrime%) DO SET _IsPrime%%G=1
ECHO:Calculating primes...
FOR /L %%G IN (3,2,%_MaxPrime%) DO (
	IF DEFINED _IsPrime%%G (
		SET /A _Next=%%G+%%G
		FOR /L %%H IN (!_Next!,%%G,%_MaxPrime%) DO IF DEFINED _IsPrime%%H SET _IsPrime%%H=
	)
)

ECHO:Finding consecutive primes...
SET _PMax=0
SET _MaxA=
SET _MaxB=
FOR /L %%A IN (-999,1,999) DO (
	FOR /L %%B IN (-1000,1,1000) DO (
		SET _Abs=%%B
		IF %%B LSS 0 SET _Abs=!_Abs:~1!
		IF DEFINED _IsPrime!_Abs! (
			SET _EndConsecutiveN=
			SET _PCount=0
			FOR /L %%N IN (0,1,1000) DO (
				IF NOT DEFINED _EndConsecutiveN (
					SET /A _N2=%%N*%%N
					SET /A _AN=%%A*%%N
					SET /A _PCheck=_N2+_AN+%%B
					IF DEFINED _IsPrime!_PCheck! (
						SET /A _PCount+=1
					) ELSE SET _EndConsecutiveN=1
				)
			)
			IF !_PCount! GTR !_PMax! (
				SET _MaxA=%%A
				SET _MaxB=%%B
				SET _PMax=!_PCount!
			)
			REM Debugging...
			ECHO:A: %%A, B: %%B, PCount: !_PCount!, PMax: !_PMax!
		)
	)
)

:: Finally, find the product of the coefficients.
SET /A _Answer=_MaxA*_MaxB
ECHO:The product of the coefficients, !_MaxA! and !_MaxB!, is !_Answer!
