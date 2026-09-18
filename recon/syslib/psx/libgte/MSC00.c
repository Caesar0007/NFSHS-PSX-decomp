/* syslib/psx/libgte/MSC00.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgte.lib(MSC00.OBJ): InitGeom -- bring up the GTE.  The oracle marks this a
 *   "Handwritten function": it spills $ra to a FIXED GLOBAL (D_80134A70, not the stack),
 *   calls _patch_gte, enables COP2 in the CPU status register (CU2 bit) via mfc0/mtc0 $12,
 *   then loads the default geometry control registers (ZSF3/ZSF4/H/DQA/DQB/OFX/OFY) with
 *   ctc2.  Because it is genuine handwritten assembly (the $ra-to-global spill and the raw
 *   coprocessor moves are the tells), the faithful form is a FILE-SCOPE __asm__ emitting the
 *   exact sequence -- the same idiom as the BIOS thunks, NOT a register pin.  Host = no-op. */

extern void _patch_gte(void);   /* libgte PATCHGTE.obj @0x80106454 */

#if defined(__mips__)
/* @0x80134A70 : scratch word holding $ra across the _patch_gte call (handwritten spill). */
/* SYM-GLOBAL-CARRIER: _InitGeom_ra_save -- relocation-proven private scratch
 * storage in the handwritten object; retail SYM carries no declaration row. */
int _InitGeom_ra_save = 0;   /* retail: .data word @0x80134a70 (Sony .s: .data/.word 0), absolute at -G0 */

/* @0x800F21A4 : InitGeom -- handwritten.
 * The block MUST open `.text` itself: cc1 emits a file-scope __asm__ with whatever section
 * is active at that point, and the `_InitGeom_ra_save` definition just above leaves `.data`
 * active.  Without this line InitGeom was assembled INTO .data (nm: `D InitGeom`), the gate
 * found 0 functions to check (0/0 PASS, vacuous), the recon link placed the code with the
 * data at 0x80134A74 under the retail r17 data blob, and both callers got `jal 0x80134A74`
 * -- a jump into data -- while 0x800F21A4 stayed empty. */
__asm__(
    "\t.text\n"   /* the ra-save word above left the assembler in .data: InitGeom linked at 0x80134a74 */
    "\t.set noreorder\n"
    "\t.globl InitGeom\n"
    "InitGeom:\n"
    "\tlui  $1, %hi(_InitGeom_ra_save)\n"
    "\tsw   $31, %lo(_InitGeom_ra_save)($1)\n"
    "\tjal  _patch_gte\n"
    "\tlui  $31, %hi(_InitGeom_ra_save)\n"
    "\tlw   $31, %lo(_InitGeom_ra_save)($31)\n"
    "\tnop\n"
    "\tmfc0 $2, $12\n"                 /* read CPU status */
    "\tlui  $3, 0x4000\n"              /* CU2 bit (0x40000000) */
    "\tor   $2, $2, $3\n"
    "\tmtc0 $2, $12\n"                 /* enable COP2 */
    "\tnop\n"
    "\taddiu $8, $0, 0x155\n"
    "\tctc2  $8, $29\n"                /* ZSF3 = 0x155 */
    "\tnop\n"
    "\taddiu $8, $0, 0x100\n"
    "\tctc2  $8, $30\n"                /* ZSF4 = 0x100 */
    "\tnop\n"
    "\taddiu $8, $0, 0x3E8\n"
    "\tctc2  $8, $26\n"                /* H = 1000 */
    "\tnop\n"
    "\taddiu $8, $0, -0x1062\n"
    "\tctc2  $8, $27\n"                /* DQA = -0x1062 */
    "\tnop\n"
    "\tlui  $8, 0x140\n"               /* DQB = 0x1400000 */
    "\tctc2  $8, $28\n"
    "\tnop\n"
    "\tctc2  $0, $24\n"              /* OFX = 0 */
    "\tctc2  $0, $25\n"              /* OFY = 0 */
    "\tnop\n"
    "\tjr   $31\n"
    "\t nop\n"
    "\t.set reorder\n\t.set at\n");
#else
extern void InitGeom(void) { _patch_gte(); }   /* GTE absent on host */
#endif
