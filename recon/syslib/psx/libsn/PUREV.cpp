/* syslib/psx/libsn/PUREV.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\PUREV.obj  (xlsx)  == libsn.lib(PUREV.OBJ) (disasm-v3 "// obj:")
 *   Original   : SN Systems C++ runtime, LIBSN.LIB (library binary, no .c source).
 *   1 fn @0x800E4354 (4 bytes): `__pure_virtual` -- the cfront pure-virtual-call handler.
 *
 *   Body is a SINGLE instruction: `break 0` (trap; __noreturn). cfront installs the address of
 *   this routine into the abstract slots of every vtable (see vtables_*.cpp: `&__pure_virtual`);
 *   calling a pure-virtual method through such a slot lands here and traps.
 *
 *   ⚠️ Ghidra MIS-DECODES this 1-instruction trap as a phantom-register function
 *      (`undefined4 in_a0/in_a1 ...` garbage) -- disasm-v3 / IDA (`void __noreturn`) are the
 *      authority: the real body is just `break 0`.
 *   IDA proto is `void __pure_virtual(void)`, but the tree's vtables reference it as
 *   `extern "C" int __pure_virtual(...)` (the vtable casts the address); defined to match that
 *   so it links. Asm-only trap -> `#ifdef __mips__` faithful `break 0` + host abort fallback.
 */

extern "C" int __pure_virtual(...)   /* @0x800E4354  break 0 (never returns) */
{
#ifdef __mips__
    __asm__ volatile("break 0");
#endif
    for (;;) { }   /* never returns */
}
