@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 14
:: The following sequence is defined for the set of positive integers:
:: n -> n/2 if n is even
:: n -> 3n+1 if n is odd
:: Which starting number, under one million, produces the longest chain?

:: NOTE: This script overwhelms CMD's recursion stack, which supports up to 
:: 455 recursions (we need at 525). To get around this, go here:
:: http://people.sju.edu/~ggrevera/cscCV/stack/
:: Download editbin, copy the CMD binary from %systemroot%\system32 to the 
:: extracted folder, modify the binary, then re-run the script.

SET _MaxCount=0
SET _MaxChain=0
SET _Next1=1
SET _Count1=0

FOR /L %%G IN (1,1,999999) DO (
	CALL :CreateChain %%G
	ECHO:%%G :: !_Count%%G!
	IF !_Count%%G! GTR !_MaxCount! (
		SET _MaxCount=!_Count%%G!
		SET _MaxChain=%%G
	)
)

ECHO:
ECHO:%_MaxChain% has the longest chain with !_MaxCount! steps.
GOTO :EOF

:CreateChain
SET _Step=%1
IF %_Step% EQU 1 GOTO ChainDone

IF NOT DEFINED _Next%_Step% (
	IF NOT "%_Step:~8,1%"=="" (
		SET _IsBig=1
	) ELSE SET _IsBig=0
	
	IF !_IsBig! EQU 0 (
		SET /A _IsOdd=_Step %% 2
		IF !_IsOdd! EQU 1 (
			SET /A _Next%_Step% = _Step*3
			SET /A _Next%_Step% += 1
			CALL :CreateChain !_Next%_Step%!
		) ELSE (
			SET /A _Next%_Step% = _Step/2
			CALL :CreateChain !_Next%_Step%!
		)
	) ELSE (
		SET _IsOdd=%_Step:~-1%
		SET /A _IsOdd=_IsOdd %% 2
		IF !_IsOdd! EQU 1 (
			CALL :BigMul %_Step% 3 _Next%_Step%
			CALL :BigAdd1 !_Next%_Step%! _Next%_Step%
			CALL :CreateChain !_Next%_Step%!
		) ELSE (
			REM Multiplying by 5, then taking the 0 off the end
			REM Same as multiplying by 0.5 (or dividing by 2)
			CALL :BigMul %_Step% 5 _Next%_Step%
			CALL SET _Next%_Step% = !%_Next%_Step%:~0,-1%!
		)
	)
	
	IF DEFINED _Count!_Next%_Step%! (
		SET /A _Count%_Step%=_Count!_Next%_Step%!+1
	)
)
:ChainDone
GOTO :EOF

:BigMul
SETLOCAL EnableDelayedExpansion
:: Heavily simplified version of the integer-only algorithm used here:
:: http://www.robvanderwoude.com/files/multiply_3rdparty_bat.txt
:: Taking advantage of the fact we're only multiplying by 3 or 5.
	SET _BigNum=%1
	SET _MulBy=%2
	SET _Carry=
	
	FOR %%G IN (0,1,2,3,4,5,6,7,8,9) DO (
		SET _BigNum=!_BigNum:%%G=%%G !
	)
	
	FOR %%G IN (!_BigNum!) DO SET /A _BigCnt+=1 & SET _Big_!_BigCnt!=%%G
	FOR /L %%G IN (%_BigCnt%,-1,1) DO (
		SET /A _tmp=!_Big_%%G! * %_MulBy% !_Plus! !_Carry!
		SET _Carry=
		SET _Plus=
		IF !_tmp! GTR 9 SET _Carry=!_tmp:~0,1!& SET _tmp=!_tmp:~-1!& SET _Plus=+
		SET _MulResult=!_tmp!!_MulResult!
	)
	
	IF DEFINED _Carry SET _MulResult=!_Carry!!_MulResult!

ENDLOCAL & SET %3=%_MulResult%
GOTO :EOF

:BigAdd1
SETLOCAL EnableDelayedExpansion
:: Just need to add 1 to a really big number, so let's keep this simple...
	SET _BigNum=%1
	IF DEFINED _BigNum SET _Digit=%_BigNum:~-1,1%
	SET /A _Digit+=1
	IF %_Digit% EQU 10 (
		SET _BigNum=%_BigNum:~0,-1%
		SET _AddResult=!_AddResult!0
		IF DEFINED _BigNum (
			CALL :BigAdd1 !_BigNum! _AddResult
		) ELSE SET _AddResult=1!_AddResult!
	) ELSE (
		SET _AddResult=%_BigNum:~0,-1%%_Digit%!_AddResult!
	)
ENDLOCAL & SET %2=%_AddResult%
GOTO :EOF