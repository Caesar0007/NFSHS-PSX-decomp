/* eaclib/psx/eacpsxz/sinfunc.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\sinfunc.obj  (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\SINFUNC.ASM (per SYM SLD @0x800F18E4 line 12).
 *   FOUR co-equal XDEFs over two addresses: intcos==fastintcos @0x800F18E4 (1 insn) and
 *   intsin==fastintsin @0x800F18E8 (26 insns, 0x68). intcos does a += 90deg (0x100) then FALLS THROUGH
 *   into intsin -- a quadrant-folded quarter-sine lookup no C compiler reproduces (nested branches with
 *   negu / the 0x400 table-wrap load in jr delay slots). Transcribed VERBATIM -- intcos + intsin in ONE
 *   __asm__ block for the fall-through. `int*` are the oracle/scaffolding canonical names (INCLUDE_ASM +
 *   .s) so they are the sole asm labels; `fastint*` are C aliases. C fallback for the host build.
 *
 *   full circle = 0x400 (0x100 = 90deg).  quad = (a>>8)&3, pos = a&0xFF, on the shared 257-entry table
 *   sintbl[i] = sin(i*90deg/256) (16.16):  q0: T[pos]  q1: T[256-pos]  q2: -T[pos]  q3: -T[256-pos].
 *   sintbl @0x80137464 is SHARED (also isincos) -> extern; the data pass owns its definition.
 *   maspsx: the `lw` displacement is DECIMAL (1024 == 0x400); immediates decimal; `.set noreorder`.
 */
extern const int sintbl[257];   /* @0x80137464 : quarter-sine table, 16.16 (blob-owned) */

#if defined(__mips__)
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl intcos\n"            /* @0x800F18E4 : int intcos(int a) -- a += 90deg, fall through */
    "intcos:\n"
    "\taddiu\t$a0,$a0,256\n"        /* a += 0x100 (90deg) */

    "\t.globl intsin\n"            /* @0x800F18E8 : int intsin(int a) */
    "intsin:\n"
    "\tlui\t$t4,%hi(sintbl)\n"
    "\taddiu\t$t4,$t4,%lo(sintbl)\n"
    "\tandi\t$t1,$a0,512\n"         /* a & 0x200 : quadrant bit 1 */
    "\tandi\t$t2,$a0,256\n"         /* a & 0x100 : quadrant bit 0 */
    "\tbnez\t$t1,.L800F1928\n"      /* quad 2/3 */
    "\t andi\t$t0,$a0,255\n"        /* delay: pos = a & 0xFF */
    "\tbnez\t$t2,.L800F1918\n"      /* quad 1 */
    "\t sll\t$t3,$t0,2\n"          /* delay: pos*4 */
    "\taddu\t$t5,$t4,$t3\n"         /* quad 0: &sintbl[pos] */
    "\tlw\t$v0,0($t5)\n"
    "\tjr\t$ra\n"
    "\t nop\n"
    ".L800F1918:\n"                 /* quad 1 */
    "\tsubu\t$t5,$t4,$t3\n"         /* &sintbl - pos*4 */
    "\tlw\t$v0,1024($t5)\n"         /* sintbl[256 - pos]  (0x400 == 256*4) */
    "\tjr\t$ra\n"
    "\t nop\n"
    ".L800F1928:\n"                 /* quad 2/3 */
    "\tbnez\t$t2,.L800F1940\n"      /* quad 3 */
    "\t sll\t$t3,$t0,2\n"          /* delay: pos*4 */
    "\taddu\t$t5,$t4,$t3\n"         /* quad 2: &sintbl[pos] */
    "\tlw\t$v0,0($t5)\n"
    "\tjr\t$ra\n"
    "\t negu\t$v0,$v0\n"           /* delay: -sintbl[pos] */
    ".L800F1940:\n"                 /* quad 3 */
    "\tsubu\t$t5,$t4,$t3\n"
    "\tlw\t$v0,1024($t5)\n"         /* sintbl[256 - pos] */
    "\tjr\t$ra\n"
    "\t negu\t$v0,$v0\n"           /* delay: -sintbl[256 - pos] */
    "\t.set pop\n"
);
/* co-equal XDEFs fastintcos/fastintsin. gcc-2.8.0 SILENTLY IGNORES __attribute__((alias)) (nm-verified)
   -- emit them as GNU-as symbol assignments in file-scope asm. */
__asm__(
    "\t.globl fastintcos\n"
    "fastintcos = intcos\n"
    "\t.globl fastintsin\n"
    "fastintsin = intsin\n"
);
#else  /* host build -- quadrant-folded quarter-sine lookup */
extern int intsin(int a)   /* @0x800F18E8 */
{
    int pos = a & 0xFF;
    if (a & 0x200) {                          /* quad 2/3 */
        if (a & 0x100) return -sintbl[256 - pos];   /* quad 3 */
        return -sintbl[pos];                         /* quad 2 */
    }
    if (a & 0x100) return sintbl[256 - pos];         /* quad 1 */
    return sintbl[pos];                              /* quad 0 */
}
extern int intcos(int a)   /* @0x800F18E4 : a += 90deg, fall into sin */
{
    return intsin(a + 0x100);
}
extern int fastintcos(int a) __attribute__((alias("intcos")));
extern int fastintsin(int a) __attribute__((alias("intsin")));
#endif
