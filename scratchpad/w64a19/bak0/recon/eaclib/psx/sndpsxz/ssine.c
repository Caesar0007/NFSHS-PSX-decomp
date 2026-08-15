/* eaclib/psx/sndpsxz/ssine.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\ssine.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010CC40.  iSNDsin -- quarter-wave sine lookup (the pan law's crossfade table).  Ghidra
 *   nfs4-f.exe.c (ssine) + IDA sig.  Phase = a&0xff (0..0xff), quadrant = (a>>8)&3 reflects/negates the
 *   quarter-wave table snd_sine_table[0..0x100].
 */

extern unsigned short snd_sine_table[];   /* quarter-wave sine, 0x101 entries (data-mat #75) */

extern int iSNDsin(int a);                /* @0x8010CC40 */

/* iSNDsin @0x8010CC40 : full-circle sine from a 0x100-step quarter-wave table -- quadrant 0 reads forward,
 *   1 mirrors, 2 negates forward, 3 negates the mirror. MATCH (37/37): every quadrant uses the masked
 *   low-eight-bit phase; leaving quadrants 1..3 unmasked is both behaviorally wrong and byte-different. */
extern int iSNDsin(int a)
{
    unsigned int quad = (unsigned int)(a >> 8) & 3;
    a &= 0xff;
    if (quad == 0)
        return (int)(unsigned int)snd_sine_table[a];                      /* quad 0 */
    if (quad == 1)
        return (int)(unsigned int)snd_sine_table[0x100 - a];             /* quad 1 */
    if (quad == 2)
        return -(int)(unsigned int)snd_sine_table[a];                    /* quad 2 */
    return -(int)(unsigned int)snd_sine_table[0x100 - a];                /* quad 3 */
}
