/* eaclib/psx/eacpsxz/isqrttbl.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   obj nfs4\eaclib\psx\isqrttbl.obj ; EACPSXZ.LIB.  2 fns @[0x801069C4 .. 0x801069EC].  Shift-JIS text
 *   decode (the obj name is a misnomer -- it holds the SJIS remap, not an isqrt table).
 *   Ghidra nfs4-f.exe.c + IDA sigs.
 */
/* W65-A6: the old spelling `DAT_` + lowercase hex was a reloc-referenced UNDEFINED symbol (2 sites) AND a
 * seal-criterion #3 violation (Ghidra-ism in code).  Not missing data: 0x8013BD50 is inside
 * the initialised image (< t_addr+t_size 0x8013E000) and the splat blob already defines it as
 * `D_8013BD50` (asm/data/data_8010CCD4_r18.data.s).  Only the SPELLING differed -- the
 * lowercase-hex casing-phantom class (methodology gotcha #17).  Renaming to the blob's exact
 * name is byte-neutral (relocation NAME only; TU re-gates 2/2 PASS). */
extern unsigned short D_8013BD50[];     /* @0x8013BD50 : ASCII(0x20..0x7f)->SJIS remap table [0x60] (rodata) */

extern unsigned int remapshiftjiscode(unsigned int c);      /* @0x801069C4 */
extern int          decodeshiftjis(unsigned char **cursor); /* @0x801069EC */

/* remapshiftjiscode : map a 1-byte ASCII code (0x20..0x7f) to its full-width SJIS code. */
extern unsigned int remapshiftjiscode(unsigned int c)
{
    /* hold (c-0x20) in ONE local so gcc CSE-keeps it in $a1 across the range test AND
     * the index (oracle reuses $a1 for both; a recomputed `c-0x20` colored a fresh
     * scratch -> 6 diffs).  Residual 2-diff = the oracle schedules `sll v0,a1,1` AFTER
     * the lui/addiu address build; our build emits it before -- a gcc-2.8.0
     * sll-index-vs-base scheduling tie-break, not source-reachable (methodology floor). */
    unsigned int i = c - 0x20;
    if (i < 0x60)
        c = (unsigned int)D_8013BD50[i];
    return c;
}

/* CO-EQUAL XDEFs decodeshiftjis2/decodeshiftjis3 (setfont.c device, w34 follow-up).
 * EVIDENCE-BACKED, not a matching hack: setfont's oracle keeps THREE separate
 * `lui/addiu %hi/%lo/j` decoder-pick blocks; our byte-identical cc1 (compiler snapshot
 * CLOSED w33-a7) provably cross-jumps identical hard-reg blocks in the post-reload
 * jump_optimize -- so retail's three blocks CANNOT have referenced one symbol.  Three
 * distinct symbols resolving to the same address (the sinfunc.c intsin/fastintsin
 * pattern, proven EA practice in this very library) is the only shape consistent with
 * the binary.  The real alias NAMES are unrecoverable from the linked exe; 2/3 are
 * placeholders.  gcc-2.8.0 silently ignores __attribute__((alias)) -> GNU-as symbol
 * assignments on the mips side (adds no bytes; links to the identical binary). */
#if defined(__mips__)
__asm__(
    "\t.globl decodeshiftjis2\n"
    "decodeshiftjis2 = decodeshiftjis\n"
    "\t.globl decodeshiftjis3\n"
    "decodeshiftjis3 = decodeshiftjis\n"
);
#else
extern int decodeshiftjis2(unsigned char **cursor) __attribute__((alias("decodeshiftjis")));
extern int decodeshiftjis3(unsigned char **cursor) __attribute__((alias("decodeshiftjis")));
#endif

/* decodeshiftjis : next SJIS char from a cursor -- 1 byte (remapped) if high bit clear, else a 2-byte code. */
extern int decodeshiftjis(unsigned char **cursor)
{
    /* MATCH: ONE in-place pointer (s0) -- `p++` lands in the beqz delay slot (runs on
     * BOTH paths); 2-byte path is the fall-through (`if (b1 & 0x80)`), the remap call
     * the out-of-line else.  b1 dies into the call arg -> colors $a0. */
    unsigned char *p = *cursor;
    unsigned int   b1 = *p;
    unsigned int   code;
    p = p + 1;
    if ((b1 & 0x80) != 0) {
        code = (unsigned int)*p | (b1 << 8);
        p = p + 1;
    } else {
        code = remapshiftjiscode(b1);
    }
    *cursor = p;
    return (int)(code & 0xffff);
}
