/* syslib/psx/libc/C47.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\C47.obj ; archive libc.lib (PsyQ BIOS-stub).
 *   1 fn @0x800EAAD4: rand.  BIOS trampoline (li $t2,0xA0; jr $t2; li $t1,0x2F) to PSX BIOS A0:0x2F;
 *   the real code is NOT in NFS4.EXE -> real-algorithm implementation per the reconstruction rule.
 *
 *   The PSX BIOS rand() is the classic 32-bit LCG over an internal seed (srand, A0:0x30, sets it):
 *       seed = seed * 0x41C64E6D + 0x3039 ; return (seed >> 16) & 0x7FFF
 *   The seed defaults to 1.  `_rand_seed` is shared with srand (its own libc obj) when reconstructed.
 */
unsigned int _rand_seed = 1;          /* PSX BIOS RandSeed (default 1; srand overwrites) */

extern "C" int rand(void)             /* @0x800EAAD4  (BIOS A0:0x2F) */
{
    _rand_seed = _rand_seed * 0x41C64E6Du + 0x3039u;
    return (int)((_rand_seed >> 16) & 0x7FFF);
}
