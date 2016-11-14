@ECHO OFF
SET _Sum=0
FOR /L %%G IN (1,1,999) DO (CALL :ThreeByFive %%G)
ECHO %_Sum%
GOTO :eof

:: Our "function" - checks if a number is evenly divisible by 
:: 3, 5, or both, and adds the number if so.
:ThreeByFive
:: Keep most of our variables in local scope
SETLOCAL

:: Check for divisibility.
SET /A "_ModF=%1%%5"
SET /A "_ModT=%1%%3"

:: Now to perform some tests. Note the use of a 
:: GOTO statement to skip a check if one passes.
IF %_ModT% EQU 0 GOTO SumVal
IF %_ModF% EQU 0 GOTO SumVal

:: Failed all checks - end subroutine
GOTO :eof

:: Passed at least one of the checks - add the number!
:SumVal
ENDLOCAL & SET /A "_Sum+=%1"
GOTO :eof
