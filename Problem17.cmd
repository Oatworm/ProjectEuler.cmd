@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 17
:: How many letters used in the numbers 1 to 1000, inclusively?

SET $1=one
SET $2=two
SET $3=three
SET $4=four
SET $5=five
SET $6=six
SET $7=seven
SET $8=eight
SET $9=nine
SET $10=ten
SET $11=eleven
SET $12=twelve
SET $13=thirteen
SET $14=fourteen
SET $15=fifteen
SET $16=sixteen
SET $17=seventeen
SET $18=eighteen
SET $19=nineteen
SET $20=twenty
FOR /L %%G IN (1,1,9) DO (
	SET $2%%G=%$20%!$%%G!
)
SET $30=thirty
FOR /L %%G IN (1,1,9) DO (
	SET $3%%G=%$30%!$%%G!
)
SET $40=forty
FOR /L %%G IN (1,1,9) DO (
	SET $4%%G=%$40%!$%%G!
)
SET $50=fifty
FOR /L %%G IN (1,1,9) DO (
	SET $5%%G=%$50%!$%%G!
)
SET $60=sixty
FOR /L %%G IN (1,1,9) DO (
	SET $6%%G=%$60%!$%%G!
)
SET $70=seventy
FOR /L %%G IN (1,1,9) DO (
	SET $7%%G=%$70%!$%%G!
)
SET $80=eighty
FOR /L %%G IN (1,1,9) DO (
	SET $8%%G=%$80%!$%%G!
)
SET $90=ninety
FOR /L %%G IN (1,1,9) DO (
	SET $9%%G=%$90%!$%%G!
)
SET $hun=hundred
FOR /L %%G IN (1,1,9) DO (
	FOR /L %%H IN (0,1,99) DO (
		IF %%H EQU 0 (
			SET $%%G00=!$%%G!%$hun%
		) ELSE (
			IF %%H GEQ 10 (
				SET $%%G%%H=!$%%G!%$hun%and!$%%H!
			) ELSE (
				SET $%%G0%%H=!$%%G!%$hun%and!$%%H!
			)
		)
	)
)
SET $1000=onethousand

SET _Sum=0
FOR /L %%G IN (1,1,1000) DO (
	CALL :CountLetters $%%G _Len
	SET /A _Sum+=_Len
)

ECHO:%_Sum%

GOTO :EOF

:CountLetters
SETLOCAL EnableDelayedExpansion

	SET _Array=!%1!
	SET _Len=0
	
	FOR %%G IN (a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z) DO (
		SET _Array=!_Array:%%G=%%G !
	)

	FOR %%G IN (%_Array%) DO (
		SET /A _Len+=1
	)
	
ENDLOCAL & SET %2=%_Len%
GOTO :EOF