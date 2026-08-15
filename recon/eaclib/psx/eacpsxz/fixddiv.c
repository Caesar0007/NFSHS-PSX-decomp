/* eaclib/psx/eacpsxz/fixddiv.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\fixddiv.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   Original   : hand-written MIPS assembly (SYM SLD @0x800E4404; the oracle is tagged "Handwritten
 *                function" and carries the TRAPPING `sub` -- non-`u`, never emitted by a C compiler).
 *   ONE 168-byte (42-insn) routine with TWO co-equal XDEF entry labels at offset 0: `rdiv` (the
 *   oracle/scaffolding canonical name) + `fixeddiv` (caller-facing).  Transcribed VERBATIM as a
 *   file-scope __asm__ (byte-identical); a C fallback keeps the x86 host build compiling.
 *
 *   16.16 fixed-point SIGNED divide:  result = (a << 16) / b  (truncate toward zero), overflow-safe
 *   without 64-bit: |a|/|b| via native `divu` for the integer part, then bit-by-bit refine the 16
 *   fractional bits (shift/compare/subtract), then reapply sign = sign(a) ^ sign(b).  b==0 -> 0.
 *   @0x800E4404.  (maspsx: operands are comma-joined NO-space -- `sltu`/`divu` are position-parsed.)
 */

#if defined(__mips__)
/* ASPSX-DIALECT (w64-a20): the asm below uses NUMERIC registers and no
 * `.set push/pop` -- ASPSX 2.77, the PRODUCTION assembler, rejects ABI
 * register NAMES and push/pop.  $0 zero $1 at $2-3 v0-v1 $4-7 a0-a3
 * $8-15 t0-t7 $16-23 s0-s7 $24-25 t8-t9 $28 gp $29 sp $30 fp $31 ra.
 * Gate-lane object is byte-identical (proven by hash); see
 * scratchpad/w64a20/RECEIPTS.md. */
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */
    "\t.globl rdiv\n"       /* rdiv = the oracle/scaffolding canonical label (objdump shows THIS one) */
    "rdiv:\n"
    "fixeddiv:\n"
    "\tbgez\t$4,.L800E4410\n"
    "\t slt\t$8,$4,$0\n"       /* delay: t0 = (a<0) */
    "\tnegu\t$4,$4\n"             /* |a| */
    ".L800E4410:\n"
    "\tbgez\t$5,.L800E441C\n"
    "\t slt\t$9,$5,$0\n"       /* delay: t1 = (b<0) */
    "\tnegu\t$5,$5\n"             /* |b| */
    ".L800E441C:\n"
    "\t.word\t0x0085001b\n"         /* divu $a0,$a1 -- {HI,LO} = |a|/|b|, RAW (no div-by-0 guard).
                                       w64-a20: emitted as the machine word because NEITHER assembler
                                       takes a spelling the other accepts.  GNU-as spells a raw divide
                                       `divu $zero,rs,rt`, which ASPSX 2.77 expands into the op PLUS a
                                       4-word /0 guard (and refuses it outright under .set noat);
                                       ASPSX's own raw spelling is the 2-operand `divu rs,rt`, which
                                       maspsx position-parses and dies on ("expected 3, got 2").  The
                                       .word satisfies both and is the established device for
                                       maspsx-hostile ops (cf. fixdmult's mult).  0x0085001b =
                                       SPECIAL | rs=4 | rt=5 | 0x1b -- the exact byte GNU-as emits. */
    "\txor\t$8,$8,$9\n"          /* sign = sign(a) ^ sign(b) */
    "\tnegu\t$8,$8\n"            /* -> 0 or -1 mask */
    "\tbeqz\t$5,.L800E44A4\n"      /* b==0 -> return 0 */
    "\t lui\t$10,1\n"              /* delay: t2 = 0x10000 (bit walker, (0x10000>>16) form) */
    "\tori\t$9,$0,0x1\n"        /* loop terminator */
    "\tmfhi\t$4\n"                /* remainder */
    "\tmflo\t$2\n"                /* quotient  */
    "\tbltz\t$4,.L800E4474\n"
    "\t sll\t$2,$2,16\n"         /* delay: int part << 16 */
    "\tsll\t$4,$4,1\n"
    ".L800E4448:\n"
    "\tbgez\t$4,.L800E4480\n"
    "\t sltu\t$11,$4,$5\n"        /* delay */
    ".L800E4450:\n"
    "\tbnez\t$11,.L800E4460\n"
    "\t srl\t$10,$10,1\n"           /* delay */
    "\tor\t$2,$2,$10\n"
    "\tsubu\t$4,$4,$5\n"
    ".L800E4460:\n"
    "\tbne\t$10,$9,.L800E4448\n"
    "\t srl\t$5,$5,1\n"           /* delay */
    "\txor\t$2,$2,$8\n"
    "\tjr\t$31\n"
    "\t sub\t$2,$2,$8\n"         /* delay: HANDWRITTEN trapping sub (reapply sign) */
    ".L800E4474:\n"
    "\tsrl\t$5,$5,1\n"
    ".L800E4478:\n"
    "\tbltz\t$4,.L800E4450\n"
    "\t sltu\t$11,$4,$5\n"        /* delay */
    ".L800E4480:\n"
    "\tbnez\t$11,.L800E4490\n"
    "\t srl\t$10,$10,1\n"           /* delay */
    "\tor\t$2,$2,$10\n"
    "\tsubu\t$4,$4,$5\n"
    ".L800E4490:\n"
    "\tbne\t$10,$9,.L800E4478\n"
    "\t sll\t$4,$4,1\n"           /* delay */
    "\txor\t$2,$2,$8\n"
    "\tjr\t$31\n"
    "\t sub\t$2,$2,$8\n"         /* delay: HANDWRITTEN trapping sub */
    ".L800E44A4:\n"
    "\tjr\t$31\n"
    "\t or\t$2,$0,$0\n"      /* delay: b==0 -> 0 */
    "\t.set at\n\t.set reorder\n"
);
/* co-equal XDEF `fixeddiv` at the same address (caller-facing name). gcc-2.8.0 SILENTLY IGNORES
   __attribute__((alias)) (emits nothing -- nm-verified), so the name is declared global here and
   its LABEL sits next to `rdiv:` in the block above.
   w64-a20: it used to be a GNU-as symbol assignment `fixeddiv = rdiv`; ASPSX 2.77 has no
   symbol-assignment form (`=`, `.set a,b`, `equ`, `.equ` all rejected) but does accept two labels
   at one address, so the label form is the portable spelling -- and it is what the dialect shim was
   synthesising anyway.
   The explicit `.type`/`.size` directives that used to live here are GONE: they are ELF-only (ASPSX
   rejects them) and REDUNDANT -- tools/fix_symsizes.py gives every size-less global text symbol the
   same computed st_size/STT_FUNC after assembly, so the gate object came out BIT-IDENTICAL without
   them (measured, not assumed). */
__asm__(
    "\t.globl fixeddiv\n"
);
#else
extern int fixeddiv(int a, int b)   /* @0x800E4404 : host fallback (16.16 signed divide) */
{
    unsigned ua, ub, rem, result, bit;
    int      neg;

    if (b == 0) return 0;
    neg = (a < 0) ^ (b < 0);
    ua  = (a < 0) ? (unsigned)(0 - a) : (unsigned)a;
    ub  = (b < 0) ? (unsigned)(0 - b) : (unsigned)b;
    result = (ua / ub) << 16;
    rem    = ua % ub;
    for (bit = 0x8000; bit != 0; bit >>= 1) {
        rem <<= 1;
        if (rem >= ub) { result |= bit; rem -= ub; }
    }
    return neg ? -(int)result : (int)result;
}
extern int rdiv(int a, int b) __attribute__((alias("fixeddiv")));
#endif
