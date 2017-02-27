@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 35
:: How many circular primes are there below one million?

SET _Max=1000000
ECHO:Preparing memory...
FOR /L %%G IN (3,2,%_Max%) DO SET `%%G=1

ECHO:Calculating primes...
FOR /L %%G IN (3,2,%_Max%) DO (
	IF DEFINED `%%G (
		SET /A _Start=%%G+%%G
		FOR /L %%H IN (!_Start!,%%G,%_Max%) DO IF DEFINED `%%H SET `%%H=
	)
)

ECHO:Removing primes with even digits and fives from consideration...
FOR /F "delims=`=" %%G IN ('SET `') DO (
	FOR %%H IN (0,2,4,5,6,8) DO (
		SET _ChkEven=%%G
		SET _ChkEven=!_ChkEven:%%H=%%H !
		IF NOT "!_ChkEven!"=="%%G" SET `%%G=
	)
)

:: Now for the hard work
ECHO:Finding circular primes...
FOR /F "delims=`=" %%G IN ('SET `') DO (
	CALL :DimStr %%G _Str _Len
	SET _List=
	SET _PrimeChk=%%G
	SET _NotCircular=
	FOR /L %%H IN (1,1,!_Len!) DO (
		IF NOT DEFINED `!_PrimeChk! SET _NotCircular=1
		IF NOT DEFINED _NotCircular (
			SET _List=!_List! !_PrimeChk!
		) ELSE (
			SET `!_PrimeChk!=
		)
		CALL :Circle _Str _PrimeChk
	)
	IF DEFINED _NotCircular (
		FOR %%H IN (!_List!) DO SET `%%H=
	)
)

ECHO:Counting circular primes...
SET _Answer=2
FOR /F "delims=`=" %%G IN ('SET `') DO (
	SET /A _Answer+=1
	ECHO:%%G is circular
)

ECHO:Answer is %_Answer%

GOTO :EOF

:Circle
SETLOCAL EnableDelayedExpansion

	SET _String=!%1!
	
	SET _Len=0
	FOR %%G IN (%_String%) DO (
		SET /A _Len+=1
		SET _StringArray_!_Len!=%%G
	)

	:: Circle the string by moving each digit one to the left.
	SET _String=
	SET _Num=
	FOR /L %%G IN (2,1,%_Len%) DO (
		IF DEFINED _String (
			SET _String=!_String! !_StringArray_%%G!
			SET _Num=!_Num!!_StringArray_%%G!
		) ELSE (
			SET _String=!_StringArray_%%G!
			SET _Num=!_StringArray_%%G!
		)
	)
	
	SET _String=!_String! !_StringArray_1!
	SET _Num=!_Num!!_StringArray_1!

ENDLOCAL & SET %1=%_String%& SET %2=%_Num%
GOTO :EOF

:DimStr
SETLOCAL EnableDelayedExpansion
	SET _DimArg=%1
	SET _DimLen=0
	
	FOR %%G IN (1,3,7,9) DO SET _DimArg=!_DimArg:%%G=%%G !
	FOR %%G IN (%_DimArg%) DO SET /A _DimLen+=1

ENDLOCAL & SET %2=%_DimArg%& SET %3=%_DimLen%
GOTO :EOF