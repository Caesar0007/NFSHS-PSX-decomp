/* syslib/psx/libc/C23.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\C23.obj ; archive C:\nfs4\SYSLIB\PSX\LIBC.LIB (xlsx col10)
 *               == libc.lib(C23.OBJ). proto: int strcmp(const char *s1, const char *s2) [string]
 *   1 fn @0x800E5D7C (16 bytes): strcmp -- a PSX **BIOS trampoline** (li $t2,0xA0; jr $t2;
 *   li $t1,0x17 = BIOS vector A0:0x17).  The real routine lives in the console BIOS, NOT the EXE,
 *   so per the BIOS-thunk rule (cf. C25/strcpy = A0:0x19, C43/memset = A0:0x2B) this is the REAL
 *   C behaviour + a `@VA BIOS A0:0x17` breadcrumb.  C-linkage; sorts/lookups across the tree need it.
 */

extern "C" int strcmp(const char *s1, const char *s2)   /* @0x800E5D7C  BIOS A0:0x17 */
{
    while (*s1 != '\0' && *s1 == *s2) {
        ++s1;
        ++s2;
    }
    return (int)(unsigned char)*s1 - (int)(unsigned char)*s2;
}
