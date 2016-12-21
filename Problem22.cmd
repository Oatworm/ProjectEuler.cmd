@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 22
:: What is the total of all the name scores in p022_names.txt?

:: NOTE: The name file is too big for CMD to parse natively as one line due to
:: CMD's 31 token limit and CMD's 8192 character/line limit. For this script to
:: run, the source file needs to have commas converted to newline characters
:: first. In Notepad++, this is pretty trivial (CTRL+H; find ,; replace \n).

:: First, sort the file, parse out quotation marks, and count how many 
:: names we have.
SET _Count=0
FOR /F %%G IN ('SORT p022_names.txt') DO (
	SET /A _Count+=1
	SET _TmpStr=%%G 
	SET _TmpStr=!_TmpStr:"=!
	SET _Str!_Count!=!_TmpStr!
)

:: Next, split each word apart into individual characters.
FOR /L %%G IN (1,1,%_Count%) DO (
	FOR %%H IN (A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) DO (
		SET _Str%%G=!_Str%%G:%%H=%%H !
	)
)

:: Finally, do the math.
SET _Total=0
FOR /L %%G IN (1,1,%_Count%) DO (
	SET _Sum%%G=0
	FOR %%H IN (!_Str%%G!) DO (
		IF "%%H"=="A" SET /A _Sum%%G+=1
		IF "%%H"=="B" SET /A _Sum%%G+=2
		IF "%%H"=="C" SET /A _Sum%%G+=3
		IF "%%H"=="D" SET /A _Sum%%G+=4
		IF "%%H"=="E" SET /A _Sum%%G+=5
		IF "%%H"=="F" SET /A _Sum%%G+=6
		IF "%%H"=="G" SET /A _Sum%%G+=7
		IF "%%H"=="H" SET /A _Sum%%G+=8
		IF "%%H"=="I" SET /A _Sum%%G+=9
		IF "%%H"=="J" SET /A _Sum%%G+=10
		IF "%%H"=="K" SET /A _Sum%%G+=11
		IF "%%H"=="L" SET /A _Sum%%G+=12
		IF "%%H"=="M" SET /A _Sum%%G+=13
		IF "%%H"=="N" SET /A _Sum%%G+=14
		IF "%%H"=="O" SET /A _Sum%%G+=15
		IF "%%H"=="P" SET /A _Sum%%G+=16
		IF "%%H"=="Q" SET /A _Sum%%G+=17
		IF "%%H"=="R" SET /A _Sum%%G+=18
		IF "%%H"=="S" SET /A _Sum%%G+=19
		IF "%%H"=="T" SET /A _Sum%%G+=20
		IF "%%H"=="U" SET /A _Sum%%G+=21
		IF "%%H"=="V" SET /A _Sum%%G+=22
		IF "%%H"=="W" SET /A _Sum%%G+=23
		IF "%%H"=="X" SET /A _Sum%%G+=24
		IF "%%H"=="Y" SET /A _Sum%%G+=25
		IF "%%H"=="Z" SET /A _Sum%%G+=26
	)
	SET /A _Sum%%G*=%%G
	SET /A _Total+=_Sum%%G
	REM ECHO:%%G :: !_Str%%G! :: !_Sum%%G! :: !_Total!
)

ECHO:Answer is !_Total!.

ENDLOCAL 
GOTO :EOF