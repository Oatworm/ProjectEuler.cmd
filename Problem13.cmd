@ECHO OFF
SETLOCAL EnableDelayedExpansion

:: Project Euler Problem 13
:: Work out the first 10 digits of the sum of the following 100 50 digit numbers

SET _num1=37107287533902102798797998220837590246510135740250
SET _num2=46376937677490009712648124896970078050417018260538
SET _num3=74324986199524741059474233309513058123726617309629
SET _num4=91942213363574161572522430563301811072406154908250
SET _num5=23067588207539346171171980310421047513778063246676
SET _num6=89261670696623633820136378418383684178734361726757
SET _num7=28112879812849979408065481931592621691275889832738
SET _num8=44274228917432520321923589422876796487670272189318
SET _num9=47451445736001306439091167216856844588711603153276
SET _num10=70386486105843025439939619828917593665686757934951
SET _num11=62176457141856560629502157223196586755079324193331
SET _num12=64906352462741904929101432445813822663347944758178
SET _num13=92575867718337217661963751590579239728245598838407
SET _num14=58203565325359399008402633568948830189458628227828
SET _num15=80181199384826282014278194139940567587151170094390
SET _num16=35398664372827112653829987240784473053190104293586
SET _num17=86515506006295864861532075273371959191420517255829
SET _num18=71693888707715466499115593487603532921714970056938
SET _num19=54370070576826684624621495650076471787294438377604
SET _num20=53282654108756828443191190634694037855217779295145
SET _num21=36123272525000296071075082563815656710885258350721
SET _num22=45876576172410976447339110607218265236877223636045
SET _num23=17423706905851860660448207621209813287860733969412
SET _num24=81142660418086830619328460811191061556940512689692
SET _num25=51934325451728388641918047049293215058642563049483
SET _num26=62467221648435076201727918039944693004732956340691
SET _num27=15732444386908125794514089057706229429197107928209
SET _num28=55037687525678773091862540744969844508330393682126
SET _num29=18336384825330154686196124348767681297534375946515
SET _num30=80386287592878490201521685554828717201219257766954
SET _num31=78182833757993103614740356856449095527097864797581
SET _num32=16726320100436897842553539920931837441497806860984
SET _num33=48403098129077791799088218795327364475675590848030
SET _num34=87086987551392711854517078544161852424320693150332
SET _num35=59959406895756536782107074926966537676326235447210
SET _num36=69793950679652694742597709739166693763042633987085
SET _num37=41052684708299085211399427365734116182760315001271
SET _num38=65378607361501080857009149939512557028198746004375
SET _num39=35829035317434717326932123578154982629742552737307
SET _num40=94953759765105305946966067683156574377167401875275
SET _num41=88902802571733229619176668713819931811048770190271
SET _num42=25267680276078003013678680992525463401061632866526
SET _num43=36270218540497705585629946580636237993140746255962
SET _num44=24074486908231174977792365466257246923322810917141
SET _num45=91430288197103288597806669760892938638285025333403
SET _num46=34413065578016127815921815005561868836468420090470
SET _num47=23053081172816430487623791969842487255036638784583
SET _num48=11487696932154902810424020138335124462181441773470
SET _num49=63783299490636259666498587618221225225512486764533
SET _num50=67720186971698544312419572409913959008952310058822
SET _num51=95548255300263520781532296796249481641953868218774
SET _num52=76085327132285723110424803456124867697064507995236
SET _num53=37774242535411291684276865538926205024910326572967
SET _num54=23701913275725675285653248258265463092207058596522
SET _num55=29798860272258331913126375147341994889534765745501
SET _num56=18495701454879288984856827726077713721403798879715
SET _num57=38298203783031473527721580348144513491373226651381
SET _num58=34829543829199918180278916522431027392251122869539
SET _num59=40957953066405232632538044100059654939159879593635
SET _num60=29746152185502371307642255121183693803580388584903
SET _num61=41698116222072977186158236678424689157993532961922
SET _num62=62467957194401269043877107275048102390895523597457
SET _num63=23189706772547915061505504953922979530901129967519
SET _num64=86188088225875314529584099251203829009407770775672
SET _num65=11306739708304724483816533873502340845647058077308
SET _num66=82959174767140363198008187129011875491310547126581
SET _num67=97623331044818386269515456334926366572897563400500
SET _num68=42846280183517070527831839425882145521227251250327
SET _num69=55121603546981200581762165212827652751691296897789
SET _num70=32238195734329339946437501907836945765883352399886
SET _num71=75506164965184775180738168837861091527357929701337
SET _num72=62177842752192623401942399639168044983993173312731
SET _num73=32924185707147349566916674687634660915035914677504
SET _num74=99518671430235219628894890102423325116913619626622
SET _num75=73267460800591547471830798392868535206946944540724
SET _num76=76841822524674417161514036427982273348055556214818
SET _num77=97142617910342598647204516893989422179826088076852
SET _num78=87783646182799346313767754307809363333018982642090
SET _num79=10848802521674670883215120185883543223812876952786
SET _num80=71329612474782464538636993009049310363619763878039
SET _num81=62184073572399794223406235393808339651327408011116
SET _num82=66627891981488087797941876876144230030984490851411
SET _num83=60661826293682836764744779239180335110989069790714
SET _num84=85786944089552990653640447425576083659976645795096
SET _num85=66024396409905389607120198219976047599490197230297
SET _num86=64913982680032973156037120041377903785566085089252
SET _num87=16730939319872750275468906903707539413042652315011
SET _num88=94809377245048795150954100921645863754710598436791
SET _num89=78639167021187492431995700641917969777599028300699
SET _num90=15368713711936614952811305876380278410754449733078
SET _num91=40789923115535562561142322423255033685442488917353
SET _num92=44889911501440648020369068063960672322193204149535
SET _num93=41503128880339536053299340368006977710650566631954
SET _num94=81234880673210146739058568557934581403627822703280
SET _num95=82616570773948327592232845941706525094512325230608
SET _num96=22918802058777319719839450180888072429661980811197
SET _num97=77158542502016545090413245809786882778948721859617
SET _num98=72107838435069186155435662884062257473692284509516
SET _num99=20849603980134001723930671666823555245252804609722
SET _num100=53503534226472524250874054075591789781264330331690
SET _Sum=0

FOR /L %%G IN (1,1,100) DO (
	CALL SET _11num%%G=%%_num%%G%:~0,11%%
	CALL :ExtAdd !_11num%%G! !_Sum! _Sum
)

ECHO:%_Sum:~0,10%

GOTO :EOF

:: MathLibrary.cmd
:: David Colborne - david@colbornemmx.com

:: https://github.com/Oatworm/MathLibrary.cmd
:: This project is licensed using the Simplified BSD license.
:: For additional details, see the LICENSE file on GitHub.

:ExtAdd
	SETLOCAL EnableDelayedExpansion
	:: Used to add two arbitrary numbers together.
	:: Requires - :ExtMatchPad, :ExtDim
	:: Accepts three parameters:
	:: %1, %2 - The numbers to be added together (passed by value)
	:: %3 - The result (passed by reference)
	::
	:: Example invocation:
	:: CALL :ExtAdd %_Num1% %_Num2% _Result
	:: |--> Sums _Num1 and _Num2 and saves result in _Result

	SET _Add1=%1
	SET _Add2=%2
	SET _AddResult=
	SET _AddCarry=0
	SET _IntLen=1
	SET _AddNegFlag=0
	
	IF %_Add1:~0,1%==- (
		IF %_Add2:~0,1%==- (
			SET _AddNegFlag=1
			SET _Add1=%_Add1:~1%
			SET _Add2=%_Add2:~1%
			GOTO ExtAddNums
		) ELSE (
			SET _Add1=%_Add1:~1%
			CALL :ExtSubtract %_Add2% !_Add1! _AddResult
			GOTO ExtAddReturnResult
		)
	) ELSE (
		IF %_Add2:~0,1%==- (
			SET _Add2=%_Add2:~1%
			CALL :ExtSubtract %_Add1% !_Add2! _AddResult
			GOTO ExtAddReturnResult
		)
	)
	
	:ExtAddNums
	CALL :ExtDim %_Add1% _Add1Len _Add1Dec
	CALL :ExtDim %_Add2% _Add2Len _Add2Dec
	CALL :ExtMatchPad _Add1 _Add2 _AddLen _AddDec %_Add1Len% %_Add1Dec% %_Add2Len% %_Add2Dec%

	FOR /L %%G IN (%_AddLen%,-1,1) DO (
		SET /A _AddPos=%%G-1
		CALL SET _AddInt1=%%_Add1:~!_AddPos!,%_IntLen%%%
		CALL SET _AddInt2=%%_Add2:~!_AddPos!,%_IntLen%%%
		IF !_AddInt1!==. (
			SET _AddResult=.!_AddResult!
		) ELSE (
			SET /A _AddByPos=_AddInt1+_AddInt2+_AddCarry
			IF !_AddByPos! GEQ 10 (
				SET _AddCarry=1
				SET /A _AddByPos-=10
			) ELSE (
				SET _AddCarry=0
			)
			SET _AddResult=!_AddByPos!!_AddResult!
		)
	)

	IF %_AddCarry% EQU 1 SET _AddResult=1%_AddResult%
	IF %_AddNegFlag% EQU 1 SET _AddResult=-%_AddResult%

	:ExtAddReturnResult
	ENDLOCAL & SET %3=%_AddResult%
GOTO :EOF

:ExtCompare
	SETLOCAL EnableDelayedExpansion
	:: Used to compare two numbers.
	:: Requires - :ExtDim, :ExtMatchPad
	:: Accepts the following parameters:
	:: %1, %2 - The numbers to compare, evaluated in order (passed by value)
	:: %3 - The result, returned as GTR, LSS, or EQU
	::
	:: Optional arguments:
	:: %4, %5 - Length and decimal position of %1
	:: %6, %7 - Length and decimal position of %2
	::
	:: Example invocation:
	:: CALL :ExtCompare %_Num1% %_Num2% _Result
	:: |--> If _Num1 is 1 and _Num2 is 3, returns LSS.
	:: |--> If _Num1 is 3 and _Num2 is 1, returns GTR
	:: |--> If _Num1 and _Num2 are both 3, returns EQU
	
	SET _Com1=%1
	SET _Com2=%2
	SET _ComLen=
	SET _IntLen=1
	SET _ComResult=EQU
	SET _ComNegFlag=0
	
	IF %_Com1:~0,1%==- (
		IF NOT %_Com2:~0,1%==- (
			SET _ComResult=LSS
			GOTO ExtCompareReturnResult
		) ELSE (
			SET _ComNegFlag=1
			SET _Com1=%_Com1:~1%
			SET _Com2=%_Com2:~1%
			GOTO ExtCompareCheck
		)
	)
	
	IF %_Com2:~0,1%==- (
		SET _ComResult=GTR
		GOTO ExtCompareReturnResult
	)
	
	:ExtCompareCheck
	IF NOT [%7]==[] (
		SET _Com2Len=%6
		SET _Com2Dec=%7
	) ELSE CALL :ExtDim %_Com2% _Com2Len _Com2Dec
	
	IF NOT [%5]==[] (
		SET _Com1Len=%4
		SET _Com1Dec=%5
	) ELSE CALL :ExtDim %_Com1% _Com1Len _Com1Dec
	
	SET /A _Com1IntLen=_Com1Len-_Com1Dec
	IF %_Com1IntLen%==-1 (SET _Com1IntLen=%_Com1Len%) ELSE (SET /A _Com1IntLen=_Com1Len-_Com1IntLen-1)
	SET /A _Com2IntLen=_Com2Len-_Com2Dec
	IF %_Com2IntLen%==-1 (SET _Com2IntLen=%_Com2Len%) ELSE (SET /A _Com2IntLen=_Com2Len-_Com2IntLen-1)
	
	IF %_Com1IntLen% GTR %_Com2IntLen% (
		SET _ComResult=GTR
		GOTO ExtCompareReturnResult
	)
	
	IF %_Com2IntLen% GTR %_Com1IntLen% (
		SET _ComResult=LSS
		GOTO ExtCompareReturnResult
	)
	
	CALL :ExtMatchPad _Com1 _Com2 _ComLen _ComDec %_Com1Len% %_Com1Dec% %_Com2Len% %_Com2Dec%
	
	FOR /L %%G IN (0,1,%_ComLen%) DO (
		SET /A _ComPos=%%G
		CALL SET _ComLInt=%%_Com1:~!_ComPos!,%_IntLen%%%
		CALL SET _ComRInt=%%_Com2:~!_ComPos!,%_IntLen%%%
		IF NOT !_ComLInt!==. (
			IF !_ComLInt! LSS !_ComRInt! (
				SET _ComResult=LSS
				GOTO ExtCompareCheckNeg
			)
			IF !_ComLInt! GTR !_ComRInt! (
				SET _ComResult=GTR
				GOTO ExtCompareCheckNeg
			)
		)
	)
	
	:ExtCompareCheckNeg
	IF %_ComNegFlag% EQU 1 (
		IF %_ComResult%==GTR SET _ComResult=LSS
		IF %_ComResult%==LSS SET _ComResult=GTR
	)
	
	:ExtCompareReturnResult
	ENDLOCAL & SET %3=%_ComResult%
GOTO :EOF

:ExtUnDecimal
	SETLOCAL EnableDelayedExpansion
	:: Used to strip decimal points out of numbers.
	:: Requires - :ExtDim
	:: Necessary for division and multiplication. See :ExtReDecimal.
	:: Accepts the following parameters:
	:: %1 - The number to strip (passed by reference)
	:: %2, %3 (Optional) - Length and Decimal position of the stripped number
	::
	:: Example invocation:
	:: CALL :ExtUnDecimal _Num1
	:: |--> If _Num1=123.45, returns 12345
	:: Note that you should store the decimal position for use in :ExtReDecimal
	:: elsewhere.
	
	SET _UnDNum=!%1!
	SET _UnDResult=
	SET _UnDLeft=
	SET _UnDRight=
	
	IF NOT [%3]==[] (
		SET _UnDLen=%2
		SET _UnDDec=%3
	) ELSE CALL :ExtDim %_UnDNum% _UnDLen _UnDDec
	
	IF %_UnDDec% LEQ %_UnDLen% (
		SET _UnD0=0
		SET /A _UnDLLen=_UnDDec-1
		SET /A _UnDRLen=_UnDLen-_UnDDec
		CALL SET _UnDLeft=%%_UnDNum:~!_UnD0!,!_UnDLLen!%%
		CALL SET _UnDRight=%%_UnDNum:~%_UnDDec%,!_UnDRLen!%%
		SET _UnDResult=!_UnDLeft!!_UnDRight!
	) ELSE (
		SET _UnDResult=!_UnDNum!
	)
	
	ENDLOCAL & SET %1=%_UnDResult%
GOTO :EOF

:ExtReDecimal
	SETLOCAL EnableDelayedExpansion
	:: Used to place a decimal point back into a number.
	:: Useful for proper decimal placement when multiplying or dividing.
	:: Accepts the following parameters:
	:: %1 - The number to place the decimal into (passed by reference)
	:: %2 - The length of the number string (passed by reference)
	:: %3 - The decimal position (passed by value, counting from the left)
	::
	:: Example invocation:
	:: CALL :ExtReDecimal _Num1 _NumLen 6
	:: |--> If _Num1=1234567, returns 12345.67 with a new length of 8.
	::
	:: Note that this subroutine assumes that the number being changed is 
	:: an integer - there's no error checking.
	
	SET _ReDNum=!%1!
	SET _ReDLen=!%2!
	SET /A _ReDPos=%3
	SET _ReDLeft=
	SET _ReDRight=
	SET _ReDResult=
	
	IF %_ReDPos% LEQ %_ReDLen% (
		SET _ReD0=0
		SET /A _ReDLLen=_ReDPos-1
		SET /A _ReDLen+=1
		CALL SET _ReDLeft=%%_ReDNum:~!_ReD0!,!_ReDLLen!%%
		CALL SET _ReDRight=%%_ReDNum:~!_ReDLLen!,!_ReDLen!%%
		SET _ReDResult=!_ReDLeft!.!_ReDRight!
	) ELSE (
		SET _ReDResult=!_ReDNum!
	)
	
	ENDLOCAL & SET %1=%_ReDResult%& SET %2=%_ReDLen%
GOTO :EOF

:ExtMatchPad
	SETLOCAL EnableDelayedExpansion
	:: Used to match length and decimal position of two number strings
	:: Requires - :ExtPad, :ExtDim
	:: Accepts the following parameters (passed by reference):
	:: %1, %2 - Two numbers to match
	:: %3, %4 - Length and decimal position of padded numbers.
	::
	:: Optionally accepts the following (passed by value)
	:: %5, %6 - Length and decimal position of %1
	:: %7, %8 - Length and decimal position of %2
	::
	:: Example invocation:
	:: CALL :ExtMatchPad _Num1 _Num2
	:: |--> Makes _Num1 and _Num2 have the same length
	::      and decimal position
	:: So, 1234.5 and 1.2345 become 1234.5000 and 0001.2345.

	SET _MatchPad1=!%1!
	SET _MatchPad2=!%2!
	SET _MatchPadL=
	SET _MatchPadD=
	
	IF NOT [%8]==[] (
		SET _MatchPadL2=%7
		SET _MatchPadD2=%8
	) ELSE CALL :ExtDim %_MatchPad2% _MatchPadL2 _MatchPadD2
	
	IF NOT [%6]==[] (
		SET _MatchPadL1=%5
		SET _MatchPadD1=%6
	) ELSE CALL :ExtDim %_MatchPad1% _MatchPadL1 _MatchPadD1


	:: Add a decimal if one number has a decimal and the other doesn't.
	IF %_MatchPadD1% GTR %_MatchPadL1% (
		IF %_MatchPadD2% LEQ %_MatchPadL2% (
			CALL :ExtMakeFloat _MatchPad1 _MatchPadL1
		)
	)
	IF %_MatchPadD2% GTR %_MatchPadL2% (
		IF %_MatchPadD1% LEQ %_MatchPadL1% (
			CALL :ExtMakeFloat _MatchPad2 _MatchPadL2
		)
	)
	
	:: Pad number strings so they both line up.
	IF %_MatchPadD1% GTR %_MatchPadD2% (
		SET /A "_DPadLen=_MatchPadD1-_MatchPadD2"
		CALL :ExtPad _MatchPad2 !_DPadLen! L _MatchPadL2 _MatchPadD2
		SET _MatchPadD=_MatchPadD1
	)
	IF %_MatchPadD2% GTR %_MatchPadD1% (
		SET /A "_DPadLen=_MatchPadD2-_MatchPadD1"
		CALL :ExtPad _MatchPad1 !_DPadLen! L _MatchPadL1 _MatchPadD1
		SET _MatchPadD=_MatchPadD2
	)

	IF %_MatchPadL1% GTR %_MatchPadL2% (
		SET /A _LPadLen=_MatchPadL1-_MatchPadL2
		CALL :ExtPad _MatchPad2 !_LPadLen! R _MatchPadL2 _MatchPadD2
		SET _MatchPadL=_MatchPadL1
	)
	IF %_MatchPadL2% GTR %_MatchPadL1% (
		SET /A _LPadLen=_MatchPadL2-_MatchPadL1
		CALL :ExtPad _MatchPad1 !_LPadLen! R _MatchPadL1 _MatchPadD1
		SET _MatchPadL=_MatchPadL2
	)
	
	IF NOT DEFINED _MatchPadL SET _MatchPadL=%_MatchPadL1%
	IF NOT DEFINED _MatchPadD SET _MatchPadD=%_MatchPadD1%

	ENDLOCAL & SET %1=%_MatchPad1%& SET %2=%_MatchPad2%& SET %3=%_MatchPadL%& SET %4=%_MatchPadD%
GOTO :EOF

:ExtMakeFloat
	SETLOCAL EnableDelayedExpansion
	:: Used to add a decimal point to a number string
	:: Accepts the following parameters:
	:: %1 - The variable that needs a decimal point
	::
	:: Example invocation:
	:: CALL :ExtMakeFloat _Num _Len
	:: |--> Returns _Num with a . at the end (1234 -> 1234.)
	:: |--> Automatically increments length by one.

	SET _FloatNum=!%1!
	SET /A _FloatLength=%2

	:: Only do this if we really need to...
	CALL :ExtDim %_FloatNum% _FloatLen _FloatDec
	IF %_FloatDec% GTR %_FloatLen% (
		SET _FloatNum=!_FloatNum!.
		SET /A _FloatLength+=1
	)
	
	ENDLOCAL & SET %1=%_FloatNum%& SET /A %2=%_FloatLength%
GOTO :EOF

:ExtPad
	SETLOCAL EnableDelayedExpansion
	:: Used to pad a number to facilitate mathematical operations
	:: Accepts the following parameters:
	:: %1 - The variable that needs to be padded
	:: %2 - The number of positions to pad
	:: %3 - The direction the pad needs to be applied (L or R)
	:: %4 - Length variable - Returned with padded length
	:: %5 - Decimal variable - Returned with adjusted position
	::
	:: Example invocation:
	:: CALL :ExtPad _Num 5 L _Len _Dec
	:: |--> Returns padded length and decimal position in _Len & _Dec.
	:: |--> Returns padded number back in _Num

	SET _PadNum=!%1!
	SET /A _PadLength=%4
	SET /A _PadDecimal=%5
	IF %3==L (
		FOR /L %%G IN (1,1,%2) DO (
			SET _PadNum=0!_PadNum!
			SET /A _PadLength+=1
			SET /A _PadDecimal+=1
		)
	)
	IF %3==R (
		FOR /L %%G IN (1,1,%2) DO (
			SET _PadNum=!_PadNum!0
			SET /A _PadLength+=1
		)
	)
	ENDLOCAL & SET %1=%_PadNum%& SET /A %4=%_PadLength% & SET /A %5=%_PadDecimal%
GOTO :EOF	

:ExtDim
	SETLOCAL EnableDelayedExpansion
	:: Used to get the string length and decimal position of a number.
	:: Accepts three parameters:
	:: %1 - The number that needs its size and precision
	:: %2 - A variable in which the size is returned
	:: %3 - A variable in which the position of the decimal is returned
	:: Returns length and decimal position by reference.
	::
	:: Example invocation:
	:: CALL :ExtDim %_Num% _Len _Dec
	
	SET _DimLength=0
	SET _DimDecimal=-1
	SET _DimArg=%1
	SET _DimPos=1
	:DimLoop
		CALL SET _DimLCheck=%%_DimArg:~%_DimLength%,%_DimPos%%%
		IF NOT DEFINED _DimLCheck GOTO ExitDimLoop
		SET /A _DimLength+=1
		IF %_DimLCheck%==. SET _DimDecimal=%_DimLength%
	GOTO DimLoop
	:ExitDimLoop
	IF %_DimDecimal% EQU -1 SET /A "_DimDecimal=_DimLength+1"
	ENDLOCAL & SET /A %2=%_DimLength% & SET /A %3=%_DimDecimal%
GOTO :EOF
