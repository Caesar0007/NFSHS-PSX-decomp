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
        u_short azimuth;
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
        azimuth = 0;
        if (dst < (int)se->range << 0x10) {
          if (se->type == '\x03') {
            azimuth += trkazi;
          }
          else if (se->type != '\x02') {
            azimuth = AudioClc_CalcAzimuth(&AudioClc_gRenderView,&se->cp);
            dop = AudioClc_CalcDopplerShiftRatio(&se->cp,vel);
          }
          if ((u_char)se->type - 4 < 0x20) {
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
  int numelems;
  int quater;
  int gtck;
  int vx;
  int vz;
  coorddef v;
  int start;
  int end;
  int i;
  int tck;
  int cur;
  int max;
  Trk_AnimateInst*anim;
  int x;
  int z;
  int d;
  int randtick;
  int fade;
  int fadeIn;
  int fadeOut;
  coorddef nextcp;
  int next;
  int time;
  u_int uVar1;
  int iVar2;
  short sVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  char *pcVar9;
  Trk_AnimateInst *animInst;
  AudioElem *se;
  coorddef *vel;
  coorddef local_60;
  coorddef local_50;
  int local_40;
  int local_3c;
  int local_38;
  int local_34;
  int local_30;
  
  if ((((GameSetup_gData.commMode != 1) && (gMasterAmbientLevel != 0)) &&
      (AudioTrk_g != (AudioTrk_tGlobals *)0x0)) && (gGameAudioList != (CAudioList *)0x0)) {
    iVar8 = gGameAudioList->numElements_;
    iVar6 = simGlobal.gameTicks >> 1;
    iVar7 = (iVar8 >> 2) + 1;
    local_38 = simGlobal.gameTicks >> 3;
    local_34 = 0;
    local_30 = 0;
    iVar4 = iVar6;
    if (iVar6 < 0) {
      iVar4 = iVar6 + 3;
    }
    iVar4 = (iVar6 + (iVar4 >> 2) * -4) * iVar7;
    iVar7 = iVar4 + iVar7;
    if (iVar7 <= iVar8) {
      iVar8 = iVar7;
    }
    se = (AudioElem *)((int)gGameAudioList + iVar4 * 0x18 + 0x10);
    pcVar9 = &se->type;
    for (; iVar7 = local_38, iVar4 < iVar8; iVar4 = iVar4 + 1) {
      if ((pcVar9[1] != -1) && (AudioTrk_g->chan[pcVar9[1]].se != se)) {
        pcVar9[1] = 0xff;
      }
      animInst = (Trk_AnimateInst *)0x0;
      if ((u_char)*pcVar9 - 4 < 0x20) {
        local_60.z = 0;
        local_60.y = 0;
        local_60.x = 0;
        animInst = Anim_gInstanceFromIndex[(u_char)*pcVar9 - 4];
        if (animInst != (Trk_AnimateInst *)0x0) {
          iVar7 = DrawW_GetAnimationTime(animInst);
          Anim_GetPos(animInst,1,iVar7,&se->cp,&local_40,&local_3c);
        }
      }
      else if ((((*(u_int *)(pcVar9 + -4) & 0xffff0000) != 0) &&
               ((int)(u_int)*(u_short *)(pcVar9 + -8) < local_38)) && (pcVar9[1] == 0xff)) {
        sVar3 = 0;
        if (1 < (u_char)pcVar9[-1]) {
          uVar1 = random();
          sVar3 = (short)(uVar1 % (u_int)(u_char)pcVar9[-1]);
        }
        *(u_short *)(pcVar9 + -8) = (u_short)(u_char)pcVar9[-2] + (short)iVar7 + sVar3;
      }
      iVar6 = (se->cp).x;
      iVar5 = iVar6 - local_34;
      if (iVar5 < 1) {
        iVar5 = local_34 - iVar6;
      }
      iVar6 = *(int *)(pcVar9 + -0xc) - local_30;
      if (iVar6 < 1) {
        iVar6 = local_30 - *(int *)(pcVar9 + -0xc);
      }
      if (iVar6 < iVar5) {
        iVar5 = iVar5 + (iVar6 >> 2);
      }
      else {
        iVar5 = iVar6 + (iVar5 >> 2);
      }
      vel = (coorddef *)0x0;
      if ((iVar5 < (*(short *)(pcVar9 + -4) + 100) * 0x10000) || (-1 < pcVar9[1])) {
        iVar6 = 0x80;
        if ((u_char)*pcVar9 - 4 < 0x20) {
          if (animInst != (Trk_AnimateInst *)0x0) {
            *(u_short *)(pcVar9 + -8) = (u_short)(u_char)pcVar9[-2];
            iVar5 = (u_int)(u_char)pcVar9[-5] * 8;
            if (local_40 < iVar5) {
              iVar6 = 0;
            }
            else if (local_40 < iVar5 + 0x80) {
              iVar6 = local_40 + (u_int)(u_char)pcVar9[-5] * -8;
            }
            iVar5 = (u_int)(u_char)pcVar9[-1] * 8;
            if ((u_char)pcVar9[-1] != 0) {
              if (iVar5 + 0x80 < local_40) {
                iVar6 = 0;
              }
              else if (iVar5 < local_40) {
                iVar6 = iVar5 - (local_40 + -0x80);
              }
            }
            if (0 < iVar6) {
              iVar5 = local_3c + -1;
              if (iVar7 + 0x20 < local_3c + -1) {
                iVar5 = iVar7 + 0x20;
              }
              Anim_GetPos(animInst,1,iVar5,&local_50,(int *)0x0,(int *)0x0);
              iVar5 = iVar5 - iVar7;
              if (iVar5 == 0x20) {
                local_60.x = (local_50.x - (se->cp).x) * 2;
                local_60.y = (local_50.y - *(int *)(pcVar9 + -0x10)) * 2;
                local_60.z = (local_50.z - *(int *)(pcVar9 + -0xc)) * 2;
              }
              else {
                if (iVar5 == 0) goto LAB_8007d294;
                iVar2 = (local_50.x - (se->cp).x) * 0x40;
                local_60.x = iVar2 / iVar5;
                iVar2 = (local_50.y - *(int *)(pcVar9 + -0x10)) * 0x40;
                local_60.y = iVar2 / iVar5;
                iVar2 = (local_50.z - *(int *)(pcVar9 + -0xc)) * 0x40;
                local_60.z = iVar2 / iVar5;
              }
              vel = &local_60;
            }
LAB_8007d294:
            iVar5 = iVar7;
            if (0 < local_3c) {
              iVar5 = iVar7 % local_3c;
            }
            iVar7 = iVar5 >> 3;
          }
          if (((u_char)*pcVar9 - 4 < 0x20) && (animInst == (Trk_AnimateInst *)0x0)) goto LAB_8007d31c;
        }
        AudioTrk_AddCustomObject(se,iVar7,vel,iVar6,car,trkazi)
        ;
      }
LAB_8007d31c:
      pcVar9 = pcVar9 + 0x18;
      se = se + 1;
    }
  }
  return;
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
