# 0 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\toc.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\toc.c"
# 12 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\toc.c"
typedef unsigned char u_char;
struct CdlLOC { u_char minute, second, sector, track; };
typedef struct CdlLOC CdlLOC;


extern int CdControlB(u_char com, u_char *param, u_char *result);
extern int CdSyncCallback(int func);
extern int printf(const char *fmt, ...);


extern int CD_debug;


extern int CdGetToc2(int n, CdlLOC *loc);


extern int CdGetToc(CdlLOC *loc)
{
    return CdGetToc2(1, loc);
}
# 117 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\toc.c"
extern int CdGetToc2(int n, CdlLOC *loc)
{
    int track_first;
    int track_last;
    u_char param[4];
    u_char result[4];
    int save;

    int i;
    int nTrack;
    int magic;
# 150 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\toc.c"
    param[0] = 1;
    save = CdSyncCallback(0);
    if (CdControlB(0x13, 0, result) == 0)
        goto err;
    track_first = (result[1] >> 4) * 10 + (result[1] & 0xF);
    track_last = (result[2] >> 4) * 10 + (result[2] & 0xF);
    if (CD_debug >= 2)
        printf("track=%d,%d\n", track_first, track_last);

    param[0] = 0;
    if (CdControlB(0x14, param, result) == 0)
        goto err;
    loc->minute = result[1];
    loc->second = result[2];
    loc->sector = 0;

    i = 1;
    if (track_first <= track_last) {
        magic = 0x66666667;
        do {
            __asm__("" : : "r"(magic), "r"(track_first));
            param[0] = (u_char)(((track_first / 10) << 4) + track_first % 10);
            if (CdControlB(0x14, param, result) == 0)
                goto err;
            loc[i].minute = result[1];
            loc[i].second = result[2];
            loc[i].sector = 0;
            i++;
            track_first++;
        } while (track_first <= track_last);
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
