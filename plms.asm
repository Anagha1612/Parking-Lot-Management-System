.MODEL SMALL
.STACK 100H
.DATA
MENU DB '**********MENU**********$'
MENU1 DB 'Press 1 for rickshaw$'
MENU2 DB 'Press 2 for car$'
MENU3 DB 'Press 3 for bus$'
MENU4 DB 'Press 4 to show the record$'
MENU5 DB 'Press 5 to delete the record$'
MENU6 DB 'Press 6 to exit$'
MSG1 DB 'Parking is Full$'
MSG2 DB 'Wrong input$'
MSG3 DB 'Car$'
MSG4 DB 'Bus$'
MSG5 DB 'Record$'
MSG6 DB 'There is more space$'
MSG7 DB 'Total amount is=$'
MSG8 DB 'Total number of vehicles parked=$'
MSG9 DB 'Total number of rickshaws parked=$'
MSG10 DB 'Total number of cars parked=$'
MSG11 DB 'Total number of buses parked=$'
MSG12 DB '***Record deleted successfully***$'
AMOUNT DW 0
COUNT DW '0'
AM1 DW ?
AM2 DW ?
AM3 DW ?
R DW '0'
C DB '0'
B DB '0'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    WHILE_: 
    
    ;MENU
    MOV DX,10
    MOV AH,2
    INT 21H
    MOV DX,13
    MOV AH,2
    INT 21H
    
    MOV DX,OFFSET MENU
    MOV AH,9
    INT 21H
    MOV DX,10
    MOV AH,2
    INT 21H
    MOV DX,13
    MOV AH,2
    INT 21H
    
    MOV DX,OFFSET MENU1
    MOV AH,9
    INT 21H    
    MOV DX,10
    MOV AH,2
    INT 21H
    MOV DX,13
    MOV AH,2
    INT 21H    
    
    MOV DX,OFFSET MENU2
    MOV AH,9
    INT 21H
    
    MOV DX,10
    MOV AH,2
    INT 21H
    MOV DX,13
    MOV AH,2
    INT 21H 
    
    MOV DX,OFFSET MENU3
    MOV AH,9
    INT 21H    
    MOV DX,10
    MOV AH,2
    INT 21H
    MOV DX,13
    MOV AH,2
    INT 21H   
    
    MOV DX,OFFSET MENU4
    MOV AH,9
    INT 21H
    MOV DX,10
    MOV AH,2
    INT 21H
    MOV DX,13
    MOV AH,2
    INT 21H
    
     MOV DX,OFFSET MENU5
    MOV AH,9
    INT 21H
    MOV DX,10
    MOV AH,2
    INT 21H
    MOV DX,13
    MOV AH,2
    INT 21H   
    
    MOV DX,OFFSET MENU6
    MOV AH,9
    INT 21H
    MOV DX,10
    MOV AH,2
    INT 21H
    MOV DX,13
    MOV AH,2
    INT 21H
    
    ;USERINPUT
    MOV AH,1
    INT 21H
    MOV BL,AL
    MOV DX,10
    MOV AH,2
    INT 21H
    MOV DX,13
    MOV AH,2
    INT 21H
    
    ;NOW COMPARE
    MOV AL,BL
    CMP AL,'1'
    JE RIKSHW
    CMP AL,'2'
    JE CAR
    CMP AL,'3'
    JE BUS
    CMP AL,'4'
    JE REC
    CMP AL,'5'
    JE DEL
    CMP AL,'6'
    JE END_
    
    MOV DX,OFFSET MSG2
    MOV AH,9
    INT 21H
    
    MOV DX,10
    MOV AH,2
    INT 21H
    JMP WHILE_
    
    RIKSHW:
    CALL RIKSHAW
    
    CAR:
    CALL CAAR
    
    REC:
    CALL RECRD
    
    DEL:
    CALL DELT
    
    BUS:
    CALL BUSS
    
    END_:
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
    
RIKSHAW PROC
    CMP COUNT,'8'
    JLE RIKSHW1
    MOV DX,OFFSET MSG1
    MOV AH,9
    INT 21H
    JMP WHILE_
    JMP END_
    
    RIKSHW1:
    MOV AX,200
    ADD AMOUNT,AX
    MOV DX,0 ;REMAINDER IS 0
    MOV BX,10
    MOV CX,0
    L2:
        DIV BX
        PUSH DX
        MOV DX,0
        MOV AH,0
        INC CX
        CMP AX,0
        JNE L2
    L3:
        POP DX
        ADD DX,48
        MOV AH,2
        INT 21H
    LOOP L3
    INC COUNT
    INC R  
    
    JMP WHILE_
    JMP END_
    
CAAR PROC
    CMP COUNT,'8'
    JLE CAR1
    MOV DX,OFFSET MSG1
    MOV AH,9
    INT 21H
    JMP WHILE_
    JMP END_
    CAR1:
        MOV AX,300
        ADD AMOUNT,AX
        MOV DX,0
        MOV BX,10
        MOV CX,0
    L22:
        DIV BX
        PUSH DX
        MOV DX,0
        MOV AH,0
        INC CX
        CMP AX,0
        JNE L22
    L33:
        POP DX
        ADD DX,48
        MOV AH,2
        INT 21H
    LOOP L33
    INC COUNT
    INC C
    JMP WHILE_
    JMP END_

BUSS PROC
    CMP COUNT,'8'
    JLE BUS1
    MOV DX,OFFSET MSG1
    MOV AH,9
    INT 21H
    JMP WHILE_
    JMP END_
    
    BUS1:
    MOV AX,400
    ADD AMOUNT,AX
    MOV DX,0
    MOV BX,10
    MOV CX,0
    L222:
        DIV BX
        PUSH DX
        MOV DX,0
        MOV AH,0
        INC CX
        CMP AX,0
        JNE L222
    L333:
        POP DX
        ADD DX,48
        MOV AH,2
        INT 21H
    LOOP L333
    INC COUNT
    INC B
    JMP WHILE_
    JMP END_

RECRD PROC 
    MOV DX,OFFSET MSG7
    MOV AH,9
    INT 21H

;print here the whole amount
MOV AX,AMOUNT

MOV DX,0
MOV BX,10
MOV CX,0
TOTALPUSH:
    DIV BX
    PUSH DX
    MOV DX,0
    INC CX
    CMP AX,0
    JNE TOTALPUSH

TOTALPRINT:
    POP DX
    ADD DX,48
    MOV AH,2
    INT 21H
LOOP TOTALPRINT

MOV DX,10
MOV AH,2
INT 21H
MOV DX,13
MOV AH,2
INT 21H

MOV DX,OFFSET MSG8
MOV AH,9
INT 21H

MOV DX,COUNT
MOV AH,2
INT 21H

MOV DX,10
MOV AH,2
INT 21H
MOV DX,13
MOV AH,2
INT 21H

MOV DX,OFFSET MSG9
MOV AH,9
INT 21H

MOV DX,R
MOV AH,2
INT 21H

MOV DX,10
MOV AH,2
INT 21H
MOV DX,13
MOV AH,2
INT 21H

MOV DX,OFFSET MSG10
MOV AH,9
INT 21H
      
MOV DL,C
MOV AH,2
INT 21H

MOV DX,10
MOV AH,2
INT 21H
MOV DX,13
MOV AH,2
INT 21H

MOV DX,OFFSET MSG11
MOV AH,9
INT 21H

MOV DL,B
MOV AH,2
INT 21H

JMP WHILE_
JMP END_

DELT PROC
    MOV R,'0'
    MOV C,'0'
    MOV B,'0'
    MOV AMOUNT,0
    MOV COUNT,'0'
    MOV DX,OFFSET MSG12
    MOV AH,9
    INT 21H
    MOV DX,10
    MOV AH,2
    INT 21H
    MOV DX,13
    MOV AH,2
    INT 21H
    JMP WHILE_
    JMP END_
    
END MAIN