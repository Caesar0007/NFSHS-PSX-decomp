/* lib/libfns.h -- AUTHORITATIVE extern "C" interface for eaclib/syslib functions.
 *   Platform/runtime boundary: same decls satisfied by PSX(PsyQ+eaclib), PC(PsyCross+eaclib), etc.
 *   Canonical signatures harvested from the best existing tree decl per fn (typed > varargs);
 *   the 5 reconstructed defs are pinned. C linkage => stable symbol, no mangling.
 *   NOTE: for syslib/PsyQ SDK fns the REAL header is libgpu.h/libgte.h/... (see disasm-v3 // proto).
 *
 *   PsyQ-SDK split (B-integration): under ccpsx (NFS4_PSYQ_HEADERS, set in nfs4_types.h),
 *   the PsyQ standard-library functions (libgpu/libgte/libetc/libapi/libpad) are supplied by the
 *   REAL PsyQ headers — declaring them here too would clash (return-type / macro / linkage), so they
 *   are gated OFF. Under the modern-gcc pre-gate they stay ON as the varargs boundary decls.
 *   EA eaclib/syslib (FILE_*, SND*, fixed-point, loaders) + libc + libgcc soft-float are ALWAYS on
 *   (no PsyQ header declares them, so no conflict in either toolchain).
 */
#ifndef _LIB_LIBFNS_H_
#define _LIB_LIBFNS_H_
#include "../nfs4_types.h"

extern "C" {

/* =====================================================================
 *  PsyQ SDK functions -- libgpu / libgte / libetc / libapi / libpad.
 *  Gated OFF under ccpsx (real PsyQ headers provide these).
 * ===================================================================== */
#ifndef NFS4_PSYQ_HEADERS
/* ---- libgpu (graphics) ---- */
int ClearImage(...);   /* (RECT *rect, u_char r, u_char g, u_char b) */
u_long * ClearOTagR(...);   /* (u_long *ot, int n) */
void DrawOTag(...);   /* (u_long *) */
long DrawSync(...);   /* (long mode) */
unsigned short GetClut(...);   /* (int,int) */
int GetTPage(...);   /* (int,int,int,int) */
int LoadImage(...);   /* (RECT * recp, u_long * p) */
int MoveImage(...);   /* (RECT *rect, int x, int y) */
DISPENV * PutDispEnv(...);   /* (DISPENV *) */
DRAWENV * PutDrawEnv(...);   /* (DRAWENV *) */
DISPENV * SetDefDispEnv(...);   /* (DISPENV *, int, int, int, int) */
DRAWENV * SetDefDrawEnv(...);   /* (DRAWENV *, int, int, int, int) */
void SetDispMask(...);   /* (int) */
void SetDrawArea(...);   /* (DR_AREA *p, RECT *r) */
void SetDrawEnv(...);   /* (void *, DRAWENV *) */
void SetDrawMode(...);   /* (void*,int,int,int,RECT*) */
void SetDrawStp(...);   /* (void *p,int stp) */
void SetPolyF3(...);   /* (POLY_F3 *p = 0) */
void SetPolyF4(...);   /* (void*) */
void SetPolyFT4(...);   /* (void*) */
void SetPolyG4(...);   /* (POLY_G4 *p) */
void SetPolyGT4(...);   /* (POLY_GT4 *p) */
void SetSemiTrans(...);   /* (void*,int) */
void SetShadeTex(...);   /* (void*,int) */
void SetTexWindow(...);   /* (void *prim, RECT *tw) */
int StoreImage(...);   /* (RECT *rect, u_long *p) */
/* ---- libgte (geometry) ---- */
void InitGeom(...);   /* (void) */
MATRIX * RotMatrix(...);   /* (SVECTOR *r,MATRIX *m) */
MATRIX * RotMatrixZ(...);   /* (long r,MATRIX *m) */
void SetFarColor(...);   /* (int r, int g, int b) */
void SetFogNear(...);   /* (int a, int otz) */
void SetGeomScreen(...);   /* (int h) */
int VectorNormal(...);   /* (VECTOR *v0, VECTOR *v1) */
long VectorNormalS(...);   /* (VECTOR *v0, SVECTOR *v1) */
/* ---- libetc (callback / vsync / rcnt / video) ---- */
int GetRCnt(...);   /* (int spec) */
void ResetCallback(...);   /* (void) */
void SetVideoMode(...);   /* (int) */
int VSync(...);   /* (int) */
void VSyncCallback(...);   /* (void *cb) */
/* ---- libapi (kernel) ---- */
void FlushCache(...);   /* (void) */
/* ---- libpad ---- */
int PadGetState(...);   /* (int port) */
int PadInfoMode(...);
void PadSetAct(...);   /* (int port, const void *table, int len) */
int PadSetActAlign(...);   /* (int port, const void *table) */
void PadSetMainMode(...);
void PadStartCom(...);   /* (void) */
#endif /* !NFS4_PSYQ_HEADERS */

/* =====================================================================
 *  EA eaclib / syslib  +  libc  +  libgcc soft-float -- ALWAYS declared.
 *  (No PsyQ header declares these; safe under both toolchains.)
 * ===================================================================== */
int CdDiskReady(...);   /* (int mode) -- EA wrapper, not PsyQ CdReady */
int FILE_addbigsync(...);   /* (char *name, void *a, int b, int *handle) */
int FILE_closesync(...);   /* (int h) */
int FILE_completeop(...);   /* (int oph) */
void FILE_delbigsync(...);   /* (char *name, void *a, int b, int *handle) */
void FILE_init(...);   /* (int a, int b, int c) */
int FILE_opensync(...);   /* (char *name, int mode, int prio, void *cb) */
int FILE_operror(...);   /* (int oph) */
int FILE_opstatus(...);   /* (int oph) */
int FILE_read(...);   /* (int arg0) */
int FILE_readsync(...);   /* (int h, void *dst, int n) */
void PAD_restore(...);
u_int PAD_state(...);   /* (int port) */
void PAD_update(...);
int SND3dpos(...);   /* (u_int tag, u_int x, int y) */
int SNDSTRM_autovol(...);   /* (int handle, int ticks, int flag) */
int SNDSTRM_create(...);   /* (int *priority,int numReq,int pktArg,int objbuf,int memsize) -> stream handle; def in eaclib sndpsxz/spvoices.cpp */
int SNDSTRM_destroy(...);   /* (int handle) */
int SNDSTRM_getvol(...);   /* (int handle) */
int SNDSTRM_overhead(...);   /* (int a, int b) */
void SNDSTRM_purge(...);   /* (int handle) */
void SNDSTRM_queuefile(...);   /* (int arg0) */
int SNDSTRM_requeststatus(...);   /* (int req, u_int statusptr) */
void SNDSTRM_setgreedylevel(...);   /* (int handle, int level) */
void SNDSTRM_setgreedystate(...);   /* (int handle, int state) */
void SNDSTRM_setpriority(...);   /* (int handle, int prio, int n) */
int SNDSTRM_status(...);   /* (int handle, int statusptr) */
int SNDSTRM_vol(...);   /* (int handle, int vol) */
int SNDSYS_getopts(...);   /* (void * outOpts) */
void SNDSYS_init(...);   /* (void *, int, int) */
void SNDSYS_restore(...);   /* (int arg0) */
int SNDSYS_setopts(...);   /* (void * newOpts) */
void SNDSYS_vectortoreal(...);   /* (void) */
void SNDautovol(...);   /* (void *, int, int) */
int SNDbankadd(...);   /* (void *, void *) */
void SNDbankheadercopy(...);   /* (void *, int) */
int SNDbankheadersize(...);   /* (int) */
int SNDbankremove(...);   /* (int) */
int SNDfxinitbus(...);   /* (int bus, int mode, int a2, int a3, int a4) */
int SNDfxmasterlevel(...);   /* (int bus, int level) */
int SNDgetlimits(...);   /* (int *opts) */
int SNDmastervol(...);   /* (int vol) */
int SNDmemlargestunused(...);   /* (int *buf) */
int SNDover(...);   /* (int) */
int SNDpan(...);   /* (u_int tag, int pan) */
int SNDpitchbend(...);   /* (u_int tag, int bend) */
int SNDpitchmult(...);   /* (int tag, u_int mult) */
int SNDplay(...);   /* (void *) */
void SNDplaysetdef(...);   /* (void *) */
int SNDsetlimits(...);   /* (int *opts) */
int SNDstop(...);   /* (int handle) */
int SNDtimeremaining(...);   /* (int handle) */
void SNDvol(...);   /* (int handle, int vol) */
void  * SetSp(...);   /* (void *sp) -- EA, not PsyQ */
double __adddf3(...);   /* (double, double) */
double __divdf3(...);   /* (double, double) */
float __divsf3(...);   /* (float a, float b) */
double __extendsfdf2(...);   /* (float) */
int __fixsfsi(...);   /* (float a) */
double __floatsidf(...);   /* (int) */
float __floatsisf(...);   /* (int) */
int __ltdf2(...);   /* (double, double) */
void __main(...);   /* (void) */
float __mulsf3(...);   /* (float,float) */
float __truncdfsf2(...);   /* (double) */
int addsystemtask(...);   /* (void (*fn)(void), void *a, void *b) */
int addtimer(...);   /* (void (*proc)(void)) */
void asyncidle(...);   /* (void * arg0) */
unsigned int asyncloadfile(...);   /* (char*, void*) */
unsigned int asyncloadfileat(...);   /* (char*, char*) */
int asyncloadsegment(...);   /* (char *, void *, int) */
int atoi(...);   /* (const char *s) */
int bigcount(...);   /* (void *big) */
void blockclear(...);   /* (void*, int) */
void blockfill(...);   /* (void *dst, int size, int val) */
void blockmove(...);   /* (void *, void *, int) */
void cancelasyncload(...);   /* (unsigned int) */
int ccos(...);   /* (int) */
unsigned long crc16(...);   /* (void*, int) */
void crossproduct(...);   /* (coorddef *, coorddef *, coorddef *) */
int csin(...);   /* (int) */
int delsystemtask(...);   /* (int fn) */
int deltimer(...);   /* (void (*proc)(void)) */
int fastintcos(...);   /* (int angle) */
int fastintsin(...);   /* (int angle) */
int filesize(...);   /* (char*) */
int fixedatan(...);   /* (int y, int x) */
int fixedcos(...);   /* (int angle) */
int fixeddiv(...);   /* (int a, int b) */
int rdiv(...);   /* (int a, int b) — reciprocal divide @0x800E4404 */
int fixedmult(...);   /* (int, int) */
int fixedsin(...);   /* (int angle) */
void fixedsincos(...);   /* (int a, int *s, int *c) */
int fixedsqrt(...);   /* (int x) */
void fixedxformx(...);   /* (void *m, int angle) */
int fixedxformy(...);   /* (void *m, int angle) */
void fixedxformz(...);   /* (void *m, int angle) */
char * getasyncreadadr(...);   /* (unsigned int, void*) */
int getasyncreadstatus(...);   /* (unsigned int) */
charactertbl * getcharacter(...);   /* (int code) */
int geti(...);   /* (void *p, int n) */
long getm(...);   /* (void *p, int n) */
int gettick(...);
short * iSNDserveradd100hzclient(...);   /* (int cb) */
int iSNDserverremove100hzclient(...);   /* (int cb) */
void iSPCH_EACseedrandom(...);   /* (int arg0) */
void initasync(...);   /* (int reqs, int bufsize, int flag) */
void initjoy(...);   /* (int mode) */
void initlinkmode(...);   /* (int a, int count, int c) */
void initmemadr(...);   /* (void *base, int size) */
void inittimer(...);   /* (int hz) */
int intarccos(...);   /* (int cosval) */
int intatan(...);   /* (int dx, int dz) */
int intsincos(...);   /* (int angle) */
int isqrt(...);   /* (int v) */
int largestunused(...);   /* (void) */
int loadbigfileheader(...);   /* (char *name, void *hdr) */
void     * loadfileadr(...);   /* (char *, int) */
char * loadfileadrz(...);   /* (char *name, int flag) */
void * loadfileatadr(...);   /* (char *name, void *addr) */
int loadfileatadrz(...);   /* (char *filename, void *loadAddr) */
void * loadpackadr(...);   /* (char *name, void *dst) */
void * loadpackadrz(...);   /* (char *name, void *dst) */
int loadshapeadr(...);   /* (char *name, void *dst) */
void * locatebig(...);   /* (char *big, char *name, int from) */
void *locatebigentry(...);   /* (char *bigfile, char *name, int a, int *b, int sizeOut) */
void *locatebigentryz(...);   /* (void * arg0) */
void *locateshape(...);   /* (void *base, const char *tag, int n) */
void *locateshapez(...);   /* (char *buf, char *name) */
void * memcpy(...);   /* (void *dest, void *src, uint n) */
void * memset(...);   /* (void *, int, int) */
void movfxya(...);   /* (void *, int, int) */
void padinit(...);
int purgememadr(...);   /* (char *p) */
int puts(...);   /* (const char *s) */
void qsort(...);   /* (void*, int, int, int(*)(char*, char*)) */
int rand(...);
int random(...);   /* (void) */
void reorthogonalize(...);   /* (matrixtdef *m) */
void  * reservememadr(...);   /* (const char *, int, int) */
void resizememadr(...);   /* (void *, int) */
void restoregp(...);   /* (int arg0) */
int rinverse(...);   /* (int x) */
void savegp(...);   /* (int *arg0) */
void seedrandom(...);   /* (int seed) */
void setasyncfile(...);   /* (char *) */
void setdirectory(...);   /* (char *path) */
void setfont(...);   /* (char *f) */
void settrans(...);   /* (int on) */
int shapedepth(...);   /* (void *shp) */
void shapename(...);   /* (void *, int, char *) */
void *shapepointer(...);   /* (void*, int) */
int shapetoclutid(...);   /* (void * shape) */
int sprintf(...);   /* (char *, const char *, ...) */
char * strcat(...);   /* (char *, const char *) */
char * strchr(...);   /* (char*, int) */
int strcmp(...);   /* (char *, char *) */
char * strcpy(...);   /* (char*, char*) */
unsigned int strlen(...);   /* (char *) */
int strncmp(...);   /* (const char *, const char *, unsigned) */
char  * strncpy(...);   /* (char *, char *, int) */
char * strstr(...);   /* (const char *haystack, const char *needle) */
int systemtask(...);   /* (int taskFlag) */
void timedwait(...);   /* (int) */
void transform(...);   /* (void *src, void *mtx, void *dst) */
void transpose(...);   /* (matrixtdef *, matrixtdef *) */
long unbtree(...);   /* (void *src, void *dst, int reverse) */
long unhuff(...);   /* (void *src, void *dst, int reverse) */
long unrefpack(...);   /* (void *src, void *dst, int reverse) */
void vramfxya(...);   /* (void * shape_data, short x_scale, short y_scale, short angle, int flags) */
void waitdraw(...);   /* (void) */
int wildcard(...);   /* (u_char *str, char *pattern) */
int xformy(...);   /* (matrixtdef *m, int angle) */

} /* extern "C" */

#endif
