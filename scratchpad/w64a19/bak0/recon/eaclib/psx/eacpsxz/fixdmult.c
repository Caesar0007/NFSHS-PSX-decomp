/* eaclib/psx/eacpsxz/fixdmult.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
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
 /* ASPSX-DIALECT (w64-a20): the asm below uses NUMERIC registers and no
  * `.set push/pop` -- ASPSX 2.77, the PRODUCTION assembler, rejects ABI
  * register NAMES and push/pop.  $0 zero $1 at $2-3 v0-v1 $4-7 a0-a3
  * $8-15 t0-t7 $16-23 s0-s7 $24-25 t8-t9 $28 gp $29 sp $30 fp $31 ra.
  * Gate-lane object is byte-identical (proven by hash); see
  * scratchpad/w64a20/RECEIPTS.md. */
 *   transcribed VERBATIM as a file-scope __asm__ (byte-identical to FIXDMULT.ASM) with BOTH XDEF
 *   labels (rmult, fixedmult) at offset 0.  A C fallback keeps the x86 host build compiling.
 *   Semantics: v0 = ((HI+carry)<<16) | ((LO+0x8000)>>16) = (int)(((s64)a*(s64)b + 0x8000) >> 16).
 *   @0x800E4328, 44 bytes (11 insns).
 */

#if defined(__mips__)
__asm__(
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
    "\tori\t$10,$0,0x8000\n"   /* round bias 0x8000 */
    "\tmflo\t$8\n"
    "\tmfhi\t$9\n"
    "\taddu\t$8,$8,$10\n"       /* LO + 0x8000 */
    "\tsltu\t$10,$8,$10\n"       /* carry out of the low word */
    "\taddu\t$9,$9,$10\n"       /* HI + carry */
    "\tsrl\t$10,$8,16\n"
    "\tsll\t$11,$9,16\n"
    "\tjr\t$31\n"
    "\tor\t$2,$10,$11\n"         /* jr delay slot: combine (HI+carry)<<16 | (LO+0x8000)>>16 */
    "\t.set at\n"
    "\t.set reorder\n"
);
#else
extern int fixedmult(int a, int b)   /* @0x800E4328 */
{
    return (int)(((long long)a * (long long)b + 0x8000) >> 16);
}
extern int rmult(int a, int b) __attribute__((alias("fixedmult")));
#endif
