@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 18
:: Find the maximum total from top to bottom of the triangle below...

SET t_0=75
SET t_1=95 64
SET t_2=17 47 82
SET t_3=18 35 87 10
SET t_4=20 04 82 47 65
SET t_5=19 01 23 75 03 34
SET t_6=88 02 77 73 07 63 67
SET t_7=99 65 04 28 06 16 70 92
SET t_8=41 41 26 56 83 40 80 70 33
SET t_9=41 48 72 33 47 32 37 16 94 29
SET t_10=53 71 44 65 25 43 91 52 97 51 14
SET t_11=70 11 33 28 77 73 17 78 39 68 17 57
SET t_12=91 71 52 38 17 14 91 43 58 50 27 29 48
SET t_13=63 66 04 68 89 53 67 30 73 16 69 87 40 31
SET t_14=04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

FOR /L %%G IN (0,1,14) DO (
	SET Index=0
	FOR %%H IN (!t_%%G!) DO (
		SET t_%%G_!Index!=%%H
		SET /A Index+=1
	)
)

:: Rules: Can either move to same index below or to index+1.
:: Let's try a greedy semi-recursive algorithm!
:: Depth sets how far ahead we look to determine "greediness".

SET Sum=0
SET Index=0
SET Depth=12
SET /A Step=Depth+1
SET End=14
FOR /L %%G IN (0,%Step%,%End%) DO (
	CALL :Search %Depth% %%G !Index! MaxSum MaxIndex
	SET /A Sum+=MaxSum
	SET Index=!MaxIndex!
)

ECHO:%Sum%

GOTO :EOF

:Search
SETLOCAL EnableDelayedExpansion

	SET SearchDepth=%1
	SET SearchRow=%2
	SET LIndex=%3
	SET /A RIndex=LIndex+1
	SET /A NextDepth=SearchDepth-1
	SET /A NextRow=SearchRow+1
	
	IF %SearchDepth% GTR 1 (
		CALL :Search %NextDepth% %NextRow% !LIndex! SearchLSum SearchLIndex
		CALL :Search %NextDepth% %NextRow% !RIndex! SearchRSum SearchRIndex
		SET /A SearchLSum+=t_%SearchRow%_%LIndex%
		SET /A SearchRSum+=t_%SearchRow%_%LIndex%
	) ELSE (
		SET /A SearchLSum=t_%SearchRow%_%LIndex%+t_%NextRow%_%LIndex%
		SET /A SearchRSum=t_%SearchRow%_%LIndex%+t_%NextRow%_%RIndex%
		SET SearchLIndex=%LIndex%
		SET SearchRIndex=%RIndex%
	)
	
	IF %SearchLSum% GEQ %SearchRSum% (
		SET ReturnSum=%SearchLSum%
		SET ReturnIndex=%SearchLIndex%
	) ELSE (
		SET ReturnSum=%SearchRSum%
		SET ReturnIndex=%SearchRIndex%
	)
	
ENDLOCAL & SET %4=%ReturnSum%& SET %5=%ReturnIndex%
GOTO :EOF