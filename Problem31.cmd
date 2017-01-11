@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 31
:: How many different ways can £2 be made using any number of coins?

SET _P=200
CALL :200Pence %_P% _Result
ECHO:%_Result%

GOTO :EOF

:200Pence
SETLOCAL EnableDelayedExpansion

	SET _Pence=%1
	SET _Count=0
	
	FOR /L %%G IN (%_Pence%,-200,0) DO (
		CALL :100Pence %%G _100Count
		SET /A _Count+=_100Count
	)

ENDLOCAL & SET %2=%_Count%
GOTO :EOF 

:100Pence
SETLOCAL EnableDelayedExpansion

	SET _Pence=%1
	SET _Count=0
	
	FOR /L %%G IN (%_Pence%,-100,0) DO (
		CALL :50Pence %%G _50Count
		SET /A _Count+=_50Count
	)

ENDLOCAL & SET %2=%_Count%
GOTO :EOF 

:50Pence
SETLOCAL EnableDelayedExpansion

	SET _Pence=%1
	SET _Count=0
	
	FOR /L %%G IN (%_Pence%,-50,0) DO (
		CALL :20Pence %%G _20Count
		SET /A _Count+=_20Count
	)

ENDLOCAL & SET %2=%_Count%
GOTO :EOF 

:20Pence
SETLOCAL EnableDelayedExpansion

	SET _Pence=%1
	SET _Count=0
	
	FOR /L %%G IN (%_Pence%,-20,0) DO (
		CALL :10Pence %%G _10Count
		SET /A _Count+=_10Count
	)

ENDLOCAL & SET %2=%_Count%
GOTO :EOF 

:10Pence
SETLOCAL EnableDelayedExpansion

	SET _Pence=%1
	SET _Count=0
	
	FOR /L %%G IN (%_Pence%,-10,0) DO (
		CALL :5Pence %%G _5Count
		SET /A _Count+=_5Count
	)

ENDLOCAL & SET %2=%_Count%
GOTO :EOF

:5Pence
SETLOCAL EnableDelayedExpansion

	SET _Pence=%1
	SET _Count=0
	
	FOR /L %%G IN (%_Pence%,-5,0) DO (
		CALL :2Pence %%G _2Count
		SET /A _Count+=_2Count
	)

ENDLOCAL & SET %2=%_Count%
GOTO :EOF

:2Pence
SETLOCAL EnableDelayedExpansion

	SET _Pence=%1
	SET _Count=0
	
	:: We are totally taking advantage of CMD's ignorance of 
	:: floating point numbers here.
	SET /A _Count=_Pence/2
	SET /A _Count+=1	

ENDLOCAL & SET %2=%_Count%
GOTO :EOF