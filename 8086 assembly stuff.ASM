.model small
.stack 100h
.data 

string1 db 100 dup ('$')
str1 db 100 dup ('$')
str2 db 100 dup('$')
msg1 db "ENTER YOUR NAME: $"
msg2 db "NUMBER OF VOWELS: $"
MSG3 DB "NUMBER OF CONSONENTS: $"
msg4 db "BINARY OUTPUT: $"
MSG5  DB "CASE CONVERSION: $"
pica dw 0
dica db ?
shy1 db 50 dup ('$')
msg6 db "HEXADECIMAL: $"
LINE DB 10,13,'$'
msg7 db "REVERSE OF STRING: $"
str3 db 100 dup('$')
str4 db  100 dup('$')
str5 db  100 dup('$')
msg8 db "WITHOUT VOWELS: $"
MSG9 DB "WITHOUT CONSONENTS: $"

;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

.CODE 
MAIN PROC
MOV AX,@DATA
MOV DS,AX

MOV AH,09H
MOV DX,OFFSET MSG1
INT 21H

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CALL INPUTNAAM  
call printnaam  
call convertcase
call printconverted
call vowelcase
call vowelprint
call CONVERT_TO_BINARY
call newline
call hexaname
call Processcharacter
call OutputResult
call reverseo
call vowelsss

mov ah,4ch
int 21h
main endp

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


INPUTNAAM PROC
LEA SI,string1

NAAM:
MOV AH,01H
INT 21H

MOV [SI],AL
INC SI

CMP AL,'$'
JE NAAMDONE
jmp NAAM

NAAMDONE:
RET

INPUTNAAM ENDP

convertcase proc
lea si,string1
lea di,str1

convert_loop:
  MOV AL, [SI]
  CMP AL, '$'
  JE convert_loop_done

  CMP AL, 'A'
  JB NOT_LETTER
  CMP AL, 'Z'
  JBE CONVERT_UPPER

  CMP AL, 'a'
  JB NOT_LETTER
  CMP AL, 'z'
  JBE CONVERT_LOWER

NOT_LETTER:
  INC SI
  JMP CONVERT_LOOP

CONVERT_UPPER:
  ADD AL, 32
  MOV [DI], AL
  INC DI
  INC SI
  JMP CONVERT_LOOP

CONVERT_LOWER:
  SUB AL, 32
  MOV [DI], AL
  INC DI
  INC SI
  JMP CONVERT_LOOP

convert_loop_done:
ret
convertcase endp

vowelcase proc
lea si,string1
mov bl,'0'
mov cl,'0'

 VOWELS:
    MOV AL, [SI]
    CMP AL, '$'
    JE vowel_done
    CMP AL, 'A'
    JE VOWEL_COUNT
    CMP AL, 'E'
    JE VOWEL_COUNT
    CMP AL, 'I'
    JE VOWEL_COUNT
    CMP AL, 'O'
    JE VOWEL_COUNT
    CMP AL, 'U'
    JE VOWEL_COUNT
    CMP AL, 'a'
    JE VOWEL_COUNT
    CMP AL, 'e'
    JE VOWEL_COUNT
    CMP AL, 'i'
    JE VOWEL_COUNT
    CMP AL, 'o'
    JE VOWEL_COUNT
    CMP AL, 'u'
    JE VOWEL_COUNT
    JMP CONSONENT
    

  VOWEL_COUNT:
    INC BL
    INC SI
    JMP VOWELS
  CONSONENT:
        INC CL
        INC SI
        JMP VOWELS

vowel_done:
ret
vowelcase endp

CONVERT_TO_BINARY PROC
    LEA SI, STRING1
    LEA DI, STR2
    CALL CONVERTG_LOOP

    MOV BYTE PTR [DI], '$'

    CALL PRINT_BINARY_RESULT  
    RET

    CONVERTG_LOOP:
        MOV AL, [SI]
        MOV BH, AL
        MOV BL, 80H  
        MOV CL, 8 
    BIT_LOOP:
        TEST BH, BL 
        JZ PRINT_ZERO
        JMP PRINT_ONE

    PRINT_ZERO:
        MOV DL, '0'
        MOV [DI], DL
        INC DI
    
        JMP SHIFT_BIT

    PRINT_ONE:
        MOV DL, '1'
        MOV [DI], DL
        INC DI
      
   
    SHIFT_BIT:
        SHL BH, 1 
        LOOP BIT_LOOP 
        INC SI 
        CMP AL, '$' 
        JE PARTE_EXIT 
        JMP CONVERTG_LOOP 

    PARTE_EXIT:
        RET

hexaname proc
    mov ah,09h
    mov dx,offset MSG6
    int 21h
lea si,string1
mov cx,30

hexprocedureloop:
mov al,[si]
mov dica,al
cmp al,'$'
je next
call checkcharacter
lea si,shy1
mov cl,4
and al,0f0h
shr al,cl
call processcharacter
       mov [si], al
        inc si
        mov al, dica
        and al, 0fh
        call ProcessCharacter
        mov [si], al
        inc pica
 Hehe:
        lea si, string1
        add si, pica

        mov ah, 9
        lea dx, shy1
        int 21h

        mov dl, 32
        mov ah, 2
        int 21h

        loop hexprocedureloop
    
   Next:
    ret
hexaname endp

CheckCharacter proc
    cmp al, 32
    je YCheck
    ret
YCheck:
    lea si, string1
    inc pica
    add si, pica
    jmp hexprocedureloop
CheckCharacter endp

ProcessCharacter proc
    cmp al, 9
    jle Digit

    cmp al, 15
    jle Alpha

    ret

Digit:
    add al, 48
    ret

Alpha:
    add al, 55
    ret
ProcessCharacter endp


reverseo proc
mov ah,09h
mov dx,offset msg7
int 21h

mov cx,0
lea si,string1
lea di,str3


reversing:
mov al,[si]
cmp al,'$'
je exi
inc cx
push ax
inc si
jmp reversing

exi:

senpai:
pop bx
mov dl,bl
mov ah,02h
int 21h
loop senpai
ret

reverseo endp


vowelsss proc
    mov ah,09h
    mov dx,offset line
    int 21h
lea si,string1
lea di,str4
lea bx,str5

REMOVE_LOOP:
    MOV AL, [SI]
    CMP AL, '$'
    JE STRING_WITHOUT_VOWEL

    CMP AL, 'A'
    JE SKIP_CHARACTER
    CMP AL, 'E'
    JE SKIP_CHARACTER
    CMP AL, 'I'
    JE SKIP_CHARACTER
    CMP AL, 'O'
    JE SKIP_CHARACTER
    CMP AL, 'U'
    JE SKIP_CHARACTER
    CMP AL, 'a'
    JE SKIP_CHARACTER
    CMP AL, 'e'
    JE SKIP_CHARACTER
    CMP AL, 'i'
    JE SKIP_CHARACTER
    CMP AL, 'o'
    JE SKIP_CHARACTER
    CMP AL, 'u'
    JE SKIP_CHARACTER

    JMP CONSONENTTT

CONSONENTTT: 
    MOV [DI], AL
    INC DI
    INC SI 
    JMP REMOVE_LOOP   

    SKIP_CHARACTER:
    MOV [BX],AL
    INC BX
    INC SI
    JMP REMOVE_LOOP

STRING_WITHOUT_VOWEL:
    MOV DX,OFFSET MSG8
    MOV AH,09H
    INT 21H

    LEA DX,STR4
    MOV AH, 09H
    INT 21H
    
    mov ah,09h
    mov dx,offset line
    int 21h

    MOV DX,OFFSET MSG9
    MOV AH,09H
    INT 21H

    LEA DX,STR5
    MOV AH,09H
    INT 21H
  
   RET 
vowelsss endp











;--------------------------------------------------------------------------------------------------
printnaam PROC
mov ah,09h
mov dx,offset line
int 21h 

LEA DX,string1
mov ah,09h
int 21h


ret
printnaam endp 

printconverted PROC
mov ah,09h
mov dx, offset line
int 21h 


LEA DX, STR1
MOV AH, 09H
INT 21H

ret 
printconverted endp

vowelprint PROC
mov ah,09h
mov dx,offset line
int 21h

mov ah,09h
mov dx,offset MSG2
INT 21H

MOV AH,02h
MOV DL,BL
INT 21H

MOV AH,09H
MOV DX,offset line
int 21h

mov ah,09h
mov dx,offset MSG3
INT 21H

MOV AH,02H
MOV DL,CL
INT 21H

mov ah,09h
mov dx,offset line
int 21h
    
    mov ah,09h
    mov dx,offset msg4
    int 21h
ret
vowelprint endp

PRINT_BINARY_RESULT PROC
   
    LEA DX, STR2
    MOV AH, 09H
    INT 21H
    RET
    PRINT_BINARY_RESULT ENDP

    OutputResult proc

    mov dl, 10
    mov ah, 2
    int 21h

    mov cx, 30
    lea si, string1

     ret
OutputResult endp


newline proc
mov ah,09h
mov dx,offset line 
int 21h

ret 
newline endp


end main