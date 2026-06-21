/* eaclib/psx/spchpsxz/spchrand.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
 *   Source obj : nfs4\eaclib\psx\spchrand.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   4 fns @[0x800EB9C4 .. 0x800EBB84].  The speech subsystem's PRNG -- a 6-word additive lagged-Fibonacci
 *   generator (the EAC random), byte-identical in structure to eacpsxz srandom.obj (iSNDrandom) and seeded
 *   from the SAME 6 magic constants.  Ghidra nfs4-f.exe.c (spchrand) + disasm-v3 + IDA sigs.
 *
 *   Ghidra-ism resolved: Ghidra collided TWO distinct state words under the name `seedX` -- word0 (the
 *   accumulator @0x801235F4) and word5 (@0x80123608).  disasm-v3 (base 0x801235F4, offsets 0..20) shows 6
 *   separate words; the main-path "seedX = seedX + 1" is really word5++ (DAT_80123608), and the rollover
 *   "seedX = seedX + 1" is the accumulator++ -- exactly mirroring srandom.  IDA: EACrandom returns int (the
 *   new accumulator; Ghidra typed it void), EACseedrandom takes the seed (Ghidra's __thiscall `this`) and
 *   returns int* (the state base).
 */

/* ---- 6-word PRNG state @0x801235F4 (.data; runtime-seeded by iSPCH_EACseedrandom).  data-mat #75. ---- */
extern "C" unsigned int seedX;          /* @0x801235F4 accumulator (word0) */
extern "C" unsigned int DAT_801235f8;   /* @0x801235F8 word1 */
extern "C" unsigned int DAT_801235fc;   /* @0x801235FC word2 */
extern "C" unsigned int DAT_80123600;   /* @0x80123600 word3 */
extern "C" unsigned int DAT_80123604;   /* @0x80123604 word4 */
extern "C" unsigned int DAT_80123608;   /* @0x80123608 word5 */

extern "C" int  gEventDats[];           /* @0x80148048 : int[4] bound event-data pointers (shared w/ spchevnt) */
extern "C" void trap(unsigned int code);

extern "C" int   iSPCH_EACrandom(void);                 /* @0x800EB9C4 */
extern "C" int  *iSPCH_EACseedrandom(unsigned int seed);/* @0x800EBAC4 */
extern "C" int   iSPCH_Rand(int n);                     /* @0x800EBB30 */
extern "C" int   iSPCH_BindData(unsigned short *dat);   /* @0x800EBB84 */

/* iSPCH_EACrandom @0x800EB9C4 : step the additive generator (carry-propagated) and return the new seed. */
extern "C" int iSPCH_EACrandom(void)
{
    unsigned int u1, u2, u3, u4;
    int carry = 0;
    u1 = DAT_80123608 + DAT_80123604;
    if (u1 < DAT_80123608 || u1 < DAT_80123604)
        carry = 1;
    u2 = u1 + DAT_80123600 + carry;
    u3 = u2 + DAT_801235fc + (unsigned int)(u2 < DAT_80123600);
    u4 = u3 + DAT_801235f8 + (unsigned int)(u3 < DAT_801235fc);
    seedX = u4 + seedX + (unsigned int)(u4 < DAT_801235f8);
    DAT_80123608 = DAT_80123608 + 1;
    DAT_801235f8 = u4;
    DAT_801235fc = u3;
    DAT_80123600 = u2;
    DAT_80123604 = u1;
    if (DAT_80123608 == 0 && (DAT_80123604 = u1 + 1, DAT_80123604 == 0) &&
        (DAT_80123600 = u2 + 1, DAT_80123600 == 0) &&
        (DAT_801235fc = u3 + 1, DAT_801235fc == 0) &&
        (DAT_801235f8 = u4 + 1, DAT_801235f8 == 0))
        seedX = seedX + 1;
    return (int)seedX;
}

/* iSPCH_EACseedrandom @0x800EBAC4 : seed all 6 state words from `seed` (each = seed + a fixed constant; the
 *   constants are eacpsxz srandom's default seeds, so seed==0 reproduces that default state).  Returns base. */
extern "C" int *iSPCH_EACseedrandom(unsigned int seed)
{
    seedX        = seed + 0xf22d0e56u;
    DAT_801235f8 = seed + 0x883126e9u;
    DAT_801235fc = seed + 0xc624dd2fu;
    DAT_80123600 = seed + 0x0702c49cu;
    DAT_80123604 = seed + 0x9e353f7du;
    DAT_80123608 = seed + 0x6fdf3b64u;
    return (int *)&seedX;
}

/* iSPCH_Rand @0x800EBB30 : a uniform pseudo-random in [0, n) from the low 16 bits of EACrandom.  The n==-1 /
 *   INT_MIN guard is the compiler's signed-division-overflow trap (dead here: (r&0xffff) is never INT_MIN). */
extern "C" int iSPCH_Rand(int n)
{
    unsigned int r = (unsigned int)iSPCH_EACrandom();
    if (n == 0)
        trap(0x1c00);
    if (n == -1 && (r & 0xffff) == 0x80000000u)
        trap(0x1800);
    return (int)(r & 0xffff) % n;
}

/* iSPCH_BindData @0x800EBB84 : register a speech data blob (header word > 0x11d) into the first free
 *   gEventDats[0..3] slot.  Returns 1 on success, 0 if rejected or the table is full. */
extern "C" int iSPCH_BindData(unsigned short *dat)
{
    int *p;
    int  i;
    int  result = 0;
    if (0x11d < *dat) {
        i = 0;
        p = gEventDats;
        do {
            i++;
            if (*p == 0) {
                *p = (int)dat;
                result = 1;
                goto done;
            }
            p++;
        } while (i < 4);
    }
done:
    return result;
}
