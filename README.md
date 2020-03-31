# Hexoses Notes

http://www.cs.uwm.edu/classes/cs315/Bacon/Lecture/HTML/ch14s03.html
says that 0xffff0004 is the address the RO receiver data register,
of which the lowest 8 bits contain the ASCII or ISO code of the last
key press.  Load byte unsigned to get it.

https://www.doc.ic.ac.uk/lab/secondyear/spim/node24.html
explains how to use the receiver control register at 0xffff0000 to 
check whether a key is waiting to be read.

Similar registers exists at 0xffff0008 and 0xffff000c for transmitter,
which sends characters to the terminal.  But I guess we'll keep using
VGA for that.