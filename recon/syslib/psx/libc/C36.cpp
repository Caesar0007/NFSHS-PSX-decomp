/* syslib/psx/libc/C36.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\C36.obj ; archive C:\nfs4\SYSLIB\PSX\LIBC.LIB (xlsx col10)
 *               == libc.lib(C36.OBJ). proto: char *strstr(const char *hay, const char *needle) [string]
 *   1 fn @0x800E62CC (16 bytes): strstr -- a PSX **BIOS trampoline** (li $t2,0xA0; jr $t2;
 *   li $t1,0x24 = BIOS vector A0:0x24).  The real routine lives in the console BIOS, NOT the EXE,
 *   so per the BIOS-thunk rule (cf. C23/strcmp=A0:0x17, C25/strcpy=A0:0x19, C43/memset=A0:0x2B)
 *   this is the REAL C behaviour + a `@VA BIOS A0:0x24` breadcrumb.  C-linkage.
 */

extern "C" char *strstr(const char *hay, const char *needle)   /* @0x800E62CC  BIOS A0:0x24 */
{
    if (*needle == '\0')
        return (char *)hay;                 /* empty needle matches at start */

    for (; *hay != '\0'; ++hay) {
        const char *h = hay;
        const char *n = needle;
        while (*h != '\0' && *h == *n) {
            ++h;
            ++n;
        }
        if (*n == '\0')                      /* whole needle matched */
            return (char *)hay;
    }
    return 0;
}
