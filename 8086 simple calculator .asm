.model small
.stack 100h
.data
    num dw ?
    num1 dw ?
    result dw ?
    msg db 'Enter 1st number : $'
    msg1 db 0dh,0ah,'Enter 2nd number : $'
    msg2 db 0dh,0ah,'Enter operator : $'
    msg3 db 0dh,0ah,'Result is : $ '

.code
main proc
    mov ax, @data
    mov ds, ax

    call GetNumber        
    mov num, ax

    call GetNumber        
    mov num1, ax

    call GetOperator     

    cmp al, '+'
    je addition
    cmp al, '*'
    je multiply
    cmp al, '-'
    je subtract
    cmp al, '/'
    je divide
    jmp exit

addition:
    call AddNumbers
    jmp disp

multiply:
    call MultiplyNumbers
    jmp disp

subtract:
    call SubtractNumbers
    jmp disp

divide:
    call DivideNumbers
    jmp disp

disp:
    call DisplayResult
    jmp exit

exit:
    mov ah, 4ch
    int 21h

main endp

GetNumber proc
    lea dx, msg
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, 48
    mov ax, ax

    ret
GetNumber endp

GetOperator proc
    lea dx, msg2
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h

    ret
GetOperator endp

AddNumbers proc
    mov ax, num
    add ax, num1
    mov result, ax

    ret
AddNumbers endp

MultiplyNumbers proc
    mov ax, num
    mov bx, num1
    imul bx
    mov result, ax

    ret
MultiplyNumbers endp

SubtractNumbers proc
    mov ax, num1
    sub ax, num
    mov result, ax

    ret
SubtractNumbers endp

DivideNumbers proc
    mov ax, num
    mov bx, num1
    xor dx, dx
    div bx
    mov result, ax

    ret
DivideNumbers endp

DisplayResult proc
    lea dx, msg3
    mov ah, 09h
    int 21h

    mov dx, result
    add dx, 48
    mov ah, 02h
    int 21h

    ret
DisplayResult endp

end main
