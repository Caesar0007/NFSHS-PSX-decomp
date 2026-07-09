/* syslib/psx/libsn/SNMAIN.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libsn.lib(SNMAIN.OBJ): the SN runtime.  __main @0x800E4024 is GCC's static-constructor
 *   invoker; here it is EMPTY (NFS4 links no global C++ ctors through it) -- the oracle body is just
 *   `jr ra; nop`.  The CRT entry point that follows it in the object (__SN_ENTRY_POINT/start
 *   @0x800E402C: set $sp, clear .bss from _bss_obj.._bss_objend, jump to main) is the target boot
 *   stub -- inherently machine code, not part of the recompilable tree.
 *
 *   FILE-SCOPE __asm__ (BIOS_THUNK style): emits exactly `jr ra; nop` with no extra compiler
 *   epilogue.  An empty C `void __main(void){}` body would emit the same two words BUT this keeps
 *   it in the SNMAIN obj with the exact oracle form. */
#if defined(__mips__)
__asm__("\t.set push\n\t.set noreorder\n"
        "\t.globl __main\n__main:\n"
        "\tjr    $ra\n"
        "\t nop\n"
        "\t.set pop\n");
#else
extern void __main(void) { }   /* host: no global constructors to run */
#endif
