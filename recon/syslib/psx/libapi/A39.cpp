/* syslib/psx/libapi/A39.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libapi.lib(A39.OBJ): SetSp -- set the stack pointer, return the previous one.
 *     0x800E44AC  addu $v0,$sp,$zero   ; return old $sp
 *     0x800E44B0  jr   $ra
 *     0x800E44B4  addu $sp,$a0,$zero   ; (delay slot) $sp = newSp
 *   The new-$sp store sits in the `jr $ra` delay slot -- a frameless register thunk no
 *   normal C function can emit (gcc would frame it and never park the $sp write in the
 *   return delay slot).  So emit it as a file-scope __asm__ (no prologue/epilogue added).
 *   proto: unsigned long SetSp(unsigned long) [libapi.h].   @0x800E44AC */
#if defined(__mips__)
__asm__("\t.set push\n\t.set noreorder\n"
        "\t.globl SetSp\nSetSp:\n"
        "\taddu  $v0, $sp, $zero\n"
        "\tjr    $ra\n"
        "\t addu $sp, $a0, $zero\n"   /* SetSp is exactly 3 words (oracle: endlabel before the
                                         0x800E44B8 nop -> that pad is inter-obj, not in the symbol) */
        "\t.set pop\n");
#else
extern "C" unsigned long SetSp(unsigned long newSp) { (void)newSp; return 0; }
#endif
