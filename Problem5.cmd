@ECHO OFF
:: Project Euler Problem 5

SETLOCAL EnableDelayedExpansion
SET _res=1
FOR /L %%G IN (1,1,20) DO (
	SET /A _test=!_res! %% %%G
	IF !_test! NEQ 0 (
		SET _max=%%G
		FOR /L %%H IN (1,1,!_max!) DO (
			SET /A _restry=!_res!*%%H
			SET /A _testtry=!_restry! %% %%G
			IF !_testtry! EQU 0 (
				SET _res=!_restry!
				SET _max=%%H
			)
		)
	)
)

ECHO:%_res%
