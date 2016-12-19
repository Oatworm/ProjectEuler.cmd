@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 21
:: Evaluate the sum of all the amicable numbers under 10000

FOR /L %%G IN (1,1,5000) DO (
	SET /A First=%%G+%%G
	FOR /L %%H IN (!First!,%%G,10000) DO (
		IF DEFINED _Sum%%H (
			SET /A _Sum%%H+=%%G
		) ELSE SET _Sum%%H=%%G
	)
)

SET _AmicableSum=0
FOR /L %%G IN (1,1,10000) DO (
	IF DEFINED _Sum%%G (
		SET AmicableIndex=!_Sum%%G!
		CALL SET AmicableChk=%%_Sum!AmicableIndex!%%
		IF "%%G"=="!AmicableChk!" (
			IF %%G NEQ !AmicableIndex! SET /A _AmicableSum+=%%G
		)
	)
)

ECHO:Sum is %_AmicableSum%.

ENDLOCAL
GOTO :EOF