@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 44
:: Find the pair of pentagonal numbers, Pj and Pk, for which their sum and 
:: difference are pentagonal.

:: Force. Brute force.

SET _j=1
SET _Seed=0
SET _Start=0
SET _Answer=-1

:Loop

	SET /A _Pj=_j*3
	SET /A _Pj-=1
	SET /A _Pj*=_j
	SET /A _Pj/=2
	
	SET /A _SeedChk=_Seed/2	
	IF %_j% GEQ %_SeedChk% CALL :Seed
	
	ECHO:J=%_j%, Seed=%_Seed%
	SET /A _KEnd=_j-1
	FOR /L %%K IN (1,1,%_KEnd%) DO (
		SET /A _Pk=%%K*3
		SET /A _Pk-=1
		SET /A _Pk*=%%K
		SET /A _Pk/=2
		SET /A _Sum=_Pj+_Pk
		IF DEFINED _!_Sum! (
			SET /A _Diff=_Pj-_Pk
			IF DEFINED _!_Diff! (
				SET _Answer=!_Diff!
				GOTO EndLoop
			)
		)
	)
	
	SET /A _j+=1
	GOTO Loop

:EndLoop

ECHO:%_Answer%

GOTO :EOF

:Seed

	SET /A _End=_Start+100
	FOR /L %%G IN (%_Start%,1,%_End%) DO (
		SET /A _P=%%G*3
		SET /A _P-=1
		SET /A _P*=%%G
		SET /A _P/=2
		SET _!_P!=!_P!
		SET _Seed=%%G
	)
	
	SET _Start=%_End%
	
GOTO :EOF