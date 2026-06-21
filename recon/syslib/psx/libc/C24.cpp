/* syslib/psx/libc/C24.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\C24.obj ; archive libc.lib (PsyQ BIOS-stub).
 *   1 fn @0x800EB1D0: strncmp.  BIOS trampoline (li $t2,0xA0; jr $t2; li $t1,0x18) to PSX BIOS A0:0x18;
 *   the real code is NOT in NFS4.EXE -> real-algorithm implementation per the reconstruction rule.
 *   Compares at most n bytes; returns the signed difference of the first differing (unsigned) chars,
 *   or 0 if equal through n bytes / a shared terminator.
 */
extern "C" int strncmp(const char *a, const char *b, int n)   /* @0x800EB1D0  (BIOS A0:0x18) */
{
    while (n-- > 0) {
        unsigned char ca = (unsigned char)*a++;
        unsigned char cb = (unsigned char)*b++;
        if (ca != cb)
            return (int)ca - (int)cb;
        if (ca == 0)
            break;
    }
    return 0;
}
