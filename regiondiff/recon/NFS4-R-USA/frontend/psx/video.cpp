/* frontend/psx/video.cpp  --  RECONSTRUCTED  (PSX MDEC/STR video playback)
 *   Bodies      : Ghidra decompiler (nfs4-f.exe MIPS), full re-decompile (no truncation).
 *   Line numbers: PsyQ SLD per-instruction stream (C:\nfs4\FRONTEND\PSX\VIDEO.CPP).
 *   Field names : SYM-authentic VIDEOSTRUCT layout (id/bufferwidth/bufferheight/streambuffer/
 *                 mdechandle/frame/videotap/state/streamrequestid/reftime/displaytime/
 *                 displaytimefrac/displaytimeincr/framewidth/frameheight/droppedframes).
 *   Locals      : SYM-AUTHENTIC where present (vid/playopts/handle/fname/srs/chunk/
 *                 audiostatus/currenttime/dropped/timeout). Remaining decompiler temps
 *                 given SEMANTIC names by data-flow analysis (status/mem/requestid/
 *                 buffered/result/streamstate/endofstream/acc/done). Two were SYM-
 *                 authentic recoveries from dead decls: VIDEO_create iVar1->handle,
 *                 VIDEO_updateframexy bVar1->dropped. Two SSA register-reuse merges
 *                 collapsed to nested exprs (VIDEO_create timeincr, VIDEO_state ticks).
 *   state values: rendered as VIDEOSTATE enum (IDLE/SPOOLING/READY/PLAYING).
 *   Magic 0x57444956 = ASCII 'VIDW' (VIDEOSTRUCT.id validity tag).
 *   The 4 simple accessors have NO 'vid' SYM-local -> rendered as ((VIDEOSTRUCT*)handle)->.
 */
#include "video.h"
#include "video_externs.h"
/* MATCH: split-address view of `ticks` for videodecode's PRE-LOOP read only -- a bare
   scalar extern compiles to the atomic `lw $r,sym` assembler macro, so its lui cannot
   interleave with timerhz's the way retail does.  The IN-LOOP read must stay the plain
   scalar: the array view there lets loop.c hoist the %hi out of the loop (+2 insns). */
extern int ticks_a[] asm("ticks");

/* lines 1-61: file header, #includes, static data, macros (no symbols emitted) */

/* ---- VIDEO_create  (video.cpp:62, code lines 62-102) ---- */
int VIDEO_create(int width,int height,int fps,int streambuffersize,int memtype)

{
  struct VIDEOSTRUCT *vid;
  int handle;
  SNDPLAYOPTS playopts;
  char fname [60];
  
  Platform_ResetDCTBuffer();
  sprintf(fname,"%sDCT.BIN",Paths_Paths[0x20]);
  handle = asyncloadfileat(fname,(int)CF_DVLC);
  while (getasyncreadstatus(handle) == 0) {
    systemtask(0);
  }
  vid = (struct VIDEOSTRUCT *)reservememadr("Videostruct",0x40,memtype);
  blockclear(vid,0x40);
  vid->id = 0x57444956;   /* 'VIDW' */
  vid->bufferwidth = width;
  vid->bufferheight = height;
  vid->streambuffer = (char *)reservememadr("streambuffer",streambuffersize,memtype);
  vid->videotap = (long)STREAM_create(2,2,2,vid->streambuffer,streambuffersize);
  STREAM_setfilter(vid->videotap,1,0xffff,0x4353,2);
  {
    extern int screenbpp[];
    extern int timerhz[];
    /* MATCH: reaching timerhz through a pointer local makes its address a plain
       schedulable pseudo instead of an in-struct array MEM: retail materializes the
       %hi in a SEPARATE scratch ($v1) and issues the load BEFORE the mdechandle
       store, which still holds the call result in $v0.  A direct timerhz[0] read
       sinks below the store and then self-temps into $a0. */
    int *hzp /* SYM-CODEGEN-CARRIER: hzp -- the direct timerhz read sinks past the
                mdechandle store and changes retail scheduling, as measured above */ = timerhz;
    vid->mdechandle = initmdec(width,height,screenbpp[0],memtype);
    vid->displaytimeincr = fixeddiv(fixedmult(*hzp << 0x10,0xa0000),fps);
  }
  vid->state = VIDEOSTATE_IDLE;
  return (int)vid;
}

/* lines 103-119: (static data / macros / comments - no emitted code) */

/* ---- VIDEO_destroy  (video.cpp:120, code lines 120-136) ---- */
void VIDEO_destroy(int handle)

{
  
  if (((VIDEOSTRUCT *)handle)->id == 0x57444956   /* 'VIDW' */) {
    ((VIDEOSTRUCT *)handle)->id = 0;
    restoremdec(((VIDEOSTRUCT *)handle)->mdechandle);
    STREAM_destroy(((VIDEOSTRUCT *)handle)->videotap);
    purgememadr(((VIDEOSTRUCT *)handle)->streambuffer);
  }
  return;
}

/* lines 137-138: (static data / macros / comments - no emitted code) */

/* ---- VIDEO_spoolfile  (video.cpp:139, code lines 139-155) ---- */
void VIDEO_spoolfile(int handle,char *fname)

{
  if ((((VIDEOSTRUCT *)handle)->id == 0x57444956   /* 'VIDW' */) && (((VIDEOSTRUCT *)handle)->state == VIDEOSTATE_IDLE)) {
    ((VIDEOSTRUCT *)handle)->streamrequestid =
        STREAM_queuefile(((VIDEOSTRUCT *)handle)->videotap,fname,0,0);
    ((VIDEOSTRUCT *)handle)->state = VIDEOSTATE_SPOOLING;
  }
  return;
}

/* lines 156-157: (static data / macros / comments - no emitted code) */

/* ---- VIDEO_startplayback  (video.cpp:158, code lines 158-179) ---- */
void VIDEO_startplayback(int handle)

{
  if ((((VIDEOSTRUCT *)handle)->id == 0x57444956   /* 'VIDW' */) && (((VIDEOSTRUCT *)handle)->state != VIDEOSTATE_IDLE)) {
    if (STREAM_bufferusage(((VIDEOSTRUCT *)handle)->videotap) >= 20001) {
      ((VIDEOSTRUCT *)handle)->state = VIDEOSTATE_PLAYING;
    }
  }
  return;
}

/* lines 180-181: (static data / macros / comments - no emitted code) */

/* ---- VIDEO_abortplayback  (video.cpp:182, code lines 182-195) ---- */
void VIDEO_abortplayback(int handle)

{
  
  if (((VIDEOSTRUCT *)handle)->id == 0x57444956   /* 'VIDW' */) {
    STREAM_kill(((VIDEOSTRUCT *)handle)->videotap);
    ((VIDEOSTRUCT *)handle)->state = VIDEOSTATE_IDLE;
  }
  return;
}

/* lines 196-197: (static data / macros / comments - no emitted code) */

/* ---- VIDEO_state  (video.cpp:198, code lines 198-247) ---- */
enum VIDEOSTATE VIDEO_state(int handle)

{
  struct VIDEOSTRUCT *vid;
  SNDREQUESTSTATUS srs;
  vid = (struct VIDEOSTRUCT *)handle;
  
  if (vid->id != 0x57444956   /* 'VIDW' */) {
    return (enum VIDEOSTATE)0;
  }
  if (vid->state == VIDEOSTATE_SPOOLING) {
    if (STREAM_state(vid->videotap) == 2) {
      extern int ticks[];
      vid->reftime = ticks[0] * 10;
      vid->state = VIDEOSTATE_PLAYING;
      vid->displaytime = 0;
      vid->displaytimefrac = 0;
    }
  }
  else if ((vid->state == VIDEOSTATE_PLAYING) &&
          (STREAM_state(vid->videotap) == 0))
  {
    vid->state = VIDEOSTATE_IDLE;
  }
  return (enum VIDEOSTATE)vid->state;
}

/* lines 248-256: (static data / macros / comments - no emitted code) */

/* ---- VIDEO_updateframexy  (video.cpp:257, code lines 257-335) ---- */
int VIDEO_updateframexy(int handle,int x,int y)

{
  int result; /* SYM-CODEGEN-CARRIER: result -- direct videodecode testing rotates
                 retail chunk/dropped ($s2/$s1) and is measured FAIL 17 (81/80) */
  struct STREAMCHUNKHDR *chunk;
  struct VIDEOSTRUCT *vid;
  int dropped;
  int currenttime;
  SNDREQUESTSTATUS audiostatus;
  vid = (struct VIDEOSTRUCT *)handle;
  
  if (vid->id == 0x57444956   /* 'VIDW' */) {
    if (vid->state != VIDEOSTATE_PLAYING) {
      return 0;
    }
    currenttime = ticks * 10 - vid->reftime;
    if (vid->displaytime > currenttime) {
      return 0;
    }
    if (STREAM_isendofstream(vid->videotap) != 0) {
      return 0;
    }
    while (1) {
      chunk = STREAM_get(vid->videotap);
      if (chunk == (struct STREAMCHUNKHDR *)0x0) {
        return 0;
      }
      videoupdatetime(vid);
      if (currenttime < vid->displaytime) {
        result = videodecode(vid,chunk,x,y);
        dropped = 0;
        if (result == 0) goto VIDEOupdateFrame_incCounter;
      }
      else {
VIDEOupdateFrame_incCounter:
        dropped = 1;
        vid->droppedframes = vid->droppedframes + 1;
      }
      STREAM_release(vid->videotap,chunk);
      if (!dropped) {
        return 1;
      }
      if (STREAM_isendofstream(vid->videotap) == 0) continue;
      return 1;
    }
  }
  else {
    result = 0;
  }
  return result;
}

/* lines 336-368: (static data / macros / comments - no emitted code) */

/* ---- videoupdatetime  (video.cpp:369, code lines 369-371) ---- */
void videoupdatetime(struct VIDEOSTRUCT *vid)

{
  vid->displaytimefrac = vid->displaytimefrac + vid->displaytimeincr;
  vid->displaytime = vid->displaytime + (vid->displaytimefrac >> 0x10);
  vid->displaytimefrac = (u_int)(ushort)vid->displaytimefrac;
  return;
}

/* lines 372-374: (static data / macros / comments - no emitted code) */

/* ---- videodecode  (video.cpp:375, code lines 375-423) ---- */
int videodecode(struct VIDEOSTRUCT *vid,struct STREAMCHUNKHDR *chunk,int x,int y)

{
  int timeout;

  if (chunk->type == 0x4443546d) {
    vid->framewidth = (int)(short)chunk[1].size;
    vid->frameheight = (int)*(short *)((int)&chunk[1].size + 2);
    mdec(vid->mdechandle,(char *)(chunk + 1),x,y);
    timeout = ticks_a[0] + timerhz * 4;
    /* MATCH (allocno ref dial, -dg receipts): the poll step sits in two nested
       scopes.  gcc-2.8 weights REG_N_REFS by loop_depth, so the in-loop
       `vid->mdechandle` read counts 4x instead of 2x -> vid 8 refs / live 52 =>
       priority 4615 vs timeout 3/9 => 3333, so `vid` is allocated FIRST and takes
       $s0 with timeout in $s1 (SYM: vid REGPARM $10=s0, timeout REG $11=s1).
       Flat (unwrapped) the numbers invert (vid 6/52 = 2307 < 3333) and the whole
       function comes out as a clean s0<->s1 role swap, 18 diffs at 43/43 insns.
       SYM shows 4 nested Block records inside this loop body, so nested scopes
       are real here; the exact nesting SITE is a codegen dial, not SYM-placed. */
    do {
      do { do {
        if (mdecdone(vid->mdechandle) != 0) {
          return 1;
        }
        systemtask(0);
      } while (0); } while (0);
    } while (ticks <= timeout);
    mdecreset();
  }
  return 0;
}

/* end of video.cpp */
