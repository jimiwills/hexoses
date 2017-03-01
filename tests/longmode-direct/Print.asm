
; Prints out a message using the BIOS. 

; es:si    Address of ASCIIZ string to print. 

Print: 
    pushad 
.PrintLoop: 
    lodsb                             ; Load the value at [@es:@si] in @al. 
    test al, al                       ; If AL is the terminator character, stop printing. 
    je .PrintDone 
    mov ah, 0x0E 
    int 0x10 
    jmp .PrintLoop                    ; Loop till the null character not found. 

.PrintDone: 
    popad                             ; Pop all general purpose registers to save them. 
    ret 


