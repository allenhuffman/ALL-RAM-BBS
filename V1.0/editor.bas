
0 REM *ALL RAM* BBS Editor 1.0
1 REM   Shareware / (C) 1983
2 REM     By Allen Huffman
3 REM  110 Champions Dr, #811
4 REM     Lufkin, TX 75901
5 FORA=0TO8:READA$:POKE1024+A,VAL("&H"+A$):NEXTA:EXEC1024:DATAC6,1,96,BC,1F,2,7E,96,A3
10 CLEAR21000:DIMNM$(200),MS$(19,10),A$,F$,S$,T$,NM$,PW$,A,B,C,LN,LV,MS,NM,PR:PR=80
15 CLS:PRINTTAB(3)"*ALL RAM* EDITOR COMMANDS:":PRINTSTRING$(32,45)
20 PRINTTAB(4)"1. CREATE USERLOG",TAB(4)"2. LOAD USERLOG/MSG BASE",TAB(4)"3. SAVE USERLOG/MSG BASE",TAB(4)"4. PRINT USERLOG",TAB(4)"5. PRINT MESSAGES",TAB(4)"6. EDIT USERS",TAB(4)"7. KILL MESSAGES",TAB(4)"8. QUIT"
25 PRINT@392,"ENTER FUNCTION :"
30 A$=INKEY$:IFA$=""THEN30ELSEPRINT@408,A$:LN=VAL(A$):IFLN<1ORLN>8THENSOUND50,1:GOTO25
35 SOUND200,1:ONLN GOTO55,105,155,205,255,305,405,40
40 STOP
50 'Create Userlog
55 CLS:PRINTTAB(7)"SYSOP INFORMATION:":PRINTSTRING$(32,45)
60 PRINT@128,"SYSOP'S NAME:    (20 CHARACTERS)>";:LINEINPUTA$:IFA$=""ORLEN(A$)>20THENSOUND50,1:GOTO15ELSENM$=A$
65 PRINT@192,"PASSWORD    :     (8 CHARACTERS)>";:LINEINPUTA$:IFA$=""ORLEN(A$)>8THENSOUND50,1:GOTO15ELSEPW$=A$
70 PRINT@297,"*VERIFY ENTRY*":PRINT:PRINT"NAME :"NM$:PRINT"PSWD :"PW$:PRINT@456,"IS THIS CORRECT?";
75 LINEINPUTA$:IFLEFT$(A$,1)<>"Y"THENSOUND50,1:GOTO55
80 NM$(0)=NM$+"\"+PW$+"9":GOTO15
100 'Load Userlog/Msg Base
105 CLS:PRINTTAB(5)"LOAD USERLOG/MSG BASE:":PRINTSTRING$(32,45)
110 LINEINPUT" READY TAPE, THEN PRESS ENTER:";A$:PRINT@168,"...ONE MOMENT..."
115 OPEN"I",#-1,"USERLOG":PRINT@232,"LOADING  USERLOG":INPUT#-1,CL,NM:FORA=0TONM:INPUT#-1,NM$(A):NEXTA:CLOSE
120 OPEN"I",#-1,"MSG BASE":PRINT@240,"MSG BASE":INPUT#-1,MS:FORA=0TOMS-1:FORB=0TO10:INPUT#-1,MS$(A,B):NEXTB:NEXTA:CLOSE:GOTO15
150 'Save Userlog/Msg Base
155 CLS:PRINTTAB(5)"SAVE USERLOG/MSG BASE:":PRINTSTRING$(32,45)
160 LINEINPUT" READY TAPE, THEN PRESS ENTER:";A$:PRINT@168,"...ONE MOMENT...":MOTORON:FORA=1TO1000:NEXTA
165 PRINT@232,"SAVING   USERLOG":OPEN"O",#-1,"USERLOG":PRINT#-1,CL,NM:FORA=0TONM:PRINT#-1,NM$(A):NEXTA:CLOSE
170 PRINT@240,"MSG BASE":OPEN"O",#-1,"MSG BASE":PRINT#-1,MS:FORA=0TOMS-1:FORB=0TO10:PRINT#-1,MS$(A,B):NEXTB:NEXTA:CLOSE:GOTO15
200 'Print Userlog
205 IFNM$(0)=""THENPRINT@454,"*USERLOG NOT LOADED*":SOUND50,1:GOTO25
210 CLS:PRINTTAB(9)"PRINT USERLOG:":PRINTSTRING$(32,45)
215 LINEINPUT"    PRESS ENTER WHEN READY:";A$:PRINT@169,"...PRINTING..."
220 PRINT#-2,TAB((PR-30)/2)"[*ALL RAM* BBS System Userlog]":PRINT#-2,"":PRINT#-2,TAB((PR-46)/2)"[###]  [        NAME        ]  [PASSWORD]  [L]"
225 FORA=0TONM:A$=NM$(A):B=INSTR(A$,"\"):NM$=LEFT$(A$,B-1):PW$=MID$(A$,B+1,LEN(A$)-B-1):LV=VAL(RIGHT$(A$,1))
230 A$="000........................................0":B=LEN(STR$(A))-1:MID$(A$,4-B,B)=RIGHT$(STR$(A),B):MID$(A$,8,LEN(NM$))=NM$:MID$(A$,32,LEN(PW$))=PW$:MID$(A$,44,1)=RIGHT$(STR$(LV),1)
235 PRINT@238,A:PRINT#-2,TAB((PR-44)/2)A$:NEXTA:GOTO15
250 'Print Messages
255 IFMS$(0,0)=""THENPRINT@454,"*MSG BASE NOT LOADED*":SOUND50,1:GOTO25
260 CLS:PRINTTAB(8)"PRINT  MESSAGES:":PRINTSTRING$(32,45)
265 LINEINPUT"    PRESS ENTER WHEN READY:";A$:PRINT@169,"...PRINTING..."
270 PRINT#-2,TAB((PR-30)/2)"[*ALL RAM* BBS System Messages]":PRINT#-2,""
275 FORA=0TOMS-1:A$=MS$(A,0):B=INSTR(A$,"\"):C=INSTR(B+1,A$,"\"):T$=LEFT$(A$,B-1):F$=MID$(A$,B+1,C-B-1):S$=RIGHT$(A$,LEN(A$)-C)
280 PRINT@238,A+1:B=(PR-64)/2:PRINT#-2,TAB(B)"Message #"A:PRINT#-2,TAB(B)"TO :"T$:PRINT#-2,TAB(B)"FR :"F$:PRINT#-2,TAB(B)"SB :"S$:PRINT#-2,STRING$(64,45):C=0
285 C=C+1:PRINT#-2,TAB(B)MS$(A,C):IFMS$(A,C)=""THEN290ELSEIFC<10THEN285
290 PRINT#-2,"":NEXTA:GOTO15
300 'Edit Users
305 IFNM$(0)=""THENPRINT@454,"*USERLOG NOT LOADED*":SOUND50,1:GOTO25
310 CLS:PRINTTAB(10)"EDIT  USERS:":PRINTSTRING$(32,45):A=0
315 PRINT@70,"USERS ON SYSTEM:"NM
320 A$=NM$(A):B=INSTR(A$,"\"):NM$=LEFT$(A$,B-1):PW$=MID$(A$,B+1,LEN(A$)-B-1):LV=VAL(RIGHT$(A$,1))
325 PRINT@128,"USER #"A:PRINT:PRINT"NAME: "NM$:PRINT"PSWD: "PW$:PRINT"LVL :"LV
330 PRINT@320,STRING$(32,45)TAB(4)"D-LET   UP-BACK   J-UMP",TAB(4)"E-DIT   DN-NEXT   M-ENU"
335 PRINT@456,"ENTER FUNCTION :"
340 A$=INKEY$:IFA$=""THEN340ELSEPRINT@472,A$;:LN=INSTR("DEJM"+CHR$(94)+CHR$(10),A$):IFLN=0THENSOUND50,1:GOTO335
345 SOUND200,1:ONLN GOTO350,365,385,15,390,395
350 IFA=0THENSOUND1,5:GOTO335
355 IFA=NM THENNM=NM-1:A=A-1:GOTO315
360 FORB=A TONM:NM$(B)=NM$(B+1):NEXTB:NM=NM-1:GOTO315
365 PRINT@198,;:LINEINPUTA$:IFA$=""ORLEN(A$)>20THENPRINT@198,NM$ELSENM$=A$
370 PRINT@230,;:LINEINPUTA$:IFA$=""ORLEN(A$)>8THENPRINT@230,PW$ELSEPW$=A$
375 PRINT@262,;:LINEINPUTA$:B=VAL(A$):IFB<1ORB>9THENPRINT@261,LV ELSELV=B
380 NM$(A)=NM$+"\"+PW$+RIGHT$(STR$(LV),1):GOTO335
385 PRINT@456," JUMP TO USER # ";:LINEINPUTA$:B=VAL(A$):IFB<0ORB>NM THENSOUND1,5:GOTO335ELSEA=B:GOTO320
390 A=A-1:IFA<0THENA=NM
391 GOTO315
395 A=A+1:IFA>NM THENA=0
396 GOTO315
400 'Kill Messages
405 IFMS$(0,0)=""THENPRINT@454,"*MSG BASE NOT LOADED*":SOUND50,1:GOTO25
410 CLS:PRINTTAB(9)"KILL MESSAGES:":PRINTSTRING$(32,45)
415 PRINT@96,"DELETE MESSAGE # 1 -"MS":";:LINEINPUTA$:A=VAL(A$):IFA<1ORA>MS THEN15
420 A$=MS$(A-1,0):B=INSTR(A$,"\"):C=INSTR(B+1,A$,"\"):T$=LEFT$(A$,B-1):F$=MID$(A$,B+1,C-B-1):S$=RIGHT$(A$,LEN(A$)-C)
425 PRINT:PRINT"TO: "T$:PRINT"FR: "F$:PRINT"SB: "S$
430 PRINT:LINEINPUT"DELETE THIS?";A$:IFLEFT$(A$,1)<>"Y"THEN410
435 IFA=MS THENMS=MS-1:GOTO410
440 FORB=A-1 TOMS-2:FORC=0TO10:MS$(B,C)=MS$(B+1,C):NEXTC:NEXTB:MS=MS-1:GOTO410
