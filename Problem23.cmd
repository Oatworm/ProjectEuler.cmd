@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 23
:: Find the sum of all the positive integers which cannot be written as the sum
:: of two abundant numbers.

:: First, factor all numbers between 1-28123.
:: We'll just keep an array of factors for later use.
ECHO:Factoring...
FOR /L %%G IN (1,1,14062) DO (
	SET /A _Start=%%G+%%G
	FOR /L %%H IN (!_Start!,%%G,28123) DO (
		IF DEFINED _Factor%%H (
			SET _Factor%%H=!_Factor%%H! %%G
		) ELSE SET _Factor%%H=%%G
	)
)

:: Next, find all abundant numbers... 
ECHO:Finding abundant numbers...
FOR /L %%G IN (1,1,28123) DO (
	SET _Sum%%G=0
	FOR %%H IN (!_Factor%%G!) DO SET /A _Sum%%G+=%%H
	IF DEFINED _Sum%%G IF !_Sum%%G! GTR %%G SET _Abundant$%%G=1
	SET _ChkAbundant$%%G=1
)

:: Then find all sums of abundant numbers...
ECHO:Finding sums of abundant numbers...
FOR /L %%G IN (12,1,28123) DO (
	IF DEFINED _Abundant$%%G (
		SET /A _Max=28123-%%G
		FOR /L %%H IN (%%G,1,!_Max!) DO (
			IF DEFINED _Abundant$%%H (
				SET /A _SumAbundant=%%G+%%H
				IF DEFINED _ChkAbundant$!_SumAbundant! (
					SET _ChkAbundant$!_SumAbundant!=
					REM ECHO:!_SumAbundant! is the sum of abundant numbers %%G and %%H
				)
			)
		)
	)
)

:: Now sum the ones that aren't.
ECHO:Summing numbers that aren't sums of abundant numbers...
SET _Answer=0
FOR /F "tokens=2 delims=$=" %%G IN ('SET _ChkAbundant') DO (
	REM ECHO:%%G is not abundant.
	SET /A _Answer+=%%G
)

ECHO:The answer is !_Answer!

ENDLOCAL
GOTO :EOF