@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 42
:: How mahy words in words.txt are triangle words?

:: First, let's get some triangle numbers.
SET _T1=1
FOR /L %%G IN (2,1,40) DO (
	SET /A _T%%G=%%G+1
	SET /A _T%%G*=%%G
	SET /A _T%%G/=2
)

SET _Answer=0
FOR /F %%G IN (p042_words.txt) DO (
	SET _Str=%%G
	SET _Str=!_Str:"=!
	CALL :GetLen !_Str! _Len
	SET _StrTotal=0
	
	REM Sum the letter scores
	FOR /L %%H IN (0,1,!_Len!) DO (
		SET _Char=!_Str:~%%H,1!
		CALL :AlphaCase !_Char! _Num
		SET /A _StrTotal+=_Num
	)
	
	REM Compare the score to the triangle numbers
	FOR /L %%H IN (1,1,40) DO (
		IF !_T%%H! EQU !_StrTotal! SET /A _Answer+=1
	)
)

ECHO:%_Answer%

GOTO :EOF

:AlphaCase
SETLOCAL EnableDelayedExpansion

	IF "%1"=="A" SET _Case=1
	IF "%1"=="B" SET _Case=2
	IF "%1"=="C" SET _Case=3
	IF "%1"=="D" SET _Case=4
	IF "%1"=="E" SET _Case=5
	IF "%1"=="F" SET _Case=6
	IF "%1"=="G" SET _Case=7
	IF "%1"=="H" SET _Case=8
	IF "%1"=="I" SET _Case=9
	IF "%1"=="J" SET _Case=10
	IF "%1"=="K" SET _Case=11
	IF "%1"=="L" SET _Case=12
	IF "%1"=="M" SET _Case=13
	IF "%1"=="N" SET _Case=14
	IF "%1"=="O" SET _Case=15
	IF "%1"=="P" SET _Case=16
	IF "%1"=="Q" SET _Case=17
	IF "%1"=="R" SET _Case=18
	IF "%1"=="S" SET _Case=19
	IF "%1"=="T" SET _Case=20
	IF "%1"=="U" SET _Case=21
	IF "%1"=="V" SET _Case=22
	IF "%1"=="W" SET _Case=23
	IF "%1"=="X" SET _Case=24
	IF "%1"=="Y" SET _Case=25
	IF "%1"=="Z" SET _Case=26

ENDLOCAL & SET %2=%_Case%
GOTO :EOF

:GetLen
SETLOCAL EnableDelayedExpansion
	SET _Str=%1
	SET _Len=-1

	FOR %%G IN (A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) DO (
		SET _Str=!_Str:%%G=%%G !
	)
	FOR %%G IN (%_Str%) DO SET /A _Len+=1

ENDLOCAL & SET %2=%_Len%
GOTO :EOF