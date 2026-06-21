/* syslib/psx/libc/C42.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\C42.obj ; archive libc.lib (PsyQ BIOS-stub).
 *   1 fn @0x800EAAC4: memcpy.  BIOS trampoline (li $t2,0xA0; jr $t2; li $t1,0x2A) to PSX BIOS A0:0x2A;
 *   the real code is NOT in NFS4.EXE -> real-algorithm implementation per the reconstruction rule.
 *   (PSX BIOS memcpy copies forward, n bytes, returns dst.)
 */
extern "C" void *memcpy(void *dst, const void *src, int n)   /* @0x800EAAC4  (BIOS A0:0x2A) */
{
    char *d = (char *)dst;
    const char *s = (const char *)src;
    while (n-- > 0)
        *d++ = *s++;
    return dst;
}
