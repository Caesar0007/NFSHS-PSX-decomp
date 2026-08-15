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
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl _mainasu\n"          /* @0x80106F00 : int *_mainasu(int *out,int a2,int a3) */
    "_mainasu:\n"
    "\taddiu\t$sp,$sp,-40\n"
    "\tsw\t$s0,32($sp)\n"
    "\taddu\t$s0,$a0,$zero\n"      /* s0 = out */
    "\taddiu\t$v0,$zero,1\n"
    "\tsw\t$a2,48($sp)\n"          /* spill raw a3 (a2 == 3rd param, in reg $a2) */
    "\tnor\t$a2,$zero,$a2\n"       /* a2 = ~a3param */
    "\tsw\t$a1,44($sp)\n"          /* spill raw a2param (in reg $a1) */
    "\tnor\t$a1,$zero,$a1\n"       /* a1 = ~a2param */
    "\tsw\t$zero,28($sp)\n"        /* the (1,0) addend pair -- hi = 0 */
    "\tsw\t$v0,24($sp)\n"          /* the (1,0) addend pair -- lo = 1 */
    "\tsw\t$a2,48($sp)\n"          /* re-store negated a3param over its own slot */
    "\tsw\t$a1,44($sp)\n"          /* re-store negated a2param over its own slot */
    "\tsw\t$zero,16($sp)\n"        /* a5 (5th stack arg to _add_mant_d) = 0 */
    "\tlw\t$a3,24($sp)\n"          /* a3 = 1 (the addend lo) */
    "\tlw\t$a1,44($sp)\n"          /* a1 = ~a2param (reload) */
    "\tlw\t$a2,48($sp)\n"          /* a2 = ~a3param (reload) */
    "\tsw\t$ra,36($sp)\n"
    "\tjal\t_add_mant_d\n"
    "\t addiu\t$a0,$sp,44\n"       /* delay: out-ptr = &sp[44] (a2param's own negated-value slot) */
    "\tlw\t$v0,44($sp)\n"
    "\tlw\t$v1,48($sp)\n"
    "\tsw\t$v0,0($s0)\n"
    "\tsw\t$v1,4($s0)\n"
    "\taddu\t$v0,$s0,$zero\n"
    "\tlw\t$ra,36($sp)\n"
    "\tlw\t$s0,32($sp)\n"
    "\tjr\t$ra\n"
    "\t addiu\t$sp,$sp,40\n"
    "\t.set pop\n"
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
