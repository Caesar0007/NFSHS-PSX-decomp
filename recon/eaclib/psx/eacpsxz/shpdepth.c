/* eaclib/psx/eacpsxz/shpdepth.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\shpdepth.obj  (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\SHPDEPTH.ASM (per SYM SLD @0x800F43E4 line 4).
 *   ONE XDEF: shapedepth @0x800F43E4 (27 insns, 0x6C). Bit depth from a shape's type byte (&0x77) via
 *   a hand-written `ori $v1,K; beq $v1,$v0` compare chain with the result `ori`s in the jr delay slots
 *   -- not the shape a C `switch` compiles to (the C recon FAILed 40). Transcribed VERBATIM; C fallback.
 *   maspsx: lbu offset DECIMAL; `.set noreorder`.
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
    "\t.globl shapedepth\n"        /* @0x800F43E4 : int shapedepth(unsigned char *shape) */
    "shapedepth:\n"
    "\tlbu\t$2,0($4)\n"           /* t = shape[0] */
    "\tori\t$3,$0,0x41\n"
    "\tandi\t$2,$2,0x77\n"        /* t &= 0x77 */
    "\tbeq\t$3,$2,.L800F4438\n"   /* 0x41 -> 8 */
    "\t ori\t$3,$0,0x40\n"
    "\tbeq\t$3,$2,.L800F4430\n"   /* 0x40 -> 4 */
    "\t ori\t$3,$0,0x42\n"
    "\tbeq\t$3,$2,.L800F4440\n"   /* 0x42 -> 0x10 */
    "\t ori\t$3,$0,0x23\n"
    "\tbeq\t$3,$2,.L800F4440\n"   /* 0x23 -> 0x10 */
    "\t ori\t$3,$0,0x44\n"
    "\tbeq\t$3,$2,.L800F4428\n"   /* 0x44 -> 1 */
    "\t ori\t$3,$0,0x43\n"
    "\tbeq\t$3,$2,.L800F4448\n"   /* 0x43 -> 0x18 */
    "\t ori\t$3,$0,0x72\n"
    "\tbeq\t$3,$2,.L800F4438\n"   /* 0x72 -> 8 */
    "\t nop\n"
    ".L800F4428:\n"                 /* default / 0x44 */
    "\tjr\t$31\n"
    "\t ori\t$2,$0,0x1\n"       /* return 1 */
    ".L800F4430:\n"
    "\tjr\t$31\n"
    "\t ori\t$2,$0,0x4\n"       /* return 4 */
    ".L800F4438:\n"
    "\tjr\t$31\n"
    "\t ori\t$2,$0,0x8\n"       /* return 8 */
    ".L800F4440:\n"
    "\tjr\t$31\n"
    "\t ori\t$2,$0,0x10\n"      /* return 0x10 */
    ".L800F4448:\n"
    "\tjr\t$31\n"
    "\t ori\t$2,$0,0x18\n"      /* return 0x18 */
    "\t.set at\n"
    "\t.set reorder\n"
);
#else
extern int shapedepth(unsigned char *shape)   /* @0x800F43E4 */
{
    unsigned char t = *shape & 0x77;
    if (t == 0x41) return 8;
    if (t == 0x40) return 4;
    if (t == 0x42 || t == 0x23) return 0x10;
    if (t == 0x44) return 1;
    if (t == 0x43) return 0x18;
    if (t == 0x72) return 8;
    return 1;
}
#endif
