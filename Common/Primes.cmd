@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Common function: Find primes

SET _Max=%1
ECHO:Preparing memory...
FOR /L %%G IN (3,2,%_Max%) DO SET `%%G=1

ECHO:Calculating primes...
FOR /L %%G IN (3,2,%_Max%) DO (
	IF DEFINED `%%G (
		SET /A _Start=%%G+%%G
		FOR /L %%H IN (!_Start!,%%G,%_Max%) DO IF DEFINED `%%H SET `%%H=
	)
)

:: Retrieve primes
FOR /F "delims=`=" %%G IN ('SET `') DO (
	ECHO:%%G
)