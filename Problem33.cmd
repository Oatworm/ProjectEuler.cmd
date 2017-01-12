@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 33
:: Find the LCD of a set of very special fractions

:: First, let's find these fractions...
SET _Index=0
FOR /L %%G IN (10,1,99) DO (
	SET _Numerator=%%G
	FOR /L %%H IN (%%G,1,99) DO (
		SET _Denominator=%%H
		
		SET _FracD=
		SET _FracN=
		IF "!_Numerator:~0,1!"=="!_Denominator:~0,1!" (
			SET _FracN=!_Numerator:~1,1!
			SET _FracD=!_Denominator:~1,1!
		) ELSE IF "!_Numerator:~1,1!"=="!_Denominator:~0,1!" (
			SET _FracN=!_Numerator:~0,1!
			SET _FracD=!_Denominator:~1,1!
		) ELSE IF "!_Numerator:~0,1!"=="!_Denominator:~1,1!" (
			SET _FracN=!_Numerator:~1,1!
			SET _FracD=!_Denominator:~0,1!
		) ELSE IF "!_Numerator:~1,1!"=="!_Denominator:~1,1!" (
			IF NOT "!_Numerator:~1,1!"=="0" (
				SET _FracN=!_Numerator:~0,1!
				SET _FracD=!_Denominator:~0,1!
			)
		)
		
		IF DEFINED _FracD (
			IF !_FracN! LSS !_FracD! (
				SET /A _DxFN=%%H*!_FracN!
				SET /A _NxFD=%%G*!_FracD!
				IF !_DxFN! EQU !_NxFD! (
					SET /A _Index+=1
					SET _FracN_!_Index!=%%G
					SET _FracD_!_Index!=%%H
				)
			)
		)
	)
)

:: Found them - now to multiply them together...
FOR /L %%G IN (1,1,%_Index%) DO (
	IF DEFINED _ProdN (
		SET /A _ProdN*=!_FracN_%%G!
		SET /A _ProdD*=!_FracD_%%G!
	) ELSE (
		SET _ProdN=!_FracN_%%G!
		SET _ProdD=!_FracD_%%G!
	)
)

:: Next, let's find the LCD...
SET /A _Max=_ProdN/2
FOR /L %%G IN (1,1,%_Max%) DO (
	SET /A _ModN=_ProdN %% %%G
	SET /A _ModD=_ProdD %% %%G
	IF !_ModN! EQU 0 IF !_ModD! EQU 0 (
		SET /A _ChkLCD=_ProdD %% _ProdN
		IF !_ChkLCD! EQU 0 SET /A _Answer=_ProdD/_ProdN
		GOTO Done
	)
)

:Done
ECHO:%_Answer%