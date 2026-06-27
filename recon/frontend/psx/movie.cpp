/* frontend/psx/movie.cpp  --  RECONSTRUCTED  (PSX .STR streaming movie player; C++ TU)
 *   Bodies: Ghidra decompiler. Line numbers: PsyQ SLD (8c-start, 8e-end).
 *   17 functions; C++ linkage (cfront-mangled in SYM). 10 EXT Movie + play_movie, 7 STAT str.
 *   Externs declared from Ghidra sigs (movie_externs.h).
 */
#include "movie.h"

/* ---- Movie.obj STAT (file-local) globals ---- */
static int     width, height;                       /* 0x80052a24/28 */
static CdlLOC  loc;                                 /* 0x80052cf8 */
static short   PPWTop, PPWBottom, gMode;            /* 0x80052cfc/cfe/d00 */
static int     gIsRGB24 __attribute__((section(".bss")));  /* 0x80052d04 (.bss=absolute, oracle %hi/%lo not gp-rel) */
static short   gMovieHeight, gMovieWidth;           /* 0x80052d08/d0a */
static u_long  gMovieFrame, gEndFrame;              /* 0x80052d0c/d10 */
static int     movieFlags__[4]; /* 0x80052d14..d20 - aggregate forces .bss (absolute), not .sbss */
#define bMovieLoaded movieFlags__[0]
#define bStopMovie   movieFlags__[1]
#define bRewindMovie movieFlags__[2]
#define isFirstSlice movieFlags__[3]
static DECENV  dec;                                 /* 0x80052d28 */
static u_long *vlcbuf0 __attribute__((section(".bss")));   /* 0x80052d58 (.bss=absolute, not .sbss) */
static u_long *vlcbuf1 __attribute__((section(".bss")));   /* 0x80052d5c */
static u_short *imgbuf __attribute__((section(".bss")));   /* 0x80052d60 */
static u_long *sect_buff __attribute__((section(".bss")));   /* 0x80052d64 */

/* lines 1-129: file header, #includes, static data, macros (no symbols emitted) */

/* ---- Movie_Init  (movie.cpp:130, code lines 130-169) ---- */
void Movie_Init(char movie)

{
  PPWTop = 3;
  PPWBottom = 2;
  gMovieWidth = moviewidth[(byte)movie];
  gMovieHeight = movieheight[(byte)movie];
  Movie_SetDecodeOffset(0,0,0,0x100);
  gMovieFrame = 0;
  gEndFrame = 0;
  bMovieLoaded = 0;
  settrans(0);
  download[0] = 0;
  vlcbuf0 = (u_long *)reservememadr("vlcbuf0",0x28000,0x10);
  vlcbuf1 = (u_long *)reservememadr("vlcbuf1",0x28000,0x10);
  if ((int)PPWBottom == 0) {
    trap(0x1c00);
  }
  imgbuf = (u_short *)reservememadr
                     ("imgbuf",((uint)((int)PPWTop << 5) / (uint)(int)PPWBottom) * 0x1e0,0x10);
  sect_buff = (u_long *)reservememadr("sect_buff",0x10000,0x10);
  Platform_ResetDCTBuffer();
  CD_Restart(0);
  CdControlB('\v',(u_char *)0x0,(u_char *)0x0);
  CdControlB('\t',(u_char *)0x0,(u_char *)0x0);
  CdControlB('\f',(u_char *)0x0,(u_char *)0x0);
  DecDCToutCallback((void *)0x0);
  CdDataCallback((void *)0x0);
  CdReadyCallback((void *)0x0);
  DecDCTvlcSize(0);
  return;
}

/* lines 170-174: (static data / macros / comments - no emitted code) */

/* ---- Movie_DeInit  (movie.cpp:175, code lines 175-200) ---- */
void Movie_DeInit(void)

{
  byte param [8];
  
  bMovieLoaded = 0;
  param[0] = 0x80;
  CdControlB('\x0e',param,(u_char *)0x0);
  DecDCToutCallback((void *)0x0);
  StUnSetRing();
  CdDataCallback((void *)0x0);
  CdReadyCallback((void *)0x0);
  CdControlB('\v',(u_char *)0x0,(u_char *)0x0);
  CdControlB('\t',(u_char *)0x0,(u_char *)0x0);
  CdControlB('\f',(u_char *)0x0,(u_char *)0x0);
  purgememadr(vlcbuf0);
  purgememadr(vlcbuf1);
  purgememadr(imgbuf);
  purgememadr(sect_buff);
  Platform_ResetDCTBuffer();
  CD_Restart(0);
  return;
}

/* lines 201-205: (static data / macros / comments - no emitted code) */

/* ---- Movie_SetDecodeOffset  (movie.cpp:206, code lines 206-212) ---- */
void Movie_SetDecodeOffset(short x0,short y0,short x1,short y1)

{
  int bottom;
  
  bottom = (int)PPWBottom;
  if (bottom == 0) {
    trap(0x1c00);
  }
  if ((bottom == -1) && ((int)gMovieWidth * (int)PPWTop == -0x80000000)) {
    trap(0x1800);
  }
  dec.rect[0].h = gMovieHeight;
  dec.rect[1].h = gMovieHeight;
  dec.rect[0].w = (short)(((int)gMovieWidth * (int)PPWTop) / bottom);
  dec.rect[0].x = x0;
  dec.rect[0].y = y0;
  dec.rect[1].x = x1;
  dec.rect[1].y = y1;
  dec.rect[1].w = dec.rect[0].w;
  ClearImage(dec.rect,'\0','\0','\0');
  ClearImage(dec.rect + 1,'\0','\0','\0');
  DrawSync(0);
  return;
}

/* lines 213-217: (static data / macros / comments - no emitted code) */

/* ---- Movie_Load  (movie.cpp:218, code lines 218-282) ---- */
void Movie_Load(char movie)

{
  void *found;
  CdlFILE file;
  char gFEFileName [80];
  
  bMovieLoaded = 0;
  bRewindMovie = 0;
  bStopMovie = 0;
  download[0] = 0;
  isFirstSlice = 1;
  ResetCallback();
  sprintf(gFEFileName,"\\MOVIES\\%s;1",movienames[(byte)movie]);
  gMovieFrame = 0;
  gEndFrame = (int)movieframes[(byte)movie] - 1;
  gIsRGB24 = movie24bit[(byte)movie];
  gMovieWidth = moviewidth[(byte)movie];
  gMovieHeight = movieheight[(byte)movie];
  if (gIsRGB24 == 0) {
    PPWTop = 1;
    PPWBottom = 1;
    gMode = 2;
  }
  else {
    PPWTop = 3;
    PPWBottom = 2;
    gMode = 3;
  }
  found = CdSearchFile(&file,gFEFileName);
  if (found != (void *)0x0) {
    loc.minute = file.pos.minute;
    loc.sector = file.pos.sector;
    loc.second = file.pos.second;
    strSetDefDecEnv(&dec);
    strInit__FP6CdlLOCiPFe_vT2(&loc,0xfffffff,strCallback,(fn_void *)0x0);
    strNextVlc(&dec);
    bMovieLoaded = 1;
  }
  return;
}

/* lines 283-286: (static data / macros / comments - no emitted code) */

/* ---- Movie_NextFrame  (movie.cpp:287, code lines 287-299) ---- */
int Movie_NextFrame(void)

{
  int bottom;
  int vh;
  int ret;
  int xstep;
  
  DecDCTin(dec.vlcbuf[dec.vlcid],(int)gMode);
  DecDCTinSync(1);
  bottom = (int)PPWBottom;
  xstep = ((int)PPWTop << 4) / bottom;
  if (bottom == 0) {
    trap(0x1c00);
  }
  if ((bottom == -1) && ((int)PPWTop << 4 == -0x80000000)) {
    trap(0x1800);
  }
  if (xstep == 0) {
    trap(0x1c00);
  }
  if ((xstep == -1) && (dec.slice.w + -1 == -0x80000000)) {
    trap(0x1800);
  }
  vh = dec.slice.h + -1;
  if (vh < 0) {
    vh = dec.slice.h + 0xe;
  }
  DecDCTout
            ((u_long *)dec.imgbuf,
             ((dec.slice.w + -1) / xstep + 1) * xstep * 0x10 * ((vh >> 4) + 1) >> 1);
  ret = strNextVlc(&dec);
  if (ret < 0) {
    ret = -1;
  }
  else {
    strSync(&dec,0);
    VSync(0);
    ret = 0;
  }
  return ret;
}

/* lines 300-305: (static data / macros / comments - no emitted code) */

/* ---- Movie_DownloadFrame  (movie.cpp:306, code lines 306-307) ---- */
void Movie_DownloadFrame(void)

{
  download[0] = 1;
  return;
}

/* lines 308-312: (static data / macros / comments - no emitted code) */

/* ---- Movie_Stop  (movie.cpp:313, code lines 313-314) ---- */
void Movie_Stop(void)

{
  bStopMovie = 1;
  return;
}

/* lines 315-319: (static data / macros / comments - no emitted code) */

/* ---- Movie_Finished  (movie.cpp:320, code lines 320-321) ---- */
void * Movie_Finished(void)

{
  void *finished;
  
  finished = (void *)0x0;
  if ((((gEndFrame <= gMovieFrame) || (bMovieLoaded == 0)) || (bStopMovie != 0)) ||
     (bRewindMovie != 0)) {
    finished = (void *)0x1;
  }
  return finished;
}

/* lines 322-326: (static data / macros / comments - no emitted code) */

/* ---- Movie_Play  (movie.cpp:327, code lines 327-406) ---- */
int Movie_Play(char movie)

{
  bool dispRect;
  void *finished;
  int frame_ret;
  uint pad_p1;
  uint pad_p2;
  uint joyval;
  DISPENV disp;
  DRAWENV draw;
  
  SNDcdvol(gMasterMusicLevel * 0x7f >> 7);
  Movie_Init(movie);
  Movie_Load(movie);
  while ((finished = Movie_Finished(), finished != (void *)0x1 &&
         (frame_ret = Movie_NextFrame(), frame_ret != -1))) {
    dispRect = dec.rectid == 0;
    SetDefDispEnv
              (&disp,(int)dec.rect[dispRect].x,(int)dec.rect[dispRect].y,(int)dec.rect[dispRect].w,
               (int)dec.rect[dispRect].h);
    disp.screen.h = 0xf0;
    SetDefDrawEnv
              (&draw,(int)dec.rect[dispRect].x,(int)dec.rect[dispRect].y,(int)dec.rect[dispRect].w,
               (int)dec.rect[dispRect].h);
    if (gIsRGB24 != 0) {
      disp.isrgb24 = '\x01';
      disp.disp.w = (short)((ulonglong)((longlong)((int)disp.disp.w << 1) * 0x55555556) >> 0x20) -
                    (short)(((int)disp.disp.w << 1) >> 0x1f);
    }
    PutDispEnv(&disp);
    PutDrawEnv(&draw);
    SetDispMask(1);
    if (gIsRGB24 == 0) {
      FntFlush(-1);
    }
    Movie_DownloadFrame();
    download[0] = 1;
    PAD_update();
    pad_p1 = PAD_state(0);
    pad_p2 = PAD_state(4);
    joyval = (pad_p1 | pad_p2) & 0xffff;
    if ((joyval != 0) && ((Movie_Stop(), skip_all != '\0' || (joyval == 8)))) {
      user_exit = 1;
    }
  }
  Movie_DeInit();
  ClearImage(dec.rect,'\0','\0','\0');
  ClearImage(dec.rect + 1,'\0','\0','\0');
  DrawSync(0);
  return (int)user_exit;
}

/* lines 407-409: (static data / macros / comments - no emitted code) */

/* ---- play_movie  (movie.cpp:410, code lines 410-412) ---- */
int play_movie(char movie)

{
  int ret;
  
  ret = Movie_Play(movie);
  return ret;
}

/* lines 413-419: (static data / macros / comments - no emitted code) */

/* ---- strSetDefDecEnv  (movie.cpp:420, code lines 420-428) ---- */
void strSetDefDecEnv(DECENV *dec)

{
  short mh;
  u_long *vb0;
  u_long *vb1;
  u_short *img;
  int bottom;
  int top;
  
  img = imgbuf;
  vb1 = vlcbuf1;
  vb0 = vlcbuf0;
  mh = gMovieHeight;
  top = (int)PPWTop;
  bottom = (int)PPWBottom;
  if (bottom == 0) {
    trap(0x1c00);
  }
  if ((bottom == -1) && (top << 4 == -0x80000000)) {
    trap(0x1800);
  }
  dec->vlcid = 0;
  dec->rectid = 0;
  dec->isdone = 0;
  (dec->slice).x = 0;
  (dec->slice).y = 0;
  dec->vlcbuf[1] = vb1;
  dec->imgbuf = img;
  (dec->slice).h = mh;
  dec->vlcbuf[0] = vb0;
  (dec->slice).w = (short)((top << 4) / bottom);
  return;
}

/* lines 429-432: (static data / macros / comments - no emitted code) */

/* ---- strInit__FP6CdlLOCiPFe_vT2  (movie.cpp:433, code lines 433-445) ---- */
extern "C" void strInit__FP6CdlLOCiPFe_vT2(CdlLOC *loc,int frame_size,fn_void *callback,fn_void *endcallback)

{
  
  DecDCTReset(0);
  bRewindMovie = 0;
  DecDCToutCallback((void *)callback);
  StSetRing(sect_buff,0x20);
  StClearRing();
  StSetStream(gIsRGB24,1,frame_size,(void *)0x0,(void *)endcallback);
  strKickCD(loc);
  return;
}

/* lines 446-449: (static data / macros / comments - no emitted code) */

/* ---- strCallback  (movie.cpp:450, code lines 450-488) ---- */
void strCallback(void)

{
  short xstep;
  int topsh;
  int rw;
  int remTop;
  int bottom;
  int vh;
  int hstep;
  int rem;
  
  if ((gIsRGB24 != 0) && (StCdIntrFlag != 0)) {
    StCdInterrupt();
    StCdIntrFlag = 0;
  }
  if (download[0] != 0) {
    LoadImage(&dec.slice,(u_long *)dec.imgbuf);
  }
  if (isFirstSlice != 0) {
    bottom = (int)PPWBottom;
    topsh = (int)PPWTop << 4;
    hstep = topsh / bottom;
    if (bottom == 0) {
      trap(0x1c00);
    }
    if ((bottom == -1) && (topsh == -0x80000000)) {
      trap(0x1800);
    }
    rw = (int)dec.rect[dec.rectid].w;
    rem = rw % hstep;
    if (hstep == 0) {
      trap(0x1c00);
    }
    if ((hstep == -1) && (rw == -0x80000000)) {
      trap(0x1800);
    }
    remTop = rem * PPWTop;
    if (rem != 0) {
      if (bottom == 0) {
        trap(0x1c00);
      }
      if ((bottom == -1) && (remTop == -0x80000000)) {
        trap(0x1800);
      }
      isFirstSlice = 0;
      xstep = (short)(remTop / bottom);
      goto strCallback_inlinedJoin;
    }
  }
  bottom = (int)PPWBottom;
  if (bottom == 0) {
    trap(0x1c00);
  }
  if ((bottom == -1) && ((int)PPWTop << 4 == -0x80000000)) {
    trap(0x1800);
  }
  xstep = (short)(((int)PPWTop << 4) / bottom);
strCallback_inlinedJoin:
  dec.slice.x = dec.slice.x + xstep;
  if ((int)dec.slice.x < (int)dec.rect[dec.rectid].x + (int)dec.rect[dec.rectid].w) {
    bottom = (int)PPWBottom;
    hstep = ((int)PPWTop << 4) / bottom;
    if (bottom == 0) {
      trap(0x1c00);
    }
    if ((bottom == -1) && ((int)PPWTop << 4 == -0x80000000)) {
      trap(0x1800);
    }
    if (hstep == 0) {
      trap(0x1c00);
    }
    if ((hstep == -1) && (dec.slice.w + -1 == -0x80000000)) {
      trap(0x1800);
    }
    vh = dec.slice.h + -1;
    if (vh < 0) {
      vh = dec.slice.h + 0xe;
    }
    DecDCTout
              ((u_long *)dec.imgbuf,
               ((dec.slice.w + -1) / hstep + 1) * hstep * 0x10 * ((vh >> 4) + 1) >> 1);
  }
  else {
    dec.rectid = (int)(dec.rectid == 0);
    dec.isdone = 1;
    dec.slice.x = dec.rect[dec.rectid].x;
    isFirstSlice = 1;
    dec.slice.y = dec.rect[dec.rectid].y + (short)((0xf0 - height) / 2);
  }
  return;
}

/* lines 489-492: (static data / macros / comments - no emitted code) */

/* ---- strNextVlc  (movie.cpp:493, code lines 493-518) ---- */
int strNextVlc(DECENV *dec)

{
  u_long *next;
  uint vid;
  int cnt;
  int r;
  
  cnt = 10;
  do {
    next = strNext(dec);
    cnt = cnt + -1;
    if (next != (u_long *)0x0) goto found;
  } while (cnt != 0);
  return -1;
found:
  vid = (uint)(dec->vlcid == 0);
  dec->vlcid = vid;
  r = DecDCTvlc(next,dec->vlcbuf[vid]);
  while (r != 0) {
    r = DecDCTvlc((u_long *)0x0,(u_long *)0x0);
  }
  StFreeRing(next);
  return 0;
}

/* lines 519-536: (static data / macros / comments - no emitted code) */

/* ---- strNext  (movie.cpp:537, code lines 537-600) ---- */
u_long * strNext(DECENV *dec)

{
  u_long st;
  u_long fc;
  short mh;
  short ws;
  int bottom;
  int cnt;
  int wt;
  RECT rect;
  u_long *addr;
  CDSECTOR *sector;
  
  cnt = 50000;
  while( true ) {
    st = StGetNext((u_long *)&addr,(u_long *)&sector);
    cnt = cnt + -1;
    if (st == 0) break;
    if (cnt == 0) {
      return (u_long *)0x0;
    }
  }
  if ((*addr == sector->headm) && (addr[1] == sector->headv)) {
    fc = sector->frameCount;
    if ((fc < gMovieFrame) || (gEndFrame <= fc)) {
      bRewindMovie = 1;
      fc = gMovieFrame;
    }
    gMovieFrame = fc;
    if ((width != (uint)sector->width) || (height != (uint)sector->height)) {
      bottom = (int)PPWBottom;
      if (bottom == 0) {
        trap(0x1c00);
      }
      if ((bottom == -1) && (PPWTop * 0x280 == -0x80000000)) {
        trap(0x1800);
      }
      rect.x = 0;
      rect.y = 0;
      rect.h = 0x1e0;
      rect.w = (short)((PPWTop * 0x280) / bottom);
      ClearImage(&rect,'\0','\0','\0');
      width = (int)sector->width;
      height = (int)sector->height;
    }
    wt = width * PPWTop;
    bottom = (int)PPWBottom;
    if (bottom == 0) {
      trap(0x1c00);
    }
    if ((bottom == -1) && (wt == -0x80000000)) {
      trap(0x1800);
    }
    mh = (short)height;
    dec->rect[1].h = (short)height;
    dec->rect[0].h = mh;
    (dec->slice).h = mh;
    ws = (short)(wt / bottom);
    dec->rect[1].w = ws;
    dec->rect[0].w = ws;
    return addr;
  }
  StFreeRing(addr);
  return (u_long *)0x0;
}

/* lines 601-603: (static data / macros / comments - no emitted code) */

/* ---- strSync  (movie.cpp:604, code lines 604-621) ---- */
void strSync(DECENV *dec,int arg1)

{
  int viewOff;
  uint nextRect;
  int ridx;
  u_long cnt;
  
  cnt = 0x800000;
  if (dec->isdone == 0) {
    viewOff = 0xf0 - height;
    do {
      cnt = cnt - 1;
      if (cnt == 0) {
        dec->isdone = 1;
        nextRect = (uint)(dec->rectid == 0);
        dec->rectid = nextRect;
        ridx = dec->rectid;
        (dec->slice).x = dec->rect[nextRect].x;
        (dec->slice).y = dec->rect[ridx].y + (short)(viewOff / 2);
      }
    } while (dec->isdone == 0);
  }
  dec->isdone = 0;
  return;
}

/* lines 622-626: (static data / macros / comments - no emitted code) */

/* ---- strKickCD  (movie.cpp:627, code lines 627-629) ---- */
void strKickCD(CdlLOC *loc)

{
  int status;
  
  do {
    status = CdControl('\x15',&loc->minute,(u_char *)0x0);
  } while (status == 0);
  do {
    status = CdRead2(0x1c0);
  } while (status == 0);
  return;
}

/* end of movie.cpp */
