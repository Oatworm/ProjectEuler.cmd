@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Common function - Find permutations
SET _Arg=%1
CALL :Permute _Arg
ECHO:%_Arg%

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
		SET _NewLen=%_Len%
		FOR %%G IN (%_String%) DO (
			SET _StringArray_!_NewLen!=%%G
			SET /A _NewLen-=1
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
	
	:: Rebuild the string
	SET _String=
	FOR /L %%G IN (1,1,%_Len%) DO (
		IF DEFINED _String (
			SET _String=!_String!!_StringArray_%%G!
		) ELSE SET _String=!_StringArray_%%G!
	)

ENDLOCAL & SET %1=%_String%
GOTO :EOF