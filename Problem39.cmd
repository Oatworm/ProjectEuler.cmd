@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 39

:: If p is the perimeter of a right angle triangle with integral length sides, 
:: {a,b,c}, there are exactly three solutions for p = 120: {20,48,52}, 
:: {24,45,51}, {30,40,50}. For which value of p ≤ 1000, is the number of 
:: solutions maximised?

:: Level of difficulty: Square roots? What are those?

FOR /L %%A IN (1,1,333) DO (
	SET /A _BMax=1000-%%A
	SET /A _BMax/=2
	SET /A _A2=%%A*%%A
	FOR /L %%B IN (%%A,1,!_BMax!) DO (
		SET /A _B2=%%B*%%B
		SET /A _CMin=%%B+1
		SET /A _CMax=%%A+%%B
		SET /A _CMaxAlt=1000-%%A-%%B
		IF !_CMax! GTR !_CMaxAlt! SET _CMax=!_CMaxAlt!
		FOR /L %%C IN (!_CMin!,1,!_CMax!) DO (
			SET /A _C2=%%C*%%C
			SET /A _A2B2=_A2+_B2
			IF !_A2B2! EQU !_C2! (
				SET /A _Perimeter=%%A+%%B+%%C
				IF DEFINED _T!_Perimeter! (
					SET /A _T!_Perimeter!+=1
				) ELSE SET _T!_Perimeter!=1
				ECHO:{%%A,%%B,%%C}=!_Perimeter!
			)
		)
	)
)

SET _Answer=1
SET _Max=1
FOR /F "tokens=2,3 delims=T=" %%G IN ('SET _T') DO (
	IF %%H GTR !_Max! (
		SET _Answer=%%G
		SET _Max=%%H
	)
)

ECHO:%_Answer%