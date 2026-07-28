/* game/common/audiomus.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "audiomus_externs.h"


/* ---- audiomus.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
AudioMus_tMusicGlobals *AudioMus_g;   /* @0x8013c720  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
void AudioMus_RefreshStatus(void);
int AudioMus_Threshold(void);
int AudioMus_Buffered(void);
AudioMus_tCurrentSong * AudioMus_GetCurrentSong(void);
void AudioMus_SwitchSong(void);
void AudioMus_Fail(int errorcode);
void AudioMus_QueueRequestedSong(void);
void AudioMus_SetEntry(AudioMus_tSongEntry *info);
void AudioMus_SetCurrentSongInfo(void);
int AudioMus_Server(int mode,int ticks);
void AudioMus_InitGlobals(void);
void AudioMus_InitDriverGlobals(void);
void AudioMus_DriverStartUp(int buffersize,int spusize);
void AudioMus_SysStartUp(int buffersize,int spusize,char *songs);
void AudioMus_DriverCleanUp(void);
void AudioMus_SysCleanUp(void);
void AudioMus_StopSong(int fadeticks);
void AudioMus_BuildPlayList(int numplaylistsongs,int *playlist);
void AudioMus_BuildPattern(char *pattern);
int AudioMus_PlaySong(char *pattern);
void AudioMus_Volume(int volume);
void AudioMus_AutoVolume(int fadeticks,int volume);


/* ---- AudioMus_RefreshStatus__Fv  [@0x80079ef4] ---- */
void AudioMus_RefreshStatus(void)
{
  if (AudioMus_g->streamhandle >= 0) {
    SNDSTRM_status(AudioMus_g->streamhandle,(int)&AudioMus_g->streamstatus);
    if (0 < (AudioMus_g->streamstatus).outstandingrequests) {
      SNDSTRM_requeststatus((AudioMus_g->streamstatus).currentrequest,
                 (u_int)&AudioMus_g->requeststatus);
    }
  }
  else {
    (AudioMus_g->streamstatus).outstandingrequests = 0;
  }
  return;
}

/* ---- AudioMus_Threshold__Fv  [@0x80079f58] ---- */
int AudioMus_Threshold(void)
{
  /* Retail keeps music in $a0 and places the threshold-return block before
   * the buffering tests so the final comparison can branch backward to it. */
  AudioMus_tMusicGlobals *music = AudioMus_g;

  if (music == (AudioMus_tMusicGlobals *)0x0) goto return_zero;
  if (music->bigfileheader != (char *)0x0) goto valid_header;

return_zero:
  return 0;

valid_header:
  if (music->errorcode != 0) goto return_zero;
  if (music->switchsong != 2) goto check_buffer;

return_threshold:
  return music->threshold;

check_buffer:
  if ((music->streamstatus).outstandingrequests == 0) goto return_zero;
  if ((music->requeststatus).timetoend >
      (music->requeststatus).timebuffered) goto return_threshold;
  return 0;
}

/* ---- AudioMus_Buffered__Fv  [@0x80079fdc] ---- */
int AudioMus_Buffered(void)
{
  if (AudioMus_g == (AudioMus_tMusicGlobals *)0x0) {
    return 0;
  }
  if (AudioMus_g->bigfileheader == (char *)0x0) {
    return 0;
  }
  if ((AudioMus_g->streamstatus).outstandingrequests == 0) {
    return 0;
  }
  return (AudioMus_g->requeststatus).timebuffered;
}

/* ---- AudioMus_GetCurrentSong__Fv  [@0x8007a028] ---- */
AudioMus_tCurrentSong * AudioMus_GetCurrentSong(void)
{
  AudioMus_tCurrentSong*curr;
  AudioMus_tSongEntry*info;
  int iVar2;

  /* w30-a7: curr = &AudioMus_g->current cached ONCE (oracle computes it in the null-check
     branch's delay slot) and reused via small offsets for remaining/index; info = &curr->info
     is a further in-place bump (+0xC) reused for the title store -- cached sub-field pointer
     idiom (proven this TU, w28-a6). The errorcode/newswitch checks re-read AudioMus_g-> fresh
     (oracle re-issues the gp-rel load at each of those, not through a cached AudioMus_g local). */
  curr = &AudioMus_g->current;
  if (AudioMus_g == (AudioMus_tMusicGlobals *)0x0) {
    return (AudioMus_tCurrentSong *)0x0;
  }
  curr->remaining = (AudioMus_g->requeststatus).timetoend;
  iVar2 = AudioMus_g->errorcode;
  if (iVar2 == 0) {
    iVar2 = AudioMus_g->requestsong + 1;
  }
  curr->index = iVar2;
  info = &curr->info;
  switch ((*(AudioMus_tMusicGlobals *volatile *)&AudioMus_g)->errorcode) {
    case -4:
      info->title = "BUFFER NOT ALLOCATED";
      break;
    case -3:
      info->title = "STREAM NOT CREATED";
      break;
  }
  if (AudioMus_g->newswitch != 0) {
    AudioMus_g->newswitch = 0;
    (AudioMus_g->current).newsong = 1;
  }
  else {
    (AudioMus_g->current).newsong = 0;
  }
  return &AudioMus_g->current;
}

/* ---- AudioMus_SwitchSong__Fv  [@0x8007a0e4] ---- */
void AudioMus_SwitchSong(void)
{
  AudioMus_tSongEntry *info;

  if (((AudioMus_g != (AudioMus_tMusicGlobals *)0x0) && (AudioMus_g->availablesongs != 0)) &&
     (0 < AudioMus_g->volume)) {
    AudioMus_g->newswitch = 1;
    AudioMus_g->songname = (char *)0x0;
    AudioMus_g->errorcode = 0;
    AudioMus_g->current.remaining = 0;
    info = &AudioMus_g->current.info;
    info->length = 0;
    info->filename = (char *)0x0;
    info->title = (char *)0x0;
    info->artist = (char *)0x0;
    info->label = (char *)0x0;
    info->notes = (char *)0x0;
    if ((AudioMus_g->switchsong == 0) && (-1 < AudioMus_g->requestsong)) {
      SNDSTRM_autovol(AudioMus_g->streamhandle,2000,0);
      AudioMus_g->fadetime = 1000;
    }
    AudioMus_g->requestsong = AudioMus_g->requestsong + 1;
    if (Hud_kTurnSongOffNext != 0) goto SONG_OFF;
    if (AudioMus_g->requestsong < AudioMus_g->availablesongs) goto SONG_ON;
SONG_OFF:
    Hud_kTurnSongOffNext = 0;
    AudioMus_g->firstswitch = 0;
    AudioMus_g->switchsong = -1;
    AudioMus_g->requestsong = -1;
    goto SONG_DONE;
SONG_ON:
    AudioMus_g->switchsong = 1;
SONG_DONE:
    ;
  }
  return;
}

/* ---- AudioMus_Fail__Fi  [@0x8007a1dc] ---- */
void AudioMus_Fail(int errorcode)
{
  AudioMus_tMusicGlobals *pAVar1;
  int iVar2;
  
  iVar2 = (AudioMus_g->streamstatus).outstandingrequests;
  AudioMus_g->errorcode = errorcode;
  if (iVar2 != 0) {
    iVar2 = AudioMus_Buffered();
    SNDSTRM_autovol(AudioMus_g->streamhandle,iVar2,0);
    iVar2 = AudioMus_Buffered();
    AudioMus_g->fadetime = iVar2;
  }
  pAVar1 = AudioMus_g;
  AudioMus_g->newswitch = 1;
  pAVar1->firstswitch = 0;
  pAVar1->songname = (char *)0x0;
  pAVar1->switchsong = -1;
  pAVar1->requestsong = -1;
  return;
}

/* ---- AudioMus_QueueRequestedSong__Fv  [@0x8007a258] ---- */
void AudioMus_QueueRequestedSong(void)
{
  long offset;
  AudioMus_tSongEntry*info;
  int *piVar1;
  AudioMus_tMusicGlobals *pAVar2;
  char *pcVar3;
  int iVar4;
  
  pcVar3 = locatebigentry(AudioMus_g->bigfileheader,(char *)0x0,
                          (u_char)AudioMus_g->playlist[AudioMus_g->requestsong],
                          &offset,(long *)0x0);   /* oracle 0x6a280: a2=playlist[requestsong] a3=&offset stk=NULL */
  piVar1 = &AudioMus_g->streamhandle;
  AudioMus_g->songname = pcVar3;
  if (-1 < *piVar1) {
    /* w30-a7: oracle stores SNDSTRM_queuefile's RETURN into requesthandle (sw v0,0x78(v1)
       right after the jal, v0 untouched by the intervening gp-rel reload) -- the prior
       reconstruction discarded the call's return and stored pcVar3 again, which is a
       different value; fixed to match the oracle's real data flow. */
    AudioMus_g->requesthandle = SNDSTRM_queuefile(AudioMus_g->streamhandle,0x3e8,AudioMus_g->bigfilename,offset);   /* oracle 0x6a2a8: dropped 3 args (handle,0x3e8,bigfilename,offset) */
  }
  AudioMus_g->switchsong = 2;
  /* w30-a7: failby = gettick()+0x280 (oracle: v0=2 only feeds switchsong via the jal's delay
     slot; v0 is gettick's RETURN by the time it's added to 0x280) -- prior recon reused the
     switchsong constant (iVar4=2) for failby instead of the call's return. */
  iVar4 = gettick();
  pAVar2 = AudioMus_g;
  AudioMus_g->failby = iVar4 + 0x280;
  info = &pAVar2->current.info;   /* w30-a7: cached sub-field pointer -- oracle computes &current.info
                                      once (independent of remaining/length, scheduler hoists it early)
                                      and reuses it for every song-info field. */
  (pAVar2->current).remaining = 0;
  info->length = 0;
  info->filename = (char *)0x0;
  info->title = (char *)0x0;
  info->artist = (char *)0x0;
  info->label = (char *)0x0;
  info->notes = (char *)0x0;
  return;
}

/* ---- AudioMus_SetEntry__FP19AudioMus_tSongEntry  [@0x8007a308] ---- */
void AudioMus_SetEntry(AudioMus_tSongEntry *info)
{
  char cVar1;
  bool bVar2;
  int iVar3;
  char *pcVar4;

  pcVar4 = info->filename;
  iVar3 = 0;  /* FLOOR (w30-a7, 2026-07-26): 2-diff residual is a single `addu a1,zero,zero`
                 (iVar3=0) SCHEDULING position tie-break -- oracle hoists it here (right after
                 the a2 load, before the 4 field-zero stores); our cc1 defers it to right before
                 first use (after the beqz test, filling that branch's delay slot). Declaration-
                 order/statement-order edits don't move it (gcc reorders independent constant
                 loads by register pressure, not source position). One time-boxed permuter job
                 (-j 2, ~600 iters, stop-on-zero) plateaued at score 20, never reached 0 -- not a
                 quick permuter win either. Proven allocator/scheduler tie-break; not re-fighting. */
  info->artist = (char *)0x0;
  info->label = (char *)0x0;
  info->date = (char *)0x0;
  info->notes = (char *)0x0;
  cVar1 = *pcVar4;
  if (cVar1 != '\0') {   /* loop-rotated: oracle tests the FIRST char once up-front, then the */
    bVar2 = false;       /* back-edge test is the ONLY other '\0' check (matches the rotated */
    do {                 /* while-loop gcc emits for a plain `while` — see methodology §3.12#15a) */
      if (cVar1 == '-') {
        if (!bVar2) {
          bVar2 = true;
          iVar3 = 0;
        }
        else {
          info->artist = pcVar4 + 1;
          goto LAB_8007a37c;
        }
      }
      else if (iVar3 < 0x1f) {
        info->strbuf[iVar3] = cVar1;
        iVar3 = iVar3 + 1;
      }
      pcVar4 = pcVar4 + 1;
      cVar1 = *pcVar4;
    } while (cVar1 != '\0');
  }
LAB_8007a37c:
  info->strbuf[iVar3] = '\0';
  info->title = info->strbuf;
}

/* ---- AudioMus_SetCurrentSongInfo__Fv  [@0x8007a390] ---- */
void AudioMus_SetCurrentSongInfo(void)
{
  AudioMus_tSongEntry*info;
  AudioMus_tMusicGlobals *pAVar2;
  int iVar3;
  int iVar4;

  pAVar2 = AudioMus_g;
  iVar3 = (pAVar2->requeststatus).timetoend;
  iVar4 = (pAVar2->requeststatus).currenttime;
  info = &(pAVar2->current).info;
  (pAVar2->current).remaining = iVar3;
  info->length = iVar3 + iVar4;
  info->filename = pAVar2->songname;
  AudioMus_SetEntry(info);
  return;
}

/* ---- AudioMus_Server__Fii  [@0x8007a3d0] ---- */
int AudioMus_Server(int mode,int ticks)
{
  int *piVar1;
  AudioMus_tMusicGlobals *pAVar2;
  int iVar3;
  AudioMus_tMusicGlobals *pAVar4;
  int iVar5;
  void *pThis;
  int iVar6;
  int iVar7;
  
  if (AudioMus_g->bigfileheader != (char *)0x0) {
    if ((AudioMus_g->bigfilename[0] == '.') ||
       (iVar3 = CdDiskReady(1), pAVar4 = AudioMus_g, iVar3 != 0x10)) {
      if (AudioMus_g->errorcode == -2) {
        iVar3 = CdDiskReady(1);
        pAVar2 = AudioMus_g;
        if (iVar3 != 2) {
          return 0;
        }
        piVar1 = &AudioMus_g->requestsong;
        AudioMus_g->errorcode = -5;
        if (*piVar1 < 0) {
          return 0;
        }
        pAVar4 = (AudioMus_tMusicGlobals *)0x1;
        pAVar2->newswitch = 1;
        pAVar2->switchsong = 2;
      }
      else {
        AudioMus_RefreshStatus();
        iVar3 = AudioMus_Threshold();
        if ((iVar3 != 0) && (AudioMus_g->switchsong != 2)) {
          iVar3 = AudioMus_Buffered();
          if (iVar3 < 0x226) {
            AudioMus_Fail(-5);
          }
          else {
            iVar3 = AudioMus_Buffered();
            if (iVar3 < 0x5dc) {
              if (AudioMus_g->greedy == 0) {
                SNDSTRM_setgreedystate(AudioMus_g->streamhandle,1);
                AudioMus_g->greedy = 1;
              }
            }
            else {
              iVar3 = AudioMus_Buffered();
              if ((AudioMus_g->threshold <= iVar3) && (AudioMus_g->greedy != 0)) {
                SNDSTRM_setgreedystate(AudioMus_g->streamhandle,0);
                AudioMus_g->greedy = 0;
              }
            }
          }
        }
        pAVar4 = AudioMus_g;
        if (AudioMus_g->switchsong == 0) {
          if ((AudioMus_g->streamstatus).outstandingrequests != 0) {
            return 0;
          }
          iVar3 = AudioMus_g->requestsong;
          if (iVar3 < 0) {
            return 0;
          }
          iVar6 = AudioMus_g->availablesongs;
          if (1 < iVar6) {
            if (AudioMus_g->randomize == 0) {
              AudioMus_g->requestsong = (iVar3 + 1) % iVar6;
            }
            else {
              iVar7 = iVar6 + -1;
              iVar5 = GetRCnt(0);
              if (iVar5 < 1) {
                iVar5 = GetRCnt(0);
                iVar5 = -iVar5;
              }
              else {
                iVar5 = GetRCnt(0);
              }
              iVar3 = iVar3 + 1 + iVar5 % iVar7;
              pAVar4->requestsong = iVar3 % iVar6;
            }
          }
          SNDSTRM_vol(AudioMus_g->streamhandle,0);
          AudioMus_QueueRequestedSong();
          pAVar4 = AudioMus_g;
          AudioMus_g->newswitch = 1;
          pAVar4->firstswitch = 1;
          return 0;
        }
        if (AudioMus_g->switchsong == 2) {
          if (AudioMus_g->streambuffer == (char *)0x0) {
            AudioMus_Fail(-4);
            return 0;
          }
          if (AudioMus_g->streamhandle < 0) {
            AudioMus_Fail(-3);
            return 0;
          }
          if ((AudioMus_g->streamstatus).outstandingrequests == 0) {
            return 0;
          }
          if ((AudioMus_g->requeststatus).timebuffered <= AudioMus_g->threshold) {
            return 0;
          }
          if (AudioMus_g->errorcode == -5) {
            pThis = AudioMus_g->streamhandle;
            iVar3 = AudioMus_g->volume;
            AudioMus_g->errorcode = 0;
          }
          else {
            AudioMus_SetCurrentSongInfo();
            pThis = AudioMus_g->streamhandle;
            iVar3 = AudioMus_g->volume;
          }
          SNDSTRM_autovol(pThis,2000,iVar3);
          AudioMus_g->switchsong = 0;
          return 0;
        }
        iVar3 = (AudioMus_g->streamstatus).outstandingrequests;
        if ((iVar3 != 0) &&
           (SNDSTRM_getvol(AudioMus_g->streamhandle), iVar3 != 0)) {
          return 0;
        }
        if (-1 < AudioMus_g->streamhandle) {
          SNDSTRM_purge(AudioMus_g->streamhandle);
        }
        pAVar4 = AudioMus_g;
        piVar1 = &AudioMus_g->switchsong;
        AudioMus_g->songname = (char *)0x0;
        if (*piVar1 != 1) {
          pAVar4->switchsong = 0;
          return 0;
        }
        pAVar4->fadetime = 0;
        AudioMus_QueueRequestedSong();
        pAVar4 = AudioMus_g;
        AudioMus_g->switchsong = 2;
      }
      gettick();
      AudioMus_g->failby = (int)&pAVar4[1].current.info.date;
    }
    else if (AudioMus_g->errorcode == 0) {
      iVar3 = AudioMus_g->requestsong;
      AudioMus_g->errorcode = -2;
      pAVar4->newswitch = 1;
      if (-1 < iVar3) {
        iVar3 = AudioMus_Buffered();
        SNDSTRM_autovol(AudioMus_g->streamhandle,iVar3,0);
      }
    }
  }
  return 0;
}

/* ---- AudioMus_GetSongList__FPci  [@0x8007a880] ---- */
AudioMus_tSongList *
AudioMus_GetSongList(char *pattern,int memtype)
{
  AudioMus_tSongList*list;
  AudioMus_tSongEntry*song;
  int numsongs;
  int i;
  long size;
  char*songname;
  AudioMus_tMusicGlobals *pAVar1;
  u_char *pbVar2;
  int iVar3;
  AudioMus_tSongList *pAVar4;
  int iVar5;
  int iVar6;
  int *piVar7;
  AudioMus_tSongEntry *info;

  iVar6 = 0;
  if (AudioMus_g == (AudioMus_tMusicGlobals *)0x0) {
    pAVar4 = reservememadr("Song List",8,memtype);
    pAVar4->numsongs = 0;
    pAVar4->currentsong = -1;
  }
  else {
    iVar5 = 0;
    if (0 < AudioMus_g->totalsongs) {
      do {
        pbVar2 = locatebigentry(AudioMus_g->bigfileheader,(char *)0x0,iVar5,(long *)0x0,(long *)0x0);   /* oracle 0x6a8d8: a2=i a3=NULL stk=NULL */
        iVar3 = wildcard(pbVar2,pattern);
        if (iVar3 != 0) {
          iVar6 = iVar6 + 1;
        }
        iVar5 = iVar5 + 1;
      } while (iVar5 < AudioMus_g->totalsongs);
    }
    pAVar4 = reservememadr("Song List",iVar6 << 6 | 8,memtype);
    info = (AudioMus_tSongEntry *)(pAVar4 + 1);
    piVar7 = &pAVar4[4].currentsong;
    pAVar4->numsongs = 0;
    pAVar4->currentsong = -1;
    for (iVar6 = 0; iVar6 < AudioMus_g->totalsongs; iVar6 = iVar6 + 1) {
      pbVar2 = locatebigentry(AudioMus_g->bigfileheader,(char *)0x0,iVar6,(long *)0x0,&size);   /* oracle 0x6a974: a2=i a3=NULL stk=&size */
      iVar5 = wildcard(pbVar2,pattern);
      if (iVar5 != 0) {
        info->filename = (char *)pbVar2;
        AudioMus_SetEntry(info);
        *piVar7 = iVar6;
        pAVar1 = AudioMus_g;
        ((AudioMus_tSongList *)(piVar7 + -1))->numsongs = (size * 10) / 0xfc;   /* size from locatebigentry (was phantom local_28) */
        if (pbVar2 == (u_char *)pAVar1->songname) {
          pAVar4->currentsong = iVar6;
        }
        piVar7 = piVar7 + 0x10;
        info = info + 1;
        pAVar4->numsongs = pAVar4->numsongs + 1;
      }
    }
  }
  return pAVar4;
}

/* ---- AudioMus_InitGlobals__Fv  [@0x8007aa54] ---- */
void AudioMus_InitGlobals(void)
{
  AudioMus_tMusicGlobals *pAVar1;
  
  pAVar1 = AudioMus_g;
  AudioMus_g->bigfileheader = (char *)0x0;
  pAVar1->streambuffer = (char *)0x0;
  pAVar1->streamhandle = -1;
  pAVar1->serveractive = 0;
  pAVar1->driveractive = 0;
  pAVar1->totalsongs = 0;
  return;
}

/* ---- AudioMus_InitDriverGlobals__Fv  [@0x8007aa78] ---- */
void AudioMus_InitDriverGlobals(void)
{
  AudioMus_tSongEntry*info;
  AudioMus_tMusicGlobals *pAVar1;

  pAVar1 = AudioMus_g;
  AudioMus_g->requestsong = -1;
  pAVar1->volume = 0;
  pAVar1->fadetime = 0;
  pAVar1->availablesongs = 0;
  pAVar1->firstswitch = 0;
  pAVar1->newswitch = 0;
  pAVar1->songname = (char *)0x0;
  pAVar1->switchsong = 0;
  pAVar1->errorcode = 0;
  pAVar1->greedy = 0;
  (pAVar1->current).remaining = 0;
  info = &(pAVar1->current).info;
  info->length = 0;
  info->filename = (char *)0x0;
  info->title = (char *)0x0;
  info->artist = (char *)0x0;
  info->label = (char *)0x0;
  info->notes = (char *)0x0;
  pAVar1->driveractive = 1;
  return;
}

/* ---- AudioMus_DriverStartUp__Fii  [@0x8007aad4] ---- */
void AudioMus_DriverStartUp(int buffersize,int spusize)
{
  int chunks;
  int size;
  SNDLIMITS sndlimits;
  SNDPLAYOPTS opts;
  int *piVar1;
  AudioMus_tMusicGlobals *pAVar2;
  int aiStack_40 [4];
  int local_30;
  int aiStack_28 [2];
  u_char local_20;
  
  if (AudioMus_g != (AudioMus_tMusicGlobals *)0x0) {
    if (AudioMus_g->driveractive == 0) {
      AudioMus_InitDriverGlobals();
    }
    pAVar2 = AudioMus_g;
    piVar1 = &AudioMus_g->streamhandle;
    AudioMus_g->threshold = buffersize + spusize >> 5;
    if ((*piVar1 < 0) && (pAVar2->streambuffer != (char *)0x0)) {
      chunks = buffersize;
      if (buffersize < 0) {
        chunks = buffersize + 0x3ff;
      }
      chunks = chunks >> 10;
      SNDSTRM_overhead(0x1,chunks);
      size = buffersize + SNDgetlimits(aiStack_40);   /* oracle 0x6ab5c: size = buffersize + SNDgetlimits ret */
      local_30 = spusize;
      SNDsetlimits(aiStack_40);
      SNDplaysetdef(aiStack_28);
      local_20 = 0;
      pAVar2 = (AudioMus_tMusicGlobals *)
               SNDSTRM_create(aiStack_28,1,chunks,AudioMus_g->streambuffer,size);   /* oracle 0x6ab90: 5 real args, returns stream handle (was stubbed: 0 args + bogus pAVar2=AudioMus_g) */
      AudioMus_g->streamhandle = (int)pAVar2;
      if (-1 < (int)pAVar2) {
        SNDSTRM_setgreedylevel(pAVar2,0);
        SNDSTRM_setpriority(AudioMus_g->streamhandle,0xff,5);
      }
    }
    gMusicHandle = AudioMus_g->streamhandle;
    if (AudioMus_g->serveractive == 0) {
      addsystemtask(AudioMus_Server,(void *)0x19,(void *)0x0);
      AudioMus_g->serveractive = 1;
    }
  }
  return;
}

/* ---- AudioMus_SysStartUp__FiiPc  [@0x8007ac18] ---- */
void AudioMus_SysStartUp(int buffersize,int spusize,char *songs)
{
  char *pcVar1;
  int iVar2;
  
  if (AudioMus_g == (AudioMus_tMusicGlobals *)0x0) {
    AudioMus_g = reservememadr("Music Globals",0x158,0);
    if (AudioMus_g != (AudioMus_tMusicGlobals *)0x0) {
      AudioMus_InitGlobals();
      iVar2 = SNDSTRM_overhead(0x1,buffersize / 0x400);
      pcVar1 = reservememadr("Music Buffer",buffersize + iVar2,0);
      AudioMus_g->streambuffer = pcVar1;
      AudioMus_DriverStartUp(buffersize,spusize);
      sprintf(AudioMus_g->bigfilename,"%szzz%s.viv",Paths_Paths[27],songs);
      pcVar1 = (char *)loadbigfileheader(AudioMus_g->bigfilename,(void *)0x0)
      ;
      AudioMus_g->bigfileheader = pcVar1;
      if (pcVar1 != (char *)0x0) {
        iVar2 = bigcount(pcVar1);
        AudioMus_g->totalsongs = iVar2;
      }
    }
  }
  return;
}

/* ---- AudioMus_DriverCleanUp__Fv  [@0x8007ad10] ---- */
void AudioMus_DriverCleanUp(void)
{
  if (AudioMus_g != (AudioMus_tMusicGlobals *)0x0) {
    if (AudioMus_g->serveractive != 0) {
      delsystemtask((int)AudioMus_Server /* @0x8007a3d0 system-task callback */);
      AudioMus_g->serveractive = 0;
    }
    if (-1 < AudioMus_g->streamhandle) {
      SNDSTRM_destroy(AudioMus_g->streamhandle);
      AudioMus_g->streamhandle = -1;
    }
    AudioMus_g->driveractive = 0;
  }
  return;
}

/* ---- AudioMus_SysCleanUp__Fv  [@0x8007ad8c] ---- */
void AudioMus_SysCleanUp(void)
{
  if (AudioMus_g != (AudioMus_tMusicGlobals *)0x0) {
    AudioMus_DriverCleanUp();
    if (AudioMus_g->streambuffer != (char *)0x0) {
      purgememadr(AudioMus_g->streambuffer);
    }
    if (AudioMus_g->bigfileheader != (char *)0x0) {
      purgememadr(AudioMus_g->bigfileheader);
    }
    purgememadr(AudioMus_g);
    AudioMus_g = (AudioMus_tMusicGlobals *)0x0;
  }
  return;
}

/* ---- AudioMus_StopSong__Fi  [@0x8007ae04] ---- */
void AudioMus_StopSong(int fadeticks)
{
  AudioMus_tMusicGlobals *pAVar1;
  
  if ((AudioMus_g != (AudioMus_tMusicGlobals *)0x0) && (-1 < AudioMus_g->requestsong)) {
    if (fadeticks == 0) {
      if (-1 < AudioMus_g->streamhandle) {
        SNDSTRM_purge(AudioMus_g->streamhandle);
      }
      pAVar1 = AudioMus_g;
      AudioMus_g->fadetime = 0;
      pAVar1->songname = (char *)0x0;
      pAVar1->switchsong = 0;
    }
    else {
      if (AudioMus_g->switchsong == 0) {
        if (AudioMus_g->streamhandle >= 0) {
          SNDSTRM_autovol(AudioMus_g->streamhandle,fadeticks,0);
          AudioMus_g->fadetime = fadeticks;
        }
        else {
          AudioMus_g->fadetime = 0;
        }
        AudioMus_g->songname = (char *)0x0;
      }
      AudioMus_g->switchsong = -1;
    }
    AudioMus_g->requestsong = -1;
  }
  return;
}

/* ---- AudioMus_BuildPlayList__FiPi  [@0x8007aed8] ---- */
void AudioMus_BuildPlayList(int numplaylistsongs,int *playlist)
{
  int i;
  int iVar1;
  
  if (AudioMus_g != (AudioMus_tMusicGlobals *)0x0) {
    AudioMus_g->availablesongs = 0;
    iVar1 = 0;
    if (0 < numplaylistsongs) {
      do {
        if ((-1 < *playlist) && (*playlist < AudioMus_g->totalsongs)) {
          AudioMus_g->playlist[AudioMus_g->availablesongs] = (char)*playlist;
          AudioMus_g->availablesongs = AudioMus_g->availablesongs + 1;
        }
        iVar1 = iVar1 + 1;
        playlist = playlist + 1;
      } while (iVar1 < numplaylistsongs);
    }
  }
  return;
}

/* ---- AudioMus_BuildPattern__FPc  [@0x8007af60] ---- */
void AudioMus_BuildPattern(char *pattern)
{
  int i;
  int *piVar1;
  u_char *pattern_00;
  int iVar2;
  int iVar3;
  
  if (AudioMus_g != (AudioMus_tMusicGlobals *)0x0) {
    piVar1 = &AudioMus_g->totalsongs;
    iVar3 = 0;
    AudioMus_g->availablesongs = 0;
    if (0 < *piVar1) {
      do {
        if (0x1f < AudioMus_g->availablesongs) {
          return;
        }
        pattern_00 = locatebigentry(AudioMus_g->bigfileheader,(char *)0x0,iVar3,(long *)0x0,(long *)0x0);   /* oracle 0x6afb4: a2=i a3=NULL stk=NULL */
        iVar2 = wildcard(pattern_00,pattern);
        if (iVar2 != 0) {
          AudioMus_g->playlist[AudioMus_g->availablesongs] = (char)iVar3;
          AudioMus_g->availablesongs = AudioMus_g->availablesongs + 1;
        }
        iVar3 = iVar3 + 1;
      } while (iVar3 < AudioMus_g->totalsongs);
    }
  }
  return;
}

/* ---- AudioMus_PlaySong__FPc  [@0x8007b030] ---- */
int AudioMus_PlaySong(char *pattern)
{
  char title[128];
  int newsong;
  int *piVar1;
  AudioMus_tMusicGlobals *pAVar2;
  u_int uVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  char acStack_98 [128];
  
  if (AudioMus_g == (AudioMus_tMusicGlobals *)0x0) {
    iVar4 = 0;
  }
  else {
    if (((pattern != (char *)0x0) &&
        (AudioMus_BuildPattern(pattern), AudioMus_g->availablesongs == 0)) &&
       (uVar3 = strlen(pattern), uVar3 < 0x3d)) {
      sprintf(acStack_98,"*-%s",pattern);
      AudioMus_BuildPattern(acStack_98);
    }
    pAVar2 = AudioMus_g;
    iVar4 = 0;
    if (AudioMus_g->volume != 0) {
      iVar4 = AudioMus_g->availablesongs;
      if (iVar4 != 0) {
        AudioMus_g->randomize = 1;
        if (iVar4 == 1) {
          iVar6 = 0;
        }
        else if (pattern == (char *)0x0) {
          iVar5 = pAVar2->requestsong;
          iVar7 = iVar4 + -1;
          iVar6 = GetRCnt(0);
          if (iVar6 < 1) {
            iVar6 = GetRCnt(0);
            iVar6 = -iVar6;
          }
          else {
            iVar6 = GetRCnt(0);
          }
          iVar5 = iVar5 + 1 + iVar6 % iVar7;
          iVar6 = iVar5 % iVar4;
        }
        else {
          iVar5 = GetRCnt(0);
          if (iVar5 < 1) {
            iVar5 = GetRCnt(0);
            iVar5 = -iVar5;
          }
          else {
            iVar5 = GetRCnt(0);
          }
          iVar6 = iVar5 % iVar4;
        }
        pAVar2 = AudioMus_g;
        if (AudioMus_g->switchsong == 0) {
          if (AudioMus_g->requestsong < 0) {
            piVar1 = &AudioMus_g->streamhandle;
            AudioMus_g->fadetime = 0;
            SNDSTRM_vol(*piVar1,0);
            AudioMus_g->requestsong = iVar6;
            AudioMus_QueueRequestedSong();
          }
          else {
            SNDSTRM_autovol(AudioMus_g->streamhandle,2000,0);
            pAVar2 = AudioMus_g;
            AudioMus_g->fadetime = 2000;
            pAVar2->switchsong = 1;
            pAVar2->requestsong = iVar6;
            pAVar2->songname = (char *)0x0;
          }
        }
        else {
          AudioMus_g->switchsong = 1;
          pAVar2->requestsong = iVar6;
        }
        pAVar2 = AudioMus_g;
        AudioMus_g->firstswitch = 1;
        pAVar2->errorcode = 0;
        if (pattern != (char *)0x0) {
          pAVar2->newswitch = 1;
        }
      }
      iVar4 = AudioMus_g->availablesongs;
    }
  }
  return iVar4;
}

/* ---- AudioMus_Volume__Fi  [@0x8007b2b0] ---- */
void AudioMus_Volume(int volume)
{
  int ticksleft;
  int curvol;
  int iVar1;
  int iVar2;
  int s;

  if ((AudioMus_g != (AudioMus_tMusicGlobals *)0x0) && (AudioMus_g->volume != volume)) {
    s = 0;
    if (volume == 0) {
      AudioMus_g->volume = 0;
      AudioMus_StopSong(0);
    }
    else {
      iVar1 = AudioMus_g->fadetime;
      if ((((iVar1 != 0) && (-1 < AudioMus_g->streamhandle)) &&
          (SNDSTRM_getvol(AudioMus_g->streamhandle), 0 < iVar1)) &&
         (iVar2 = AudioMus_g->volume, 0 < iVar2)) {
        iVar1 = AudioMus_g->fadetime * iVar1;
        s = iVar1 / iVar2;
      }
      if (s == 0) {
        if ((-1 < AudioMus_g->streamhandle) && (AudioMus_g->switchsong != 2)) {
          SNDSTRM_vol(AudioMus_g->streamhandle,volume);
        }
      }
      else {
        iVar1 = AudioMus_g->fadetime;
        SNDSTRM_vol(AudioMus_g->streamhandle,(volume * s) / iVar1);
        SNDSTRM_autovol(AudioMus_g->streamhandle,s,0);
      }
      if (AudioMus_g->volume == 0) {
        AudioMus_g->volume = volume;
        AudioMus_PlaySong((char *)0x0);
      }
      else {
        AudioMus_g->volume = volume;
      }
    }
  }
  return;
}

/* ---- AudioMus_AutoVolume__Fii  [@0x8007b46c] ---- */
void AudioMus_AutoVolume(int fadeticks,int volume)
{
  if ((AudioMus_g != (AudioMus_tMusicGlobals *)0x0) && (AudioMus_g->volume != volume)) {
    if (volume == 0) {
      AudioMus_g->volume = 0;
      AudioMus_StopSong(0);
    }
    else {
      if (AudioMus_g->volume == 0) {
        AudioMus_g->volume = volume;
        AudioMus_PlaySong((char *)0x0);
      }
      else {
        AudioMus_g->volume = volume;
      }
      if (((AudioMus_g->switchsong != 2) && (AudioMus_g->fadetime == 0)) &&
         (-1 < AudioMus_g->streamhandle)) {
        SNDSTRM_autovol(AudioMus_g->streamhandle,fadeticks,volume);
      }
    }
  }
  return;
}
