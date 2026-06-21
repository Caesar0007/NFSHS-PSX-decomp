/* syslib/psx/libapi/A39.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\A39.obj ; archive C:\nfs4\SYSLIB\PSX\LIBAPI.LIB (xlsx col10)
 *               == libapi.lib(A39.OBJ) (disasm-v3 // obj:). proto: unsigned long SetSp(unsigned long) [libapi.h]
 *   1 fn @0x800E44AC (16 bytes): SetSp -- set the stack pointer, return the previous one.
 *     0x800E44AC  $2 = $29        ; return old $29
 *     0x800E44B0  jr $31
 *     0x800E44B4  $29 = $4        ; (delay slot) $29 = newSp
 *   Register-level ($29) -> not portable C: kept under #ifdef __mips__ (faithful) with a host
 *   no-op fallback so the TU typechecks in the whole-tree sweep. C-linkage; resolves via libfns.h.
 */

extern "C" unsigned long SetSp(unsigned long newSp)   /* @0x800E44AC */
{
#ifdef __mips__
    unsigned long old;
    __asm__ volatile("move %0, $29\n\tmove $29, %1" : "=&r"(old) : "r"(newSp));
    return old;
#else
    (void)newSp;          /* host: no real $29 to swap */
    return 0;
#endif
}
