/* eaclib/psx/eacpsxz/fixdsqrt.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\fixdsqrt.obj (EACPSXZ.LIB).  1 fn @0x800EB0AC : fixedsqrt.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub.  16.16 fixed-point sqrt via a per-exponent
 *   piecewise-linear table: normalise to the highest set bit (position p), then
 *   result = (x * scale[p]) >> 16 + offset[p].  Tables @0x801234EC / @0x80123570 are obj-local
 *   rodata -> materialized inline.  (~0.8% max rel error vs sqrt -- the table's design accuracy.)
 */

static const int kSqrtScale[32] = {
    6949350,4913933,3474675,2456966,1737338,1228483,868669,614242,
    434334,307121,217167,153560,108584,76780,54292,38390,
    27146,19195,13573,9598,6786,4799,3393,2399,
    1697,1200,848,600,424,300,212,150,
};
static const int kSqrtOffset[32] = {
    152,215,304,430,608,860,1217,1721,
    2433,3441,4867,6883,9734,13765,19467,27531,
    38934,55061,77868,110122,155736,220244,311472,440488,
    622945,880977,1245890,1761954,2491779,3523908,4983558,7047816,
};

extern "C" int fixedsqrt(int x)   /* @0x800EB0AC */
{
    if (x == 0)
        return 0;
    unsigned mask = 0x80000000u;
    int p = 31;
    while ((x & mask) == 0) {          /* highest set bit position */
        mask >>= 1;
        --p;
    }
    long long prod = (long long)x * (long long)kSqrtScale[p];
    return (int)(prod >> 16) + kSqrtOffset[p];
}
