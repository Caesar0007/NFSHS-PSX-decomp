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
  /* MATCH (w54-a11) -- CSE RE-ASSOCIATION LAUNDER (zero insns, 47/47 byte-exact).
     Retail forms &curr->info as an IN-PLACE bump of the now-dead curr register,
     `addiu a0,a0,12`, and reorg then takes THAT insn for the first beq's delay slot
     (SLD line 211 owns it).  Ours instead re-associated `curr + 12` through curr's
     cse equivalence `AudioMus_g + 268` into `addiu a0,v1,280`; because that form
     READS v1, it carries an anti-dependence against the `lw v1,32(v0)` errorcode
     load, so sched2 is forced to hoist it above the gp reload -- where it lands in
     that load's delay slot, leaving reorg to steal the case's `lui` instead (the
     ours-1-shorter cascade).  The empty asm with a tied in/out operand makes curr's
     value OPAQUE to cse without naming a register, emitting nothing, so `curr + 12`
     stays curr-based.  NOT a register pin (no asm("$N") anywhere) -- same family as
     the 05C operand fence, one step stronger.
     FALSIFIED pure-C alternatives (all re-measured this session, do not retry):
       curr->info.title = ... (no info local)        26 diffs
       curr->info.title = ... (info decl kept)       26 diffs
       info = (AudioMus_tSongEntry*)((char*)curr+12)  5 diffs (folds identically)
       info = (AudioMus_tSongEntry*)(curr + 1)        5 diffs
       info assigned inside each case arm            26 diffs
       curr = (AudioMus_tCurrentSong*)info; then cast 5 diffs
       plain operand fence on curr / on info      5 / 4 diffs (position only) */
  __asm__("" : "=r"(curr) : "0"(curr));
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

  /* MATCH (w54-a11) -- SEALED; retires the w30-a7 "proven scheduler floor" receipt.
   * Two edits, both read straight off retail's SLD (LAW 05A):
   *  (1) STATEMENT ORDER.  SLD: 346 artist=0 · 347 label=0 · 348 date=0 · 349 notes=0 ·
   *      351 iVar3=0 (an explicit `Set SLD linenum to 351` record at 0x8007a30c -- i.e.
   *      a SCHEDULER-MOVED insn, its own statement) · 354 owns the filename load AND the
   *      loop guard.  So the four zero-stores come first and the filename load belongs
   *      to the loop statement (the lw only LOOKS leading because sched hoists it for
   *      load latency).
   *  (2) REORG DELAY-SLOT COMPETITION (the actual crack).  bVar2's init must live
   *      OUTSIDE the rotated `if`, in the loop PREHEADER.  With it inside, the only
   *      fill candidate for the `beqz` slot is `addu a1,zero,zero` (iVar3=0), so reorg
   *      sinks it there and the a1 init never reaches its scheduled slot 1.  Hoisted
   *      out, `addu a3,a1,zero` becomes the nearest independent insn before the branch,
   *      reorg takes THAT (= retail's slot), and a1=0 stays at slot 1.  Zero insn cost.
   * Generalization: an "unmovable constant in the delay slot" is a reorg CANDIDATE-SET
   * problem, not a scheduler floor -- give reorg a better candidate. */
  info->artist = (char *)0x0;
  info->label = (char *)0x0;
  info->date = (char *)0x0;
  info->notes = (char *)0x0;
  iVar3 = 0;
  bVar2 = false;
  pcVar4 = info->filename;
  cVar1 = *pcVar4;
  if (cVar1 != '\0') {   /* loop-rotated: oracle tests the FIRST char once up-front, then the */
                         /* back-edge test is the ONLY other '\0' check (matches the rotated */
    do {               /* while-loop gcc emits for a plain `while` — see methodology §3.12#15a) */
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
/* MATCH: PASS 300/300.  SLD maps the complete random-song calculation at
 * 0x8007A760..0x8007A7F8 to one source line.  Keeping the repeated GetRCnt(0)
 * ternary directly inside that modulo assignment recreates retail's three
 * distinct local-allocation webs: counter in v0, first remainder/sum in v1,
 * and final remainder in v0. */
int AudioMus_Server(int mode,int ticks)
{
  int buffered;
  int availableSongs;
  int randomRange;
  int randomValue;
  int diskSong;
  int diskReady;
  int requestedSong;
  int switchMode;
  AudioMus_tMusicGlobals *randomMusic;

  if (AudioMus_g->bigfileheader == (char *)0x0) goto done;
  if (AudioMus_g->bigfilename[0] == '.') goto normal_server;
  if (CdDiskReady(1) != 0x10) goto normal_server;

  if (AudioMus_g->errorcode != 0) return 0;
  diskSong = AudioMus_g->requestsong;
  AudioMus_g->errorcode = -2;
  AudioMus_g->newswitch = 1;
  if (diskSong < 0) goto done;
  buffered = AudioMus_Buffered();
  SNDSTRM_autovol(AudioMus_g->streamhandle,buffered,0);
  return 0;

normal_server:
  if (AudioMus_g->errorcode == -2) {
    diskReady = CdDiskReady(1);
    if (diskReady != 2) return 0;
    AudioMus_g->errorcode = -5;
    if (AudioMus_g->requestsong < 0) goto done;
    AudioMus_g->newswitch = 1;
    AudioMus_g->switchsong = diskReady;
    goto update_failby;
  }

  AudioMus_RefreshStatus();
  if ((AudioMus_Threshold() != 0) && (AudioMus_g->switchsong != 2)) {
    buffered = AudioMus_Buffered();
    if (buffered < 0x226) {
      AudioMus_Fail(-5);
    } else if (AudioMus_Buffered() < 0x5dc) {
      if (AudioMus_g->greedy == 0) {
        SNDSTRM_setgreedystate(AudioMus_g->streamhandle,1);
        AudioMus_g->greedy = 1;
      }
    } else {
      buffered = AudioMus_Buffered();
      if ((buffered >= AudioMus_g->threshold) && (AudioMus_g->greedy != 0)) {
        SNDSTRM_setgreedystate(AudioMus_g->streamhandle,0);
        AudioMus_g->greedy = 0;
      }
    }
  }

  switchMode = 2;
  if (AudioMus_g->switchsong == 0) goto switchsong_zero;
  if (AudioMus_g->switchsong != switchMode) goto switchsong_default;

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
  goto done;

switchsong_default:
  if (AudioMus_g->streamstatus.outstandingrequests != 0) {
    if (SNDSTRM_getvol(AudioMus_g->streamhandle) != 0) return 0;
  }
  if (AudioMus_g->streamhandle >= 0) {
    SNDSTRM_purge(AudioMus_g->streamhandle);
  }
  AudioMus_g->songname = (char *)0x0;
  if (AudioMus_g->switchsong != 1) {
    goto clear_switchsong;
  }
  AudioMus_g->fadetime = 0;
  AudioMus_QueueRequestedSong();
  AudioMus_g->switchsong = switchMode;

update_failby:
  buffered = gettick();
  AudioMus_g->failby = buffered + 0x280;
  goto done;

clear_switchsong:
  AudioMus_g->switchsong = 0;
  goto done;

switchsong_zero:
  if (AudioMus_g->streamstatus.outstandingrequests != 0) return 0;
  requestedSong = AudioMus_g->requestsong;
  if (requestedSong < 0) goto done;
  availableSongs = AudioMus_g->availablesongs;
  if (availableSongs > 1) {
    if (AudioMus_g->randomize != 0) {
      int randomNextSong;

      randomMusic = AudioMus_g;
      randomRange = availableSongs - 1;
      randomNextSong = AudioMus_g->requestsong + 1;
      randomMusic->requestsong =
          (randomNextSong +
           (GetRCnt(0) > 0 ? GetRCnt(0) : -GetRCnt(0)) % randomRange) %
          availableSongs;
    } else {
      AudioMus_g->requestsong = (requestedSong + 1) % availableSongs;
    }
  }
  SNDSTRM_vol(AudioMus_g->streamhandle,0);
  AudioMus_QueueRequestedSong();
  AudioMus_g->newswitch = 1;
  AudioMus_g->firstswitch = 1;

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
  if (AudioMus_g != (AudioMus_tMusicGlobals *)0x0) {
    if (pattern != (char *)0x0) {
      AudioMus_BuildPattern(pattern);
      if ((AudioMus_g->availablesongs == 0) && (strlen(pattern) < 0x3d)) {
        char title[128];
        sprintf(title,"*-%s",pattern);
        AudioMus_BuildPattern(title);
      }
    }

    if (AudioMus_g->volume != 0) {
      if (AudioMus_g->availablesongs != 0) {
        int newsong;
        newsong = AudioMus_g->availablesongs;
        AudioMus_g->randomize = 1;
        if (newsong == 1) {
          newsong = 0;
        }
        else if (pattern != (char *)0x0) {
          /* MATCH (W55-A10, sealed 160/160 PASS; was 15 diffs @171 insns).
             TWO cooperating facts, both about THIS arm only:
             (1) COUNT.  `newsong = <ternary> % newsong;` written inline makes RTL expand the
                 divmod INSIDE BOTH ternary arms; here (unlike the else-arm, whose two copies
                 have long identical tails and cross-jump back together) the copies do NOT
                 merge -> a whole spare 11-insn div+guard block (171 vs 160).  Naming the
                 modulo RESULT (`pick`) gives the COND_EXPR a single join pseudo, so there is
                 exactly ONE div, after the join, exactly like the oracle at .L8007B118.
             (2) THE COPY.  The oracle ends this arm `mfhi $v1 ; j .L8007B1E8 ; addu $s0,$v1,$0`
                 -- the modulo lands in a caller-saved temp and is COPIED into newsong, and
                 reorg steals that copy into the `j` delay slot.  Writing `newsong = pick;`
                 alone is not enough: combine folds the copy back into the divmod (mfhi $s0
                 direct, nothing left for the slot).  The 05C read-only operand fence gives
                 `pick` its second use so the copy survives -- and it is a ZERO-INSN device
                 (pick is register-resident), the copy still being reorg-eligible because the
                 fence sits BEFORE it.
             Falsified on the way (do NOT retry): a separate `rnd` temp for the ternary alone
             (160 exact but flips the newsong/newsong-1 pair s0<->s1: reqdelta says p92 needs
             refs 15->16); the same with a `+1`-ref fence on newsong (4 diffs, mfhi-direct);
             the identity fence `"=r"(pick):"0"(pick)` (barrier -> +2 insns, slot unfilled);
             `rnd = rnd % newsong; newsong = rnd;` and a bare `pick` temp (both copy-propped);
             giving the ELSE arm a `rnd` temp too (reorders the requestsong load, 144 insns). */
          int pick = (GetRCnt(0) > 0 ? GetRCnt(0) : -GetRCnt(0)) % newsong;
          __asm__("" : : "r"(pick));
          newsong = pick;
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
  }
  return 0;
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
