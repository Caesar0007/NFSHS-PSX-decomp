/* eaclib/psx/sndpsxz/ssine.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\ssine.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010CC40.  iSNDsin -- quarter-wave sine lookup (the pan law's crossfade table).  Ghidra
 *   nfs4-f.exe.c (ssine) + IDA sig.  Phase = a&0xff (0..0x100), quadrant = (a>>8)&3 reflects/negates the
 *   quarter-wave table snd_sine_table[0..0x100].
 */

extern unsigned short snd_sine_table[];   /* quarter-wave sine, 0x101 entries (data-mat #75) */

extern int iSNDsin(int a);                /* @0x8010CC40 */

/* iSNDsin @0x8010CC40 : full-circle sine from a 0x100-step quarter-wave table -- quadrant 0 reads forward,
 *   1 mirrors, 2 negates forward, 3 negates the mirror. */
extern int iSNDsin(int a)
{
    unsigned int quad = (unsigned int)(a >> 8) & 3;
    if (quad != 0) {
        if (quad != 1) {
            if (quad == 2)
                return -(int)(unsigned int)snd_sine_table[a];           /* quad 2: raw a (@0x8010cc94 a<<1) */
            return -(int)(unsigned int)snd_sine_table[0x100 - a];       /* quad 3: raw a (@0x8010cca4) */
        }
        return (int)(unsigned int)snd_sine_table[0x100 - a];            /* quad 1: raw a (@0x8010cc80) */
    }
    return (int)(unsigned int)snd_sine_table[(unsigned int)a & 0xff];   /* quad 0: phase masked (@0x8010cc4c) */
}
