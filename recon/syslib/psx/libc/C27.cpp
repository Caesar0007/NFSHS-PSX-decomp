/* syslib/psx/libc/C27.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\C27.obj ; archive libc.lib (PsyQ BIOS-stub).
 *   1 fn @0x800E9F74: strlen.  In the EXE this is a BIOS trampoline (li $t2,0xA0; jr $t2; li $t1,0x1B)
 *   that tail-calls the PSX BIOS A0:0x1B vector -- the actual code is NOT in NFS4.EXE.  Per the
 *   reconstruction rule, a true BIOS trampoline gets a real-algorithm implementation (not a thunk).
 */
extern "C" int strlen(const char *s)   /* @0x800E9F74  (BIOS A0:0x1B) */
{
    const char *p = s;
    while (*p)
        p++;
    return (int)(p - s);
}
