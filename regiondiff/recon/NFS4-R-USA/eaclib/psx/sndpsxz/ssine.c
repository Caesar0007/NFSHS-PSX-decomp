/* REGIONAL CANDIDATE (NFS4-R-USA; the variant is shared by all six regionals).
 *   REGIONAL DELTA = NONE.  The retail slice @0x8010D89C is the SAME 37-instruction stream as the base
 *   @0x8010CC40; the only byte difference is the %hi/%lo pair for sndsintbl (base 0x8013C348 vs R-USA
 *   0x8013D638 / PAL 0x8013D664 / JPN 0x8013D424) -- i.e. pure relocation, masked by the regional gate.
 *   This file is therefore a VERBATIM copy of recon/eaclib/psx/sndpsxz/ssine.c; no edit is required.
 *   Gate residual (all six regions): "ours 37 / oracle 38, + nop".  That 38th word is NOT code -- it is
 *   the first word of the data area that immediately follows the last .text function (base
 *   `__data_obj = 0x8010CCD4`, value 0x00000000, followed by 0a/0f/19...; the regional image has the
 *   identical bytes at 0x8010D930).  iSNDsin is the LAST function detected in every regional .text, so
 *   regionrecon's slicer had no next-function boundary and kept one data word, which disassembles as
 *   `nop`.  Base oracle asm/nonmatchings/main/iSNDsin.s sizes the function 0x94 = 37 words, confirming.
 *
 * eaclib/psx/sndpsxz/ssine.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
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
