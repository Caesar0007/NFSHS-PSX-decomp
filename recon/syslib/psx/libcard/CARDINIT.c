/* CARDINIT.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   libcard high-level start/stop wrappers (PsyQ StartCard/StopCard).  Surfaced by the
 *   link harness (declared `extern long StartCARD/StopCARD(void)` in syslib.h, referenced
 *   by the memory-card init path, never defined).  Both call the BIOS B0 thunks already
 *   reconstructed in A75/A76/END.OBJ + the libapi critical-section/pad helpers.  No caller
 *   uses the return value (v0 is a call leftover); typed `long` to match the prototype. */

extern int  EnterCriticalSection(void);   /* @0x8010698C */
extern void ExitCriticalSection(void);    /* @0x8010696C */
extern void ChangeClearPAD(long val);     /* libapi B0:0x5B @0x80106654 */
extern void StartCARD2(void);             /* A75.OBJ  BIOS B0:0x4B @0x8010CBA0 */
extern void StopCARD2(void);              /* A76.OBJ  BIOS B0:0x4C @0x8010CBB0 */
extern int  _ExitCard(void);              /* END.OBJ  @0x8010CBC0 */

/* @0x8010C7F0 : StartCard -- enter crit section, start the BIOS card driver,
 *               re-enable PAD auto-clear, leave crit section.  The oracle sets NO
 *               return value (v0 is the ExitCriticalSection leftover); declared `long`
 *               to match the prototype but the body falls off the end -> no `li v0`. */
extern long StartCARD(void)
{
    EnterCriticalSection();
    StartCARD2();
    ChangeClearPAD(0);
    ExitCriticalSection();
}

/* @0x8010C828 : StopCard -- stop the BIOS card driver and un-patch the card IRQ handler.
 *               No return value set (v0 = _ExitCard leftover). */
extern long StopCARD(void)
{
    StopCARD2();
    _ExitCard();
}
