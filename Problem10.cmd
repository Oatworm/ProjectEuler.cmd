@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 10
:: Find the sum of all the primes below two million
:: Breaking this out into two FOR loops since CMD handles smaller FORs
:: better than large single FOR loops for whatever reason.
:: Also including ECHO debug statements that slow things down a bit.

SET _Max=2000000

SET _Sum=2
SET _Sum_0=0
SET _BigIndex=0

ECHO:Preparing memory...
FOR /L %%G IN (3,2,%_Max%) DO (
	SET `%%G=1
	SET _AllocDebug=%%G
	IF "!_AllocDebug:~-3!"=="999" ECHO:Allocating %%G
)

ECHO:Calculating primes...
FOR /L %%G IN (3,2,%_Max%) DO (
	IF DEFINED `%%G (
		SET /A _Start=%%G+%%G
		FOR /L %%H IN (!_Start!,%%G,%_Max%) DO IF DEFINED `%%H SET `%%H=
		ECHO:%%G is prime...
	)
)

ECHO:Calculating sum...
:: Start by getting as many large 32-bit numbers as possible
FOR /F "delims=`=" %%G IN ('SET `') DO (
	FOR /F "tokens=2 delims==" %%H IN ('SET _Sum_!_BigIndex!') DO SET _Var=%%H
	IF !_Var! LEQ 2100000000 (
		SET /A _Sum_!_BigIndex!+=%%G
	) ELSE (
		SET /A _BigIndex+=1
		SET /A _Sum_!_BigIndex!=%%G
	)
	ECHO:%%G :: !_BigIndex! :: !_Var!
)

:: Next, let's add all of them.
FOR /L %%G IN (0,1,%_BigIndex%) DO (
	ECHO:%%G of %_BigIndex% :: !_Sum! + !_Sum_%%G!
	CALL :ExtAdd !_Sum! !_Sum_%%G! _Sum
)

ECHO:Answer: %_Sum%

GOTO :EOF

:ExtAdd
	SETLOCAL EnableDelayedExpansion
	:: Used to add two arbitrary numbers together.
	:: Requires - :ExtMatchPad, :ExtDim
	:: Accepts three parameters:
	:: %1, %2 - The numbers to be added together (passed by value)
	:: %3 - The result (passed by reference)
	::
	:: Example invocation:
	:: CALL :ExtAdd %_Num1% %_Num2% _Result
	:: |--> Sums _Num1 and _Num2 and saves result in _Result

	SET _Add1=%1
	SET _Add2=%2
	SET _AddResult=
	SET _AddCarry=0
	SET _IntLen=1
	
	:ExtAddNums
	CALL :ExtDim %_Add1% _Add1Len _Add1Dec
	CALL :ExtDim %_Add2% _Add2Len _Add2Dec
	CALL :ExtMatchPad _Add1 _Add2 _AddLen _AddDec %_Add1Len% %_Add1Dec% %_Add2Len% %_Add2Dec%

	FOR /L %%G IN (%_AddLen%,-1,1) DO (
		SET /A _AddPos=%%G-1
		CALL SET _AddInt1=%%_Add1:~!_AddPos!,%_IntLen%%%
		CALL SET _AddInt2=%%_Add2:~!_AddPos!,%_IntLen%%%
		SET /A _AddByPos=_AddInt1+_AddInt2+_AddCarry
		IF !_AddByPos! GEQ 10 (
			SET _AddCarry=1
			SET /A _AddByPos-=10
		) ELSE (
			SET _AddCarry=0
		)
		SET _AddResult=!_AddByPos!!_AddResult!
	)

	IF %_AddCarry% EQU 1 SET _AddResult=1%_AddResult%

	:ExtAddReturnResult
	ENDLOCAL & SET %3=%_AddResult%
GOTO :EOF

:ExtMatchPad
	SETLOCAL EnableDelayedExpansion
	:: Used to match length and decimal position of two number strings
	:: Requires - :ExtPad, :ExtDim
	:: Accepts the following parameters (passed by reference):
	:: %1, %2 - Two numbers to match
	:: %3, %4 - Length and decimal position of padded numbers.
	::
	:: Optionally accepts the following (passed by value)
	:: %5, %6 - Length and decimal position of %1
	:: %7, %8 - Length and decimal position of %2
	::
	:: Example invocation:
	:: CALL :ExtMatchPad _Num1 _Num2
	:: |--> Makes _Num1 and _Num2 have the same length
	::      and decimal position
	:: So, 1234.5 and 1.2345 become 1234.5000 and 0001.2345.

	SET _MatchPad1=!%1!
	SET _MatchPad2=!%2!
	SET _MatchPadL=
	SET _MatchPadD=
	
	IF NOT [%8]==[] (
		SET _MatchPadL2=%7
		SET _MatchPadD2=%8
	) ELSE CALL :ExtDim %_MatchPad2% _MatchPadL2 _MatchPadD2
	
	IF NOT [%6]==[] (
		SET _MatchPadL1=%5
		SET _MatchPadD1=%6
	) ELSE CALL :ExtDim %_MatchPad1% _MatchPadL1 _MatchPadD1

	:: Add a decimal if one number has a decimal and the other doesn't.
	IF %_MatchPadD1% GTR %_MatchPadL1% (
		IF %_MatchPadD2% LEQ %_MatchPadL2% (
			CALL :ExtMakeFloat _MatchPad1 _MatchPadL1
		)
	)
	IF %_MatchPadD2% GTR %_MatchPadL2% (
		IF %_MatchPadD1% LEQ %_MatchPadL1% (
			CALL :ExtMakeFloat _MatchPad2 _MatchPadL2
		)
	)
	
	:: Pad number strings so they both line up.
	IF %_MatchPadD1% GTR %_MatchPadD2% (
		SET /A "_DPadLen=_MatchPadD1-_MatchPadD2"
		CALL :ExtPad _MatchPad2 !_DPadLen! L _MatchPadL2 _MatchPadD2
		SET _MatchPadD=!_MatchPadD1!
	)
	IF %_MatchPadD2% GTR %_MatchPadD1% (
		SET /A "_DPadLen=_MatchPadD2-_MatchPadD1"
		CALL :ExtPad _MatchPad1 !_DPadLen! L _MatchPadL1 _MatchPadD1
		SET _MatchPadD=!_MatchPadD2!
	)

	IF %_MatchPadL1% GTR %_MatchPadL2% (
		SET /A _LPadLen=_MatchPadL1-_MatchPadL2
		CALL :ExtPad _MatchPad2 !_LPadLen! R _MatchPadL2 _MatchPadD2
		SET _MatchPadL=!_MatchPadL1!
	)
	IF %_MatchPadL2% GTR %_MatchPadL1% (
		SET /A _LPadLen=_MatchPadL2-_MatchPadL1
		CALL :ExtPad _MatchPad1 !_LPadLen! R _MatchPadL1 _MatchPadD1
		SET _MatchPadL=!_MatchPadL2!
	)
	
	IF NOT DEFINED _MatchPadL SET _MatchPadL=%_MatchPadL1%
	IF NOT DEFINED _MatchPadD SET _MatchPadD=%_MatchPadD1%

	ENDLOCAL & SET %1=%_MatchPad1%& SET %2=%_MatchPad2%& SET %3=%_MatchPadL%& SET %4=%_MatchPadD%
GOTO :EOF

:ExtPad
	SETLOCAL EnableDelayedExpansion
	:: Used to pad a number to facilitate mathematical operations
	:: Accepts the following parameters:
	:: %1 - The variable that needs to be padded
	:: %2 - The number of positions to pad
	:: %3 - The direction the pad needs to be applied (L or R)
	:: %4 - Length variable - Returned with padded length
	:: %5 - Decimal variable - Returned with adjusted position
	::
	:: Example invocation:
	:: CALL :ExtPad _Num 5 L _Len _Dec
	:: |--> Returns padded length and decimal position in _Len & _Dec.
	:: |--> Returns padded number back in _Num

	SET _PadNum=!%1!
	SET /A _PadLength=%4
	SET /A _PadDecimal=%5
	IF %3==L (
		FOR /L %%G IN (1,1,%2) DO (
			SET _PadNum=0!_PadNum!
			SET /A _PadLength+=1
			SET /A _PadDecimal+=1
		)
	)
	IF %3==R (
		FOR /L %%G IN (1,1,%2) DO (
			SET _PadNum=!_PadNum!0
			SET /A _PadLength+=1
		)
	)
	ENDLOCAL & SET %1=%_PadNum%& SET /A %4=%_PadLength% & SET /A %5=%_PadDecimal%
GOTO :EOF	

:ExtDim
	SETLOCAL EnableDelayedExpansion
	:: Used to get the string length and decimal position of a number.
	:: Accepts three parameters:
	:: %1 - The number that needs its size and precision
	:: %2 - A variable in which the size is returned
	:: %3 - A variable in which the position of the decimal is returned
	:: Returns length and decimal position by reference.
	::
	:: Example invocation:
	:: CALL :ExtDim %_Num% _Len _Dec
	
	SET _DimLength=0
	SET _DimDecimal=-1
	SET _DimArg=%1
	
	FOR %%G IN (0,1,2,3,4,5,6,7,8,9,.) DO (
		SET _DimArg=!_DimArg:%%G=%%G !
	)
	
	FOR %%G IN (%_DimArg%) DO (
		SET /A _DimLength+=1
		IF "%%G"=="." (
			SET _DimDecimal=!_DimLength!
		)
	)

	IF %_DimDecimal% EQU -1 SET /A "_DimDecimal=_DimLength+1"
	ENDLOCAL & SET /A %2=%_DimLength% & SET /A %3=%_DimDecimal%
GOTO :EOF