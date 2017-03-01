nasm -fbin Main.asm -o LongModeDirectly
qemu-system-x86_64 -hda LongModeDirectly
