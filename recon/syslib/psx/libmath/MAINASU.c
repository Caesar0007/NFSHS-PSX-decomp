/* syslib/psx/libmath/MAINASU.c -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj MAINASU.obj ; libmath.lib.  _mainasu @0x80106F00 (112 B) -- two's-complement negate a 64-bit value
 *   [a3:a2]: out = ~[a3:a2] + 1, via _add_mant_d.  (The &tmp[0] write reaches both words, matching the binary
 *   stack adjacency.)
 *
 *   TOOLCHAIN-IDENTITY WALL (w24-a2, 2026-07-25; same class as _comp_mant in DIVDF3.c -- see that file's
 *   header). No SYM entry. The oracle's frame IS the correct 40 bytes our recon already used (this is
 *   NOT a missing-locals issue) -- the mismatch is pure SHAPE: it defensively spills the raw a2/a3
 *   params to their stack homes (sp+44/48) BEFORE negating, negates in-register, re-stores the negated
 *   value back to those SAME slots, then reloads a1/a2/a3 from stack immediately before the `jal` and
 *   passes `&sp[44]` (a2's own negated-value stack slot) as the out-pointer -- i.e. it takes the ADDRESS
 *   of the (stack-homed) parameter itself rather than a fresh local, only possible because the parameter
 *   was already forced to memory. Same unreachable-at-any-`-O`-level signature as the DIVDF3.c primitives.
 *   Transcribed VERBATIM as file-scope __asm__; portable C fallback kept for host. */
extern int *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5);   /* ADDMANT */
extern int *_mainasu(int *out, int a2, int a3);   /* @0x80106F00 */

#if defined(__mips__)
__asm__(
    ""
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl _mainasu\n"          /* @0x80106F00 : int *_mainasu(int *out,int a2,int a3) */
    "_mainasu:\n"
    "\taddiu\t$29,$29,-40\n"
    "\tsw\t$16,32($29)\n"
    "\taddu\t$16,$4,$0\n"      /* s0 = out */
    "\taddiu\t$2,$0,1\n"
    "\tsw\t$6,48($29)\n"          /* spill raw a3 (a2 == 3rd param, in reg $a2) */
    "\tnor\t$6,$0,$6\n"       /* a2 = ~a3param */
    "\tsw\t$5,44($29)\n"          /* spill raw a2param (in reg $a1) */
    "\tnor\t$5,$0,$5\n"       /* a1 = ~a2param */
    "\tsw\t$0,28($29)\n"        /* the (1,0) addend pair -- hi = 0 */
    "\tsw\t$2,24($29)\n"          /* the (1,0) addend pair -- lo = 1 */
    "\tsw\t$6,48($29)\n"          /* re-store negated a3param over its own slot */
    "\tsw\t$5,44($29)\n"          /* re-store negated a2param over its own slot */
    "\tsw\t$0,16($29)\n"        /* a5 (5th stack arg to _add_mant_d) = 0 */
    "\tlw\t$7,24($29)\n"          /* a3 = 1 (the addend lo) */
    "\tlw\t$5,44($29)\n"          /* a1 = ~a2param (reload) */
    "\tlw\t$6,48($29)\n"          /* a2 = ~a3param (reload) */
    "\tsw\t$31,36($29)\n"
    "\tjal\t_add_mant_d\n"
    "\t addiu\t$4,$29,44\n"       /* delay: out-ptr = &sp[44] (a2param's own negated-value slot) */
    "\tlw\t$2,44($29)\n"
    "\tlw\t$3,48($29)\n"
    "\tsw\t$2,0($16)\n"
    "\tsw\t$3,4($16)\n"
    "\taddu\t$2,$16,$0\n"
    "\tlw\t$31,36($29)\n"
    "\tlw\t$16,32($29)\n"
    "\tjr\t$31\n"
    "\t addiu\t$29,$29,40\n"
    "\t.set reorder\n\t.set at\n"
);
#else
extern int *_mainasu(int *out, int a2, int a3)   /* @0x80106F00 */
{
    int tmp[2];
    tmp[0] = ~a2;
    tmp[1] = ~a3;
    _add_mant_d(tmp, ~a2, ~a3, 1u, 0);
    out[0] = tmp[0];
    out[1] = tmp[1];
    return out;
}
#endif
