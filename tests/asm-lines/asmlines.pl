#!/usr/bin/perl

use strict;
use warnings;

## this program reads in a line of asm at a time, calls nasm on it and outputs
## the hex code generated with the asm.
## this is for the purposes of getting a bunch of understanding of instruction codes
## i.e. for my personal benefit

#print donasm("jmp 0x0000:0x7c05",'[bits 16]');
#print donasm("mov sp, 0x7500",'[bits 16]');
my $PRE = '[bits 16]';
while(<>){
    next unless /\S/;
    if(/^\[/){
        $PRE = $_;
    }
    else {
       print donasm($_,$PRE);
    }
    #print donasm($_,"[bits 32]");
    #print donasm($_,"[bits 64]");

}

sub donasm {
    my ($asm,$pre) = @_;
    $pre = '' unless defined $pre;
    my $asmfile = 'tmp.asm';
    my $binfile = 'tmp.bin';
    my $fh;
    open($fh,'>',$asmfile) or die $!;
    print $fh "$pre\n$asm";
    close($fh);
    print STDERR `nasm -f bin -o $binfile $asmfile`;
    unlink($asmfile);
    open($fh, '<', $binfile) or die $!;
    binmode($fh);
    local $/;
    $/ = undef;
    my $bytes = <$fh>;
    close($fh);
    unlink($binfile);
    my $hex = unpack('H*',$bytes);
    my $bits = unpack('B*',$bytes);
    $hex =~ s/(..)/$1 /g;
    $bits =~ s/(.{8})/$1 /g;
    $asm =~ s/\s*$/ ; $pre $hex : $bits\n/;
    return $asm;
}

=pod

registers to check bit-patterns for...
ax
bx
cx
dx
sp

eax
ebx
ecx
edx

rax
rbx
rcx
rdx

and all the others... look them up!
Are they always the same bit-pattern in each instruction?

=cut

__DATA__



xor ax, ax
xor ax, bx
xor ax, cx
xor ax, dx
xor bx, ax
xor bx, bx
xor bx, cx
xor bx, dx
xor cx, ax
xor cx, bx
xor cx, cx
xor cx, dx
xor dx, ax
xor dx, bx
xor dx, cx
xor dx, dx


mov ax, ax
mov ax, bx
mov ax, cx
mov ax, dx
mov bx, ax
mov bx, bx
mov bx, cx
mov bx, dx
mov cx, ax
mov cx, bx
mov cx, cx
mov cx, dx
mov dx, ax
mov dx, bx
mov dx, cx
mov dx, dx


