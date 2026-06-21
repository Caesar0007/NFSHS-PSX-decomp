/* syslib/psx/libapi/A36.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libapi.lib(A36.OBJ): EnterCriticalSection -- BIOS SYSCALL(1).  Unlike the A0/B0/C0
 *   table thunks this is a REAL function: it loads $a0=1, executes `syscall 0`, then returns
 *   normally (the compiler-emitted `jr $ra; nop` epilogue IS part of the function).  The
 *   oracle sets NO $v0 (the BIOS leaves the result in $v0), so the asm-level shape is void;
 *   same as SOTN: EnterCriticalSection() { SYSCALL(1) }.   @0x8010698C
 *   NOTE: bytes are exact (syscall code=0 == 0x0000000c); verify_asm shows a cosmetic
 *   "syscall" vs "syscall 0" diff because objdump omits the zero code operand and the
 *   tool's norm_ins doesn't bridge it -- a verifier-text gap, not a body mismatch. */
#if defined(__mips__)
extern "C" void EnterCriticalSection(void)
{
    __asm__ __volatile__("addiu $a0, $zero, 0x1\n\tsyscall 0" : : : "$4");
}
#else
extern "C" void EnterCriticalSection(void) {}
#endif
