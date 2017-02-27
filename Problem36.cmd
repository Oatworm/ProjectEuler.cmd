@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 36
:: Find the sum of all numbers, less than one million, which are palindromic in
:: base 10 and base 2.

:: Strategy: Find base-10 palindromes, convert to base-2, check for palindrome.
:: Going to do this by generating palindromes, instead of checking 1-999999.
:: Three cases, given X'=X reversed:
:: 		1. All X<10 are decimal palindromes - convert to binary and check.
::		2. All X<=99 can be combined X[0-9]X' to create palindromes.
::		3. All X<=999 can be combined XX' to create palindromes.

SET _Answer=0
FOR /L %%G IN (1,1,999) DO (

	IF %%G LSS 10 (
		CALL :DecToBin %%G _BinG
		CALL :IsPalindrome !_BinG! _IsP
		IF !_IsP! EQU 1 SET /A _Answer+=%%G
		REM IF !_IsP! EQU 1 ECHO:%%G :: !_BinG!
	)
	
	CALL :GetLen %%G _Len
	SET _Left=%%G
	SET _Right=
	
	FOR /L %%H IN (-1,-1,-!_Len!) DO (
		SET _Char=!_Left:~%%H,1!
		IF DEFINED _Right (
			SET _Right=!_Right!!_Char!
		) ELSE SET _Right=!_Char!
	)
	
	IF %%G LSS 99 (
		FOR /L %%H IN (0,1,9) DO (
			SET _DecPal=!_Left!%%H!_Right!
			CALL :DecToBin !_DecPal! _BinG
			CALL :IsPalindrome !_BinG! _IsP
			IF !_IsP! EQU 1 SET /A _Answer+=!_DecPal!
			REM IF !_IsP! EQU 1 ECHO:!_DecPal! :: !_BinG!
		)
	)
	
	SET _DecPal=!_Left!!_Right!
	CALL :DecToBin !_DecPal! _BinG
	CALL :IsPalindrome !_BinG! _IsP
	IF !_IsP! EQU 1 SET /A _Answer+=!_DecPal!
	REM IF !_IsP! EQU 1 ECHO:!_DecPal! :: !_BinG!
)

ECHO:Answer is %_Answer%

GOTO :EOF

:DecToBin
SETLOCAL EnableDelayedExpansion

	SET _Dec=%1
	SET _BinPow=524288
	SET _Bin=
	SET _Len=20
	
	FOR /L %%G IN (1,1,20) DO (
		IF %_Dec% LSS !_BinPow! (
			SET /A "_BinPow>>=1"
			SET /A _Len=20-%%G
		)
	)

	FOR /L %%G IN (1,1,%_Len%) DO (
		IF !_Dec! GEQ !_BinPow! (
			IF DEFINED _Bin (
				SET _Bin=!_Bin!1
			) ELSE SET _Bin=1
			SET /A _Dec-=_BinPow
			SET /A "_BinPow>>=1"
		) ELSE (
			SET _Bin=!_Bin!0
			SET /A "_BinPow>>=1"
		)
	)

ENDLOCAL & SET %2=%_Bin%
GOTO :EOF

:IsPalindrome
SETLOCAL EnableDelayedExpansion

	SET _Num=%1
	CALL :GetLen %_Num% _Len
	SET /A _Half=_Len/2
	SET /A _Odd=_Len %% 2
	SET /A _Half+=_Odd
	CALL SET _Left=%%_Num:~0,%_Half%%%
	CALL SET _Right=%%_Num:~-%_Half%%%
	
	FOR /L %%G IN (-1,-1,-%_Half%) DO (
		SET _Char=!_Left:~%%G,1!
		IF DEFINED _RLeft (
			SET _RLeft=!_RLeft!!_Char!
		) ELSE SET _RLeft=!_Char!
	)
	
	IF "%_RLeft%"=="%_Right%" (
		SET _IsPalindrome=1
	) ELSE SET _IsPalindrome=0

ENDLOCAL & SET %2=%_IsPalindrome%
GOTO :EOF

:GetLen
SETLOCAL EnableDelayedExpansion

	SET _Str=%1
	SET _Len=0
	
	FOR %%G IN (1,2,3,4,5,6,7,8,9,0) DO SET _Str=!_Str:%%G=%%G !
	FOR %%G IN (%_Str%) DO SET /A _Len+=1

ENDLOCAL & SET %2=%_Len%
GOTO :EOF