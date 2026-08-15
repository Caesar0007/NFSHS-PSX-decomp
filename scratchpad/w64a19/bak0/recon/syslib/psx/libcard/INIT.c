/* syslib/psx/libcard/INIT.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(INIT.OBJ): InitCARD -- bring the memory-card subsystem up: clear the pad,
 *   InitCARD2, then install the three kernel patches (PATCH.OBJ), inside a critical section. */

extern void ChangeClearPAD(long val);   /* libapi B0:0x5B @0x80106654 */
extern int  EnterCriticalSection(void); /* @0x8010698C */
extern void ExitCriticalSection(void);  /* @0x8010696C */
extern int  ReadInitPadFlag(void);      /* libapi PAD @0x8010C9B0 */
extern void InitCARD2(int val);         /* A74 @0x8010C9C0 */
extern int  _copy_memcard_patch(void);  /* PATCH @0x8010CB6C */
extern int  _patch_card(void);          /* PATCH @0x8010CA68 */
extern int  _patch_card2(void);         /* PATCH @0x8010CAFC */

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
