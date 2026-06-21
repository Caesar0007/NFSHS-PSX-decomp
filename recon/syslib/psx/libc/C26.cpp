/* syslib/psx/libc/C26.cpp -- RECONSTRUCTED. obj C26.obj ; libc.lib. strncpy @0x800F6104 (BIOS A0:0x1A).
 * 12-B trampoline to PSX BIOS; real code not in NFS4.EXE -> real-algorithm per the reconstruction rule. */
extern "C" char *strncpy(char *dst, const char *src, int n)   /* @0x800F6104 */
{
    char *d = dst;
    while (n > 0 && *src) { *d++ = *src++; n--; }
    while (n > 0) { *d++ = 0; n--; }
    return dst;
}
