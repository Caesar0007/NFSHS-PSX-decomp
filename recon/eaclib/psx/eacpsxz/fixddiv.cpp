/* eaclib/psx/eacpsxz/fixddiv.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
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
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */
    "\t.globl rdiv\n"       /* rdiv = the oracle/scaffolding canonical label (objdump shows THIS one) */
    "rdiv:\n"
    "\tbgez\t$a0,.L800E4410\n"
    "\t slt\t$t0,$a0,$zero\n"       /* delay: t0 = (a<0) */
    "\tnegu\t$a0,$a0\n"             /* |a| */
    ".L800E4410:\n"
    "\tbgez\t$a1,.L800E441C\n"
    "\t slt\t$t1,$a1,$zero\n"       /* delay: t1 = (b<0) */
    "\tnegu\t$a1,$a1\n"             /* |b| */
    ".L800E441C:\n"
    "\tdivu\t$zero,$a0,$a1\n"       /* {HI,LO} = |a|/|b| (raw, $zero dest -> maspsx passes through) */
    "\txor\t$t0,$t0,$t1\n"          /* sign = sign(a) ^ sign(b) */
    "\tnegu\t$t0,$t0\n"            /* -> 0 or -1 mask */
    "\tbeqz\t$a1,.L800E44A4\n"      /* b==0 -> return 0 */
    "\t lui\t$t2,1\n"              /* delay: t2 = 0x10000 (bit walker, (0x10000>>16) form) */
    "\tori\t$t1,$zero,0x1\n"        /* loop terminator */
    "\tmfhi\t$a0\n"                /* remainder */
    "\tmflo\t$v0\n"                /* quotient  */
    "\tbltz\t$a0,.L800E4474\n"
    "\t sll\t$v0,$v0,16\n"         /* delay: int part << 16 */
    "\tsll\t$a0,$a0,1\n"
    ".L800E4448:\n"
    "\tbgez\t$a0,.L800E4480\n"
    "\t sltu\t$t3,$a0,$a1\n"        /* delay */
    ".L800E4450:\n"
    "\tbnez\t$t3,.L800E4460\n"
    "\t srl\t$t2,$t2,1\n"           /* delay */
    "\tor\t$v0,$v0,$t2\n"
    "\tsubu\t$a0,$a0,$a1\n"
    ".L800E4460:\n"
    "\tbne\t$t2,$t1,.L800E4448\n"
    "\t srl\t$a1,$a1,1\n"           /* delay */
    "\txor\t$v0,$v0,$t0\n"
    "\tjr\t$ra\n"
    "\t sub\t$v0,$v0,$t0\n"         /* delay: HANDWRITTEN trapping sub (reapply sign) */
    ".L800E4474:\n"
    "\tsrl\t$a1,$a1,1\n"
    ".L800E4478:\n"
    "\tbltz\t$a0,.L800E4450\n"
    "\t sltu\t$t3,$a0,$a1\n"        /* delay */
    ".L800E4480:\n"
    "\tbnez\t$t3,.L800E4490\n"
    "\t srl\t$t2,$t2,1\n"           /* delay */
    "\tor\t$v0,$v0,$t2\n"
    "\tsubu\t$a0,$a0,$a1\n"
    ".L800E4490:\n"
    "\tbne\t$t2,$t1,.L800E4478\n"
    "\t sll\t$a0,$a0,1\n"           /* delay */
    "\txor\t$v0,$v0,$t0\n"
    "\tjr\t$ra\n"
    "\t sub\t$v0,$v0,$t0\n"         /* delay: HANDWRITTEN trapping sub */
    ".L800E44A4:\n"
    "\tjr\t$ra\n"
    "\t or\t$v0,$zero,$zero\n"      /* delay: b==0 -> 0 */
    "\t.set pop\n"
);
/* co-equal XDEF `fixeddiv` at the same address (caller-facing name). gcc-2.8.0 SILENTLY IGNORES
   __attribute__((alias)) (emits nothing -- nm-verified), so emit the alias as a GNU-as symbol
   assignment in file-scope asm (a real global at rdiv's address). */
__asm__(
    "\t.globl fixeddiv\n"
    "fixeddiv = rdiv\n"
);
#else
extern "C" int fixeddiv(int a, int b)   /* @0x800E4404 : host fallback (16.16 signed divide) */
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
extern "C" int rdiv(int a, int b) __attribute__((alias("fixeddiv")));
#endif
