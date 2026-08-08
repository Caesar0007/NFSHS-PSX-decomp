/* syslib/psx/libcd/toc.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libcd.lib(TOC.OBJ): CdGetToc / CdGetToc2 -- read the disc Table-Of-Contents.
 *
 *   CdGetToc2 issues CdlGetTN (command 0x13) to learn the first/last track numbers, then CdlGetTD
 *   (command 0x14) once per track to fetch each track's MSF start, filling `loc[]` (one CdlLOC per
 *   track, lead-in entry first).  Track numbers are exchanged in BCD.  CD_debug>=2 prints a trace.
 *
 *   Binary quirk reproduced verbatim: the value fed back to CdSyncCallback() at every exit is the
 *   CdlGetTN result ($s6), NOT the callback CdSyncCallback(0) returned (which is discarded) -- the
 *   original captured the wrong register.  The function returns the track count - 1 (nTrack). */

typedef unsigned char u_char;
struct CdlLOC { u_char minute, second, sector, track; };
typedef struct CdlLOC CdlLOC;

/* ---- libcd public API (cdcont.cpp) / libc ----------------------------------------------------- */
extern int  CdControlB(u_char com, u_char *param, u_char *result); /* @0x800F7B24 */
extern int  CdSyncCallback(int func);                              /* @0x800F788C */
extern int  printf(const char *fmt, ...);                         /* libc C63 @0x801028AC */

/* ---- driver debug level (DRV.OBJ) ------------------------------------------------------------- */
extern int CD_debug;   /* @0x8013BF50 */

/* @0x801092C0 : CdGetToc2 -- fill loc[] with the MSF start of every track (lead-in entry first).
 *
 * MATCH: shape transplanted from the byte-exact Rage Racer decomp
 * (C:\Temp\rage-racer-decomp\src\main\PAL\lib\libcd\initialization_and_toc.c,
 * CdGetToc2) -- same PsyQ libcd TU, matched in plain C.  Load-bearing pieces:
 *   - `save = CdSyncCallback(0);`  The oracle captures $v0 in the FOLLOWING
 *     `jal CdControlB`'s DELAY SLOT (`jal ...; addu $s6,$v0,$zero`), i.e. the
 *     value live BEFORE that call = CdSyncCallback's return (methodology 3.1).
 *     The previous recon read it as "the CdlGetTN result -- the original
 *     captured the wrong register"; that note was the delay-slot trap and is
 *     retracted.  This is a real DATAFLOW fix, not just a matching lever.
 *   - the TOC entries are written through a `u_char *` walking pointer with a
 *     `u_long` load temp, in the oracle's byte order  [0] , [2]=0 , [1] .
 *   - the track loop is a GUARDED do-while (`if (first <= last) { ptr = toc+4;
 *     do {...} while (first <= last); }`), and the debug loop likewise
 *     (`if (nTrack >= 0) do {...} while (i <= nTrack);` -- the oracle's
 *     `bltz` guard).
 *   - every error exit is DUPLICATED inline (no shared `err:` label).
 * FALSIFIED in this basin (measured, do not retry): (a) the FULL Rage Racer
 * body -- u_char* walking-pointer stores with a `u_long` load temp, guarded
 * do-while loops, duplicated inline error exits, `ptr` reused to carry
 * `count-1` -- reaches the oracle's EXACT 137 instructions but rotates the
 * whole s-register handout (71 -> 112 diffs; RR needs `register u_char *ptr
 * asm("$17")` to land it, and asm register pins are forbidden here,
 * methodology 3.13); (b) spelling `track_first / 10` as its literal
 * multiply-high with a named `0x66666667` local to get the oracle's
 * preheader-hoisted magic in $s5 (71 -> 80 at 139 insns).
 * RESIDUAL (71): ours uses 6 callee-saved regs where the oracle uses 7 -- the
 * oracle hoists the /10 magic reciprocal into $s5 and puts `save` in $s6,
 * ours rematerializes the magic in the loop and puts `save` in $s5, so ours
 * is 3 instructions short (the $s6 save/restore pair + one hoist half). */
extern int CdGetToc2(int n, CdlLOC *loc)
{
    int track_first;
    int track_last;
    u_char param[4];
    u_char result[4];
    int save;                 /* $s6 : previous sync callback, restored at every exit */

    int i;
    int nTrack;

    param[0] = 1;
    save = CdSyncCallback(0);
    if (CdControlB(0x13, 0, result) == 0)               /* CdlGetTN */
        goto err;
    track_first = (result[1] >> 4) * 10 + (result[1] & 0xF);     /* BCD -> decimal */
    track_last  = (result[2] >> 4) * 10 + (result[2] & 0xF);
    if (CD_debug >= 2)
        printf("track=%d,%d
", track_first, track_last);

    param[0] = 0;
    if (CdControlB(0x14, param, result) == 0)           /* CdlGetTD, track 0 = lead-in */
        goto err;
    loc->minute = result[1];
    loc->second = result[2];
    loc->sector = 0;

    i = 1;
    while (track_first <= track_last) {
        param[0] = (u_char)(((track_first / 10) << 4) + track_first % 10);   /* track # -> BCD */
        if (CdControlB(0x14, param, result) == 0)
            goto err;
        loc[i].minute = result[1];
        loc[i].second = result[2];
        loc[i].sector = 0;
        i++;
        track_first++;
    }
    nTrack = i - 1;

    if (CD_debug >= 2) {
        for (i = 0; i <= nTrack; i++)
            printf("CdGetToc2: %02x:%02x:00
", loc[i].minute, loc[i].second);
    }
    CdSyncCallback(save);
    return nTrack;

err:
    if (CD_debug != 0)
        printf("CdGetToc2: error
");
    CdSyncCallback(save);
    return 0;
}

/* @0x8010929C : CdGetToc -- convenience wrapper, loc[] points at the caller's CdlLOC array. */
extern int CdGetToc(CdlLOC *loc)
{
    return CdGetToc2(1, loc);
}
