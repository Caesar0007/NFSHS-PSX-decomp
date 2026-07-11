/* eaclib/psx/eacpsxz/isincos.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\isincos.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   1 fn @0x800EADBC (284 B): intsincos -- integer angle -> (sin,cos) in 16.16.
 *   FULL reconstruction of the actual code (disasm-v3 MIPS); NOT a stub/thunk. C-linkage XDEF.
 *
 *   Angle is in "brads": a full circle = 1024, so quadrant = (angle>>8)&3, position = angle&0xFF
 *   (0..255 within the quadrant).  A single 257-entry quarter-sine table (gSinTable[i] =
 *   sin(i*90deg/256) in 16.16, 0..0x10000) is folded across the four quadrants to yield sin/cos:
 *     q0: sin= T[p]      cos= T[256-p]
 *     q1: sin= T[256-p]  cos=-T[p]
 *     q2: sin=-T[p]      cos=-T[256-p]
 *     q3: sin=-T[256-p]  cos= T[p]
 *   gSinTable @0x80137464 is SHARED rodata (also read by fastintsin) -> declared extern here and
 *   defined once in the data-materialization pass (NOT inlined, to keep a single owner).
 */

extern const int gSinTable[257];
/* gSinTable -- RECONSTRUCTED byte-exact from NFS4.EXE @0x80137464 (isincos.obj-owned;
   was extern-declared, never defined). Quarter-wave sine LUT, 16.16 fixed (0..0x10000),
   257 entries. Bytes verified vs EXE. */
extern const int gSinTable[257] = {
    0,402,804,1206,1608,2010,2412,2814,
    3215,3617,4018,4420,4821,5222,5622,6023,
    6423,6823,7223,7623,8022,8421,8819,9218,
    9616,10013,10410,10807,11204,11600,11995,12390,
    12785,13179,13573,13966,14359,14751,15142,15533,
    15923,16313,16702,17091,17479,17866,18253,18638,
    19024,19408,19792,20175,20557,20938,21319,21699,
    22078,22456,22833,23210,23586,23960,24334,24707,
    25079,25450,25820,26189,26557,26925,27291,27656,
    28020,28383,28745,29105,29465,29824,30181,30538,
    30893,31247,31600,31952,32302,32651,32999,33346,
    33692,34036,34379,34721,35061,35400,35738,36074,
    36409,36743,37075,37406,37736,38064,38390,38716,
    39039,39361,39682,40002,40319,40636,40950,41263,
    41575,41885,42194,42501,42806,43110,43412,43712,
    44011,44308,44603,44897,45189,45480,45768,46055,
    46340,46624,46906,47186,47464,47740,48015,48288,
    48558,48828,49095,49360,49624,49886,50145,50403,
    50659,50914,51166,51416,51665,51911,52155,52398,
    52639,52877,53114,53348,53581,53811,54040,54266,
    54491,54713,54933,55152,55368,55582,55794,56004,
    56212,56417,56621,56822,57022,57219,57414,57606,
    57797,57986,58172,58356,58538,58718,58895,59070,
    59243,59414,59583,59749,59913,60075,60235,60392,
    60547,60700,60850,60998,61144,61288,61429,61568,
    61705,61839,61971,62100,62228,62353,62475,62596,
    62714,62829,62942,63053,63162,63268,63371,63473,
    63571,63668,63762,63854,63943,64030,64114,64197,
    64276,64353,64428,64501,64571,64638,64703,64766,
    64826,64884,64939,64992,65043,65091,65136,65179,
    65220,65258,65294,65327,65358,65386,65412,65436,
    65457,65475,65491,65505,65516,65524,65531,65534,
    65536,
};   /* @0x80137464 quarter-sine, 16.16 (0..0x10000) */

/* intsincos @0x800EADBC : write sin -> *psin, cos -> *pcos for a brads angle. */
extern void intsincos(int angle, int *psin, int *pcos)
{
    /* RESIDUAL (86 diffs, ours 69 vs oracle 71 insns) -- NOT a coloring near-miss, a genuine
     * SWITCH-LOWERING SHAPE divergence: the oracle's compare tree checks quad==1 first, then
     * quad<2, then quad==0/2/3 (each with a dead "can't happen" trap), and CROSS-JUMPS the
     * quad0-cos / quad3-sin arms into one shared `*pcos=gSinTable[idx]` tail. Our cc1 compiles
     * the same `switch(quad){0,1,2,default}` into a DIFFERENT (shorter, all-loads-unconditional)
     * cross-merge instead. Tried: literal case-order permutation (1,0,2,default) -> worse
     * (96 diffs); an explicit goto/label CFG hand-built to match the oracle's exact tree ->
     * worse (94 diffs, gcc did not reproduce the switch-expander's RTL from hand-written
     * ifs/gotos); plain if/else-if chain (matching compare order) -> worse (101 diffs). None
     * beat the plain switch. This is switch-expander-internal codegen (case density / cost
     * heuristics), not source-shapable without a pin; accept as a structural near-miss. */
    int quad = (angle >> 8) & 3;
    int p    = angle & 0xFF;          /* 0x800EADCC (branch delay slot -> all quadrants) */

    switch (quad) {
    case 0:
        *psin =  gSinTable[p];
        *pcos =  gSinTable[256 - p];
        break;
    case 1:
        *psin =  gSinTable[256 - p];
        *pcos = -gSinTable[p];
        break;
    case 2:
        *psin = -gSinTable[p];
        *pcos = -gSinTable[256 - p];
        break;
    default: /* 3 */
        *psin = -gSinTable[256 - p];
        *pcos =  gSinTable[p];
        break;
    }
}
