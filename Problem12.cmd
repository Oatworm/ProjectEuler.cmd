@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 12
:: What is the value of the first triangle number to have over 500 divisors?

<NUL SET /P _echo=Priming
SET _Max=75000
FOR /L %%G IN (2,1,%_Max%) DO (
	IF NOT DEFINED _%%G (
		SET /A _Start=%%G+%%G
		FOR /L %%H IN (!_Start!,%%G,%_Max%) DO (
			SET _%%H=1
		)
		<NUL SET /P _echo=.
	)
)

SET _Triangle=0
FOR /L %%G IN (1,1,64000) DO (
	SET /A _Triangle+=%%G
	CALL :FactorPrimes !_Triangle! _FactorCount
	ECHO:!_Triangle! :: !_FactorCount!
	IF !_FactorCount! GEQ 500 GOTO P12Done
)

:P12Done
ECHO:%_Triangle%
GOTO :EOF

:FactorPrimes
SETLOCAL EnableDelayedExpansion

SET _Count=1
SET _Remain=%1
IF %1 LEQ %_Max% (SET _Loop=%1) ELSE (SET _Loop=%_Max%)
FOR /L %%G IN (2,1,%_Loop%) DO (
	IF NOT DEFINED _%%G (
		SET /A _Sq=%%G*%%G
		IF !_Sq! GTR !_Remain! (
			SET /A _Count*=2
			GOTO FPReturn
		)
		SET _Exp=1
		CALL :FPExpLoop %%G
		SET /A _Count*=_Exp
		IF !_Remain! EQU 1 GOTO FPReturn
	)
)

:FPReturn
ENDLOCAL & SET %2=%_Count%
GOTO :EOF

:FPExpLoop
SET _LPrime=%1
SET /A _ChkRemain=_Remain%%_LPrime
IF !_ChkRemain! EQU 0 (
	SET /A _Exp+=1
	SET /A _Remain=_Remain/_LPrime
	SET /A _ChkRemain=_Remain%%_LPrime
	IF !_ChkRemain! EQU 0 CALL :FPExpLoop !_LPrime!
)
GOTO :EOF