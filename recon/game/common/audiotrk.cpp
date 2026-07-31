/* game/common/audiotrk.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
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
  int i;
  AudioTrk_tAmbientChannel *pAVar1;
  CAudioList *pCVar2;
  signed char *puVar3;
  int iVar4;
  int iVar5;
  signed char neg1;

  if (AudioTrk_g != (AudioTrk_tGlobals *)0x0) {
    i = 0;
    do {
      if (AudioTrk_g->chan[i].handle != -1) {
        freeVoiceChannel(i + 0x37);
        AudioTrk_g->chan[i].handle = -1;
      }
      pAVar1 = AudioTrk_g->chan + i;
      pAVar1->se = (AudioElem *)0x0;
      pAVar1->patch = -1;
      i++;
    } while (i < 0x10);
  }
  if ((gGameAudioList != (CAudioList *)0x0) && (iVar4 = 0, 0 < gGameAudioList->numElements_)) {
    neg1 = -1;
    puVar3 = (signed char *)((int)&gGameAudioList[2].numElements_ + 1);
    do {
      *puVar3 = neg1;
      pCVar2 = gGameAudioList;
      *(u_short *)(puVar3 + -9) = 0;
      puVar3 = puVar3 + 0x18;
      iVar4 = iVar4 + 1;
    } while (iVar4 < pCVar2->numElements_);
  }
  return;
}

/* ---- AudioTrk_StartUp__Fv  [@0x8007c6f4] ---- */
void AudioTrk_StartUp(void)
{
  int i;
  AudioTrk_tAmbientChannel *pAVar1;
  int iVar2;
  int neg1;

  if (AudioTrk_g == (AudioTrk_tGlobals *)0x0) {
    AudioTrk_g = reservememadr("trck globals",0x100,0);
    neg1 = -1;
    iVar2 = 0xf;
    pAVar1 = AudioTrk_g->chan + 0xf;
    do {
      pAVar1->handle = neg1;
      iVar2 = iVar2 + -1;
      pAVar1 = pAVar1 + -1;
    } while (-1 < iVar2);
  }
  AudioTrk_Reset();
  return;
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
      for (i = 0; (i < 0x10) && (c == (AudioTrk_tAmbientChannel *)0x0); i++) {
        if (AudioTrk_g->chan[i].se == (AudioElem *)0x0) {
          c = AudioTrk_g->chan + i;
          c->se = se;
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
        for (i = 0; i < 0x10; i++) {
          chkdst =
              Math_Dist3D(&(AudioTrk_g->chan[i].se)->cp,&AudioClc_gRenderView.translation);
          if (AudioTrk_g->chan[i].handle != 0xffffffff) {
            if ((SNDover(AudioTrk_g->chan[i].handle) != 0) && (maxdst < chkdst)) {
              maxdst = chkdst;
              maxind = i;
            }
          }
        }
        if (dst < maxdst) {
          c = AudioTrk_g->chan + maxind;
          c->se = se;
          c->slice = -1;
          c->repeat =
              (u_short)(u_char)se->minRepeat +
              (se->randomRepeat != '\0'
                   ? (u_short)((u_int)random() % ((u_char)se->randomRepeat + 1))
                   : 0);
          c->se->chan = (char)maxind;
          n = maxind;
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
        int dop;
        char vol;

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
        maxind = 0;
        if (dst < (int)se->range << 0x10) {
          if (se->type == '\x03') {
            maxind += trkazi;
          }
          else if (se->type != '\x02') {
            maxind = AudioClc_CalcAzimuth(&AudioClc_gRenderView,&se->cp);
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
            u_int level =
                (((rangesq >> 4) * 0x10000 -
                 fixedmult(dst >> 2,dst >> 2)) /
                 rangesq) *
                fade * 0x7f;

            vol = level >> 0x13;
            if ((int)level < 0) {
              vol = (level + 0xffff) >> 0x13;
            }
            goto AudioTrk_volume_done;
          }

AudioTrk_fade_volume:
          {
            int fadeIn = (u_char)se->fadeIn;

            vol = 0x7f;
            if (fadeIn * 0x10000 <= dst) {
              int range = (int)se->range - fadeIn;
              int rangesq = range * range;
              int ambdist = (dst - fadeIn * 0x10000) >> 2;
              u_int level =
                  (((rangesq >> 4) * 0x10000 -
                    fixedmult(ambdist,ambdist)) /
                   rangesq) *
                  0x7f0;

              vol = level >> 0x10;
              if ((int)level < 0) {
                vol = (level + 0xffff) >> 0x10;
              }
            }
          }

AudioTrk_volume_done:
          ;
        }
        if (0xa0000 < dop) {
          dop = 0xa0000;
        }
        if (dop < 1) {
          dop = 1;
        }
        if ((PAD_state(4) & 0x400) == 0) {
          c->handle =
              AudioCmn_PlaySFX(n + 0x37,(int)c->patch,0x40,dop,vol & 0xff,
                               maxind & 0xffff);
        }
      }
    }
  }
  return;
}

/* ---- AudioTrk_SoundTrack__FP8Car_tObji  [@0x8007cdc4] ---- */
void AudioTrk_SoundTrack(Car_tObj *car,int trkazi)
{
  if (GameSetup_gData.commMode != 1) {
    if (gMasterAmbientLevel != 0) {
      if (AudioTrk_g != 0) {
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
          int end = numelems < start + quater ? numelems : start + quater;
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
                      fade = fadeOut - (cur - 128);
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
  AudioElem*se;
  int i;
  int x;
  int z;
  int d;
  bool bVar1;
  bool bVar2;
  u_int uVar3;
  int iVar4;
  int iVar5;
  u_char *pbVar6;
  CAudioList *pCVar7;
  int iVar8;
  int iVar9;
  int iVar10;
  int iVar11;
  int iVar12;
  int aiStack_30 [2];
  
  if ((gGameAudioList == (CAudioList *)0x0) || (gMasterAmbientLevel == 0)) {
    uVar3 = 1;
  }
  else {
    iVar10 = *(int *)BWorldSm_slices;
    iVar9 = *(int *)(BWorldSm_slices + 8);
    bVar1 = false;
    uVar3 = BWorldSm_slices;
    gettick();
    iVar12 = uVar3 + 0x280;
    iVar11 = gGameAudioList->numElements_;
    while( true ) {
      bVar2 = false;
      if (!bVar1) {
        gettick();
        bVar1 = (int)uVar3 < iVar12;
        uVar3 = 0;
        if (bVar1) {
          uVar3 = SNDmemlargestunused(aiStack_30);
          bVar2 = 0x8000 < (int)uVar3;
        }
      }
      bVar1 = true;
      if (!bVar2) break;
      pCVar7 = gGameAudioList + 1;
      pbVar6 = (u_char *)((int)&gGameAudioList[1].versionNumber_ + 2);
      for (iVar8 = 0; iVar8 < iVar11; iVar8 = iVar8 + 1) {
        iVar5 = pCVar7->id_ - iVar10;
        if (iVar5 < 1) {
          iVar5 = iVar10 - pCVar7->id_;
        }
        iVar4 = *(int *)(pbVar6 + -6) - iVar9;
        if (iVar4 < 1) {
          iVar4 = iVar9 - *(int *)(pbVar6 + -6);
        }
        if (iVar4 < iVar5) {
          iVar5 = iVar5 + (iVar4 >> 2);
        }
        else {
          iVar5 = iVar4 + (iVar5 >> 2);
        }
        if (((iVar5 < (*(short *)(pbVar6 + 2) + 100) * 0x10000) &&
            ((int)(u_int)*pbVar6 < CopSpeak_gNumTrackSfx)) &&
           (iVar5 = AudioCmn_GetAsyncSfx(0,(u_int)*pbVar6,(void *)0x0), iVar5 == -1)) {
          bVar1 = false;
        }
        pbVar6 = pbVar6 + 0x18;
        pCVar7 = (CAudioList *)&pCVar7[1].slice_;
      }
      CopSpeak_Server();
      uVar3 = systemtask(0);
    }
    gettick();
    uVar3 = (u_int)((int)uVar3 < iVar12);
  }
  return uVar3;
}

/* ---- AudioTrk_CleanUp__Fv  [@0x8007d52c] ---- */
void AudioTrk_CleanUp(void)
{
  int iVar1;

  AudioTrk_Reset();
  iVar1 = 0;
  if (AudioTrk_g != (AudioTrk_tGlobals *)0x0) {
    do {
      if (AudioTrk_g->chan[iVar1].handle != -1) {
        freeVoiceChannel(iVar1 + 0x37);
        AudioTrk_g->chan[iVar1].handle = -1;
      }
      iVar1 = iVar1 + 1;
    } while (iVar1 < 0x10);
    purgememadr(AudioTrk_g);
    AudioTrk_g = (AudioTrk_tGlobals *)0x0;
  }
  return;
}
