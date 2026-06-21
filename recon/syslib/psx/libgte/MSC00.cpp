/* syslib/psx/libgte/MSC00.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgte.lib(MSC00.OBJ): InitGeom -- bring up the GTE.  The oracle marks this a
 *   "Handwritten function": it spills $ra to a FIXED GLOBAL (D_80134A70, not the stack),
 *   calls _patch_gte, enables COP2 in the CPU status register (CU2 bit) via mfc0/mtc0 $12,
 *   then loads the default geometry control registers (ZSF3/ZSF4/H/DQA/DQB/OFX/OFY) with
 *   ctc2.  Because it is genuine handwritten assembly (the $ra-to-global spill and the raw
 *   coprocessor moves are the tells), the faithful form is a FILE-SCOPE __asm__ emitting the
 *   exact sequence -- the same idiom as the BIOS thunks, NOT a register pin.  Host = no-op. */

extern "C" void _patch_gte(void);   /* libgte PATCHGTE.obj @0x80106454 */

#if defined(__mips__)
/* @0x80134A70 : scratch word holding $ra across the _patch_gte call (handwritten spill). */
int _InitGeom_ra_save;

/* @0x800F21A4 : InitGeom -- handwritten. */
__asm__(
    "\t.set push\n\t.set noreorder\n"
    "\t.globl InitGeom\n"
    "InitGeom:\n"
    "\tlui  $at, %hi(_InitGeom_ra_save)\n"
    "\tsw   $ra, %lo(_InitGeom_ra_save)($at)\n"
    "\tjal  _patch_gte\n"
    "\tlui  $ra, %hi(_InitGeom_ra_save)\n"
    "\tlw   $ra, %lo(_InitGeom_ra_save)($ra)\n"
    "\tnop\n"
    "\tmfc0 $v0, $12\n"                 /* read CPU status */
    "\tlui  $v1, 0x4000\n"              /* CU2 bit (0x40000000) */
    "\tor   $v0, $v0, $v1\n"
    "\tmtc0 $v0, $12\n"                 /* enable COP2 */
    "\tnop\n"
    "\taddiu $t0, $zero, 0x155\n"
    "\tctc2  $t0, $29\n"                /* ZSF3 = 0x155 */
    "\tnop\n"
    "\taddiu $t0, $zero, 0x100\n"
    "\tctc2  $t0, $30\n"                /* ZSF4 = 0x100 */
    "\tnop\n"
    "\taddiu $t0, $zero, 0x3E8\n"
    "\tctc2  $t0, $26\n"                /* H = 1000 */
    "\tnop\n"
    "\taddiu $t0, $zero, -0x1062\n"
    "\tctc2  $t0, $27\n"                /* DQA = -0x1062 */
    "\tnop\n"
    "\tlui  $t0, 0x140\n"               /* DQB = 0x1400000 */
    "\tctc2  $t0, $28\n"
    "\tnop\n"
    "\tctc2  $zero, $24\n"              /* OFX = 0 */
    "\tctc2  $zero, $25\n"              /* OFY = 0 */
    "\tnop\n"
    "\tjr   $ra\n"
    "\t nop\n"
    "\t.set pop\n");
#else
extern "C" void InitGeom(void) { _patch_gte(); }   /* GTE absent on host */
#endif
