/* syslib/psx/libcd/cdread2.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libcd.lib(CDREAD2.OBJ): CdRead2 -- start a streaming (CdlReadS) read.
 *
 *   Sets the drive mode (CdlSetmode), and for a streaming read (mode bit 0x100) installs the
 *   sectoring callbacks -- data_ready_callback (libcd C_004) as the DMA-data handler and a tiny
 *   ready wrapper that drives StCdInterrupt() -- then fires CdlReadS (command 0x1B).  Returns the
 *   CdControl(CdlReadS) result. */

typedef unsigned char u_char;

/* ---- libcd public API (cdcont.cpp) ------------------------------------------------------------ */
extern "C" int CdControl(u_char com, u_char *param, u_char *result); /* @0x800F78B4 */
extern "C" int CdDataCallback(int func);                             /* @0x800F7CB0 */
extern "C" int CdReadyCallback(int func);                            /* @0x800F78A0 */

/* ---- streaming subsystem (libcd C_011 / C_004) ------------------------------------------------ */
extern "C" void StCdInterrupt(void);        /* @0x800F7E78 (C_011) */
extern "C" int  data_ready_callback(void);  /* @0x80108798 (C_004) */
extern "C" int  StMode;                     /* @0x801489CC : streaming RGB24/mode flag */

/* @0x800F8FCC : ready callback for a streaming read -- pump the stream interrupt handler. */
extern "C" int _cdread2_ready(int /*intr*/, int /*result*/)
{
    StCdInterrupt();
    return 0;
}

/* @0x800F8F48 : CdRead2 -- begin a CdlReadS read in the given mode. */
extern "C" int CdRead2(long mode)
{
    u_char modeb = (u_char)mode;
    CdControl(0xE, &modeb, 0);                  /* CdlSetmode */

    if (mode & 0x100) {                          /* streaming read */
        /* StMode = 0 for size-1 (CdlModeSize1, 0x20) sectors, 1 otherwise -- selects the
         * data_ready_callback's per-sector RGB24/mono word stride.  (Oracle stores v0=1 in
         * the else branch; matches SOTN libcd cdread2.c D_8003C768 = 0/1.) */
        if (mode & 0x20) StMode = 0;
        else             StMode = 1;
        CdDataCallback((int)data_ready_callback);
        CdReadyCallback((int)_cdread2_ready);
    }

    return CdControl(0x1B, 0, 0);                /* CdlReadS */
}
