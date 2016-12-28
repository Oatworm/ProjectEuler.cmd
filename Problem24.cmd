@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 24
:: What is the millionth lexicographic permutation of the digits
:: 0, 1, 2, 3, 4, 5, 6, 7, 8, and 9?

:: This solution will implement the algorithm described here:
:: https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order

SET _Steps=999999
SET _String=0123456789
SET _Result=

FOR %%G IN (0,1,2,3,4,5,6,7,8,9) DO (
	SET _String=!_String:%%G=%%G !
)

SET _Len=0
FOR %%G IN (%_String%) DO (
	SET /A _Len+=1
	SET _StringArray_!_Len!=%%G
)

FOR /L %%G IN (1,1,%_Steps%) DO (
	CALL :Permute
	REM For debugging purposes only.
	REM SET _Debug=
	REM FOR /L %%H IN (1,1,%_Len%) DO (
	REM	IF DEFINED _Debug (
	REM		SET _Debug=!_Debug!!_StringArray_%%H!
	REM	) ELSE SET _Debug=!_StringArray_%%H!
	REM )
	REM ECHO:%%G :: !_Debug!
	SET /A _Chk=%%G %% 1000
	IF !_Chk! EQU 0 ECHO:%%G
)

FOR /L %%G IN (1,1,%_Len%) DO (
	IF DEFINED _Result (
		SET _Result=!_Result!!_StringArray_%%G!
	) ELSE SET _Result=!_StringArray_%%G!
)

ECHO:Answer is %_Result%

GOTO :EOF

:Permute

	:: Find the largest index k such that a[k] < a[k + 1]. 
	:: If no such index exists, the permutation is the last permutation.
	SET _k=-1
	SET /A _LenM1=_Len-1
	FOR /L %%G IN (1,1,!_LenM1!) DO (
		SET /A _kP1=%%G+1
		CALL SET _StrNext=%%_StringArray_!_kP1!%%
		IF !_StringArray_%%G! LSS !_StrNext! SET _k=%%G
	)
	
	IF !_k! EQU -1 (
		REM On last permutation - return to original state.
		SET _NewLen=0
		FOR %%G IN (%_String%) DO (
			SET /A _NewLen+=1
			SET _StringArray_!_NewLen!=%%G
		)
	) ELSE (
		REM Find the largest index l greater than k such that a[k] < a[l].
		SET /A _kP1=_k+1
		CALL SET _StrK=%%_StringArray_!_k!%%
		FOR /L %%G IN (!_kP1!,1,%_Len%) DO (
			IF !_StrK! LSS !_StringArray_%%G! SET _l=%%G
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

GOTO :EOF