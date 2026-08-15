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

    "\t.globl random\n"     /* @0x800E77A8 : int random(void) */
    "random:\n"
    "\tlui\t$4,%hi(seed)\n"
    "\taddiu\t$4,$4,%lo(seed)\n"
    "\tlw\t$13,20($4)\n"          /* load the six state words (state[5]..state[0]); maspsx needs */
    "\tlw\t$12,16($4)\n"          /* DECIMAL load/store offsets (it int()-parses offset base-10) */
    "\tlw\t$11,12($4)\n"
    "\tlw\t$10,8($4)\n"
    "\tlw\t$9,4($4)\n"
    "\tlw\t$8,0($4)\n"
    "\taddu\t$12,$12,$13\n"        /* t4 += t5 */
    "\tsltu\t$5,$12,$13\n"        /* a1 = carry */
    "\taddu\t$11,$11,$12\n"        /* t3 += t4 */
    "\tsltu\t$6,$11,$12\n"        /* a2 = carry */
    "\taddu\t$11,$11,$5\n"        /* t3 += a1 */
    "\tsltu\t$5,$11,$5\n"
    "\taddu\t$5,$5,$6\n"
    "\taddu\t$10,$10,$11\n"
    "\tsltu\t$6,$10,$11\n"
    "\taddu\t$10,$10,$5\n"
    "\tsltu\t$5,$10,$5\n"
    "\taddu\t$5,$5,$6\n"
    "\taddu\t$9,$9,$10\n"
    "\tsltu\t$6,$9,$10\n"
    "\taddu\t$9,$9,$5\n"
    "\tsltu\t$5,$9,$5\n"
    "\taddu\t$5,$5,$6\n"
    "\taddu\t$8,$8,$9\n"
    "\tsltu\t$6,$8,$9\n"
    "\taddu\t$8,$8,$5\n"
    "\taddiu\t$13,$13,0x1\n"       /* 192-bit counter increment (carry-chained) */
    "\tbnez\t$13,.L800E7858\n"
    "\t nop\n"
    "\taddiu\t$12,$12,0x1\n"
    "\tbnez\t$12,.L800E7858\n"
    "\t nop\n"
    "\taddiu\t$11,$11,0x1\n"
    "\tbnez\t$11,.L800E7858\n"
    "\t nop\n"
    "\taddiu\t$10,$10,0x1\n"
    "\tbnez\t$10,.L800E7858\n"
    "\t nop\n"
    "\taddiu\t$9,$9,0x1\n"
    "\tbnez\t$9,.L800E7858\n"
    "\t nop\n"
    "\taddiu\t$8,$8,0x1\n"
    ".L800E7858:\n"
    "\tsw\t$13,20($4)\n"          /* store the six words back */
    "\tsw\t$12,16($4)\n"
    "\tsw\t$11,12($4)\n"
    "\tsw\t$10,8($4)\n"
    "\tsw\t$9,4($4)\n"
    "\tsw\t$8,0($4)\n"
    "\tjr\t$31\n"
    "\t addu\t$2,$8,$0\n"     /* jr delay slot: return top word (state[0]) */

    "\t.globl seedrandom\n"        /* @0x800E7878 : void seedrandom(int s) */
    "seedrandom:\n"
    "\tlui\t$5,%hi(seed)\n"
    "\taddiu\t$5,$5,%lo(seed)\n"
    "\tlui\t$1,0xf22d\n"          /* += 0xF22D0E56 ; store state[0] */
    "\tori\t$1,$1,0xe56\n"
    "\taddu\t$4,$4,$1\n"
    "\tsw\t$4,0($5)\n"
    "\tlui\t$1,0x9604\n"          /* += 0x96041893 ; store state[1] */
    "\tori\t$1,$1,0x1893\n"
    "\taddu\t$4,$4,$1\n"
    "\tsw\t$4,4($5)\n"
    "\tlui\t$1,0x3df3\n"          /* += 0x3DF3B646 ; store state[2] */
    "\tori\t$1,$1,0xb646\n"
    "\taddu\t$4,$4,$1\n"
    "\tsw\t$4,8($5)\n"
    "\tlui\t$1,0x40dd\n"          /* += 0x40DDE76D ; store state[3] */
    "\tori\t$1,$1,0xe76d\n"
    "\taddu\t$4,$4,$1\n"
    "\tsw\t$4,12($5)\n"
    "\tlui\t$1,0x9732\n"          /* += 0x97327AE1 ; store state[4] */
    "\tori\t$1,$1,0x7ae1\n"
    "\taddu\t$4,$4,$1\n"
    "\tsw\t$4,16($5)\n"
    "\tlui\t$1,0xd1a9\n"          /* += 0xD1A9FBE7 ; store state[5] */
    "\tori\t$1,$1,0xfbe7\n"
    "\taddu\t$4,$4,$1\n"
    "\tsw\t$4,20($5)\n"
    "\tjr\t$31\n"
    "\t nop\n"
    "\t.set at\n"
    "\t.set reorder\n"
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
