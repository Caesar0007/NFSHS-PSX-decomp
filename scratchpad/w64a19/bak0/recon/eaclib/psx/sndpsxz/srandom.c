/* eaclib/psx/sndpsxz/srandom.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\srandom.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010BE80.  iSNDrandom -- a 160-bit additive lagged-Fibonacci PRNG (5 state words + carry into
 *   sndseed); returns the accumulated seed.  Ghidra nfs4-f.exe.c (srandom) + IDA (returns int; Ghidra void).
 */

extern unsigned int sndseed[6];
#define SNDSEED(i) state[(i)]
#define NSNDSEED(i) (((unsigned int *)state)[(i)])

extern int iSNDrandom(void);   /* @0x8010BE80 */

/* iSNDrandom @0x8010BE80 : step the additive generator (with carry propagation) and return the new seed. */
extern int iSNDrandom(void)
{
    volatile unsigned int *state;
    unsigned int sum;
    unsigned int old1, old2, old3, old4, old5;
    unsigned int carry = 0;

    old5 = sndseed[5];
    old4 = sndseed[4];
    sum = old5 + old4;
    if (sum < old5 || sum < old4)
        carry = 1;

    state = sndseed;
    old3 = SNDSEED(3);
    old2 = SNDSEED(2);
    old1 = SNDSEED(1);
    SNDSEED(4) = sum;

    sum = sum + old3 + carry;
    carry = (unsigned int)(sum < old3);
    SNDSEED(3) = sum;

    sum = sum + old2 + carry;
    carry = (unsigned int)(sum < old2);
    SNDSEED(2) = sum;

    sum = sum + old1 + carry;
    carry = (unsigned int)(sum < old1);
    NSNDSEED(1) = sum;

    {
    unsigned int seed;
    seed = SNDSEED(0);
    sum = sum + seed + carry;
    NSNDSEED(0) = sum;

    if ((NSNDSEED(5) = SNDSEED(5) + 1) != 0)
        goto done;
    if ((NSNDSEED(4) = SNDSEED(4) + 1) != 0)
        goto done;
    if ((NSNDSEED(3) = SNDSEED(3) + 1) != 0)
        goto done;
    if ((NSNDSEED(2) = SNDSEED(2) + 1) != 0)
        goto done;
    if ((NSNDSEED(1) = SNDSEED(1) + 1) == 0) {
        unsigned int final = sum + 1;
        NSNDSEED(0) = final;
        sum = final;
    }
    }
done:
    return (int)sum;
}
