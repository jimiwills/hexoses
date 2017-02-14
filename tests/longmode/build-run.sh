nasm -f bin Main.asm -o LongMode.bin
qemu-system-x86_64 -hda LongMode.bin
