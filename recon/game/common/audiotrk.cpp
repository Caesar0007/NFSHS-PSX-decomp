/* game/common/audiotrk.cpp -- reconstructed ambient track audio, six functions.
 * Native SYM/oracle evidence guides restoration; unresolved source identities
 * and scope/statement questions are not implied complete by code matching. */
#include "audiotrk_types.h"
#include "audiotrk_externs.h"


/* ---- audiotrk.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
AudioTrk_tGlobals *AudioTrk_g;   /* @0x8013c754  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
void AudioTrk_Reset(void);
void AudioTrk_StartUp(void);
void AudioTrk_AddCustomObject(AudioElem *se,int tck,coorddef *vel,int fade,Car_tObj *car,int trkazi);
void AudioTrk_SoundTrack(Car_tObj *car,int trkazi);
int AudioTrk_PreLoad(void);
void AudioTrk_CleanUp(void);


/* ---- AudioTrk_Reset__Fv  [@0x8007c614] ---- */
void AudioTrk_Reset(void)
{
  if (AudioTrk_g != (AudioTrk_tGlobals *)0x0) {
    for (int i = 0; i < 0x10; i++) {
      if (AudioTrk_g->chan[i].handle != -1) {
        freeVoiceChannel(i + 0x37);
        AudioTrk_g->chan[i].handle = -1;
      }
      AudioTrk_g->chan[i].se = (AudioElem *)0x0;
      AudioTrk_g->chan[i].patch = -1;
    }
  }
  if (gGameAudioList != (CAudioList *)0x0) {
    /* SOURCE-RECOVERY-OPEN: se is a semantic name borrowed from the sibling
       SoundTrack/PreLoad roles, not recovered from Reset's own source records.
       Its native SYM lists only the two i locals. This exact pointer walk is
       verified code, but a distinct original source pointer/name is unproved.
       P897's direct index trial is58/56 with32diffs; no carrier exemption or
       original-name claim is justified by that failed source form. */
    AudioElem *se = (AudioElem *)(gGameAudioList + 1);
    for (int i = 0; i < gGameAudioList->numElements_; i++) {
      se->nextDelay = 0;
      se->chan = -1;
      se++;
    }
  }
}

/* ---- AudioTrk_StartUp__Fv  [@0x8007c6f4] ---- */
void AudioTrk_StartUp(void)
{
  if (AudioTrk_g == (AudioTrk_tGlobals *)0x0) {
    AudioTrk_g = reservememadr("trck globals",0x100,0);
    for (int i = 0; i < 16; i++)
      AudioTrk_g->chan[i].handle = -1;
  }
  AudioTrk_Reset();
}

/* ---- AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji  [@0x8007c750] ----
 * P900: structured guards/loops recover all 31 native scopes and 18 local
 * owners; SLD instruction partitions are exact. Seven reconstruction labels
 * are removed. Initialize c after the rejection guard: moving it before
 * the guard changes its delay slot (4 diffs); a comma guard adds an XOR.
 * All 413 raw words and branch targets remain exact without codegen devices. */
void AudioTrk_AddCustomObject(AudioElem *se,int tck,coorddef *vel,int fade,Car_tObj *car,int trkazi)
{
  int dst;
  AudioTrk_tAmbientChannel *c;
  int n;
  if (AudioTrk_g == (AudioTrk_tGlobals *)0x0)
    return;
  dst = Math_Dist3D(&se->cp,&AudioClc_gRenderView.translation);
  if (((se->range + 100) * 0x10000 <= dst) ||
      (CopSpeak_gNumTrackSfx <= (int)(u_int)(u_char)se->patchID)) {
    if (-1 < (signed char)se->chan) {
      AudioTrk_tAmbientChannel *c;

      c = AudioTrk_g->chan + (signed char)se->chan;
      if (c->handle != -1) {
        freeVoiceChannel((signed char)se->chan + 0x37);
        c->handle = -1;
      }
      c->se->chan = -1;
      c->se = (AudioElem *)0x0;
      c->patch = -1;
    }
    return;
  }
  c = (AudioTrk_tAmbientChannel *)0x0;
  n = -1;
  if ((signed char)se->chan >= 0) {
    n = (int)(signed char)se->chan;
    c = AudioTrk_g->chan + n;
  } else {
    if ((se->nextDelay == 0) || ((u_int)se->nextDelay == tck)) {
      for (int i = 0; (c == (AudioTrk_tAmbientChannel *)0x0) && (i < 0x10); i++) {
        if (AudioTrk_g->chan[i].se == (AudioElem *)0x0) {
          /* MATCH (W85-S2, device removal): retail stores `se` through the ORIGINAL
             `&chan[i]` address pseudo ($v1 -- the one the `se == 0` test built) while
             `c` is the surviving COPY ($s2); oracle 8007C890/894.  This used to be
             bought with an identity fence `__asm__("" : "=r"(c) : "0"(c))`.  The fence
             is DELETED: assigning `n` FIRST and spelling `c` off `n` makes c's address
             expression cse-DISTINCT from the `chan[i]` the test/store use, so gcc keeps
             both pseudos and stores through $v1 exactly like retail.  Zero devices.
             FALSIFIED (all 2 @413, a lone `sw s4,0(s2)`-vs-`0(v1)`): every ordering of
             `c = chan+i` / `chan[i].se = se` (store-first, &chan[i] form, ptr-form
             store, `chan[n]` store with `n=i` placed after, slice-store-first); a
             `slot` local is 5 @414. */
          n = i;
          c = AudioTrk_g->chan + n;
          AudioTrk_g->chan[i].se = se;
          c->slice = -1;
          c->repeat =
              (u_short)(u_char)se->minRepeat +
              (se->randomRepeat != '\0'
                   ? (u_short)((u_int)random() % ((u_char)se->randomRepeat + 1))
                   : 0);
          c->se->chan = (char)n;
        }
      }
    } else {
      return;
    }
  }
  if (c == (AudioTrk_tAmbientChannel *)0x0) {
    int maxind = 0;
    int maxdst = 0;
    for (int i = 0; (c == (AudioTrk_tAmbientChannel *)0x0) && (i < 0x10); i++) {
      int chkdst;
      chkdst = Math_Dist3D(&(AudioTrk_g->chan[i].se)->cp,
                           &AudioClc_gRenderView.translation);
      if ((c->handle != 0xffffffff) &&
          (SNDover(c->handle) != 0) && (maxdst < chkdst)) {
        maxind = i;
        maxdst = chkdst;
      }
    }
    if (dst < maxdst) {
      n = maxind;
      c = AudioTrk_g->chan + maxind;
      c->se = se;
      c->slice = -1;
      c->repeat =
          (u_short)(u_char)se->minRepeat +
          (se->randomRepeat != '\0'
               ? (u_short)((u_int)random() % ((u_char)se->randomRepeat + 1))
               : 0);
      c->se->chan = (char)maxind;
    }
  }
  if (c != (AudioTrk_tAmbientChannel *)0x0) {
    bool repeatnow;

    if (c->patch != (u_short)(u_char)se->patchID) {
      if (c->handle != -1) {
        freeVoiceChannel(n + 0x37);
        c->handle = -1;
      }
      c->patch = (u_short)(u_char)se->patchID;
    }
    repeatnow = false;
    if ((c->handle != 0xffffffff) &&
        (SNDover(c->handle) != 0)) {
      if (c->repeat != 0) {
        repeatnow = true;
        c->handle = -1;
        c->repeat = c->repeat + -1;
      }
      else if ((se->type != '\x01') || ((int)se->range << 0x10 < dst)) {
        freeVoiceChannel(n + 0x37);
        c->handle = -1;
        c->patch = -1;
        c->se->chan = -1;
        c->se = (AudioElem *)0x0;
      }
    }
    if (c->se != (AudioElem *)0x0) {
      u_short azimuth;
      int dop;
      char vol;

      azimuth = 0;
      dop = 0x10000;
      vol = 0;
      if ((se->type == '\x01') && (!repeatnow)) {
        if ((c->handle == 0xffffffff) ||
            (SNDover(c->handle) == 0)) {
          if ((dst < (int)((u_int)(u_char)se->fadeIn << 0x10)) && (c->slice == -1)) {
            BWorldSm_Pos slicePos;

            BWorldSm_SetSlice((int)(car->N).simRoadInfo.slice,&slicePos);
            BWorldSm_FindClosestSlice(&se->cp,&slicePos);
            c->slice = (int)slicePos.slice;
          }
        } else {
          return;
        }
        if (((int)(car->N).simRoadInfo.slice != c->slice) ||
            ((int)((u_int)(u_char)se->fadeIn << 0x10) < dst)) {
          AudioCmn_GetAsyncSfx(0,(int)c->patch,false);
          return;
        }
      }
      if (dst < (int)se->range << 0x10) {
        if (se->type == '\x03') {
          /* W85-S2: an `'m'`-fence `__asm__("" : "+m"(se->type))` sat here claiming
             to stop GCC reusing the known value 3 across the merge.  MEASURED
             EXACTLY INERT (PASS 413/413 with and without it) -- DELETED. */
          azimuth += trkazi;
        }
        else if (se->type != '\x02') {
          azimuth = AudioClc_CalcAzimuth(&AudioClc_gRenderView,&se->cp);
          dop = AudioClc_CalcDopplerShiftRatio(&se->cp,vel);
        }
        /* P879: keep the byte interval as two bounds. GCC otherwise gives
           this reload the same SI-mode RTL as the earlier type test and
           bypasses it on the type-3 edge. Both emit LBU, but only these
           bounds retain the retail jump target (SLD 279, 8007CBF0). */
        if ((((u_char)se->type >= 4) && ((u_char)se->type < 36)) ||
            ((u_char)se->type == 1)) {
          int rangesq = (int)se->range * (int)se->range;
          vol = ((((((rangesq >> 4) * 0x10000 -
                      fixedmult(dst >> 2,dst >> 2)) /
                     rangesq) *
                    /* MATCH: keep the 127 scale as its shift/subtract idiom so
                       GCC does not reassociate 127 onto the distance quotient. */
                    ((fade << 7) - fade)) /
                  0x10000) >> 3);
        } else {
          vol = 0x7f;
          if ((u_char)se->fadeIn * 0x10000 <= dst) {
            int range = (int)se->range - (u_char)se->fadeIn;
            int rangesq = range * range;
            int ambdist = dst - (u_char)se->fadeIn * 0x10000;
            /* SOURCE-SHAPE: retail SYM retains range/rangesq/ambdist but no
               full-width level temporary.  Signed division supplies the
               exact negative bias before the result narrows into vol.
               P900: native SLD292 computes unshifted ambdist; the >>2
               belongs to the fixedmult inputs on SLD293, not its initializer. */
            vol = (((((rangesq >> 4) * 0x10000 -
                       fixedmult(ambdist >> 2,ambdist >> 2)) /
                      rangesq) *
                     0x7f0) /
                   0x10000);
          }
        }
      }
      /* MATCH: retail materializes both minimum arms independently; the
         usual single temporary or MIN/MAX spelling CSEs this select web. */
      dop = (((dop > 0xa0000) ? 0xa0000 : dop) <= 0)
                ? 1
                : ((dop < 0xa0000) ? dop : 0xa0000);
      if ((PAD_state(4) & 0x400) == 0) {
        c->handle =
            AudioCmn_PlaySFX(n + 0x37,(int)c->patch,0x40,dop,vol & 0xff,
                             azimuth & 0xffff);
      }
    }
  }
  return;
}

/* ---- AudioTrk_SoundTrack__FP8Car_tObji  [@0x8007cdc4] ---- */
void AudioTrk_SoundTrack(Car_tObj *car,int trkazi)
{
  if (GameSetup_gData.commMode == 1)
    return;
  if (gMasterAmbientLevel == 0)
    return;
  if (AudioTrk_g != 0)
    if (gGameAudioList != 0) {
      AudioElem *se;
      int numelems = gGameAudioList->numElements_;
      int quater = (numelems >> 2) + 1;
      int gtck = simGlobal.gameTicks >> 3;
      int vx = AudioClc_gRenderView.translation.x;
      se = (AudioElem *)(gGameAudioList + 1);
      int vz = AudioClc_gRenderView.translation.z;
      coorddef v;
      int start = ((simGlobal.gameTicks >> 1) % 4) * quater;
      /* MATCH P901: conditional assignment arms keep the native one-statement
         selection; a bare min expression reverses the retail compare polarity. */
      int end;
      (numelems < start + quater) ? (end = numelems) : (end = start + quater);
      se += start;
      for (int i = start; i < end; i++) {
        int tck;
        int cur;
        int max;
        Trk_AnimateInst *anim;
        int x;
        int z;
        int d;

        if ((se->chan != -1) && (AudioTrk_g->chan[se->chan].se != se)) {
          se->chan = -1;
        }

        tck = gtck;
        anim = 0;
        if ((u_int)((u_char)se->type - 4) < 32) {
          v.x = v.y = v.z = 0;
          anim = Anim_gInstanceFromIndex[(u_char)se->type - 4];
          if (anim != 0) {
            tck = DrawW_GetAnimationTime(anim);
            Anim_GetPos(anim,1,tck,&se->cp,&cur,&max);
          }
        } else {
          if ((*(u_int *)&se->range & 0xffff0000) != 0)
            if ((se->nextDelay < gtck) && (se->chan == -1)) {
              int randtick = ((u_char)se->randomDelay > 1) ? (u_int)random() % (u_char)se->randomDelay : 0;
              se->nextDelay = (u_char)se->minDelay + tck + randtick;
            }
        }

        x = (se->cp.x - vx > 0) ? se->cp.x - vx : vx - se->cp.x;
        z = (se->cp.z - vz > 0) ? se->cp.z - vz : vz - se->cp.z;
        d = (z < x) ? x + (z >> 2) : z + (x >> 2);

        if ((d < (se->range + 100) * 0x10000) || (se->chan >= 0)) {
          coorddef *vel = 0;
          int fade = 128;

          if (((u_int)((u_char)se->type - 4) < 32) && (anim != 0)) {
            se->nextDelay = (u_char)se->minDelay;
            int fadeIn = (u_char)se->fadeIn << 3;
            if (cur < fadeIn) {
              fade = 0;
            } else if (cur < fadeIn + 128) {
              fade = cur - fadeIn;
            }
            int fadeOut = (u_char)se->randomDelay << 3;
            if (fadeOut != 0) {
              if (fadeOut + 128 < cur) {
                fade = 0;
              } else if (fadeOut < cur) {
                /* MATCH P898: keep the grouped int subtraction without
                   a non-SYM local. Direct form: FAIL20/358; widened: PASS358.
                   This arm bounds the result to0..127. The original cast
                   spelling remains unproved (raw8007D118/11C). */
                fade = fadeOut - (long long)(cur - 128);
              }
            }

            if (fade > 0) {
              coorddef nextcp;
              int next = (max - 1 <= tck + 32) ? max - 1 : tck + 32;
              int time;

              Anim_GetPos(anim,1,next,&nextcp,0,0);
              time = next - tck;
              if (time == 32) {
                v.x = (nextcp.x - se->cp.x) * 2;
                v.y = (nextcp.y - se->cp.y) * 2;
                v.z = (nextcp.z - se->cp.z) * 2;
                vel = &v;
              } else if (time != 0) {
                v.x = ((nextcp.x - se->cp.x) * 64) / time;
                v.y = ((nextcp.y - se->cp.y) * 64) / time;
                v.z = ((nextcp.z - se->cp.z) * 64) / time;
                vel = &v;
              }
            }
            if (max > 0) {
              tck %= max;
            }
            tck >>= 3;
          }
          if (((u_int)((u_char)se->type - 4) >= 32) || (anim != 0)) {
            AudioTrk_AddCustomObject(se,tck,vel,fade,car,trkazi);
          }
        }
        se++;
      }
    }
}

/* ---- AudioTrk_PreLoad__Fv  [@0x8007d35c] ----
 * P898: native statement groups restored without new helpers or locals.
 * Native se/i/x/z/d ownership is retained; the original CAudioList inline
 * accessor identity (SYM1bf4f2 this) remains a source-recovery gap. */
int AudioTrk_PreLoad(void)
{
  int vx;
  int vz;
  int tick;
  bool loaded;
  int check;
  int numelems;

  if (gGameAudioList == (CAudioList *)0x0)
    return 1;
  if (gMasterAmbientLevel == 0)
    return 1;

  vx = BWorldSm_slices[0].center[0];
  vz = BWorldSm_slices[0].center[2];
  loaded = false;
  tick = gettick() + 0x280;
  numelems = gGameAudioList->numElements_;
  while (!loaded && gettick() < tick &&
         0x8000 < SNDmemlargestunused(&check)) {
    AudioElem *se;

    loaded = true;
    se = (AudioElem *)(gGameAudioList + 1);
    for (int i = 0; i < numelems; i++) {
      int x;
      int z;
      int d;

      x = (se->cp.x - vx > 0) ? se->cp.x - vx : vx - se->cp.x;
      z = (se->cp.z - vz > 0) ? se->cp.z - vz : vz - se->cp.z;
      d = (z < x) ? x + (z >> 2) : z + (x >> 2);
      if (d < (se->range + 100) * 0x10000)
        if ((int)(u_char)se->patchID < CopSpeak_gNumTrackSfx)
          if (AudioCmn_GetAsyncSfx(0,(u_int)(u_char)se->patchID,false) == -1)
            loaded = false;
      se++;
    }
    CopSpeak_Server();
    systemtask(0);
  }
  if (gettick() < tick)
    return 1;
  else
    return 0;
}

/* ---- AudioTrk_CleanUp__Fv  [@0x8007d52c] ---- */
void AudioTrk_CleanUp(void)
{
  AudioTrk_Reset();
  if (AudioTrk_g != (AudioTrk_tGlobals *)0x0) {
    for (int i = 0; i < 0x10; i++) {
      if (AudioTrk_g->chan[i].handle != -1) {
        freeVoiceChannel(i + 0x37);
        AudioTrk_g->chan[i].handle = -1;
      }
    }
    purgememadr(AudioTrk_g);
    AudioTrk_g = (AudioTrk_tGlobals *)0x0;
  }
}
