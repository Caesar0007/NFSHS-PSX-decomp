/* syslib/psx/libc/C21.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\C21.obj == libc.lib(C21.OBJ).  1 fn @0x800E78E8 : strcat.
 *   BIOS trampoline (li $t2,0xA0; jr $t2; li $t1,0x15 = A0:0x15) -> real C behaviour + breadcrumb.
 */
extern "C" char *strcat(char *dst, const char *src)   /* @0x800E78E8  BIOS A0:0x15 */
{
    char *d = dst;
    while (*d) ++d;
    while ((*d++ = *src++) != '\0') ;
    return dst;
}
