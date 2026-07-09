/* eaclib/psx/eacpsxz/random.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\random.obj  (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\RANDOM.ASM (per SYM SLD -- data `seed`
 *                @0x8012349C = lines 4-6, `random` @0x800E77A8 = line 14). The oracle keeps the
 *                six state words in a fixed $t0-$t5 file with a single base held in $a0 across all
 *                12 loads/stores and manual $a1/$a2 carry temps -- a register layout no C compiler
 *                reproduces (the C recon FAILs 92/53). Two XDEF entries: random (0x800E77A8, no args,
 *                returns $v0) + seedrandom (0x800E7878, one arg in $a0), plus exported state `seed`.
 *
 *   `seed` = six 32-bit words @0x8012349C (== seedrandom(0)); the real bytes live in the splat-
 *   extracted .data blob (global XDEF `seed`), which this asm references via %hi/%lo(seed).
 *
 *   ALGORITHM: a 192-bit add-with-carry PRNG. random() folds the six words together with full
 *   carry propagation ($t(i+1) += $t(i); sltu = carry), then increments the 192-bit counter and
 *   returns the top word. seedrandom(s) writes a running sum of six fixed constants offset by s.
 *
 *   Transcribed VERBATIM as a file-scope __asm__ (byte-identical to RANDOM.ASM); a C fallback keeps
 *   the x86 host build compiling. maspsx notes: operands are comma-joined with NO spaces (sltu/ori
 *   etc. are position-parsed), double `.set noreorder` (tab form turns maspsx is_reorder OFF; space
 *   form passes to gnu-as), `.set noat` to allow the manual $at in seedrandom.
 */

#if defined(__mips__)
/* the 6-word PRNG state, defined in the .data blob (original @0x8012349C); asm refs it as `seed`. */
extern unsigned seed[6];
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl random\n"     /* @0x800E77A8 : int random(void) */
    "random:\n"
    "\tlui\t$a0,%hi(seed)\n"
    "\taddiu\t$a0,$a0,%lo(seed)\n"
    "\tlw\t$t5,20($a0)\n"          /* load the six state words (state[5]..state[0]); maspsx needs */
    "\tlw\t$t4,16($a0)\n"          /* DECIMAL load/store offsets (it int()-parses offset base-10) */
    "\tlw\t$t3,12($a0)\n"
    "\tlw\t$t2,8($a0)\n"
    "\tlw\t$t1,4($a0)\n"
    "\tlw\t$t0,0($a0)\n"
    "\taddu\t$t4,$t4,$t5\n"        /* t4 += t5 */
    "\tsltu\t$a1,$t4,$t5\n"        /* a1 = carry */
    "\taddu\t$t3,$t3,$t4\n"        /* t3 += t4 */
    "\tsltu\t$a2,$t3,$t4\n"        /* a2 = carry */
    "\taddu\t$t3,$t3,$a1\n"        /* t3 += a1 */
    "\tsltu\t$a1,$t3,$a1\n"
    "\taddu\t$a1,$a1,$a2\n"
    "\taddu\t$t2,$t2,$t3\n"
    "\tsltu\t$a2,$t2,$t3\n"
    "\taddu\t$t2,$t2,$a1\n"
    "\tsltu\t$a1,$t2,$a1\n"
    "\taddu\t$a1,$a1,$a2\n"
    "\taddu\t$t1,$t1,$t2\n"
    "\tsltu\t$a2,$t1,$t2\n"
    "\taddu\t$t1,$t1,$a1\n"
    "\tsltu\t$a1,$t1,$a1\n"
    "\taddu\t$a1,$a1,$a2\n"
    "\taddu\t$t0,$t0,$t1\n"
    "\tsltu\t$a2,$t0,$t1\n"
    "\taddu\t$t0,$t0,$a1\n"
    "\taddiu\t$t5,$t5,0x1\n"       /* 192-bit counter increment (carry-chained) */
    "\tbnez\t$t5,.L800E7858\n"
    "\t nop\n"
    "\taddiu\t$t4,$t4,0x1\n"
    "\tbnez\t$t4,.L800E7858\n"
    "\t nop\n"
    "\taddiu\t$t3,$t3,0x1\n"
    "\tbnez\t$t3,.L800E7858\n"
    "\t nop\n"
    "\taddiu\t$t2,$t2,0x1\n"
    "\tbnez\t$t2,.L800E7858\n"
    "\t nop\n"
    "\taddiu\t$t1,$t1,0x1\n"
    "\tbnez\t$t1,.L800E7858\n"
    "\t nop\n"
    "\taddiu\t$t0,$t0,0x1\n"
    ".L800E7858:\n"
    "\tsw\t$t5,20($a0)\n"          /* store the six words back */
    "\tsw\t$t4,16($a0)\n"
    "\tsw\t$t3,12($a0)\n"
    "\tsw\t$t2,8($a0)\n"
    "\tsw\t$t1,4($a0)\n"
    "\tsw\t$t0,0($a0)\n"
    "\tjr\t$ra\n"
    "\t addu\t$v0,$t0,$zero\n"     /* jr delay slot: return top word (state[0]) */

    "\t.globl seedrandom\n"        /* @0x800E7878 : void seedrandom(int s) */
    "seedrandom:\n"
    "\tlui\t$a1,%hi(seed)\n"
    "\taddiu\t$a1,$a1,%lo(seed)\n"
    "\tlui\t$at,0xf22d\n"          /* += 0xF22D0E56 ; store state[0] */
    "\tori\t$at,$at,0xe56\n"
    "\taddu\t$a0,$a0,$at\n"
    "\tsw\t$a0,0($a1)\n"
    "\tlui\t$at,0x9604\n"          /* += 0x96041893 ; store state[1] */
    "\tori\t$at,$at,0x1893\n"
    "\taddu\t$a0,$a0,$at\n"
    "\tsw\t$a0,4($a1)\n"
    "\tlui\t$at,0x3df3\n"          /* += 0x3DF3B646 ; store state[2] */
    "\tori\t$at,$at,0xb646\n"
    "\taddu\t$a0,$a0,$at\n"
    "\tsw\t$a0,8($a1)\n"
    "\tlui\t$at,0x40dd\n"          /* += 0x40DDE76D ; store state[3] */
    "\tori\t$at,$at,0xe76d\n"
    "\taddu\t$a0,$a0,$at\n"
    "\tsw\t$a0,12($a1)\n"
    "\tlui\t$at,0x9732\n"          /* += 0x97327AE1 ; store state[4] */
    "\tori\t$at,$at,0x7ae1\n"
    "\taddu\t$a0,$a0,$at\n"
    "\tsw\t$a0,16($a1)\n"
    "\tlui\t$at,0xd1a9\n"          /* += 0xD1A9FBE7 ; store state[5] */
    "\tori\t$at,$at,0xfbe7\n"
    "\taddu\t$a0,$a0,$at\n"
    "\tsw\t$a0,20($a1)\n"
    "\tjr\t$ra\n"
    "\t nop\n"
    "\t.set pop\n"
);
#else
static unsigned seed[6] = {                  /* @0x8012349C (== seedrandom(0)) */
    0xF22D0E56u, 0x883126E9u, 0xC624DD2Fu, 0x0702C49Cu, 0x9E353F7Du, 0x6FDF3B64u
};

extern int random(void)   /* @0x800E77A8 */
{
    unsigned t0 = seed[0], t1 = seed[1], t2 = seed[2];
    unsigned t3 = seed[3], t4 = seed[4], t5 = seed[5];
    unsigned a1, a2;

    t4 += t5;  a1 = (t4 < t5);
    t3 += t4;  a2 = (t3 < t4);
    t3 += a1;  a1 = (t3 < a1);  a1 += a2;
    t2 += t3;  a2 = (t2 < t3);
    t2 += a1;  a1 = (t2 < a1);  a1 += a2;
    t1 += t2;  a2 = (t1 < t2);
    t1 += a1;  a1 = (t1 < a1);  a1 += a2;
    t0 += t1;
    t0 += a1;

    if (++t5 == 0)                            /* 192-bit increment (carry on word wrap) */
      if (++t4 == 0)
        if (++t3 == 0)
          if (++t2 == 0)
            if (++t1 == 0)
              ++t0;

    seed[0] = t0; seed[1] = t1; seed[2] = t2;
    seed[3] = t3; seed[4] = t4; seed[5] = t5;
    return (int)t0;
}

extern void seedrandom(int s)   /* @0x800E7878 */
{
    unsigned a = (unsigned)s;
    a += 0xF22D0E56u; seed[0] = a;
    a += 0x96041893u; seed[1] = a;
    a += 0x3DF3B646u; seed[2] = a;
    a += 0x40DDE76Du; seed[3] = a;
    a += 0x97327AE1u; seed[4] = a;
    a += 0xD1A9FBE7u; seed[5] = a;
}
#endif
