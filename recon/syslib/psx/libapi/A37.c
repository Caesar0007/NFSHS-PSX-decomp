/* syslib/psx/libapi/A37.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libapi.lib(A37.OBJ): ExitCriticalSection -- BIOS SYSCALL(2).  Real function (loads
 *   $a0=2, `syscall 0`, normal `jr $ra; nop` epilogue, no $v0 set).  Same shape as SOTN:
 *   ExitCriticalSection() { SYSCALL(2) }.   @0x8010696C
 *   NOTE: bytes are exact (syscall code=0 == 0x0000000c); verify_asm shows a cosmetic
 *   "syscall" vs "syscall 0" diff because objdump omits the zero code operand and the
 *   tool's norm_ins doesn't bridge it -- a verifier-text gap, not a body mismatch. */
#if defined(__mips__)
extern void ExitCriticalSection(void)
{
    __asm__ __volatile__("addiu $a0, $zero, 0x2\n\tsyscall 0" : : : "$4");
}
#else
extern void ExitCriticalSection(void) {}
#endif
