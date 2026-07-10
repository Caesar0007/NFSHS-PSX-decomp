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

/* lines 1-61: file header, #includes, static data, macros (no symbols emitted) */

/* ---- VIDEO_create  (video.cpp:62, code lines 62-102) ---- */
int VIDEO_create(int width,int height,int fps,int streambuffersize,int memtype)

{
  int status;
  VIDEOSTRUCT *vid;
  void *mem;
  int handle;
  SNDPLAYOPTS playopts;
  char fname [60];
  
  Platform_ResetDCTBuffer();
  sprintf(fname,"%sDCT.BIN",Paths_Paths[0x20]);
  handle = asyncloadfileat(fname,(int)CF_DVLC);
  while (status = getasyncreadstatus(handle), status == 0) {
    systemtask(0);
  }
  vid = (VIDEOSTRUCT *)reservememadr("Videostruct",0x40,memtype);
  blockclear(vid,0x40);
  vid->id = 0x57444956;   /* 'VIDW' */
  vid->bufferwidth = width;
  vid->bufferheight = height;
  mem = reservememadr("streambuffer",streambuffersize,memtype);
  vid->streambuffer = (char *)mem;
  mem = STREAM_create(2,2,2,vid->streambuffer,streambuffersize);
  vid->videotap = (long)mem;
  STREAM_setfilter(vid->videotap,1,0xffff,0x4353,2);
  {
    extern int screenbpp[];
    extern int timerhz[];
    vid->mdechandle = initmdec(width,height,screenbpp[0],memtype);
    vid->displaytimeincr = fixeddiv(fixedmult(timerhz[0] << 0x10,0xa0000),fps);
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
  int requestid;
  
  if ((((VIDEOSTRUCT *)handle)->id == 0x57444956   /* 'VIDW' */) && (((VIDEOSTRUCT *)handle)->state == VIDEOSTATE_IDLE)) {
    requestid = STREAM_queuefile(((VIDEOSTRUCT *)handle)->videotap,fname,0,0);
    ((VIDEOSTRUCT *)handle)->streamrequestid = requestid;
    ((VIDEOSTRUCT *)handle)->state = VIDEOSTATE_SPOOLING;
  }
  return;
}

/* lines 156-157: (static data / macros / comments - no emitted code) */

/* ---- VIDEO_startplayback  (video.cpp:158, code lines 158-179) ---- */
void VIDEO_startplayback(int handle)

{
  int buffered;
  
  if ((((VIDEOSTRUCT *)handle)->id == 0x57444956   /* 'VIDW' */) && (((VIDEOSTRUCT *)handle)->state != VIDEOSTATE_IDLE)) {
    buffered = STREAM_bufferusage(((VIDEOSTRUCT *)handle)->videotap);
    if (buffered >= 20001) {
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
VIDEOSTATE VIDEO_state(int handle)

{
  VIDEOSTRUCT *vid;
  SNDREQUESTSTATUS srs;
  vid = (VIDEOSTRUCT *)handle;
  
  if (vid->id != 0x57444956   /* 'VIDW' */) {
    return (VIDEOSTATE)0;
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
  return (VIDEOSTATE)vid->state;
}

/* lines 248-256: (static data / macros / comments - no emitted code) */

/* ---- VIDEO_updateframexy  (video.cpp:257, code lines 257-335) ---- */
int VIDEO_updateframexy(int handle,int x,int y)

{
  int result;
  int endofstream;
  STREAMCHUNKHDR *chunk;
  VIDEOSTRUCT *vid;
  int dropped;
  int currenttime;
  SNDREQUESTSTATUS audiostatus;
  vid = (VIDEOSTRUCT *)handle;
  
  if (vid->id == 0x57444956   /* 'VIDW' */) {
    if (vid->state != VIDEOSTATE_PLAYING) {
      return 0;
    }
    currenttime = ticks * 10 - vid->reftime;
    if (vid->displaytime > currenttime) {
      return 0;
    }
    endofstream = STREAM_isendofstream(vid->videotap);
    if (endofstream != 0) {
      return 0;
    }
    while (endofstream == 0) {
      chunk = STREAM_get(vid->videotap);
      if (chunk == (STREAMCHUNKHDR *)0x0) {
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
      endofstream = STREAM_isendofstream(vid->videotap);
      if (endofstream == 0) continue;
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
void videoupdatetime(VIDEOSTRUCT *vid)

{
  int acc;
  
  acc = vid->displaytimefrac + vid->displaytimeincr;
  vid->displaytimefrac = acc;
  vid->displaytime = vid->displaytime + (acc >> 0x10);
  vid->displaytimefrac = (uint)(ushort)vid->displaytimefrac;
  return;
}

/* lines 372-374: (static data / macros / comments - no emitted code) */

/* ---- videodecode  (video.cpp:375, code lines 375-423) ---- */
int videodecode(VIDEOSTRUCT *vid,STREAMCHUNKHDR *chunk,int x,int y)

{
  int done;
  int timeout;

  if (chunk->type == 0x4443546d) {
    vid->framewidth = (int)(short)chunk[1].size;
    vid->frameheight = (int)*(short *)((int)&chunk[1].size + 2);
    mdec(vid->mdechandle,(char *)(chunk + 1),x,y);
    timeout = ticks + timerhz * 4;
    do {
      done = mdecdone(vid->mdechandle);
      if (done != 0) {
        return 1;
      }
      systemtask(0);
    } while (ticks <= timeout);
    mdecreset();
  }
  return 0;
}

/* end of video.cpp */