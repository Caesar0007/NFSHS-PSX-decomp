/* syslib/psx/libgte/MSC00.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgte.lib(MSC00.OBJ): InitGeom -- bring up the GTE.  Applies the GTE-bug patch,
 *   enables COP2 in the CPU status register (CU2 bit), and loads the default geometry
 *   control registers (depth-cue, screen distance, screen offset). */

extern "C" void _patch_gte(void);   /* libgte PATCHGTE.obj @0x80106454 */

/* @0x800F21A4 : InitGeom */
extern "C" void InitGeom(void)
{
    _patch_gte();
#if defined(__mips__)
    unsigned sr;
    __asm__ volatile("mfc0 %0,$12" : "=r"(sr));      /* read CPU status */
    sr |= 0x40000000;                                 /* set CU2 (enable COP2) */
    __asm__ volatile("mtc0 %0,$12" : : "r"(sr));
    __asm__ volatile("ctc2 %0,$29" : : "r"(0x155));    /* ZSF3 */
    __asm__ volatile("ctc2 %0,$30" : : "r"(0x100));    /* ZSF4 */
    __asm__ volatile("ctc2 %0,$26" : : "r"(0x3E8));    /* H = 1000 */
    __asm__ volatile("ctc2 %0,$27" : : "r"(-0x1062));  /* DQA */
    __asm__ volatile("ctc2 %0,$28" : : "r"(0x1400000));/* DQB */
    __asm__ volatile("ctc2 %0,$24" : : "r"(0));        /* OFX */
    __asm__ volatile("ctc2 %0,$25" : : "r"(0));        /* OFY */
#endif
}
