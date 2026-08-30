/* syslib/psx/libcard/INIT.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(INIT.OBJ): InitCARD / StartCARD / StopCARD.  Canonical PsyQ 4.3
 *   INDEX.tsv proves all three public functions share this translation unit in this exact order. */

extern void ChangeClearPAD(long val);   /* libapi B0:0x5B @0x80106654 */
extern int  EnterCriticalSection(void); /* @0x8010698C */
extern void ExitCriticalSection(void);  /* @0x8010696C */
extern int  ReadInitPadFlag(void);      /* libapi PAD @0x8010C9B0 */
extern void InitCARD2(int val);         /* A74 @0x8010C9C0 */
extern int  _copy_memcard_patch(void);  /* PATCH @0x8010CB6C */
extern int  _patch_card(void);          /* PATCH @0x8010CA68 */
extern int  _patch_card2(void);         /* PATCH @0x8010CAFC */
extern void StartCARD2(void);            /* A75, BIOS B0:0x4B @0x8010CBA0 */
extern void StopCARD2(void);             /* A76, BIOS B0:0x4C @0x8010CBB0 */
extern int  _ExitCard(void);             /* END @0x8010CBC0 */

/* @0x8010C784 : InitCARD(val) -- val forced to 0 if the pad was not pre-initialised. */
extern void InitCARD(long val)
{
    ChangeClearPAD(0);
    EnterCriticalSection();
    if (ReadInitPadFlag() == 0)
        val = 0;
    InitCARD2((int)val);
    _copy_memcard_patch();
    _patch_card();
    _patch_card2();
    ExitCriticalSection();
}

/* @0x8010C7F0 : enter the critical section, start the BIOS card driver,
 * re-enable PAD auto-clear, then leave the critical section.  PsyQ's public
 * prototype is long; the function intentionally returns the final call's v0. */
extern long StartCARD(void)
{
    EnterCriticalSection();
    StartCARD2();
    ChangeClearPAD(0);
    ExitCriticalSection();
}

/* @0x8010C828 : stop the BIOS card driver and remove the card IRQ patch.
 * The public long result is likewise the final call's leftover v0. */
extern long StopCARD(void)
{
    StopCARD2();
    _ExitCard();
}
