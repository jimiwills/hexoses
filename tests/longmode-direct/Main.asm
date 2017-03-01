; this file templated from wiki.osdev.org/Entering_Long_mode_Directly
%define FREE_SPACE 0x9000 

ORG 0x7C00 
BITS 16 

; Main entry point where BIOS leaves us.  

Main: 
    jmp 0x0000:.FlushCS               ; Some BIOS' may load us at 0x0000:0x7C00 while other may load us at 0x07C0:0x0000. 
                                      ; Do a far jump to fix this issue, and reload CS to 0x0000. 

.FlushCS:  
    xor ax, ax  

    ; Set up segment registers.  
    mov ss, ax  
    ; Set up stack so that it starts below Main. 
    mov sp, Main 

    mov ds, ax 
    mov es, ax 
    mov fs, ax 
    mov gs, ax 
    cld 

    call CheckCPU                     ; Check whether we support Long Mode or not. 
    jc .NoLongMode 

    ; set A20
    call FastA20
 
    ; load up second sector...
    mov ah, 0x42
    mov dl, 0x80
    mov si, DAP
    int 0x13

    ; Point edi to a free space bracket. 
    mov edi, FREE_SPACE 
    ; Switch to Long Mode. 
    jmp SwitchToLongMode 

BITS 64 
.Long: 
    hlt 
    jmp .Long 

BITS 16 

.NoLongMode: 
    mov si, NoLongMode 
    call Print 

.Die: 
    hlt 
    jmp .Die 

;%include "CheckA20.asm"
%include "A20methods.asm"
BITS 16

NoLongMode db "ERROR: CPU does not support long mode.", 0x0A, 0x0D, 0 

DAP:
 db 	0x10 ; DAP length
 db	0x0  ; unused
 dw  	0x1  ; number sectors to read
 dw	0x7e00 ; mem offset
 dw	0x0    ; and segment
 dq	0x01   ; sector of disk to start on

%include "CheckCPU.asm"
%include "Print.asm"
; Pad out file. 

times 510 - ($-$$) db 0 
dw 0xAA55 

%include "LongModeDirectly.asm" 

times 1024 - ($-$$) db 0 
