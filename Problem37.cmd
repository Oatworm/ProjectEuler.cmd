@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 37
:: Find the sum of the only eleven primes that are both truncatable from left
:: to right and right to left.

:: What we know... 
::		1. Any prime starting or ending with 1 is out
::		2. Any prime with an even number is out, unless it starts with 2
::		3. Any prime with 5 is out unless it starts with 5
::		4. 3797, 797, and 37 are truncatable.
::
:: What we don't know...
::		1. How high we have to go to find all eleven primes.
::
:: Strategy: Find primes 1<x<=250000. See how many truncatable primes we find.
:: If we're not to 11, find primes 250000<x<=500000 and check them, and so on.

SET `2=1
SET _Min=3
SET _Max=0
SET _AddBy=250000
SET _Count=0
SET _Answer=0

:Loop

	SET /A _Max+=_AddBy
	IF %_Count% LSS 11 (
		SET _OldMin=!_Min!
		CALL :FindPrimes
		FOR /F "delims=`=" %%G IN ('SET `') DO (
			IF %%G GEQ !_OldMin! (
				CALL :IsTrunctable %%G _Result
				IF !_Result! EQU 1 (
					ECHO:%%G is trunctable
					SET /A _Count+=1
					SET /A _Answer+=%%G
				)
			)
		)
	) ELSE GOTO ExitLoop
	
	IF %_Count% LSS 11 GOTO Loop

:ExitLoop

ECHO:Answer is %_Answer%

GOTO :EOF

:FindPrimes
REM Using globally scoped variables so we can access primes later

	ECHO:Calculating primes %_Min% to %_Max%...
	REM Preparing memory...
	FOR /L %%G IN (%_Min%,2,%_Max%) DO SET `%%G=1

	REM Sieve with existing primes...
	FOR /F "delims=`=" %%G IN ('SET `') DO (
		IF %%G LSS %_Min% (
			SET /A _Rem=_Min %% %%G
			SET /A _Start=_Min-_Rem+%%G
			FOR /L %%H IN (!_Start!,%%G,%_Max%) DO IF DEFINED `%%H SET `%%H=
		)
	)

	REM Find new primes...
	FOR /L %%G IN (%_Min%,2,%_Max%) DO (
		SET _NewMin=%%G
		IF DEFINED `%%G (
			SET /A _Start=%%G+%%G
			FOR /L %%H IN (!_Start!,%%G,%_Max%) DO IF DEFINED `%%H SET `%%H=
		)
	)

	SET _Min=%_NewMin%

GOTO :EOF

:IsTrunctable
SETLOCAL EnableDelayedExpansion

	SET _Prime=%1
	SET _PrimeStr=%1
	
	:: Let's rule out the obvious...
	:: Starting or ending with one is out
	IF "%_Prime:~0,1%"=="1" (
		ENDLOCAL & SET %2=0&GOTO :EOF
	)
	IF "%_Prime:~-1%"=="1" (
		ENDLOCAL & SET %2=0&GOTO :EOF
	)
	
	:: No 0,4,6,8 allowed
	FOR %%G IN (0,4,6,8) DO SET _PrimeStr=!_PrimeStr:%%G=%%G !
	IF NOT "%_PrimeStr%"=="%_Prime%" (
		ENDLOCAL & SET %2=0&GOTO :EOF
	)
	
	:: 2 or 5 only allowed if they're at the start
	SET _PrimeStr=%_Prime:~1%
	FOR %%G IN (2,5) DO SET _PrimeStr=!_PrimeStr:%%G=%%G !
	IF NOT "%_PrimeStr%"=="%_Prime:~1%" (
		ENDLOCAL & SET %2=0&GOTO :EOF
	)
	
	:: Still there? Then we have work to do. 
	:: First, we need the length of the prime.
	SET _PrimeLen=-1
	SET _PrimeStr=%_Prime%
	FOR %%G IN (1,2,3,5,7,9) DO SET _PrimeStr=!_PrimeStr:%%G=%%G !
	FOR %%G IN (%_PrimeStr%) DO SET /A _PrimeLen+=1
	
	:: It's just a jump to the left...
	FOR /L %%G IN (1,1,%_PrimeLen%) DO (
		SET _PrimeChk=!_Prime:~%%G!
		IF NOT DEFINED `!_PrimeChk! (
			ENDLOCAL & SET %2=0&GOTO :EOF
		)
	)
	
	:: And then a step to the right!
	FOR /L %%G IN (%_PrimeLen%,-1,1) DO (
		SET _PrimeChk=!_Prime:~0,%%G!
		IF NOT DEFINED `!_PrimeChk! (
			ENDLOCAL & SET %2=0&GOTO :EOF
		)
	)

ENDLOCAL & SET %2=1
GOTO :EOF