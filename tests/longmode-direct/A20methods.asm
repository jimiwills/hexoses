; this is grossly incomplete... for more, see wiki.osdev.org/A20

[bits 16]
FastA20:
    in al, 0x92
    or al, 2
    out 0x92, al

    ret

