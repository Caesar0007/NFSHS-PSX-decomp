/* NFS4-specific compact media probes for the memory-oriented libcd variant.
 * The API is unchanged; behavior is narrowed only where the whole-program call graph proves it safe.
 */

typedef unsigned char u_char;
typedef struct CdlLOC { u_char minute, second, sector, track; } CdlLOC;
typedef void (*CdlCB)(u_char, u_char *);

extern int CdControl(int com, u_char *param, u_char *result);
extern int CdControlB(int com, u_char *param, u_char *result);
extern int CdReady(int mode, u_char *result);
extern CdlCB CdSyncCallback(CdlCB fn);
extern CdlLOC *CdIntToPos(int sector, CdlLOC *pos);
extern int CdGetSector(void *dst, int words);
extern int strncmp(const char *a, const char *b, int n);

/* Every NFS4 caller passes mode=1.  Keep the parameter for ABI compatibility. */
int CdDiskReady(int mode)
{
    u_char result[8];
    int ok;
    (void)mode;

    CdControlB(1, 0, result);
    if ((result[0] & 0x10) != 0)
        return 16;
    ok = CdControlB(0x13, 0, result);
    if (result[0] != 2 || ok == 0)
        return 5;
    return 2;
}

/* NFS4's sole caller uses CdGetToc only as a media-validity probe.  Query the track range and
 * lead-out, populate loc[0] for API hygiene, and avoid building the unused per-track table. */
int CdGetToc(CdlLOC *loc)
{
    u_char result[8];
    u_char param[4];
    CdlCB saved;

    saved = CdSyncCallback(0);
    if (CdControlB(0x13, 0, result) == 0)
        goto fail;
    param[0] = 0;
    if (CdControlB(0x14, param, result) == 0)
        goto fail;
    loc[0].minute = result[1];
    loc[0].second = result[2];
    loc[0].sector = 0;
    CdSyncCallback(saved);
    return 1;
fail:
    CdSyncCallback(saved);
    return 0;
}

/* Preserve the behavior needed by cdfs's disc-change task: distinguish shell/error, ISO data,
 * command failure and audio media.  Debug-only printf paths from PsyQ TYPE.OBJ are omitted. */
int CdGetDiskType(void)
{
    CdlLOC loc;
    u_char result[8];
    u_char sector[2048];
    int ready = 0;
    int tries;

    CdControl(1, 0, result);
    if ((result[0] & 0x10) != 0)
        return 16;

    CdIntToPos(16, &loc);
    for (tries = 0; tries != 10; ++tries) {
        CdControl(0x1b, (u_char *)&loc, 0);
        ready = CdReady(0, result);
        if (ready == 1)
            break;
    }

    if (ready != 1) {
        if ((result[0] & 0x10) != 0)
            return 16;
        if ((result[0] & 1) != 0 && (result[1] & 0x40) != 0)
            return 1;
        return (result[0] & 2) != 0;
    }

    CdControl(9, 0, 0);
    CdGetSector(sector, 512);
    return strncmp((char *)sector + 1, "CD001", 5) == 0 ? 2 : 1;
}
