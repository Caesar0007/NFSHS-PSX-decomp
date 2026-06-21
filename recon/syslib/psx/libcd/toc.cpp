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

/* ---- libcd public API (cdcont.cpp) / libc ----------------------------------------------------- */
extern "C" int  CdControlB(u_char com, u_char *param, u_char *result); /* @0x800F7B24 */
extern "C" int  CdSyncCallback(int func);                              /* @0x800F788C */
extern "C" int  printf(const char *fmt, ...);                         /* libc C63 @0x801028AC */

/* ---- driver debug level (DRV.OBJ) ------------------------------------------------------------- */
extern "C" int CD_debug;   /* @0x8013BF50 */

/* @0x801092C0 : CdGetToc2 -- fill loc[] with the MSF start of every track (lead-in entry first). */
extern "C" int CdGetToc2(int /*n*/, CdlLOC *loc)
{
    u_char param[4];
    u_char result[4];
    int save;                 /* $s6 : CdlGetTN result, also fed back to CdSyncCallback() */
    int track_first, track_last;
    int i;
    int nTrack;

    param[0] = 1;
    CdSyncCallback(0);                                  /* return discarded (param[0]=1 in delay slot) */
    save = CdControlB(0x13, 0, result);                 /* CdlGetTN */
    if (save == 0)
        goto err;
    track_first = (result[1] >> 4) * 10 + (result[1] & 0xF);     /* BCD -> decimal */
    track_last  = (result[2] >> 4) * 10 + (result[2] & 0xF);
    if (CD_debug >= 2)
        printf("track=%d,%d\n", track_first, track_last);

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
            printf("CdGetToc2: %02x:%02x:00\n", loc[i].minute, loc[i].second);
    }
    CdSyncCallback(save);
    return nTrack;

err:
    if (CD_debug != 0)
        printf("CdGetToc2: error\n");
    CdSyncCallback(save);
    return 0;
}

/* @0x8010929C : CdGetToc -- convenience wrapper, loc[] points at the caller's CdlLOC array. */
extern "C" int CdGetToc(CdlLOC *loc)
{
    return CdGetToc2(1, loc);
}
