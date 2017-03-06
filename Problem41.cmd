@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 41
:: What is the largest n-digit pandigital prime that exists?

SET _Max=1093474
ECHO:Preparing memory...
FOR /L %%G IN (3,2,%_Max%) DO SET `%%G=1

ECHO:Calculating primes...
FOR /L %%G IN (3,2,%_Max%) DO (
	IF DEFINED `%%G (
		SET /A _Start=%%G+%%G
		FOR /L %%H IN (!_Start!,%%G,%_Max%) DO IF DEFINED `%%H SET `%%H=
	)
)

:: Trying 7-digit pandigital numbers...
:: Using a GOTO so we don't divide by 80,000 primes each time.
SET _Answer=0
SET _Str=7654321
SET _Max=5039

:DoWhile
	IF !_Max! EQU 0 ( GOTO ExitWhile ) ELSE (
		ECHO:Trying !_Str!...
		SET _LastChar=!_Str:~-1!
		IF !_LastChar! NEQ 5 (
			SET /A _PossiblyPrime=_LastChar %% 2
		) ELSE SET _PossiblyPrime=0
		IF !_PossiblyPrime! NEQ 0 (
			REM Going to have to put our backs into it...
			SET /A _MaxFactor=_Str/7
			SET /A _MaxFactor+=1
			FOR /F "delims=`=" %%G IN ('SET `') DO (
				IF %%G LEQ !_MaxFactor! (
					SET /A _DivChk=_Str %% %%G
					IF !_DivChk! EQU 0 (
						REM Evenly divisible - not prime.
						CALL :Permute _Str
						SET /A _Max-=1
						GOTO DoWhile
					)
				)
			)
		) ELSE (
			CALL :Permute _Str
			SET /A _Max-=1
			GOTO DoWhile
		)
		
		REM If we made it this far, we found one!
		REM And since we're going high to low, we're done!
		IF !_Str! GTR !_Answer! (
			ECHO:********** !_Str! **********
			SET _Answer=!_Str!
		)
	)
:ExitWhile 

:: Did we find any 7-digit pans?
IF %_Answer% GTR 0 GOTO Answer

:: If not, time to look at four digit ones - but first, let's get rid of some
:: unneeded primes...
ECHO:No 7-digit pandigits found! Trying 4-digit pandigits...
SET /A _PrimeMax=617
FOR /F "delims=`=" %%G IN ('SET `') DO IF %%G GTR %_PrimeMax% SET `%%G=

:: Going to use a FOR loop on this one since the count is small
SET _Str=1234
FOR /L %%G IN (1,1,24) DO (
	SET _PossiblyPrime=1
	IF "!_Str:~-1!"=="2" SET _PossiblyPrime=0
	IF "!_Str:~-1!"=="4" SET _PossiblyPrime=0
	IF !_PossiblyPrime! EQU 1 (
		FOR /F "delims=`=" %%H IN ('SET `') DO (
			IF !_PossiblyPrime! EQU 1 (
				SET /A _DivChk=_Str %% %%H
				IF !_DivChk! EQU 0 SET _PossiblyPrime=0
			)
		)
		PAUSE
		REM Found one?
		IF !_PossiblyPrime! EQU 1 (
			IF !_Str! GTR !_Answer! SET _Answer=!_Str!
		)
	)
	
	CALL :Permute _Str
)

:Answer
ECHO:%_Answer%

GOTO :EOF

:Permute
SETLOCAL EnableDelayedExpansion

	SET _String=!%1!
	
	FOR %%G IN (1,2,3,4,5,6,7,8,9) DO (
		SET _String=!_String:%%G=%%G !
	)
	
	SET _Len=0
	FOR %%G IN (%_String%) DO (
		SET /A _Len+=1
		SET _StringArray_!_Len!=%%G
	)

	:: Find the largest index k such that a[k] > a[k + 1]. 
	:: If no such index exists, the permutation is the last permutation.
	SET _k=-1
	SET /A _LenM1=_Len-1
	FOR /L %%G IN (1,1,!_LenM1!) DO (
		SET /A _kP1=%%G+1
		CALL SET _StrNext=%%_StringArray_!_kP1!%%
		IF !_StringArray_%%G! GTR !_StrNext! SET _k=%%G
	)
	
	IF !_k! EQU -1 (
		REM On last permutation - return to original state.
		SET _NewLen=%_Len%
		FOR %%G IN (%_String%) DO (
			SET _StringArray_!_NewLen!=%%G
			SET /A _NewLen-=1
		)
	) ELSE (
		REM Find the largest index l greater than k such that a[k] > a[l].
		SET /A _kP1=_k+1
		CALL SET _StrK=%%_StringArray_!_k!%%
		FOR /L %%G IN (!_kP1!,1,%_Len%) DO (
			IF !_StrK! GTR !_StringArray_%%G! SET _l=%%G
		)
	
		REM Swap the value of a[k] with that of a[l].
		CALL SET _StrL=%%_StringArray_!_l!%%
		SET _StringArray_!_k!=!_StrL!
		SET _StringArray_!_l!=!_StrK!
	
		REM Reverse the sequence from a[k + 1] up to and including the final
		REM element a[n].
		SET _Back=%_Len%
		FOR /L %%G IN (!_kP1!,1,%_Len%) DO (
			IF !_Back! GTR %%G (
				SET _Swap=!_StringArray_%%G!
				CALL SET _StringArray_%%G=%%_StringArray_!_Back!%%
				SET _StringArray_!_Back!=!_Swap!
				SET /A _Back-=1
			)
		)
	)
	
	:: Rebuild the string
	SET _String=
	FOR /L %%G IN (1,1,%_Len%) DO (
		IF DEFINED _String (
			SET _String=!_String!!_StringArray_%%G!
		) ELSE SET _String=!_StringArray_%%G!
	)
	
ENDLOCAL & SET %1=%_String%
GOTO :EOF