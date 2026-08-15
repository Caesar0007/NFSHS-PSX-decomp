/* eaclib/psx/eacpsxz/fixdsqrt.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\fixdsqrt.obj (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\FIXDSQRT.ASM (per SYM SLD -- code @0x800EB0AC
 *                = line 128, tables @0x801234EC = line 55). ONE XDEF here: fixedsqrt @0x800EB0AC
 *                (21 insns, 0x54). The oracle walks a single table base pointer BACKWARD, uses a bare
 *                2-op `mult` + manual mflo/mfhi hi-lo combine -- forms no C compiler emits (the C recon
 *                FAILed 46 diffs). Transcribed VERBATIM as file-scope __asm__; C fallback for the host.
 *                (`isqrt` @0x800F32CC is a SEPARATE obj -- src/eaclib/psx/eacpsxz/isqrt.c, INCLUDE_ASM'd
 *                 -- NOT part of fixdsqrt.obj; its table isqrttbl is isqrttbl.obj. Not touched here.)
 *
 *   16.16 fixed-point sqrt via a per-highest-set-bit piecewise-linear table:
 *     find the highest set bit position p of x, then  result = ((x * scale[p]) >> 16) + offset[p].
 *   Tables (blob-owned data, splat symbol `D_8012356C`): scale[32] @0x801234EC, a base word @0x8012356C
 *   (== D_8012356C, one past scale[31] -- the loop's start pointer; not read as data), offset[32]
 *   @0x80123570.  The reload `lw $t4,0x84($t0)` reaches offset[p] = scale[p] + 132 bytes.
 *
 *   maspsx notes: the `lw` displacement MUST be decimal (132, not 0x84 -- it int()-parses base-10);
 *   the bare 2-op `mult $a0,$t3` is emitted as a raw `.word 0x008B0018` (maspsx routes bare mult
 *   through load-parse and would mishandle it / add spurious hazard nops).
 */

#if defined(__mips__)
extern int D_8012356C;   /* @0x8012356C : base of the fixdsqrt scale/offset tables (data blob owns it) */
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */
    "\t.globl fixedsqrt\n"  /* @0x800EB0AC : int fixedsqrt(int x) */
    "fixedsqrt:\n"
    "\tbeqz\t$a0,.L800EB0F8\n"          /* x == 0 -> return 0 */
    "\t lui\t$t1,0x8000\n"             /* delay: mask = 0x80000000 */
    "\tlui\t$t0,%hi(D_8012356C)\n"
    "\taddiu\t$t0,$t0,%lo(D_8012356C)\n" /* t0 = &(one past scale[31]); walks BACKWARD */
    ".L800EB0BC:\n"
    "\tand\t$t2,$a0,$t1\n"             /* test the current (mask) bit */
    "\taddiu\t$t0,$t0,-4\n"            /* t0-- (down into the scale table) */
    "\tbeqz\t$t2,.L800EB0BC\n"         /* bit clear -> keep scanning */
    "\t srl\t$t1,$t1,1\n"             /* delay: mask >>= 1 */
    "\tlw\t$t3,0($t0)\n"               /* scale[p] */
    "\tlw\t$t4,132($t0)\n"            /* offset[p] (scale[p] + 0x84; DECIMAL 132 for maspsx) */
    "\t.word\t0x008B0018\n"            /* mult $a0,$t3  (bare 2-op -> raw word for maspsx) */
    "\tnop\n"
    "\tmflo\t$t0\n"
    "\tmfhi\t$t1\n"
    "\tsrl\t$t0,$t0,16\n"
    "\tsll\t$t1,$t1,16\n"
    "\tor\t$v0,$t0,$t1\n"              /* v0 = (x * scale[p]) >> 16 */
    "\tjr\t$ra\n"
    "\t addu\t$v0,$v0,$t4\n"           /* delay: + offset[p] */
    ".L800EB0F8:\n"
    "\tjr\t$ra\n"
    "\t addu\t$v0,$zero,$zero\n"       /* delay: x == 0 -> 0 */
    "\t.set pop\n"
);
#else
static const int kSqrtScale[32] = {          /* @0x801234EC */
    6949350,4913933,3474675,2456966,1737338,1228483,868669,614242,
    434334,307121,217167,153560,108584,76780,54292,38390,
    27146,19195,13573,9598,6786,4799,3393,2399,
    1697,1200,848,600,424,300,212,150,
};
static const int kSqrtOffset[32] = {         /* @0x80123570 */
    152,215,304,430,608,860,1217,1721,
    2433,3441,4867,6883,9734,13765,19467,27531,
    38934,55061,77868,110122,155736,220244,311472,440488,
    622945,880977,1245890,1761954,2491779,3523908,4983558,7047816,
};

extern int fixedsqrt(int x)   /* @0x800EB0AC */
{
    if (x == 0)
        return 0;
    unsigned mask = 0x80000000u;
    int p = 31;
    while ((x & mask) == 0) {          /* highest set bit position */
        mask >>= 1;
        --p;
    }
    long long prod = (long long)x * (long long)kSqrtScale[p];
    return (int)(prod >> 16) + kSqrtOffset[p];
}
#endif
