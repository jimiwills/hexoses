; wiki.osdev.org/Rolling_Your_Own_Bootloader
; suggests to look at /Ralf_Brown's_Interrupt_List

; for 13h ah=0x42, drive 0x80

ExtendedReadSectorsFromDrive:
	mov ah, 42h
	mov dl, 80h
	; ds:si seg:offset pointer to DAP...

DAP:
	;1 byte... suze of dap = 10h
	; 1byte, unused = 0
	; 2bytes, number of sectors to read
	; 4 bytes, seg:offset (offset must be before segment?)
	; 8 bytes, absolute number of start sector (1st sector is 0)

	; returns 
	; cf  set on error, else clear
	; ah  return code

	
