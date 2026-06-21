/* syslib/psx/libgte/REG03.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgte.lib(REG03.OBJ): GTE (COP2) depth-cueing coefficient setters.  Each loads one
 *   value into a GTE control register via ctc2.  Faithful = the cop2 instruction on MIPS, a
 *   no-op stub on the host (the GTE is PSX-only hardware). */

/* @0x80106674 : DQA = GTE control register 27 (depth-cue scale). */
extern "C" void SetDQA(short dqa)
{
#if defined(__mips__)
    __asm__ volatile("ctc2 %0,$27" : : "r"((int)dqa));
#else
    (void)dqa;
#endif
}

/* @0x80106680 : DQB = GTE control register 28 (depth-cue offset). */
extern "C" void SetDQB(long dqb)
{
#if defined(__mips__)
    __asm__ volatile("ctc2 %0,$28" : : "r"((int)dqb));
#else
    (void)dqb;
#endif
}
