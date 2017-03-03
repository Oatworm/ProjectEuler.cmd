@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Common function - Get integer length

CALL :GetLen %1 _Len
ECHO:%_Len%

GOTO :EOF 

:GetLen
SETLOCAL EnableDelayedExpansion
	SET _Int=%1
	SET _Len=0

	FOR %%G IN (0,1,2,3,4,5,6,7,8,9) DO SET _Int=!_Int:%%G=%%G !
	FOR %%G IN (%_String%) DO SET /A _Len+=1

ENDLOCAL & SET %2=%_Len%
GOTO :EOF