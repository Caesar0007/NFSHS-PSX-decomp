/* movie.obj: CdlLOC/CdlFILE right after the CD stream type, before the kernel types (nfs4_types.h KERNEL_KERN_AFTER_CD block). */
#ifndef NFS4_FRONTEND_PSX_MOVIE_CD_EARLY_H
#define NFS4_FRONTEND_PSX_MOVIE_CD_EARLY_H
typedef struct {
    u_char minute, second, sector, track;
} CdlLOC;

typedef struct {
    CdlLOC pos;
    u_long size;
    char name[16];
} CdlFILE;
#endif
