@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 7
:: Using hashing!

SET _Count=1
SET _Check=1
:: 8192 character limit in each hash
SET _PHash1=2
SET _PHash2=
SET _PHash3=
SET _PHash4=
SET _PHash5=
SET _PHash6=
SET _PHash7=
SET _PHash8=
SET _PHash9=
SET _PHash10=

:Loop
SET /A _Check+=2
FOR /L %%G IN (1,1,10) DO (
	SET /A _CheckMax=!_Check!/3
	IF DEFINED _PHash%%G (
		FOR %%H IN (!_PHash%%G!) DO (
			IF %%H LEQ !_CheckMax! (
				SET /A _PCheck = !_Check! %% %%H
				IF !_PCheck! EQU 0 GOTO Loop
			)
		)
	) 
)
SET /A _Count+=1
FOR /L %%I IN (1,1,10) DO (
	IF %_Count% LSS %%I000 (
		IF DEFINED _PHash%%I (
			SET _PHash%%I=!_PHash%%I!,%_Check%
			GOTO Break
		) ELSE (
			SET _PHash%%I=%_Check%
			GOTO Break
		)
	)
)

:Break
ECHO:%_Count% :: %_Check%
IF %_Count% LSS 10001 GOTO Loop
GOTO :EOF
