%define FREE_SPACE 0x9000
%define COMPORTS 0x0400 ; 4 words
%define LPT 0x0408 ; 3 words
%define EBDA 0x040E ; word EBDA address >> 4
%define HWB 0x410 ; word hw bits
%define KBSTATE 0x0417 ;word keybaord state flags
%define KBBUF 0x41E ; 32 bytes keyboard buffer
%define DISPMODE 0x0449 ; byte display mode
%define COLS 0x044A ; word number of columns in text mode
%define IOVID 0x0463 ; word base IO port for video
%define IRQTICKS 0x046C ; word
%define HDDS 0x0475 ; byte
%define KBBUFSTART 0x0480 ; word
%define KBBUFEND 0x482 ; word
%define LASTSHIFT 0x0497; byte last kb LED/shift state
%define VGARAM 0x000A0000 ; 128 KiB
%define VGA 0xB8000; where we can put text...
%define VIDEOBIOS 0x000C0000 ; 32 KiB
%define MAPPEDHW 0x000C8000 ; 160 KiB
%define BIOS 0x000F0000 ; 64 KiB mobo bios

ORG 0x7C00
BITS 16

Main:
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

    mov edi, VGA


    mov ax, 0x1F6C
    mov [edi],ax
    mov ax, 0x1F6C
    mov [edi],ax
    mov ax, 0x1F65
    mov [edi],ax
    mov ax, 0x1F48    
    mov [edi],ax
    mov ax, 0x1F6F  
    mov [edi],ax
    mov ax, 0x1F57    
    mov [edi],ax
    mov ax, 0x1F20    
    mov [edi],ax
    mov ax, 0x1F6F    
    mov [edi],ax
    mov ax, 0x1F21    
    mov [edi],ax
    mov ax, 0x1F64    
    mov [edi],ax
    mov ax, 0x1F6C    
    mov [edi],ax
    mov ax, 0x1F72    
    mov [edi],ax

Here:
    hlt
    jmp Here

times 510 - ($-$$) db 0
dw 0xAA55

