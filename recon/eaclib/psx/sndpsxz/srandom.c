/* eaclib/psx/sndpsxz/srandom.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\srandom.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010BE80.  iSNDrandom -- a 160-bit additive lagged-Fibonacci PRNG (5 state words + carry into
 *   sndseed); returns the accumulated seed.  Ghidra nfs4-f.exe.c (srandom) + IDA (returns int; Ghidra void).
 */
/* W85-S8 VOLATILE AUDIT (2026-09-02): the `volatile` qualifiers on 16 (the RNG state pointer)
 * were REMOVED -- plain main-RAM driver state, not MMIO and not IRQ-mutated; removal is
 * gate-neutral (whole-TU verify_asm/tugate PASS before and after).  Every REMAINING
 * `volatile` in this file was measured individually or as a group and is load-bearing
 * (MMIO, or state the oracle provably re-reads) -- do not strip them.  Receipt:
 * scratchpad/w85/S8_receipt.md. */

/* srandom.obj .data 0x8013C2F0 (link-order owner, 2026-09-20; was in the non-module snddata.c): the additive PRNG state,
 * same initial words as eacpsxz random.obj's `seed` and spchrand.obj's `seedX`. */
#include "srandom.h"

unsigned int sndseed[6] = {
    0xf22d0e56u, 0x883126e9u, 0xc624dd2fu,
    0x0702c49cu, 0x9e353f7du, 0x6fdf3b64u
};

/* iSNDrandom @0x8010BE80 : step the additive generator (with carry propagation) and return the new seed. */
int iSNDrandom(void)
{
    unsigned int *state;
    unsigned int sum;
    unsigned int old1, old2, old3, old4, old5;
    unsigned int carry = 0;

    old5 = sndseed[5];
    old4 = sndseed[4];
    sum = old5 + old4;
    if (sum < old5 || sum < old4)
        carry = 1;

    state = sndseed;
    old3 = state[3];
    old2 = state[2];
    old1 = state[1];
    state[4] = sum;

    sum = sum + old3 + carry;
    carry = sum < old3;
    state[3] = sum;

    sum = sum + old2 + carry;
    carry = sum < old2;
    state[2] = sum;

    sum = sum + old1 + carry;
    carry = sum < old1;
    state[1] = sum;

    {
    unsigned int seed;
    seed = state[0];
    sum = sum + seed + carry;
    state[0] = sum;

    if (!(state[5] = state[5] + 1) &&
        !(state[4] = state[4] + 1) &&
        !(state[3] = state[3] + 1) &&
        !(state[2] = state[2] + 1) &&
        !(state[1] = state[1] + 1)) {
        unsigned int final = sum + 1;
        state[0] = final;
        sum = final;
    }
    }
    return sum;
}
