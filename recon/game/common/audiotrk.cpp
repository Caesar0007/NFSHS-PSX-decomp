/* game/common/audiotrk.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
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
  /* SYM-CODEGEN-CARRIER: pCVar2 -- reloading the list base before the loop
     condition fills retail's halfword-store delay slot and avoids a nop. */
  CAudioList *pCVar2;
  /* SYM-CODEGEN-CARRIER: puVar3 -- the induction pointer is required for
     retail's strength-reduced 24-byte element walk; indexed spelling adds six
     instructions and changes 38 oracle positions. */
  signed char *puVar3;
  /* SYM-CODEGEN-CARRIER: neg1 -- the separately initialized byte sentinel
     preserves retail's placement of the invariant `li a1,-1`. */
  signed char neg1;

  if (AudioTrk_g != (AudioTrk_tGlobals *)0x0) {
    int i;

    i = 0;
    do {
      if (AudioTrk_g->chan[i].handle != -1) {
        freeVoiceChannel(i + 0x37);
        AudioTrk_g->chan[i].handle = -1;
      }
      AudioTrk_g->chan[i].se = (AudioElem *)0x0;
      AudioTrk_g->chan[i].patch = -1;
      i++;
    } while (i < 0x10);
  }
  {
    int i;

    if ((gGameAudioList != (CAudioList *)0x0) && (i = 0, 0 < gGameAudioList->numElements_)) {
      neg1 = -1;
      puVar3 = (signed char *)((int)&gGameAudioList[2].numElements_ + 1);
      do {
        *puVar3 = neg1;
        pCVar2 = gGameAudioList;
        *(u_short *)(puVar3 + -9) = 0;
        puVar3 = puVar3 + 0x18;
        i = i + 1;
      } while (i < pCVar2->numElements_);
    }
  }
  return;
}

/* ---- AudioTrk_StartUp__Fv  [@0x8007c6f4] ---- */
void AudioTrk_StartUp(void)
{
  int i;
  /* SYM-CODEGEN-CARRIER: neg1 -- SYM records only `i`, but spelling the
     reverse indexed loop with a literal -1 emits the same 23 instructions
     with a two-diff invariant-load ordering.  This separately initialized
     value materializes retail a0 before i is initialized in v1. */
  int neg1;

  if (AudioTrk_g == (AudioTrk_tGlobals *)0x0) {
    AudioTrk_g = reservememadr("trck globals",0x100,0);
    neg1 = -1;
    i = 0xf;
    do {
      AudioTrk_g->chan[i].handle = neg1;
      i--;
    } while (i >= 0);
  }
  AudioTrk_Reset();
}

/* ---- AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji  [@0x8007c750] ---- */
void AudioTrk_AddCustomObject(AudioElem *se,int tck,coorddef *vel,int fade,Car_tObj *car,int trkazi)
{
  int dst;
  AudioTrk_tAmbientChannel*c;
  int n;
  int i;
  int maxind;
  int maxdst;
  int chkdst;
  
  if (AudioTrk_g != (AudioTrk_tGlobals *)0x0) {
    dst = Math_Dist3D(&se->cp,&AudioClc_gRenderView.translation);
    if ((se->range + 100) * 0x10000 <= dst) {
      goto AudioTrk_cleanup;
    }
    c = (AudioTrk_tAmbientChannel *)0x0;
    if (CopSpeak_gNumTrackSfx <= (int)(u_int)(u_char)se->patchID) {
      goto AudioTrk_cleanup;
    }
    goto AudioTrk_valid;

AudioTrk_cleanup:
    {
      AudioTrk_tAmbientChannel *c;

      if (-1 < (signed char)se->chan) {
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

AudioTrk_valid:
    {
      n = -1;
      if ((signed char)se->chan < 0) {
        goto AudioTrk_find_channel;
      }
      n = (int)(signed char)se->chan;
      c = AudioTrk_g->chan + n;
      goto AudioTrk_channel_found;

AudioTrk_find_channel:
      if ((se->nextDelay != 0) && ((u_int)se->nextDelay != tck)) {
        return;
      }
      for (i = 0; (c == (AudioTrk_tAmbientChannel *)0x0) && (i < 0x10); i++) {
        if (AudioTrk_g->chan[i].se == (AudioElem *)0x0) {
          c = AudioTrk_g->chan + i;
          /* MATCH: identity fence (0 insns) stops cse substituting `c` for the freshly
             computed `&chan[i]`; retail stores through the ORIGINAL address pseudo
             ($v1) while `c` is the surviving copy ($s2) -- oracle 8007C890/894. */
          __asm__("" : "=r"(c) : "0"(c));
          AudioTrk_g->chan[i].se = se;
          c->slice = -1;
          n = i;
          c->repeat =
              (u_short)(u_char)se->minRepeat +
              (se->randomRepeat != '\0'
                   ? (u_short)((u_int)random() % ((u_char)se->randomRepeat + 1))
                   : 0);
          c->se->chan = (char)n;
        }
      }

AudioTrk_channel_found:
        if (c == (AudioTrk_tAmbientChannel *)0x0) {
          maxind = 0;
          maxdst = 0;
          {
            int i;

            i = 0;
            while (true) {
              if (c != (AudioTrk_tAmbientChannel *)0x0) {
                break;
              }
              if (i >= 0x10) {
                break;
              }
              chkdst = Math_Dist3D(&(AudioTrk_g->chan[i].se)->cp,
                                   &AudioClc_gRenderView.translation);
              if (c->handle != 0xffffffff) {
                if ((SNDover(c->handle) != 0) && (maxdst < chkdst)) {
                  maxind = i;
                  maxdst = chkdst;
                }
              }
              i++;
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
        if (c == (AudioTrk_tAmbientChannel *)0x0) {
          return;
        }
      }
      if (c->patch != (u_short)(u_char)se->patchID) {
        if (c->handle != -1) {
          freeVoiceChannel(n + 0x37);
          c->handle = -1;
        }
        c->patch = (u_short)(u_char)se->patchID;
      }
      bool repeatnow;

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
          if ((c->handle != 0xffffffff) &&
              (SNDover(c->handle) != 0)) {
            return;
          }
          if ((dst < (int)((u_int)(u_char)se->fadeIn << 0x10)) && (c->slice == -1)) {
            BWorldSm_Pos slicePos;

            BWorldSm_SetSlice((int)(car->N).simRoadInfo.slice,&slicePos);
            BWorldSm_FindClosestSlice(&se->cp,&slicePos);
            c->slice = (int)slicePos.slice;
          }
          if (((int)(car->N).simRoadInfo.slice != c->slice) ||
             ((int)((u_int)(u_char)se->fadeIn << 0x10) < dst)) {
            AudioCmn_GetAsyncSfx(0,(int)c->patch,(void *)0x0)
            ;
            return;
          }
        }
        if (dst < (int)se->range << 0x10) {
          if (se->type == '\x03') {
            /* MATCH: this zero-instruction field fence prevents GCC from
               reusing the known value 3 across the merge.  Retail reloads
               se->type at 8007CBF0 on every incoming edge; without the fence
               the type-3 jump lands one instruction after that shared lbu. */
            __asm__("" : "+m"(se->type));
            azimuth += trkazi;
          }
          else if (se->type != '\x02') {
            azimuth = AudioClc_CalcAzimuth(&AudioClc_gRenderView,&se->cp);
            dop = AudioClc_CalcDopplerShiftRatio(&se->cp,vel);
          }
          if ((u_int)((u_char)se->type - 4) < 0x20) {
            goto AudioTrk_near_volume;
          }
          if ((u_char)se->type != 1) {
            goto AudioTrk_fade_volume;
          }

AudioTrk_near_volume:
          {
            int rangesq = (int)se->range * (int)se->range;
            /* SYM-CODEGEN-CARRIER: fadevol -- folding `fade * 0x7f` into the
               product reverses retail's multiply operands and removes its
               scheduled gap instruction. */
            int fadevol;
            /* SYM-CODEGEN-CARRIER: level -- SYM's `vol` is a char; these
               scoped full-width pre-bias/pre-shift results cannot be expressed
               through that retail local without premature truncation. */
            int level =
                (((rangesq >> 4) * 0x10000 -
                  fixedmult(dst >> 2,dst >> 2)) /
                 rangesq);
            fadevol = fade * 0x7f;
            level *= fadevol;

            if ((int)level < 0) {
              level += 0xffff;
            }
            vol = level >> 0x13;
            goto AudioTrk_volume_done;
          }

AudioTrk_fade_volume:
          {
            vol = 0x7f;
            if ((u_char)se->fadeIn * 0x10000 <= dst) {
              int range = (int)se->range - (u_char)se->fadeIn;
              int rangesq = range * range;
              int ambdist = (dst - (u_char)se->fadeIn * 0x10000) >> 2;
              u_int level =
                  (((rangesq >> 4) * 0x10000 -
                    fixedmult(ambdist,ambdist)) /
                   rangesq) *
                  0x7f0;

              if ((int)level < 0) {
                level += 0xffff;
              }
              vol = level >> 0x10;
            }
          }

AudioTrk_volume_done:
          ;
        }
        /* MATCH: retail evaluates min(0xA0000,dop) TWICE
           (8007CD34 and 8007CD40 share
           the one `slt a0` but each select gets its own arm pair), assigns the clamp
           unconditionally and only overrides it with 1 on the <=0 arm -- the ternary
           `((min)>1)?(min):1` form CSEs the pair and inverts the branch polarity.
           `(dop < K) ? dop : K` (not `(dop > K) ? K : dop`) picks retail's arm order. */
        {
          /* SYM-CODEGEN-CARRIER: dopClamped -- the separately materialized
             minimum/select web described above is omitted from SYM. */
          int dopClamped = (dop < 0xa0000) ? dop : 0xa0000;
          if (((dop > 0xa0000) ? 0xa0000 : dop) <= 0) {
            dopClamped = 1;
          }
          dop = dopClamped;
        }
        if ((PAD_state(4) & 0x400) == 0) {
          c->handle =
              AudioCmn_PlaySFX(n + 0x37,(int)c->patch,0x40,dop,vol & 0xff,
                               azimuth & 0xffff);
        }
      }
    }
  }
  return;
}

/* ---- AudioTrk_SoundTrack__FP8Car_tObji  [@0x8007cdc4] ---- */
void AudioTrk_SoundTrack(Car_tObj *car,int trkazi)
{
  if (AudioTrk_GameSetupWords[3] != 1) {
    if (gMasterAmbientLevel != 0) {
      if (AudioTrk_g != 0) {
        if (gGameAudioList != 0) {
          AudioElem *se;
          int numelems = gGameAudioList->numElements_;
          int quater = (numelems >> 2) + 1;
          int gtck = AudioTrk_simGlobalWords[1] >> 3;
          int vx = AudioClc_gRenderView.translation.x;
          se = (AudioElem *)(gGameAudioList + 1);
          int vz = AudioClc_gRenderView.translation.z;
          coorddef v;
          int start = ((AudioTrk_simGlobalWords[1] >> 1) % 4) * quater;
          /* MATCH: retail PRE-SETS the default (end = numelems, `addu fp,a3,zero`
             at 8007CE94) and only overrides it on the `<=` arm -- the min ternary
             emits the compare with the operands the other way round. */
          int end = numelems;
          if (start + quater <= numelems) {
            end = start + quater;
          }
          se += start;
          for (int i = start; i < end; se++, i++) {
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
              if (((*(u_int *)&se->range & 0xffff0000) != 0) &&
                  (se->nextDelay < gtck) && (se->chan == -1)) {
                int randtick = 0;
                if ((u_char)se->randomDelay > 1) {
                  randtick = (u_int)random() % (u_char)se->randomDelay;
                }
                se->nextDelay = (u_char)se->minDelay + tck + randtick;
              }
            }

            x = se->cp.x - vx;
            if (x <= 0) {
              x = vx - se->cp.x;
            }
            z = se->cp.z - vz;
            if (z <= 0) {
              z = vz - se->cp.z;
            }
            if (z < x) {
              d = x + (z >> 2);
            } else {
              d = z + (x >> 2);
            }

            if ((d < (se->range + 100) * 0x10000) || (se->chan >= 0)) {
              coorddef *vel = 0;
              int fade = 128;

              if ((u_int)((u_char)se->type - 4) < 32) {
                if (anim != 0) {
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
                      /* MATCH: a separate temp stops fold reassociating
                         `fadeOut - (cur-128)` into `(fadeOut+128) - cur` (which reuses
                         the guard's temp); oracle 8007D118/11C keep `cur-128` distinct. */
                      /* SYM-CODEGEN-CARRIER: curBack -- this scoped expression
                         carrier is optimized away, but keeping `cur - 128`
                         distinct prevents GCC from reassociating the subtract
                         into `(fadeOut + 128) - cur`, as measured above. */
                      int curBack = cur - 128;
                      fade = fadeOut - curBack;
                    }
                  }

                  if (fade > 0) {
                    coorddef nextcp;
                    int next = max - 1;
                    int time;

                    if (next > tck + 32) {
                      next = tck + 32;
                    }
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
                if (((u_int)((u_char)se->type - 4) < 32) && (anim == 0)) {
                  continue;
                }
              }
              AudioTrk_AddCustomObject(se,tck,vel,fade,car,trkazi);
            }
          }
        }
      }
    }
  }
}

/* ---- AudioTrk_PreLoad__Fv  [@0x8007d35c] ---- */
int AudioTrk_PreLoad(void)
{
  int vx;
  int vz;
  int tick;
  bool loaded;
  int check;
  int numelems;

  if ((gGameAudioList == (CAudioList *)0x0) || (gMasterAmbientLevel == 0)) {
    return 1;
  }

  vx = *(int *)AudioTrk_BWorldSmSlices;
  vz = *(int *)(AudioTrk_BWorldSmSlices + 8);
  loaded = false;
  tick = gettick() + 0x280;
  numelems = gGameAudioList->numElements_;
  while (!loaded && gettick() < tick &&
         0x8000 < SNDmemlargestunused(&check)) {
    loaded = true;
    {
      AudioElem *se;
      int i;

      se = (AudioElem *)(gGameAudioList + 1);
      for (i = 0; i < numelems; se++,i++) {
        int x;
        int z;
        int d;

        x = se->cp.x - vx;
        if (x <= 0) {
          x = vx - se->cp.x;
        }
        z = se->cp.z - vz;
        if (z <= 0) {
          z = vz - se->cp.z;
        }
        if (z < x) {
          d = x + (z >> 2);
        }
        else {
          d = z + (x >> 2);
        }
        if ((d < (se->range + 100) * 0x10000) &&
            ((int)(u_char)se->patchID < CopSpeak_gNumTrackSfx) &&
            (AudioCmn_GetAsyncSfx(0,(u_int)(u_char)se->patchID,(void *)0x0) == -1)) {
          loaded = false;
        }
      }
    }
    CopSpeak_Server();
    systemtask(0);
  }
  return gettick() < tick;
}

/* ---- AudioTrk_CleanUp__Fv  [@0x8007d52c] ---- */
void AudioTrk_CleanUp(void)
{
  int i;

  AudioTrk_Reset();
  i = 0;
  if (AudioTrk_g != (AudioTrk_tGlobals *)0x0) {
    do {
      if (AudioTrk_g->chan[i].handle != -1) {
        freeVoiceChannel(i + 0x37);
        AudioTrk_g->chan[i].handle = -1;
      }
      i = i + 1;
    } while (i < 0x10);
    purgememadr(AudioTrk_g);
    AudioTrk_g = (AudioTrk_tGlobals *)0x0;
  }
  return;
}
