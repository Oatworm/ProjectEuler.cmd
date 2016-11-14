@ECHO OFF
SET _FibL=1
SET _FibR=2
SET _FibZ=0
SET _FibSum=0

:Loop
IF %_FibL% GEQ 4000000 GOTO Finish

SET /A "_LMod2=_FibL%%2"
IF %_LMod2% EQU 0 SET /A "_FibSum=_FibSum+_FibL"
SET /A "_FibZ=_FibL+_FibR"
SET /A "_FibL=_FibR"
SET /A "_FibR=_FibZ"

GOTO Loop

:Finish
ECHO Sum is %_FibSum%
GOTO :EOF
