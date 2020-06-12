org 100h

; add your code here

; INPUTTING SECTION
;====================================================
input:  mov AH, 00h ; enter the first digit
        int 16h

        sub AL, 48  ; get the number from ASCII by sub by 48
        mov BL, 10
        mul BL      ; AX = AL * BL
        mov DX, AX  ; temporarily store in DX

        mov AH, 00h ; enter the second digit
        int 16h
        
        sub AL, 48
        mov AH, 0
        add DX, AX  ; DX has the entered value
        mov temp, DL    ; backup entered value in temp var

        mov AX, DX  ; check if the entered number is gr8er than 45
        mov BX, 45
        cmp AX, BX
        jg  input
;====================================================
; END OF INPUTTING SECTION                           


; PREPARING FOR THE CALCULATION
;====================================================
mov SI, 700h        ; location where the series will be stored

mov CX, 20

setF1F2:
    mov [SI], 0
    inc SI
    loop setF1F2

mov [SI], 1
mov [SI - 10], 1

mov CX, DX          ; CX is the counter for the loop
sub CX, 2           ; we've already had 2 numbers in the series
;=====================================================
; END OF PREPARING FOR THE CALCULATION


; CALCULATE THE REST NUMBERS IN THE SERIES
;=====================================================
caltheseries:
    mov AL, [SI - 10]
    mov BL, [SI]
    add AL, BL
    mov BL, 10
    div BL
    mov carry, AL
    mov [SI + 10], AH
    mov AH, 0
    
    mov AL, [SI - 11]
    mov BL, [SI - 1]
    add AL, BL
    mov BL, carry
    add AL, BL
    mov BL, 10
    div BL
    mov carry, AL
    mov [SI + 9], AH
    mov AH, 0 
    
    mov AL, [SI - 12]
    mov BL, [SI - 2]
    add AL, BL
    mov BL, carry
    add AL, BL
    mov BL, 10
    div BL
    mov carry, AL
    mov [SI + 8], AH
    mov AH, 0 
    
    mov AL, [SI - 13]
    mov BL, [SI - 3]
    add AL, BL
    mov BL, carry
    add AL, BL
    mov BL, 10
    div BL
    mov carry, AL
    mov [SI + 7], AH    
    mov AH, 0 
    
    mov AL, [SI - 14]
    mov BL, [SI - 4]
    add AL, BL
    mov BL, carry
    add AL, BL
    mov BL, 10
    div BL
    mov carry, AL
    mov [SI + 6], AH  
    mov AH, 0 
    
    mov AL, [SI - 15]
    mov BL, [SI - 5]
    add AL, BL
    mov BL, carry
    add AL, BL
    mov BL, 10
    div BL
    mov carry, AL
    mov [SI + 5], AH 
    mov AH, 0 
    
    mov AL, [SI - 16]
    mov BL, [SI - 6]
    add AL, BL
    mov BL, carry
    add AL, BL
    mov BL, 10
    div BL
    mov carry, AL
    mov [SI + 4], AH 
    mov AH, 0 
    
    mov AL, [SI - 17]
    mov BL, [SI - 7]
    add AL, BL
    mov BL, carry
    add AL, BL
    mov BL, 10
    div BL
    mov carry, AL
    mov [SI + 3], AH 
    mov AH, 0 
    
    mov AL, [SI - 18]
    mov BL, [SI - 8]
    add AL, BL
    mov BL, carry
    add AL, BL
    mov BL, 10
    div BL
    mov carry, AL
    mov [SI + 2], AH  
    mov AH, 0 
    
    mov AL, [SI - 19]
    mov BL, [SI - 9]
    add AL, BL
    mov BL, carry
    add AL, BL
    mov BL, 10
    div BL
    mov carry, AL
    mov [SI + 1], AH
    
    add SI, 10
    
    loop caltheseries
;=========================================================
; END OF CALCULATING THE SERIES


;PRINT THE NUMBERS
;=========================================================
mov SI, 700h
inc SI
mov CX, 10
mov DL, temp 

; check for zeros at the start of a number
checkzero:
        mov AL, [SI]
        cmp AL, 0
        je  ignorezero
        
printchar:
        mov AH, 0Eh
        mov AL, [SI]
        add AL, 48
        int 10h
        inc SI
        loop printchar 

        ; newline
        mov AH, 0Eh
        mov AL, 13          ; carriage return char
        int 10h
        mov AH, 0Eh
        mov AL, 10          ; new line char
        int 10h
        
        mov CX, 10
        add DL, -1
        
        cmp DL, 0
        jne checkzero
        jmp end

; ignore and don't print zero at the start of
; a number
ignorezero:
        add CX, -1
        inc SI
        jmp checkzero

end:
ret

temp    DB ?
carry   DB ?
