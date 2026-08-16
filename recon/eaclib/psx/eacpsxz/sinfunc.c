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
/* w33-a5 CONST-TABLE RETEST (w32 open item) -- CLOSED, the lever is INAPPLICABLE here.
 * isincos.c cracked intsincos by DROPPING `const` (gcc-2.8 marks a const object's MEM
 * RTX_UNCHANGING_P, letting sched hoist its loads across an aliasing-unknown store).  That is a
 * pure C-CODEGEN lever, and this TU has NO C codegen: SYM SLD @0x800F18E4 = "line 12 of file
 * C:\LIB\PSX\SINFUNC.ASM" -- the obj is hand-written assembly, transcribed verbatim below, and
 * `sintbl` is reached through a %hi/%lo TEXT RELOC, not through this declaration.  A/B PROVEN
 * this session: const vs non-const -> intcos PASS (1) / intsin PASS (26) either way, byte-identical.
 * So `const` stays (it IS a read-only table, and it is what the host fallback wants); isincos.c's
 * "worth re-testing there" note is hereby answered NO.  No regression risk to intsin/intcos. */
extern int sintbl[257];   /* @0x80137464 : quarter-sine table, 16.16 */

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

    "\t.globl intcos\n"            /* @0x800F18E4 : int intcos(int a) -- a += 90deg, fall through */
    "intcos:\n"
    "fastintcos:\n"
    "\taddiu\t$4,$4,256\n"        /* a += 0x100 (90deg) */

    "\t.globl intsin\n"            /* @0x800F18E8 : int intsin(int a) */
    "intsin:\n"
    "fastintsin:\n"
    "\tlui\t$12,%hi(sintbl)\n"
    "\taddiu\t$12,$12,%lo(sintbl)\n"
    "\tandi\t$9,$4,512\n"         /* a & 0x200 : quadrant bit 1 */
    "\tandi\t$10,$4,256\n"         /* a & 0x100 : quadrant bit 0 */
    "\tbnez\t$9,.L800F1928\n"      /* quad 2/3 */
    "\t andi\t$8,$4,255\n"        /* delay: pos = a & 0xFF */
    "\tbnez\t$10,.L800F1918\n"      /* quad 1 */
    "\t sll\t$11,$8,2\n"          /* delay: pos*4 */
    "\taddu\t$13,$12,$11\n"         /* quad 0: &sintbl[pos] */
    "\tlw\t$2,0($13)\n"
    "\tjr\t$31\n"
    "\t nop\n"
    ".L800F1918:\n"                 /* quad 1 */
    "\tsubu\t$13,$12,$11\n"         /* &sintbl - pos*4 */
    "\tlw\t$2,1024($13)\n"         /* sintbl[256 - pos]  (0x400 == 256*4) */
    "\tjr\t$31\n"
    "\t nop\n"
    ".L800F1928:\n"                 /* quad 2/3 */
    "\tbnez\t$10,.L800F1940\n"      /* quad 3 */
    "\t sll\t$11,$8,2\n"          /* delay: pos*4 */
    "\taddu\t$13,$12,$11\n"         /* quad 2: &sintbl[pos] */
    "\tlw\t$2,0($13)\n"
    "\tjr\t$31\n"
    "\t negu\t$2,$2\n"           /* delay: -sintbl[pos] */
    ".L800F1940:\n"                 /* quad 3 */
    "\tsubu\t$13,$12,$11\n"
    "\tlw\t$2,1024($13)\n"         /* sintbl[256 - pos] */
    "\tjr\t$31\n"
    "\t negu\t$2,$2\n"           /* delay: -sintbl[256 - pos] */
    "\t.set at\n\t.set reorder\n"
);
/* co-equal XDEFs fastintcos/fastintsin. gcc-2.8.0 SILENTLY IGNORES __attribute__((alias)) (nm-verified)
   -- emit them as GNU-as symbol assignments in file-scope asm. */
__asm__(
    "\t.globl fastintcos\n"
    "\t.globl fastintsin\n"
    /* explicit ELF fn type+size: hand-asm labels carry none, and objdiff sizes
       symbols from these (without them the unit reports 0% despite PASS). */
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
