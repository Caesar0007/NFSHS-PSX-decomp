/* syslib/psx/libcd/toc.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libcd.lib(TOC.OBJ): CdGetToc / CdGetToc2 -- read the disc Table-Of-Contents.
 *
 *   CdGetToc2 issues CdlGetTN (command 0x13) to learn the first/last track numbers, then CdlGetTD
 *   (command 0x14) once per track to fetch each track's MSF start, filling `toc[]` (one CdlLOC per
 *   track, lead-in entry first).  Track numbers are exchanged in BCD.  CD_debug>=2 prints a trace.
 *
 *   Two binary quirks reproduced verbatim:
 *     - the sync callback is *not* saved across the call: CdControlB(0x13)'s return ($s6) is the value
 *       fed back to CdSyncCallback() at every exit (the original never captured the previous handler).
 *     - the return value is a register leftover ($s1): &toc[cnt] when CD_debug<2, cnt-1 when CD_debug
 *       >=2 -- both non-zero on success, 0 on failure, which is all callers test.  Reconstructed to
 *       return the track count `cnt` (>=1 success / 0 fail), preserving the observable !=0 contract. */

typedef unsigned char u_char;
struct CdlLOC { u_char minute, second, sector, track; };

/* ---- libcd public API (cdcont.cpp) / libc ----------------------------------------------------- */
extern "C" int  CdControlB(u_char com, u_char *param, u_char *result); /* @0x800F7B24 */
extern "C" int  CdSyncCallback(int func);                              /* @0x800F788C */
extern "C" int  printf(const char *fmt, ...);                         /* libc C63 @0x801028AC */

/* ---- driver debug level (DRV.OBJ) ------------------------------------------------------------- */
extern "C" int CD_debug;   /* @0x8013BF50 */

/* @0x801092C0 : CdGetToc2 -- fill toc[] with the MSF start of every track (lead-in entry first). */
extern "C" int CdGetToc2(int /*n*/, u_char *toc)
{
    u_char  res[8];      /* CdControlB result (sp+0x18) */
    u_char  param;       /* CdlGetTD track parameter, BCD (sp+0x10) */
    int     save;        /* $s6 : CdlGetTN result, also fed back to CdSyncCallback() */
    int     first, last; /* track range (decimal) */
    int     cnt;         /* TOC entries written */
    u_char *p;

    CdSyncCallback(0);
    param = 1;                                          /* (vestigial: GetTN takes no parameter) */
    save = CdControlB(0x13, 0, res);                    /* CdlGetTN */
    if (save == 0)
        goto err;

    first = (res[1] >> 4) * 10 + (res[1] & 0xF);        /* BCD -> decimal */
    last  = (res[2] >> 4) * 10 + (res[2] & 0xF);
    if (CD_debug >= 2)
        printf("track=%d,%d\n", first, last);

    param = 0;
    if (CdControlB(0x14, &param, res) == 0)             /* CdlGetTD, track 0 = lead-in */
        goto err;
    toc[0] = res[1];                                    /* minute */
    toc[1] = res[2];                                    /* second */
    toc[2] = 0;                                         /* sector */

    cnt = 1;
    p = toc + 4;
    for (; first <= last; first++) {
        param = (u_char)(((first / 10) << 4) + (first % 10));   /* track # -> BCD */
        if (CdControlB(0x14, &param, res) == 0)
            goto err;
        cnt++;
        p[0] = res[1];                                  /* minute */
        p[1] = res[2];                                  /* second */
        p[2] = 0;                                       /* sector */
        p += 4;
    }

    if (CD_debug >= 2) {                         /* @0x80109444 if(CD_debug<2) skip to retail exit */
        int     k;
        u_char *q = toc;
        for (k = 0; k < cnt; k++) {              /* print loop, bound $s1=cnt-1 (@0x80109448) */
            printf("CdGetToc2: %02x:%02x:00\n", q[0], q[1]);
            q += 4;
        }
        CdSyncCallback(save);
        return cnt - 1;                          /* $v0 = $s1 = cnt-1 (@0x8010948c) */
    }
    CdSyncCallback(save);
    return (int)p;                               /* retail: $v0 = $s1 = toc write ptr toc+4+cnt*4 (@0x80109480) */

err:
    if (CD_debug != 0)
        printf("CdGetToc2: error\n");
    CdSyncCallback(save);
    return 0;
}

/* @0x8010929C : CdGetToc -- convenience wrapper, toc[] points at the caller's CdlLOC array. */
extern "C" int CdGetToc(CdlLOC *loc)
{
    return CdGetToc2(1, (u_char *)loc);
}
