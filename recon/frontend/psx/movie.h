/* frontend/psx/movie.h - reconstructed declarations for MOVIE.CPP (C++ TU) */
#ifndef _FRONTEND_PSX_MOVIE_H_
#define _FRONTEND_PSX_MOVIE_H_
#include "../../nfs4_types.h"
#include "movie_externs.h"

/* MOVIE.CPP is C++ (cfront-mangled in SYM) -> normal C++ linkage. */
void Movie_Init(char movie);
void Movie_DeInit(void);
void Movie_SetDecodeOffset(short x0,short y0,short x1,short y1);
void Movie_Load(char movie);
int Movie_NextFrame(void);
void Movie_DownloadFrame(void);
void Movie_Stop(void);
void * Movie_Finished(void);
int Movie_Play(char movie);
int play_movie(char movie);
void strSetDefDecEnv(DECENV *dec);
void strInit(CdlLOC *loc,int frame_size,fn_void *callback,fn_void *endcallback);
void strCallback(void);
int strNextVlc(DECENV *dec);
u_long * strNext(DECENV *dec);
void strSync(DECENV *dec,int arg1);
void strKickCD(CdlLOC *loc);

/* ---- Movie.obj EXT data globals ---- */
extern CdlFILE  fp;            /* 0x80052a34 */
extern char    *movienames[5]; /* 0x800529d8 */
extern short    movieframes[5];/* 0x800529ec */
extern int      movie24bit[5]; /* 0x800529f8 */
extern short    movieheight[5];/* 0x80052a0c */
extern short    moviewidth[5]; /* 0x80052a18 */
extern short    user_exit;     /* 0x80052a2c */
extern char     skip_all;      /* 0x80052a2e */
extern char     gPlayerNum;    /* 0x80052a2f */
extern short    download[];    /* 0x80052a30 (unsized array: force base-reg materialization, not $at macro) */

#endif