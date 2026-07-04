/* eaclib/psx/eacpsxz/fixdinv.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
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
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */
    "\t.globl fixedinverse\n"   /* canonical (oracle) name -- objdump shows this one */
    "fixedinverse:\n"
    "\taddiu\t$t0,$zero,-1\n"       /* t0 = 0xFFFFFFFF (numerator) */
    "\tsra\t$t2,$a0,31\n"          /* sign = x >> 31  (0 or -1) */
    "\txor\t$t1,$a0,$t2\n"         /* |x| step 1 */
    "\tsubu\t$t1,$t1,$t2\n"        /* |x| = (x ^ sign) - sign */
    "\tdivu\t$zero,$t0,$t1\n"      /* {HI,LO} = 0xFFFFFFFF / |x|  (raw, $zero dest) */
    "\tnop\n"
    "\tsra\t$t3,$t1,1\n"           /* t3 = |x| >> 1 */
    "\tmflo\t$v0\n"                /* quotient */
    "\tmfhi\t$v1\n"                /* remainder */
    "\tsltu\t$t4,$t3,$v1\n"        /* round up if (|x|>>1) < remainder */
    "\taddu\t$v0,$v0,$t4\n"        /* q += round */
    "\txor\t$v0,$v0,$t2\n"         /* re-apply sign step 1 */
    "\tjr\t$ra\n"
    "\t subu\t$v0,$v0,$t2\n"       /* delay: q = (q ^ sign) - sign */
    "\t.set pop\n"
);
/* co-equal XDEF `rinverse` at the same address. gcc-2.8.0 SILENTLY IGNORES __attribute__((alias))
   (nm-verified), so emit it as a GNU-as symbol assignment in file-scope asm. */
__asm__(
    "\t.globl rinverse\n"
    "rinverse = fixedinverse\n"
);
#else
extern "C" unsigned fixedinverse(int x)   /* @0x800ED3EC : host fallback (rounded reciprocal) */
{
    int sign = x >> 31;                            /* 0 or -1 */
    unsigned ax = (unsigned)((x ^ sign) - sign);   /* |x| */
    unsigned q = 0xFFFFFFFFu / ax;
    unsigned r = 0xFFFFFFFFu % ax;
    if ((ax >> 1) < r)                             /* round half up */
        q += 1;
    return (unsigned)(((int)q ^ sign) - sign);     /* re-apply sign */
}
extern "C" unsigned rinverse(int x) __attribute__((alias("fixedinverse")));
#endif
