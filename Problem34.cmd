@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 34
:: Find the sum of all numbers which are equal to the sum of the factorial
:: of their digits.

SET _Fac0=1
FOR /L %%G IN (1,1,9) DO (
	SET /A _Prev=%%G-1
	IF !_Prev! GTR 1 (
		SET /A _Fac%%G=_Fac!_Prev!*%%G
	) ELSE SET _Fac%%G=%%G
)

SET _Max=2540160
SET _Dig1=0
SET _Dig2=1
SET _Len=2
SET _Answer=0

:Loop
SET _Sum=0
SET _Num=
FOR /L %%G IN (%_Len%,-1,1) DO (
	SET _Dig=!_Dig%%G!
	CALL SET _FacAdd=%%_Fac!_Dig!%%
	SET /A _Sum+=_FacAdd
	IF DEFINED _Num (
		SET _Num=!_Num!!_Dig%%G!
	) ELSE SET _Num=!_Dig%%G!
)

IF %_Sum% EQU %_Num% (
	REM Found one!
	ECHO:%_Num%
	SET /A _Answer+=%_Num%
	SET _IncrIndex=1
	CALL :Increment
) ELSE IF %_Sum% GTR %_Num% (
	REM Increment the second-least significant digit
	SET _Dig1=0
	SET _IncrIndex=2
	CALL :Increment
) ELSE IF %_Sum% LSS %_Num% (
	REM Increment the least significant digit
	SET _IncrIndex=1
	CALL :Increment
)

IF %_Num% LEQ %_Max% GOTO Loop

ECHO:Answer is %_Answer%

GOTO :EOF

:Increment

	SET /A _Dig!_IncrIndex!+=1
	CALL SET _DigChk=%%_Dig!_IncrIndex!%%
	IF !_DigChk! GTR 9 (
		SET _Dig!_IncrIndex!=0
		SET /A _IncrIndex+=1
		IF !_IncrIndex! GTR !_Len! SET _Len=!_IncrIndex!
		CALL :Increment
	) ELSE SET _Dig!_IncrIndex!=!_DigChk!

GOTO :EOF