/* eaclib/psx/eacpsxz/fixdmult.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\fixdmult.obj  (xlsx provenance)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\FIXDMULT.ASM (per SYM SLD @0x800E4328,
 *                lines 7-11). ONE 44-byte routine with TWO co-equal XDEF entry labels at its
 *                start -- `rmult::` and `fixedmult::` (SYM lists rmult first, then fixedmult;
 *                both type-2 defs at 0x800E4328). i.e. two names, one shared body.
 *   In the tree every call site uses `fixedmult`; `rmult` has no call sites but is a real
 *   co-equal export. Modeled as: body once under fixedmult, `rmult` a true zero-byte alias
 *   (same address -- objdump: both at offset 0). This is the C equivalent of the two asm labels.
 *
 *   16.16 fixed-point SIGNED multiply with round-to-nearest.  The 11-insn oracle is HAND ASM (no C
 *   compiler emits this exact form -- manual $t2 carry via sltu, hand-filled jr delay slot), so it is
 *   transcribed VERBATIM as a file-scope __asm__ (byte-identical to FIXDMULT.ASM) with BOTH XDEF
 *   labels (rmult, fixedmult) at offset 0.  A C fallback keeps the x86 host build compiling.
 *   Semantics: v0 = ((HI+carry)<<16) | ((LO+0x8000)>>16) = (int)(((s64)a*(s64)b + 0x8000) >> 16).
 *   @0x800E4328, 44 bytes (11 insns).
 */

#if defined(__mips__)
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto jr-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                          */
    "\t.globl rmult\n"      /* SYM: rmult + fixedmult are co-equal XDEFs, both @offset 0     */
    "\t.globl fixedmult\n"
    "rmult:\n"
    "fixedmult:\n"
    /* operands are comma-joined with NO spaces (gcc/aspsx style): maspsx position-parses `sltu`
       (rest[0].split(',') expecting 3) so a space after a comma breaks it; also `mult` (bare 2-op)
       is routed through maspsx's load-parse, so emit it as a raw .word. */
    "\t.word\t0x00850018\n"    /* mult $a0,$a1 -> {HI,LO} = a*b (signed) */
    "\tori\t$t2,$zero,0x8000\n"   /* round bias 0x8000 */
    "\tmflo\t$t0\n"
    "\tmfhi\t$t1\n"
    "\taddu\t$t0,$t0,$t2\n"       /* LO + 0x8000 */
    "\tsltu\t$t2,$t0,$t2\n"       /* carry out of the low word */
    "\taddu\t$t1,$t1,$t2\n"       /* HI + carry */
    "\tsrl\t$t2,$t0,16\n"
    "\tsll\t$t3,$t1,16\n"
    "\tjr\t$ra\n"
    "\tor\t$v0,$t2,$t3\n"         /* jr delay slot: combine (HI+carry)<<16 | (LO+0x8000)>>16 */
    "\t.set pop\n"
);
#else
extern "C" int fixedmult(int a, int b)   /* @0x800E4328 */
{
    return (int)(((long long)a * (long long)b + 0x8000) >> 16);
}
extern "C" int rmult(int a, int b) __attribute__((alias("fixedmult")));
#endif
