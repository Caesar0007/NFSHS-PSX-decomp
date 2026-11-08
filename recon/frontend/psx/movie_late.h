/* movie.obj: DECENV/CDSECTOR are the last type records in retail (after the color graph); included by movie.h after color_types.h. */
#ifndef NFS4_FRONTEND_PSX_MOVIE_LATE_H
#define NFS4_FRONTEND_PSX_MOVIE_LATE_H
typedef struct {
    u_long *vlcbuf[2];
    int vlcid;
    u_short *imgbuf;
    RECT rect[2];
    int rectid;
    RECT slice;
    int isdone;
} DECENV;

typedef struct {
    u_short id, type, secCount, nSectors;
    u_long frameCount, frameSize;
    u_short width, height;
    u_long headm, headv;
} CDSECTOR;
#endif
