/* syslib/psx/libsn/PUREV.cpp -- RECONSTRUCTED from nfs4-f.exe.  obj PUREV.OBJ ; LIBSN.LIB.
 *   1 fn @0x800E4354 (4 bytes): `__pure_virtual` -- the cfront pure-virtual-call handler.
 *
 *   Body is a SINGLE instruction: `break 0` (trap; __noreturn -- no `jr ra`, no epilogue).
 *   cfront installs the address of this routine into the abstract slots of every vtable
 *   (see vtables_*.cpp: `&__pure_virtual`); calling a pure-virtual method through such a slot
 *   lands here and traps.
 *
 *   ⚠️ Ghidra MIS-DECODES this 1-instruction trap as a phantom-register function
 *      (`undefined4 in_a0/in_a1 ...` garbage) -- disasm-v3 / IDA (`void __noreturn`) are the
 *      authority: the real body is just `break 0`.
 *   FILE-SCOPE __asm__ (BIOS_THUNK style) emits EXACTLY the one `break 0` word with no compiler
 *   epilogue appended -- a C function body (even naked) would append `jr ra; nop`.  The vtable
 *   references it via an `extern "C" int __pure_virtual(...)` decl that casts the address. */
#if defined(__mips__)
__asm__("\t.set push\n\t.set noreorder\n"
        "\t.globl __pure_virtual\n__pure_virtual:\n"
        "\tbreak 0\n"
        "\t.set pop\n");
#else
extern "C" int __pure_virtual(...) { for (;;) { } }   /* host: never returns */
#endif
