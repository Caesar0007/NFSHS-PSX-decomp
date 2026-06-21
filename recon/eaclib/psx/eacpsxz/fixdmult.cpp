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
 *   16.16 fixed-point SIGNED multiply with round-to-nearest:
 *       result = (int)( ((s64)a * (s64)b + 0x8000) >> 16 )
 *   Verbatim from the MIPS (disasm-v3 @0x800E4328):
 *       mult a,b -> {HI,LO}=64-bit signed product
 *       LO += 0x8000  (rounding; carry propagated into HI)
 *       v0 = (HI<<16) | (LO>>16)        ; == bits 16..47 of (product + 0x8000)
 *   Behavior-faithful (asm decoded to C); @VA breadcrumb.
 */

extern "C" int fixedmult(int a, int b)   /* @0x800E4328  (shared with rmult) */
{
    return (int)(((long long)a * (long long)b + 0x8000) >> 16);
}

/* `rmult` = co-equal XDEF label at the same address (FIXDMULT.ASM declares both). */
extern "C" int rmult(int a, int b) __attribute__((alias("fixedmult")));
