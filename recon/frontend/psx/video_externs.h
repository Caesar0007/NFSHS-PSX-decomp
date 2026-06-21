/* frontend/psx/video_externs.h - reconstructed extern decls (globals + lib prototypes)
 * referenced by VIDEO.CPP. NOT an original source header; added so the reconstructed
 * translation unit compiles standalone as C++. Signatures inferred from call sites. */
#ifndef _FRONTEND_PSX_VIDEO_EXTERNS_H_
#define _FRONTEND_PSX_VIDEO_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* --- globals --- */
extern char *Paths_Paths[];
extern int   CF_DVLC;
extern int   screenbpp;
extern int   timerhz;
extern int   ticks;

/* --- eaclib / platform / mdec / stream prototypes --- */
extern "C" {
void  Platform_ResetDCTBuffer(void);
int   initmdec(int, int, int, int);   /* SYM: FCN INT (returns mdec handle) - was wrongly void* */
void  restoremdec(int);
void  mdec(int, char *, int, int);
int   mdecdone(int);
void  mdecreset(void);
void *STREAM_create(int, int, int, void *, int);
void  STREAM_setfilter(long, int, int, int, int);
long  STREAM_queuefile(long, char *, int, int);
int   STREAM_bufferusage(long);
int   STREAM_state(long);
int   STREAM_isendofstream(long);
STREAMCHUNKHDR *STREAM_get(long);
void  STREAM_release(long, STREAMCHUNKHDR *);
void  STREAM_kill(long);
void  STREAM_destroy(long);
}
#endif
