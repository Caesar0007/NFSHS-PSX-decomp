/* syslib/psx/libmath/MULSF3.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj MULSF3.obj ; libmath.lib.  __mulsf3 @0x800F34B0 (320 B) -- IEEE-754 single multiply (a1*a2 bit
 *   patterns).  24x24 mantissa product split into 16/8-bit lanes; round-to-nearest.  Overflow -> _err_math.
 */
int _err_math(int errnum, int code);

/* MATCH (W52-A4, 94 -> 93 at the wired lane, 88 under rung 2.95.2;
 * RECOMMEND per-TU {"cc1_alt": "2.95.2"} -- MULSF3.obj holds only __mulsf3,
 * so there is no TU-mate risk.  Drop the existing cc1_272 entry if adopted.)
 * Cluster identity: retail libmath is Sony's PREBUILT vendor object -- these
 * 320 bytes are byte-verbatim in psq43/44/45/47 PSX/LIB/LIBMATH.LIB and in
 * COFF/LIB/LIBMATH.A (see GTDF2.c for the full receipt).
 *
 * LEVER LANDED: retail tests the product's sign as `and $v0,$a3,$t2(0x80000000);
 * beqz` -- a MASK, not `bltz`/`bgez`.  So the source wrote
 * `if (v5 & 0x80000000)`, not `if (v5 < 0)` (the same fold class GTDF2 hit:
 * gcc turns a literal-0 signed compare into the shift/branch form).
 *
 * LADDER on the ORIGINAL source: BASE/2.7.2-970404/2.8.x = 94 * 2.6.x = 100 *
 * 2.7.2 = 101 * 2.91.66/2.95.2 = 93.  After the lever 2.95.2 = 88.
 * NEXT ANGLE (named, untried): retail issues the two exponent extractions
 * (`sra $a2,$t0,23` / `sra $a1,$t1,23`) INTERLEAVED with the mantissa
 * assembly, and keeps the two 24-bit mantissas in $t0/$t1 (retail also has the
 * 2-insn entry parm copy).  Ours computes them as one late block -- that is a
 * statement-ORDER / named-temp job on the v4/v5 expressions, not coloring. */
unsigned int __mulsf3(int a1, int a2)   /* @0x800F34B0 */
{
    unsigned int v2 = a1 & 0x80000000 ^ a2 & 0x80000000;
    int v4, v5, v6, v10;
    unsigned int v7, v9;
    if ((a1 & 0x7FFFFFFF) == 0 || (a2 & 0x7FFFFFFF) == 0)
        return a1 & 0x80000000 ^ a2 & 0x80000000;
    v4 = (unsigned char)(a1 >> 23) + (unsigned char)(a2 >> 23);
    v5 = ((a1 & 0x7FFFFF | 0x800000) >> 8) * ((a2 & 0x7FFFFF | 0x800000) >> 8)
           + (((unsigned char)a1 * ((a2 & 0x7FFFFF | 0x800000) >> 8)) >> 8)
           + (((unsigned char)a2 * ((a1 & 0x7FFFFF | 0x800000) >> 8)) >> 8);
    v6 = v4 - 126;
    if ((v5 & 0x80000000) != 0) {   /* MATCH: mask form, not `v5 < 0` -- see receipt */
        v7 = (unsigned int)(v5 + 128) >> 8;
    } else {
        unsigned int v8 = v5 + 64;
        if ((v8 & 0x80000000) != 0) {
            v7 = v8 >> 8;
        } else {
            v7 = v8 >> 7;
            v6 = v4 - 127;
        }
    }
    v9 = v7 & 0xFF7FFFFF;
    if (v6 < 255) return v2 | (v6 << 23) | v9;
    _err_math(34, 12);
    v10 = 2139095040;
    if (v2) return -8388608;
    return v10;
}
