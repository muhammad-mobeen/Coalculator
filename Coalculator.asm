include emu8086.inc

org 100h


.data
menu_buffer DB ,0DH,0AH,"-------------------------------",0DH,0AH
          DB ,0DH,0AH,"         Mini Calculator",0DH,0AH,0dh,0ah
          DB "Press 'a' for ADDITION",0DH,0AH
          DB "Press 's' for SUBTRACTION",0DH,0AH
          DB "Press 'm' for MULTIPLICATION",0DH,0AH
          DB "Press 'd' for DIVISION/MODULO",0DH,0AH                  
          DB "Press 'q' for FINDING SQUARE",0DH,0AH
          DB "Press 'w' for FINDING CUBE",0DH,0AH
          DB "Press 'f' for CONVERTING INTO FARANHEIT",0DH,0AH
          DB "Press 'c' for CONVERTING INTO CELCIUS",0DH,0AH
          DB "Press any other key to EXIT",0DH,0AH,0dh,0ah 
                           
          DB "Enter Your CHOICE: ",'$'            
msg1      db ,0dh,0ah,"Enter any number:  ",'$'
msg2      db ,0dh,0ah,"Enter second number: ",'$'

num1 dw 0h
num2 dw 0h
num5 dw 32
num4 dw 9
num3 dw 5 
num6 dw 0h
num7 dw 0h

.code

;

main proc
    call menu
    
ret
main endp




;Menu for handling all operations related to User Interface
menu proc
    Again:
    MOV AH,09H
    MOV DX, OFFSET menu_buffer   
    INT 21H     

    MOV AH,01H                  
    INT 21H
    CMP al,'a'
    JE addi
    CMP al,'s'
    JE subt   
    CMP al,'m'
    JE multi
    CMP al,'d'
    JE divi 
    CMP al,'q'
    JE  sq
    CMP al,'w'
    JE cube_   
    CMP al,'f'
    JE farenheit
    CMP al,'c'
    JE celcius 
              
    print 10
    print 10
    print 13
    print "Exiting the calculator///////.........------>>>"
    ret
    
    addi:
    call addition
    JMP return
    
    subt:
    call subtraction
    JMP return
    
    multi:
    call multiplication
    JMP return
    
    divi:
    call division
    JMP return
    
    sq:
    call square
    JMP return
    
    cube_:
    call cube
    JMP return
    
    farenheit:
    call to_farenheit
    JMP return
    
    celcius:
    call to_celcius
    JMP return
    
    return:
    print 10
    print 10
    print 13
    print "Press any key to continue........."
    print 10
    MOV AH,01H                  
    INT 21H
    mov ax, 3
    int 10h
    JMP Again

menu endp




;Addition function
addition proc
    print 10
    print 13
    print 10
    print 13
    print '_*_*_* Addition *_*_*_'
    print 10
    print 13     
    MOV AH,09H
    MOV DX, OFFSET msg1   
    INT 21H  
    call scan_num
    mov num1,cx
    
    MOV AH,09H
    MOV DX, OFFSET msg2   
    INT 21H  
    call scan_num
    mov num2,cx
            
    mov ax,num1
    add ax,num2
    print 10
    print 13
    print 'Answer: '
    call print_num        
    
ret
addition endp



;Subtration Function
subtraction proc
    print 10
    print 13
    print 10
    print 13
    print '_*_*_* Substraction *_*_*_'
    print 10
    print 13
          
    MOV AH,09H
    MOV DX, OFFSET msg1   
    INT 21H  
    call scan_num
    mov num1,cx
    
    MOV AH,09H
    MOV DX, OFFSET msg2   
    INT 21H  
    call scan_num
    mov num2,cx
            
    mov ax,num1
    sub ax,num2
    print 10
    print 13
    print 'Answer: '
    call print_num
ret
subtraction endp




;Multiplication Function
multiplication proc
    print 10
    print 13 
    print 10
    print 13
    print '_*_*_* Multiplication *_*_*_'
    print 10
    print 13
          
    MOV AH,09H
    MOV DX, OFFSET msg1   
    INT 21H  
    call scan_num
    mov num1,cx
    
    MOV AH,09H
    MOV DX, OFFSET msg2   
    INT 21H  
    call scan_num
    mov num2,cx
            
    mov ax,num1
    mul num2
    print 10
    print 13
    print 'Answer: '
    call print_num
ret
multiplication endp



;Division Function
division proc
    print 10
    print 13  
    print '_*_*_* Division *_*_*_'
    print 10
    print 13
          
    MOV AH,09H
    MOV DX, OFFSET msg1   
    INT 21H  
    call scan_num
    mov num1,cx
    
    MOV AH,09H
    MOV DX, OFFSET msg2   
    INT 21H  
    call scan_num
    mov num2,cx
            
    
    mov ax,1
    mul num1
    div num2
    print 10
    print 13
    print 'Answer: '
    call print_num 
    print 10
    print 13
    print 'Remainder (MOD): '
    mov ax, dx
    call print_num
ret
division endp




;Square Function
square proc
    MOV AH,09H
    MOV DX, OFFSET msg1   
    INT 21H  
    call scan_num
    mov num1,cx 
    mov ax,num1
    mul num1 
    print 10
    print 13
    print 'Answer: '
    call print_num
ret
square endp



;Cube Function
cube proc
    MOV AH,09H
    MOV DX, OFFSET msg1   
    INT 21H  
    call scan_num
    mov num1,cx 
    mov ax,num1
    mul num1
    mul num1 
    print 10
    print 13
    print 'Answer: '
    call print_num
ret
cube endp



;Celcius to Farenheit Converter
to_farenheit proc
    ;Expression=> (C * 9/5 ) +32 
    MOV AH,09H
    MOV DX, OFFSET msg1   
    INT 21H
    call scan_num 
    mov num1,cx 
    
    mov ax,num1
    mul num4
    div num3
    add ax,num5
     
    print 10
    print 13
    print 'Answer: '
    call print_num
ret
to_farenheit endp



;Farenheit to Celcius Converter
to_celcius proc
    ;Expression=> (F - 32 ) * 5/9 = 0C
    MOV AH,09H
    MOV DX, OFFSET msg1   
    INT 21H
    call scan_num 
    mov num1,cx  
    mov ax,num1
    sub ax,num5
    mul num3
    div num4 
    
    print 10
    print 13
    print 'Answer: '
    call print_num
ret
to_celcius endp
                        
;-                     -                     -;
; -                   - -                   - ;
;  -                 -   -                 -  ;
;   -               -     -               -   ;
;    -             -       -             -    ;
;     -           -         -           -     ;
;      -         -           -         -      ;
;       -       -             -       -       ;
;        -     -               -     -        ;
;         -   -                 -   -         ;
;          - -                   - -          ;
;           -                     -           ;

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_SCAN_NUM
ret