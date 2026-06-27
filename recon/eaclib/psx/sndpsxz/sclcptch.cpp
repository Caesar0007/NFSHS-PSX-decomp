/* eaclib/psx/sndpsxz/sclcptch.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\sclcptch.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x80101900 .. 0x801019BC].  Pitch calculation (cents/detune -> SPU pitch).
 *   Ghidra nfs4-f.exe.c L166180..166251.
 */

extern "C" int            sndgs[];
/* ONE 512-byte cents curve table `sndcents` @0x801370C4 (read lbu).  The two paths share it:
 *   idx>=0 -> sndcents[idx]      (lbu 0(base))
 *   idx<0  -> sndcents[idx+256]  (lbu 0x100(base))  -- snddefaultenvelope == sndcents+0x100.
 * Using one symbol reproduces the oracle's single-base load (the +256 folds to a 0x100 displacement);
 * two separate symbols force a 2nd `lui;addiu` base materialization. */
extern "C" unsigned char  sndcents[];
unsigned char sndcents[512] = {0};  /* def (owning TU; FIXME nonzero rodata byte-exact pending - #75) */

extern "C" int iSNDdetunetolinear(int detune);     /* @0x80101900 */

/* iSNDdetunetolinear @0x80101900 : convert a detune value in cents (0x4B0 = 1200 cents = one octave) to a
 *   12.12 linear pitch multiplier, octave-folding then interpolating the fractional cents through a curve
 *   table. */
extern "C" int iSNDdetunetolinear(int detune)
{
    int mul = 0x1000;
    int idx;
    for (; 0x4af < detune; detune -= 0x4b0)        /* octave up */
        mul = mul << 1;
    for (; detune < -0x4af; detune += 0x4b0)       /* octave down */
        mul = mul >> 1;
    idx = detune * 0x369d >> 0x10;                 /* cents -> table index */
    if (idx < -0xff)
        idx = -0xff;
    if (idx < 0)
        mul = (int)(mul * (sndcents[idx + 0x100] + 0x100)) >> 9;
    else
        mul = (int)(mul * (sndcents[idx] + 0x100)) >> 8;
    return mul;
}

/* iSNDcalcpitch @0x801019BC : recompute a voice's SPU pitch from its base note + modulation sources
 *   (envelope @+0x4C / LFO @+0x54), caching the linear multiplier at +0x5E and the final SPU pitch at
 *   +0x62. */
extern "C" int iSNDcalcpitch(int note)
{
    int          v = sndgs[0x25] + note * 100;
    int          pitch;
    int          c;                               /* envelope byte; the per-load (signed char) casts emit `lb`
                                                   * (sign-extend once), and `int c` avoids re-extending on use */

    if (*(unsigned short *)(v + 0x5e) == 0) {      /* not yet cached -> compute the linear multiplier (lhu) */
        int cents = (int)*(short *)(v + 0x5c);
        if (*(short *)(v + 0x5a) != 0) {           /* envelope-driven detune */
            if (*(int *)(v + 0x4c) != 0)           /* != polarity -> oracle's beqz fall-through */
                c = *(signed char *)(*(int *)(v + 0x4c) + (int)*(signed char *)(v + 0x2f));
            else
                c = *(signed char *)(v + 0x2f);    /* +0x2f detune read signed (lb) */
            cents += ((c - 0x40) * (int)*(short *)(v + 0x5a) >> 6);
        }
        if (*(int *)(v + 0x54) != 0) {             /* LFO-driven detune */
            cents += ((*(signed char *)(*(int *)(v + 0x54) + (unsigned)*(unsigned char *)(v + 0x3b)) - 0x40) *
                      (int)*(short *)(v + 0x58) >> 6);
        }
        pitch = iSNDdetunetolinear(cents);
        *(short *)(v + 0x5e) = (short)pitch;
    }
    pitch = (int)((unsigned)*(unsigned short *)(v + 0x5e) * (unsigned)*(unsigned short *)(v + 0x60)) >> 0xc;
    *(short *)(v + 0x62) = (short)pitch;            /* final SPU pitch */
    return pitch;
}
