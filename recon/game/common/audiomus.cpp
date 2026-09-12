/* game/common/audiomus.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "audiomus_types.h"
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

/* ---- AudioMus_Threshold__Fv  [@0x80079f58] ----
 * P901: native SYM has no locals or source labels. Separate early-return
 * statements reproduce its SLD148..159 partition and single empty scope,
 * without the unrecorded music pointer or reconstructed goto labels.
 * Combining the final guards changes return branches (4 diffs); combining
 * only the first two guards preserves code but merges16 native line pairs.
 * This form preserves all33 words and every branch target. */
int AudioMus_Threshold(void)
{
  if (AudioMus_g == 0)
    return 0;
  if (AudioMus_g->bigfileheader == 0)
    return 0;
  if (AudioMus_g->errorcode != 0)
    return 0;
  if (AudioMus_g->switchsong == 2)
    return AudioMus_g->threshold;
  if (AudioMus_g->streamstatus.outstandingrequests == 0)
    return 0;
  if (AudioMus_g->requeststatus.timetoend <= AudioMus_g->requeststatus.timebuffered)
    return 0;
  return AudioMus_g->threshold;
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
  /* MATCH (W85-S2, device removal x2) -- THE `? :` MUST BE SPELLED AS A STATEMENT
     `if / else`, AND THAT ONE CHANGE RETIRES BOTH DEVICES THIS FUNCTION CARRIED:
       (a) a `volatile`-view read of the AudioMus_g pointer at the switch
           (`(*(AudioMus_tMusicGlobals *volatile *)&AudioMus_g)->errorcode`), and
       (b) a w54-a11 identity launder `__asm__("" : "=r"(curr) : "0"(curr))`.
     MECHANISM: gcc-2.8's cse works per BASIC BLOCK.  Retail re-issues the gp-rel
     `lw AudioMus_g` after the index store (oracle 8007A06C) because that store sits
     at a JOIN, so the cached load is not available to the following block.  A COND_EXPR
     is expanded and re-merged early enough that our build kept ONE live pseudo for
     `AudioMus_g` across the whole body (45 insns, 2 short, and an a0/v1 swap on every
     row); the if/else STATEMENT reproduces retail's block split, the re-load, and the
     a0=curr / v1=g register split -- and with the shape right, `curr + 12` stays
     curr-based on its own, so the launder is no longer needed either.
     MEASURED: volatile dropped alone 26 @45/47; volatile dropped + `curr` spelled
     through a `char *` cast 26 @45/47; if/else + volatile dropped PASS 47/47;
     if/else + volatile AND launder dropped PASS 47/47 (landed); the same with
     `info` re-spelled as a char*-bump also PASS (so `info = &curr->info` is free). */
  if (AudioMus_g->errorcode == 0) {
    curr->index = AudioMus_g->requestsong + 1;
  }
  else {
    curr->index = AudioMus_g->errorcode;
  }
  info = &curr->info;
  switch (AudioMus_g->errorcode) {
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
  AudioMus_g->errorcode = errorcode;
  if (AudioMus_g->streamstatus.outstandingrequests != 0) {
    SNDSTRM_autovol(AudioMus_g->streamhandle,AudioMus_Buffered(),0);
    AudioMus_g->fadetime = AudioMus_Buffered();
  }
  AudioMus_g->newswitch = 1;
  AudioMus_g->firstswitch = 0;
  AudioMus_g->songname = (char *)0x0;
  AudioMus_g->switchsong = -1;
  AudioMus_g->requestsong = -1;
  return;
}

/* ---- AudioMus_QueueRequestedSong__Fv  [@0x8007a258] ---- */
void AudioMus_QueueRequestedSong(void)
{
  long offset;
  AudioMus_tSongEntry *info;
  
  AudioMus_g->songname = locatebigentry(AudioMus_g->bigfileheader,(char *)0x0,
                                        (u_char)AudioMus_g->playlist[AudioMus_g->requestsong],
                                        &offset,(long *)0x0);   /* oracle 0x6a280: a2=playlist[requestsong] a3=&offset stk=NULL */
  if (-1 < AudioMus_g->streamhandle) {
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
  AudioMus_g->failby = gettick() + 0x280;
  info = &AudioMus_g->current.info;   /* w30-a7: cached sub-field pointer -- oracle computes &current.info
                                      once (independent of remaining/length, scheduler hoists it early)
                                      and reuses it for every song-info field. */
  AudioMus_g->current.remaining = 0;
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
  int titlechar;
  int havefile;
  char *p;

  /* Retail SYM names exactly `titlechar` ($a1), `havefile` ($a3), and the
   * nested-block `p` ($a2).  SLD lines 351/354 prove that titlechar is the
   * buffer index initialized before the filename loop, while repeated `*p`
   * reads supply the unnamed compiler temporary in $v1.  This natural while
   * form preserves retail's rotated loop and removes the former synthetic
   * iVar3 source object. */
  info->artist = (char *)0x0;
  info->label = (char *)0x0;
  info->date = (char *)0x0;
  info->notes = (char *)0x0;
  titlechar = 0;
  havefile = false;
  p = info->filename;
  while (*p != '\0') {
    if (*p == '-') {
      if (!havefile) {
        havefile = true;
        titlechar = 0;
      }
      else {
        info->artist = p + 1;
        break;
      }
    }
    else if (titlechar < 0x1f) {
      info->strbuf[titlechar] = *p;
      titlechar = titlechar + 1;
    }
    p = p + 1;
  }
  info->strbuf[titlechar] = '\0';
  info->title = info->strbuf;
}

/* ---- AudioMus_SetCurrentSongInfo__Fv  [@0x8007a390] ---- */
void AudioMus_SetCurrentSongInfo(void)
{
  AudioMus_tSongEntry *info;

  info = &AudioMus_g->current.info;
  info->length =
      (AudioMus_g->current.remaining =
       AudioMus_g->requeststatus.timetoend) +
      AudioMus_g->requeststatus.currenttime;
  info->filename = AudioMus_g->songname;
  AudioMus_SetEntry(info);
  return;
}

/* ---- AudioMus_Server__Fii  [@0x8007a3d0] ---- */
/* MATCH: PASS 300/300.  SLD maps the complete random-song calculation at
 * 0x8007A760..0x8007A7F8 to one source line.  Keeping the repeated GetRCnt(0)
 * ternary directly inside that modulo assignment recreates retail's three
 * distinct local-allocation webs: counter in v0, first remainder/sum in v1,
 * and final remainder in v0. */
int AudioMus_Server(int mode,int ticks)
{
  /* P902: native SYM has no ordinary locals. Removing randomRange and
   * randomMusic TOGETHER recovers the single native random-song expression
   * with identical code; their former isolated four-diff failures did not
   * prove separate source objects were required. Structured conditionals
   * also remove five reconstruction labels; native SLD39/170 becomes39/29.
   * The positive default-state guard also removes switchMode: it preserves
   * the CSE path carrying the anonymous constant2 in s0 across the queue call.
   * The literal/ordinary-switch form alone was300words/16diffs. No ordinary
   * local remains. The existing done label and residual SLD groups still need
   * source recovery; no new alias or codegen device is introduced. */

  if (AudioMus_g->bigfileheader == (char *)0x0) goto done;
  if ((AudioMus_g->bigfilename[0] != '.') && (CdDiskReady(1) == 0x10)) {
    if (AudioMus_g->errorcode != 0) return 0;
    AudioMus_g->errorcode = -2;
    AudioMus_g->newswitch = 1;
    if (AudioMus_g->requestsong < 0) goto done;
    SNDSTRM_autovol(AudioMus_g->streamhandle,AudioMus_Buffered(),0);
    return 0;
  }

  if (AudioMus_g->errorcode == -2) {
    if (CdDiskReady(1) != 2) return 0;
    AudioMus_g->errorcode = -5;
    if (AudioMus_g->requestsong < 0) goto done;
    AudioMus_g->newswitch = 1;
    AudioMus_g->switchsong = 2;
    AudioMus_g->failby = gettick() + 0x280;
    goto done;
  }

  AudioMus_RefreshStatus();
  if ((AudioMus_Threshold() != 0) && (AudioMus_g->switchsong != 2)) {
    if (AudioMus_Buffered() < 0x226) {
      AudioMus_Fail(-5);
    } else if (AudioMus_Buffered() < 0x5dc) {
      if (AudioMus_g->greedy == 0) {
        SNDSTRM_setgreedystate(AudioMus_g->streamhandle,1);
        AudioMus_g->greedy = 1;
      }
    } else {
      if ((AudioMus_Buffered() >= AudioMus_g->threshold) &&
          (AudioMus_g->greedy != 0)) {
        SNDSTRM_setgreedystate(AudioMus_g->streamhandle,0);
        AudioMus_g->greedy = 0;
      }
    }
  }

  if (AudioMus_g->switchsong != 0) {
    if (AudioMus_g->switchsong == 2) {
      if (AudioMus_g->streambuffer == (char *)0x0) {
        AudioMus_Fail(-4);
        return 0;
      }
      if (AudioMus_g->streamhandle < 0) {
        AudioMus_Fail(-3);
        return 0;
      }
      if (AudioMus_g->streamstatus.outstandingrequests == 0) return 0;
      if (AudioMus_g->requeststatus.timebuffered <= AudioMus_g->threshold) goto done;
      if (AudioMus_g->errorcode == -5) {
        AudioMus_g->errorcode = 0;
        SNDSTRM_autovol(AudioMus_g->streamhandle,2000,AudioMus_g->volume);
      } else {
        AudioMus_SetCurrentSongInfo();
        SNDSTRM_autovol(AudioMus_g->streamhandle,2000,AudioMus_g->volume);
      }
      AudioMus_g->switchsong = 0;
    } else if ((AudioMus_g->streamstatus.outstandingrequests == 0) ||
               (SNDSTRM_getvol(AudioMus_g->streamhandle) == 0)) {
      if (AudioMus_g->streamhandle >= 0) {
        SNDSTRM_purge(AudioMus_g->streamhandle);
      }
      AudioMus_g->songname = (char *)0x0;
      if (AudioMus_g->switchsong == 1) {
        AudioMus_g->fadetime = 0;
        AudioMus_QueueRequestedSong();
        AudioMus_g->switchsong = 2;

        AudioMus_g->failby = gettick() + 0x280;
      } else {
        AudioMus_g->switchsong = 0;
      }
    }
  } else {
    if ((AudioMus_g->streamstatus.outstandingrequests != 0) ||
        (AudioMus_g->requestsong < 0)) return 0;
    if (AudioMus_g->availablesongs > 1) {
      if (AudioMus_g->randomize != 0) {
        AudioMus_g->requestsong =
            (AudioMus_g->requestsong + 1 +
            (GetRCnt(0) > 0 ? GetRCnt(0) : -GetRCnt(0)) % (AudioMus_g->availablesongs - 1)) %
            AudioMus_g->availablesongs;
      } else {
        AudioMus_g->requestsong =
            (AudioMus_g->requestsong + 1) % AudioMus_g->availablesongs;
      }
    }
    SNDSTRM_vol(AudioMus_g->streamhandle,0);
    AudioMus_QueueRequestedSong();
    AudioMus_g->newswitch = 1;
    AudioMus_g->firstswitch = 1;
  }

done:
  return 0;
}

/* ---- AudioMus_GetSongList__FPci  [@0x8007a880] ---- */
/* SYM rule-8 REWRITE (w54-a11).  SYM local map: list = REG $17 (s1), song = REG $20 (s4),
   numsongs = REG $17 (s1, same reg -- its live range ends where list's begins), the two
   loop counters are SEPARATE block-scope `i`s in DIFFERENT regs (s0 for the counting
   loop, s2 for the fill loop -- s2 = memtype's reg, reused after memtype dies), size =
   AUTO -0x28, songname = REG $16 (s0).  Everything else in the old recon (pAVar1/pbVar2/
   iVar3/pAVar4/iVar5/iVar6/piVar7/info) was fabricated.  Two structural corrections the
   SLD forces: (a) the AudioMus_g==NULL arm is the OUT-OF-LINE arm (SLD 589-593, at the
   very END of the function) -- so the test is `if (g != NULL) {...} else {...}`, not the
   inverted form the old recon used; (b) the counting loop's induction variable starts
   from numsongs (retail CSEs the shared 0: `addu s0,s1,zero` in the guard's delay slot). */
AudioMus_tSongList *
AudioMus_GetSongList(char *pattern,int memtype)
{
  AudioMus_tSongList*list;
  AudioMus_tSongEntry*song;
  int numsongs;

  numsongs = 0;
  if (AudioMus_g != (AudioMus_tMusicGlobals *)0x0) {
    {
      int i;

      for (i = numsongs; i < AudioMus_g->totalsongs; i = i + 1) {
        if (wildcard(locatebigentry(AudioMus_g->bigfileheader,(char *)0x0,i,(long *)0x0,(long *)0x0),
                     pattern) != 0) {
          numsongs = numsongs + 1;
        }
      }
    }
    list = reservememadr("Song List",numsongs << 6 | 8,memtype);
    song = list->song;
    list->numsongs = 0;
    list->currentsong = -1;
    {
      int i;

      for (i = 0; i < AudioMus_g->totalsongs; i = i + 1) {
        long size;
        char *songname;

        songname = (char *)locatebigentry(AudioMus_g->bigfileheader,(char *)0x0,i,(long *)0x0,&size);
        if (wildcard((u_char *)songname,pattern) != 0) {
          song->filename = songname;
          AudioMus_SetEntry(song);
          song->length = (size * 10) / 0xfc;
          song->index = i;
          if (songname == AudioMus_g->songname) {
            list->currentsong = i;
          }
          song = song + 1;
          list->numsongs = list->numsongs + 1;
        }
      }
    }
  }
  else {
    list = reservememadr("Song List",8,memtype);
    list->numsongs = 0;
    list->currentsong = -1;
  }
  return list;
}

/* ---- AudioMus_InitGlobals__Fv  [@0x8007aa54] ---- */
void AudioMus_InitGlobals(void)
{
  AudioMus_g->bigfileheader = (char *)0x0;
  AudioMus_g->streambuffer = (char *)0x0;
  AudioMus_g->streamhandle = -1;
  AudioMus_g->serveractive = 0;
  AudioMus_g->driveractive = 0;
  AudioMus_g->totalsongs = 0;
  return;
}

/* ---- AudioMus_InitDriverGlobals__Fv  [@0x8007aa78] ---- */
void AudioMus_InitDriverGlobals(void)
{
  AudioMus_tSongEntry*info;
  AudioMus_g->requestsong = -1;
  AudioMus_g->volume = 0;
  AudioMus_g->fadetime = 0;
  AudioMus_g->availablesongs = 0;
  AudioMus_g->firstswitch = 0;
  AudioMus_g->newswitch = 0;
  AudioMus_g->songname = (char *)0x0;
  AudioMus_g->switchsong = 0;
  AudioMus_g->errorcode = 0;
  AudioMus_g->greedy = 0;
  (AudioMus_g->current).remaining = 0;
  info = &(AudioMus_g->current).info;
  info->length = 0;
  info->filename = (char *)0x0;
  info->title = (char *)0x0;
  info->artist = (char *)0x0;
  info->label = (char *)0x0;
  info->notes = (char *)0x0;
  AudioMus_g->driveractive = 1;
  return;
}

/* ---- AudioMus_DriverStartUp__Fii  [@0x8007aad4] ---- */
void AudioMus_DriverStartUp(int buffersize,int spusize)
{
  int chunks;
  int size;
  SNDLIMITS sndlimits;
  SNDPLAYOPTS opts;
  
  if (AudioMus_g != (AudioMus_tMusicGlobals *)0x0) {
    if (AudioMus_g->driveractive == 0) {
      AudioMus_InitDriverGlobals();
    }
    AudioMus_g->threshold = buffersize + spusize >> 5;
    if ((AudioMus_g->streamhandle < 0) && (AudioMus_g->streambuffer != (char *)0x0)) {
      chunks = buffersize / 0x400;
      size = buffersize + SNDSTRM_overhead(1,chunks);
      SNDgetlimits(&sndlimits);
      sndlimits.packetbufsize = spusize;
      SNDsetlimits(&sndlimits);
      SNDplaysetdef(&opts);
      opts.vol = 0;
      AudioMus_g->streamhandle =
          SNDSTRM_create((int *)&opts,1,chunks,AudioMus_g->streambuffer,size);
      if (-1 < AudioMus_g->streamhandle) {
        SNDSTRM_setgreedylevel(AudioMus_g->streamhandle,0);
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
  if (AudioMus_g == (AudioMus_tMusicGlobals *)0x0) {
    AudioMus_g = reservememadr("Music Globals",0x158,0);
    if (AudioMus_g != (AudioMus_tMusicGlobals *)0x0) {
      AudioMus_InitGlobals();
      AudioMus_g->streambuffer =
          reservememadr("Music Buffer",
                        buffersize + SNDSTRM_overhead(0x1,buffersize / 0x400),0);
      AudioMus_DriverStartUp(buffersize,spusize);
      sprintf(AudioMus_g->bigfilename,"%szzz%s.viv",Paths_Paths[27],songs);
      AudioMus_g->bigfileheader =
          (char *)loadbigfileheader(AudioMus_g->bigfilename,(void *)0x0);
      if (AudioMus_g->bigfileheader != (char *)0x0) {
        AudioMus_g->totalsongs = bigcount(AudioMus_g->bigfileheader);
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
  if ((AudioMus_g != (AudioMus_tMusicGlobals *)0x0) && (-1 < AudioMus_g->requestsong)) {
    if (fadeticks == 0) {
      if (-1 < AudioMus_g->streamhandle) {
        SNDSTRM_purge(AudioMus_g->streamhandle);
      }
      AudioMus_g->fadetime = 0;
      AudioMus_g->songname = (char *)0x0;
      AudioMus_g->switchsong = 0;
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
  
  if (AudioMus_g != (AudioMus_tMusicGlobals *)0x0) {
    AudioMus_g->availablesongs = 0;
    i = 0;
    if (0 < numplaylistsongs) {
      do {
        if ((-1 < *playlist) && (*playlist < AudioMus_g->totalsongs)) {
          AudioMus_g->playlist[AudioMus_g->availablesongs] = (char)*playlist;
          AudioMus_g->availablesongs = AudioMus_g->availablesongs + 1;
        }
        i = i + 1;
        playlist = playlist + 1;
      } while (i < numplaylistsongs);
    }
  }
  return;
}

/* ---- AudioMus_BuildPattern__FPc  [@0x8007af60] ---- */
void AudioMus_BuildPattern(char *pattern)
{
  int i;
  
  if (AudioMus_g != (AudioMus_tMusicGlobals *)0x0) {
    i = 0;
    AudioMus_g->availablesongs = 0;
    if (0 < AudioMus_g->totalsongs) {
      do {
        if (0x1f < AudioMus_g->availablesongs) {
          return;
        }
        if (wildcard(locatebigentry(AudioMus_g->bigfileheader,(char *)0x0,i,
                                    (long *)0x0,(long *)0x0),pattern) != 0) {
          AudioMus_g->playlist[AudioMus_g->availablesongs] = (char)i;
          AudioMus_g->availablesongs = AudioMus_g->availablesongs + 1;
        }
        i = i + 1;
      } while (i < AudioMus_g->totalsongs);
    }
  }
  return;
}

/* ---- AudioMus_PlaySong__FPc  [@0x8007b030] ---- */
/* P903: only native pattern/title/newsong remain; all nine native scopes and
 * SLD statement groups match. Initialize newsong after randomize and use the
 * actual availablesongs field as the pattern-arm divisor to retain the single
 * modulo join without a pick local or fence. Repeated GetRCnt calls are real.
 * Direct divisor-newsong form is 171 words/15 diffs; the paired form is160/PASS.
 * Original macro/token spellings are not uniquely established by these checks. */
int AudioMus_PlaySong(char *pattern)
{
  if (AudioMus_g != (AudioMus_tMusicGlobals *)0x0) {
    if (pattern != (char *)0x0) {
      AudioMus_BuildPattern(pattern);
      if ((AudioMus_g->availablesongs == 0) && (strlen(pattern) < 0x3d)) {
        char title[128];
        sprintf(title,"*-%s",pattern);
        AudioMus_BuildPattern(title);
      }
    }

    if (AudioMus_g->volume == 0)
      return 0;
    if (AudioMus_g->availablesongs != 0) {
      AudioMus_g->randomize = 1;
      int newsong = AudioMus_g->availablesongs;
      if (newsong == 1) {
        newsong = 0;
      }
      else if (pattern != (char *)0x0) {
        newsong = (GetRCnt(0) > 0 ? GetRCnt(0) : -GetRCnt(0)) % AudioMus_g->availablesongs;
      }
      else {
        newsong = (AudioMus_g->requestsong + 1 +
                    ((GetRCnt(0) > 0 ? GetRCnt(0) : -GetRCnt(0)) %
                     (newsong - 1))) % newsong;
      }

      if (AudioMus_g->switchsong != 0) {
        AudioMus_g->switchsong = 1;
        AudioMus_g->requestsong = newsong;
      }
      else if (AudioMus_g->requestsong >= 0) {
        SNDSTRM_autovol(AudioMus_g->streamhandle,2000,0);
        AudioMus_g->fadetime = 2000;
        AudioMus_g->switchsong = 1;
        AudioMus_g->requestsong = newsong;
        AudioMus_g->songname = (char *)0x0;
      }
      else {
        AudioMus_g->fadetime = 0;
        SNDSTRM_vol(AudioMus_g->streamhandle,0);
        AudioMus_g->requestsong = newsong;
        AudioMus_QueueRequestedSong();
      }

      AudioMus_g->firstswitch = 1;
      AudioMus_g->errorcode = 0;
      if (pattern != (char *)0x0) {
        AudioMus_g->newswitch = 1;
      }
    }
    return AudioMus_g->availablesongs;
  }
  else {
    return 0;
  }
}

/* ---- AudioMus_Volume__Fi  [@0x8007b2b0] ---- */
/* SYM rule-8 REWRITE (w54-a11): the SYM says this fn has exactly TWO named locals --
   ticksleft (REG $16 = s0) and curvol (REG $4 = a0, declared in a block whose code
   starts at 0x8007b318 = the SNDSTRM_getvol call).  The old recon had five fabricated
   temps, DISCARDED SNDSTRM_getvol's return (retail tests it: `blez a0` at 0x8007b324),
   passed a literal 0 to StopSong where retail passes ticksleft (`addu a0,s0,zero` in
   the jal's delay slot), and had the two fade arms in the WRONG ORDER (retail's SLD
   runs 984 ticksleft!=0 as the FALL-THROUGH, 989 as the out-of-line arm). */
void AudioMus_Volume(int volume)
{
  if ((AudioMus_g != (AudioMus_tMusicGlobals *)0x0) && (AudioMus_g->volume != volume)) {
    int ticksleft = 0;

    if (volume == 0) {
      AudioMus_g->volume = 0;
      AudioMus_StopSong(ticksleft);
    }
    else {
      if ((AudioMus_g->fadetime != 0) && (-1 < AudioMus_g->streamhandle)) {
        int curvol = SNDSTRM_getvol(AudioMus_g->streamhandle);

        if ((0 < curvol) && (0 < AudioMus_g->volume)) {
          ticksleft = AudioMus_g->fadetime * curvol / AudioMus_g->volume;
        }
      }
      if (ticksleft != 0) {
        SNDSTRM_vol(AudioMus_g->streamhandle,(volume * ticksleft) / AudioMus_g->fadetime);
        SNDSTRM_autovol(AudioMus_g->streamhandle,ticksleft,0);
      }
      else {
        if ((-1 < AudioMus_g->streamhandle) && (AudioMus_g->switchsong != 2)) {
          SNDSTRM_vol(AudioMus_g->streamhandle,volume);
        }
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
