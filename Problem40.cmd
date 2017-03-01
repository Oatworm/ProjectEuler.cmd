@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 40
:: Find the value of the following expression:
:: d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000

:: Difficulty: Can't use the simple way - variables only good up to 8192 chars
:: in Batch, including variable name. So we're going to have to get clever...

SET _DCount=1
SET _NextD=1
SET _Num=1
SET _DMax=1000000
SET _Answer=1

:Loop

	IF %_DCount% GEQ %_NextD% (
		REM Grab the desired digit...
		SET /A _Index=_DCount-_NextD
		CALL SET _CharN=%%_Num:~!_Index!,1%%
		ECHO:D%_NextD%=!_CharN! [%_Num%]
		SET /A _Answer*=_CharN
		
		REM Go to the next one...
		SET /A _NextD*=10
		IF !_NextD! GTR %_DMax% GOTO ExitLoop
	)
	
	CALL :GetLen %_Num% _Len
	SET /A _Num+=1
	SET /A _DCount+=_Len
	GOTO Loop

:ExitLoop

ECHO:%_Answer% [%_Num%]

GOTO :EOF

:GetLen
SETLOCAL EnableDelayedExpansion

	SET _Str=%1
	SET _Len=0
	FOR %%G IN (1,2,3,4,5,6,7,8,9,0) DO SET _Str=!_Str:%%G=%%G !
	FOR %%G IN (%_Str%) DO SET /A _Len+=1
	
ENDLOCAL & SET %2=%_Len%
GOTO :EOF