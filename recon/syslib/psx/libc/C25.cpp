/* syslib/psx/libc/C25.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\C25.obj ; archive C:\nfs4\SYSLIB\PSX\LIBC.LIB (xlsx col10)
 *               == libc.lib(C25.OBJ). proto: char *strcpy(char *dst, const char *src) [stdio/string]
 *   1 fn @0x800E5B28 (16 bytes): strcpy -- a PSX **BIOS trampoline** (li $t2,0xA0; jr $t2;
 *   li $t1,0x19 = BIOS vector A0:0x19).  The real routine lives in the console BIOS, NOT the EXE,
 *   so per the BIOS-thunk rule (cf. C43/memset = A0:0x2B) this is reconstructed as the REAL C
 *   behaviour + a `@VA BIOS A0:0x19` breadcrumb.  C-linkage; many TUs (memstd/nsync/...) need it.
 */

extern "C" char *strcpy(char *dst, const char *src)   /* @0x800E5B28  BIOS A0:0x19 */
{
    char *d = dst;
    while ((*d++ = *src++) != '\0')
        ;
    return dst;
}
