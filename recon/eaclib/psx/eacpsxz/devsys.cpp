/* eaclib/psx/eacpsxz/devsys.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\devsys.obj ; EACPSXZ.LIB.  1 fn @0x80106CF0.  psxdevelopmentsystem -- region/dev-kit
 *   probe: read the kernel region word @0x86 (0x375A -> 1, 0x275A -> 0, else -1).
 *   Ghidra nfs4-f.exe.c + disasm-v3 (the `in_zero` base is $zero, so the address is absolute 0x86).
 */
extern "C" int psxdevelopmentsystem(void);   /* @0x80106CF0 */
extern "C" int psxdevelopmentsystem(void)
{
    unsigned short v = *(volatile unsigned short *)0x86;   /* PSX kernel region marker */
    if (v == 0x375a) return 1;
    if (v == 0x275a) return 0;
    return -1;
}
