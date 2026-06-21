/* CARDINIT.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   libcard high-level start/stop wrappers (PsyQ StartCard/StopCard).  Surfaced by the
 *   link harness (declared `extern long StartCARD/StopCARD(void)` in syslib.h, referenced
 *   by the memory-card init path, never defined).  Both call the BIOS B0 thunks already
 *   reconstructed in A75/A76/END.OBJ + the libapi critical-section/pad helpers.  No caller
 *   uses the return value (v0 is a call leftover); typed `long` to match the prototype. */

extern "C" int  EnterCriticalSection(void);   /* @0x8010698C */
extern "C" void ExitCriticalSection(void);    /* @0x8010696C */
extern "C" void ChangeClearPAD(long val);     /* libapi B0:0x5B @0x80106654 */
extern "C" void StartCARD2(void);             /* A75.OBJ  BIOS B0:0x4B @0x8010CBA0 */
extern "C" void StopCARD2(void);              /* A76.OBJ  BIOS B0:0x4C @0x8010CBB0 */
extern "C" int  _ExitCard(void);              /* END.OBJ  @0x8010CBC0 */

/* @0x8010C7F0 : StartCard -- enter crit section, start the BIOS card driver,
 *               re-enable PAD auto-clear, leave crit section. */
extern "C" long StartCARD(void)
{
    EnterCriticalSection();
    StartCARD2();
    ChangeClearPAD(0);
    ExitCriticalSection();
    return 1;                 /* v0 = call leftover; PsyQ "started" convention (unused) */
}

/* @0x8010C828 : StopCard -- stop the BIOS card driver and un-patch the card IRQ handler. */
extern "C" long StopCARD(void)
{
    StopCARD2();
    _ExitCard();
    return 1;                 /* v0 = _ExitCard leftover (unused) */
}
