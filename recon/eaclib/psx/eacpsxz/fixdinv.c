/* eaclib/psx/eacpsxz/fixdinv.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\fixdinv.obj  (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\FIXDINV.ASM (per SYM SLD @0x800ED3EC line 7).
 *   ONE 56-byte (14-insn) routine with TWO co-equal XDEF entry labels at offset 0: `fixedinverse`
 *   (the oracle/scaffolding canonical name -- alphabetically first, so objdump shows it) + `rinverse`
 *   (caller-facing).  The oracle uses a raw `divu $zero` (no div-by-0 break guard) + sra/xor/subu sign
 *   trick -- forms no C compiler emits (the C recon FAILed 28: it adds a `bnez;break 7` div guard and
 *   different sign shifts).  Transcribed VERBATIM as file-scope __asm__; C fallback for the host build.
 *
 *   Rounded 32-bit reciprocal carrying x's sign:  q = 0xFFFFFFFF / |x|, round-half-up via
 *   (|x|>>1 <u remainder), then re-apply sign(x).  @0x800ED3EC.
 *   maspsx: `divu`/`sltu` operands are comma-joined NO-space (position-parsed); the `$zero` divu dest
 *   passes through maspsx --expand-div as a raw divide (no break guard), same as fixddiv/rdiv.
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
    "\t.globl fixedinverse\n"   /* canonical (oracle) name -- objdump shows this one */
    "fixedinverse:\n"
    "rinverse:\n"
    "\taddiu\t$8,$0,-1\n"       /* t0 = 0xFFFFFFFF (numerator) */
    "\tsra\t$10,$4,31\n"          /* sign = x >> 31  (0 or -1) */
    "\txor\t$9,$4,$10\n"         /* |x| step 1 */
    "\tsubu\t$9,$9,$10\n"        /* |x| = (x ^ sign) - sign */
    "\t.word\t0x0109001b\n"        /* divu $t0,$t1 -- {HI,LO} = 0xFFFFFFFF / |x|, RAW (no /0 guard).
                                      w64-a20: the machine word, because no single spelling suits both
                                      assemblers -- GNU-as wants `divu $zero,rs,rt` (ASPSX expands that
                                      WITH a 4-word /0 guard and rejects it under .set noat), ASPSX
                                      wants the 2-operand `divu rs,rt` (maspsx position-parses it and
                                      dies).  Same device as fixddiv.  0x0109001b = SPECIAL | rs=8 |
                                      rt=9 | 0x1b. */
    "\tnop\n"
    "\tsra\t$11,$9,1\n"           /* t3 = |x| >> 1 */
    "\tmflo\t$2\n"                /* quotient */
    "\tmfhi\t$3\n"                /* remainder */
    "\tsltu\t$12,$11,$3\n"        /* round up if (|x|>>1) < remainder */
    "\taddu\t$2,$2,$12\n"        /* q += round */
    "\txor\t$2,$2,$10\n"         /* re-apply sign step 1 */
    "\tjr\t$31\n"
    "\t subu\t$2,$2,$10\n"       /* delay: q = (q ^ sign) - sign */
    "\t.set at\n\t.set reorder\n"
);
/* co-equal XDEF `rinverse` at the same address. gcc-2.8.0 SILENTLY IGNORES __attribute__((alias))
   (nm-verified), so the name is declared global here and its LABEL sits next to `fixedinverse:`.
   w64-a20: was a GNU-as symbol assignment `rinverse = fixedinverse`; ASPSX 2.77 has no
   symbol-assignment form but accepts two labels at one address.  The `.type`/`.size` pair that used
   to live here is gone -- ELF-only, ASPSX-rejected, and redundant with tools/fix_symsizes.py (the
   gate object is bit-identical without it). */
__asm__(
    "\t.globl rinverse\n"
);
#else
extern unsigned fixedinverse(int x)   /* @0x800ED3EC : host fallback (rounded reciprocal) */
{
    int sign = x >> 31;                            /* 0 or -1 */
    unsigned ax = (unsigned)((x ^ sign) - sign);   /* |x| */
    unsigned q = 0xFFFFFFFFu / ax;
    unsigned r = 0xFFFFFFFFu % ax;
    if ((ax >> 1) < r)                             /* round half up */
        q += 1;
    return (unsigned)(((int)q ^ sign) - sign);     /* re-apply sign */
}
extern unsigned rinverse(int x) __attribute__((alias("fixedinverse")));
#endif
