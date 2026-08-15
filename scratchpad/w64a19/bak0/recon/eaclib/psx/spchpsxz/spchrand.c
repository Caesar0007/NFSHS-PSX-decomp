/* eaclib/psx/spchpsxz/spchrand.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
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

/* ---- 6-word PRNG state @0x801235F4 (.data; runtime-seeded by iSPCH_EACseedrandom).  data-mat #75.
 *   Contiguous int[6]: [0]=seedX accumulator, [1]=..f8, [2]=..fc, [3]=..600, [4]=..604, [5]=..608. ---- */
extern unsigned int seedX[];        /* @0x801235F4 : the 6-word state (word0 = accumulator) */
#define DAT_801235f8  seedX[1]
#define DAT_801235fc  seedX[2]
#define DAT_80123600  seedX[3]
#define DAT_80123604  seedX[4]
#define DAT_80123608  seedX[5]

extern int  gEventDats[];           /* @0x80148048 : int[4] bound event-data pointers (shared w/ spchevnt) */
extern void trap(unsigned int code);

extern int   iSPCH_EACrandom(void);                 /* @0x800EB9C4 */
extern int  *iSPCH_EACseedrandom(unsigned int seed);/* @0x800EBAC4 */
extern int   iSPCH_Rand(int n);                     /* @0x800EBB30 */
extern int   iSPCH_BindData(unsigned short *dat);   /* @0x800EBB84 */

/* iSPCH_EACrandom @0x800EB9C4 : step the additive generator (carry-propagated) and return the new seed.
 *   MATCH: ONE in-place running `sum` (oracle keeps it in $a2 end-to-end, incl. the return) + rollover as
 *   nested ifs incrementing the GLOBALS directly (oracle reloads each word: lw;addiu;bnez;sw-in-slot). */
extern int iSPCH_EACrandom(void)
{
    unsigned int sum;
    unsigned int carry;

    sum = seedX[5] + seedX[4];
    carry = 0;
    if (sum < seedX[5] || sum < seedX[4])
        carry = 1;
    seedX[4] = sum;
    sum = sum + seedX[3] + carry;
    carry = sum < seedX[3];
    seedX[3] = sum;
    sum = sum + seedX[2] + carry;
    carry = sum < seedX[2];
    seedX[2] = sum;
    sum = sum + seedX[1] + carry;
    carry = sum < seedX[1];
    seedX[1] = sum;
    sum = sum + seedX[0] + carry;
    seedX[0] = sum;
    seedX[5] = seedX[5] + 1;
    if (seedX[5] == 0) {
        seedX[4] = seedX[4] + 1;
        if (seedX[4] == 0) {
            seedX[3] = seedX[3] + 1;
            if (seedX[3] == 0) {
                seedX[2] = seedX[2] + 1;
                if (seedX[2] == 0) {
                    seedX[1] = seedX[1] + 1;
                    if (seedX[1] == 0) {
                        seedX[0] = sum + 1;   /* MATCH: temp v0 = sum+1 for the store ... */
                        sum = sum + 1;        /* ... then CSE copies it back into sum ($a2) */
                    }
                }
            }
        }
    }
    return (int)sum;
}

/* iSPCH_EACseedrandom @0x800EBAC4 : seed all 6 state words from `seed` (each = seed + a fixed constant; the
 *   constants are eacpsxz srandom's default seeds, so seed==0 reproduces that default state).  Returns base.
 *   The original chains the constants (running += delta) and stores all 6 off the shared seedX[] base. */
extern int *iSPCH_EACseedrandom(unsigned int seed)
{
    unsigned int w = seed + 0xf22d0e56u;
    seedX[0] = w;                    /* seed + 0xF22D0E56 */
    w += 0x96041893u; seedX[1] = w;  /* seed + 0x883126E9 */
    w += 0x3df3b646u; seedX[2] = w;  /* seed + 0xC624DD2F */
    w += 0x40dde76du; seedX[3] = w;  /* seed + 0x0702C49C */
    w += 0x97327ae1u; seedX[4] = w;  /* seed + 0x9E353F7D */
    w += 0xd1a9fbe7u; seedX[5] = w;  /* seed + 0x6FDF3B64 */
    return (int *)&seedX[0];
}

/* iSPCH_Rand @0x800EBB30 : a uniform pseudo-random in [0, n) from the low 16 bits of EACrandom.  The n==-1 /
 *   INT_MIN guard is the compiler's signed-division-overflow trap (dead here: (r&0xffff) is never INT_MIN). */
extern int iSPCH_Rand(int n)
{
    unsigned int r = (unsigned int)iSPCH_EACrandom();
    /* signed % emits the div + break 0x1c00 (div0) + break 0x1800 (overflow)
       guards itself under maspsx --expand-div; no manual trap() needed. */
    return (int)(r & 0xffff) % n;
}

/* iSPCH_BindData @0x800EBB84 : register a speech data blob (header word > 0x11d) into the first free
 *   gEventDats[0..3] slot.  Returns 1 on success, 0 if rejected or the table is full. */
extern int iSPCH_BindData(unsigned short *dat)
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
