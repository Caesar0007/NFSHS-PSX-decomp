/* eaclib/psx/eacpsxz/shpdepth.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\shpdepth.obj  (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\SHPDEPTH.ASM (per SYM SLD @0x800F43E4 line 4).
 *   ONE XDEF: shapedepth @0x800F43E4 (27 insns, 0x6C). Bit depth from a shape's type byte (&0x77) via
 *   a hand-written `ori $v1,K; beq $v1,$v0` compare chain with the result `ori`s in the jr delay slots
 *   -- not the shape a C `switch` compiles to (the C recon FAILed 40). Transcribed VERBATIM; C fallback.
 *   maspsx: lbu offset DECIMAL; `.set noreorder`.
 */

#if defined(__mips__)
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */
    "\t.globl shapedepth\n"        /* @0x800F43E4 : int shapedepth(unsigned char *shape) */
    "shapedepth:\n"
    "\tlbu\t$v0,0($a0)\n"           /* t = shape[0] */
    "\tori\t$v1,$zero,0x41\n"
    "\tandi\t$v0,$v0,0x77\n"        /* t &= 0x77 */
    "\tbeq\t$v1,$v0,.L800F4438\n"   /* 0x41 -> 8 */
    "\t ori\t$v1,$zero,0x40\n"
    "\tbeq\t$v1,$v0,.L800F4430\n"   /* 0x40 -> 4 */
    "\t ori\t$v1,$zero,0x42\n"
    "\tbeq\t$v1,$v0,.L800F4440\n"   /* 0x42 -> 0x10 */
    "\t ori\t$v1,$zero,0x23\n"
    "\tbeq\t$v1,$v0,.L800F4440\n"   /* 0x23 -> 0x10 */
    "\t ori\t$v1,$zero,0x44\n"
    "\tbeq\t$v1,$v0,.L800F4428\n"   /* 0x44 -> 1 */
    "\t ori\t$v1,$zero,0x43\n"
    "\tbeq\t$v1,$v0,.L800F4448\n"   /* 0x43 -> 0x18 */
    "\t ori\t$v1,$zero,0x72\n"
    "\tbeq\t$v1,$v0,.L800F4438\n"   /* 0x72 -> 8 */
    "\t nop\n"
    ".L800F4428:\n"                 /* default / 0x44 */
    "\tjr\t$ra\n"
    "\t ori\t$v0,$zero,0x1\n"       /* return 1 */
    ".L800F4430:\n"
    "\tjr\t$ra\n"
    "\t ori\t$v0,$zero,0x4\n"       /* return 4 */
    ".L800F4438:\n"
    "\tjr\t$ra\n"
    "\t ori\t$v0,$zero,0x8\n"       /* return 8 */
    ".L800F4440:\n"
    "\tjr\t$ra\n"
    "\t ori\t$v0,$zero,0x10\n"      /* return 0x10 */
    ".L800F4448:\n"
    "\tjr\t$ra\n"
    "\t ori\t$v0,$zero,0x18\n"      /* return 0x18 */
    "\t.set pop\n"
);
#else
extern "C" int shapedepth(unsigned char *shape)   /* @0x800F43E4 */
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
