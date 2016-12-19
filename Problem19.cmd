@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Problem 19
:: How many Sundays fell on the first of the month during the 20th century?
:: (1-Jan-1901 to 31-Dec-2000)

SET SunCount=0
SET Days=1
FOR /L %%Y IN (0,1,100) DO (
	FOR /L %%M IN (1,1,12) DO (
		SET /A SunCheck = Days %% 7
		IF !SunCheck! EQU 0 (
			IF %%Y GEQ 1 SET /A SunCount+=1
		)
		IF %%M EQU 1 SET /A Days+=31
		IF %%M EQU 2 (
			SET /A LeapCheck = %%Y %% 4
			IF !LeapCheck! EQU 0 (
				SET /A Days+=29
			) ELSE SET /A Days+=28
		)
		IF %%M EQU 3 SET /A Days+=31
		IF %%M EQU 4 SET /A Days+=30
		IF %%M EQU 5 SET /A Days+=31
		IF %%M EQU 6 SET /A Days+=30
		IF %%M EQU 7 SET /A Days+=31
		IF %%M EQU 8 SET /A Days+=31
		IF %%M EQU 9 SET /A Days+=30
		IF %%M EQU 10 SET /A Days+=31
		IF %%M EQU 11 SET /A Days+=30
		IF %%M EQU 12 SET /A Days+=31
	)
)

ECHO:%SunCount%