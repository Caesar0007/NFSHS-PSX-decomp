/* game/common/audioeng.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "audioeng_externs.h"


/* ---- audioeng.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
AudioEng_t   *AudioEng_g[2];   /* @0x8013c734  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
void AudioEng_Set(int player,int vol,int esp,int gas,int cam,int dop,int azi,int dir);
void AudioEng_Update(void);
void AudioEng_LoadDef(char *filename,char *name,int handle,long offset,long size,AudioEng_tDef **ed);
int AudioEng_StartUp(int player,char *carname);
void AudioEng_StartServer(void);
void AudioEng_StopServer(void);
void AudioEng_Pause(void);
void AudioEng_Resume(void);
void AudioEng_CleanUp(void);


/* ---- AudioEng_Set__Fiiiiiiii  [@0x8007b5a8] ---- */
void AudioEng_Set(int player,int vol,int esp,int gas,int cam,int dop,int azi,int dir)
{
  AudioEng_t*g;
  AudioEng_tAdjustments*a;
  AudioEng_tState*s;
  char cVar1;
  u_short uVar2;
  int iVar3;
  u_char bVar4;
  int iVar5;
  AudioEng_tState *pAVar6;
  AudioEng_t *pAVar7;
  
  if ((u_int)player < 2) {
    pAVar7 = AudioEng_g[player];
    if ((pAVar7 != (AudioEng_t *)0x0) &&
       ((pAVar7->plypos != '\x0f' || ((pAVar7->setpos + 1U & 1) == 0)))) {
      pAVar6 = pAVar7->queue + (u_char)pAVar7->setpos;
      iVar3 = (int)((u_int)(pAVar7->adjust).timbreScale * esp) >> 0xe;
      iVar5 = 0x1ff;
      if (iVar3 < 0x200) {
        iVar5 = iVar3;
      }
      pAVar6->esp = (u_short)iVar5;
      if (Cars_gList[player]->carInfo->carType == 0x1c) {
        iVar5 = (esp >> 2) + 0xc000;
      }
      else {
        iVar5 = esp + 0x3333;
      }
      iVar5 = fixedmult(iVar5,dop);
      pAVar6->dop = (u_short)((int)((u_int)(pAVar7->adjust).pitchScale * iVar5) >> 10);
      iVar5 = gas + (gas >> 5) + (gas >> 6);
      if (iVar5 < 0x81) {
        pAVar6->gas = (u_char)iVar5;
      }
      else {
        pAVar6->gas = 0x80;
      }
      if (cam == 0) {
        pAVar6->exh = (pAVar7->adjust).inCarExhaust;
        if (GameSetup_gData.commMode == 1) {
          pAVar6->sep = 0;
          pAVar6->azi = (u_short)azi;
        }
        else {
          pAVar6->azi = 0;
          pAVar6->sep = 0x3fff;
        }
        bVar4 = (pAVar7->adjust).inCarBoost;
      }
      else {
        pAVar6->exh = (pAVar7->adjust).outCarExhaust;
        if (dir < 0) {
          bVar4 = pAVar6->exh;
          iVar5 = dir * (u_int)(pAVar7->adjust).fwdEngBoost * (u_int)bVar4;
        }
        else {
          bVar4 = pAVar6->exh;
          iVar5 = dir * (u_int)(pAVar7->adjust).rwdExhBoost * (0x80 - (u_int)bVar4);
        }
        cVar1 = (char)(iVar5 >> 0x17);
        if (iVar5 >> 7 < 0) {
          cVar1 = (char)((u_int)((iVar5 >> 7) + 0xffff) >> 0x10);
        }
        pAVar6->exh = bVar4 + cVar1;
        pAVar6->azi = (u_short)azi;
        pAVar6->sep = 0;
        bVar4 = (pAVar7->adjust).outCarBoost;
      }
      iVar5 = (int)(vol * (u_int)bVar4) >> 6;
      uVar2 = 0x7ff;
      if (iVar5 < 0x800) {
        uVar2 = (u_short)iVar5;
      }
      pAVar6->vol = uVar2;
      pAVar7->setpos = pAVar7->setpos + 1U & 0xf;
    }
  }
  return;
}

/* ---- AudioEng_Update__Fv  [@0x8007b824] ---- */
void AudioEng_Update(void)
{
  int player;
  short sVar1;
  short sVar2;
  bool bVar3;
  int iVar4;
  u_int uVar5;
  char cVar6;
  u_int uVar7;
  int iVar8;
  int iVar9;
  AudioEng_t *pAVar10;
  AudioEng_t *pAVar11;
  AudioEng_tState *pAVar12;
  AudioEng_t *pAVar13;
  u_short uVar14;
  u_short uVar15;
  AudioEng_t *pAVar16;
  
  player = 0;
  do {
    AudioEng_t *g;
    int n;
    AudioEng_tState *s;
    int tick;

    if (1 < player) {
      return;
    }
    g = AudioEng_g[player];
    if (g == (AudioEng_t *)0x0) {
      return;
    }
    s = g->queue + (u_char)g->plypos;
    tick = gettick();
    if (g->plypos != g->setpos) {
      n = gettick();
      if (g->tick < n) {
        g->tick = tick + 2;
        for (n = 0; n < 16; n++) {
          if ((signed char)g->chan[n].patchnum >= 0) {
            u_long vol;

            if ((s->esp >= g->chan[n].min) && (s->esp < g->chan[n].max)) {
              vol = (signed char)g->chan[n].xlate[s->esp - g->chan[n].min];
            }
            else {
              vol = 0;
            }
            if (vol != 0) {
              if (n < 8) {
                vol *= Xfade[128 - s->gas];
              }
              else {
                vol *= Xfade[s->gas];
              }
              if ((signed char)g->chan[n].patchnum >= 64) {
                if (s->sep != 0) {
                  vol *= (Xfade[128 - s->exh] * 47) >> 6;
                }
                else {
                  vol *= Xfade[128 - s->exh];
                }
              }
              else {
                vol *= Xfade[s->exh];
              }
            }
            vol *= s->vol;
            vol >>= 21;
            if (vol >= 128) {
              vol = 127;
            }
            g->vol[n] = vol;
            g->azi = s->azi;
            g->sep = s->sep;
            g->dop = s->dop;
          }
        }
        g->plypos = g->plypos + 1U & 0xf;
      }
    }
    {
      SNDPLAYOPTS playopts;
      u_short leftazim;
      u_short rightazim;

      n = 0;
      for (;;) {
        if (n >= 16) {
          break;
        }
        if ((signed char)g->chan[n].patchnum >= 0) {
          if (g->vol[n] != 0) {
          if ((signed char)g->chan[n].patchnum >= 64) {
            leftazim = g->azi - g->sep;
            rightazim = g->azi + g->sep;
          }
          else {
            leftazim = g->azi;
            rightazim = leftazim;
          }
          SNDplaysetdef(&playopts);
          playopts.bhandle = g->bhandle;
          playopts.patnum = (signed char)g->chan[n].patchnum;
          playopts.vol = 0;
          playopts.pitchmult = g->dop;
          playopts.use3dpos = 1;
          playopts.elevation = 0;
          if (g->left[n].handle == -1) {
            playopts.azimuth = leftazim;
            g->left[n].handle = SNDplay(&playopts);
            g->delay[n] = 2;
            g->left[n].vol = 0;
            g->left[n].azim = leftazim;
            g->left[n].pitch = g->dop;
          }
          else {
            if ((g->sep == 0) || ((signed char)g->chan[n].patchnum < 64) ||
                (g->right[n].handle != -1)) {
              iVar8 = (signed char)g->left[n].vol;
              iVar9 = g->vol[n];
              if (iVar8 != iVar9) {
                if (iVar9 < iVar8) {
                  iVar8 -= 2;
                  bVar3 = iVar8 < iVar9;
                }
                else {
                  iVar8 += 2;
                  bVar3 = iVar9 < iVar8;
                }
                if (bVar3) {
                  iVar8 = iVar9;
                }
                *(volatile char *)&g->left[n].vol = iVar8;
                SNDvol(*(volatile int *)&g->left[n].handle,
                       (signed char)g->left[n].vol);
              }
            }
            if (g->left[n].azim != leftazim) {
              SND3dpos(g->left[n].handle, leftazim, 0);
              g->left[n].azim = leftazim;
            }
            if (g->left[n].pitch != g->dop) {
              SNDpitchmult(g->left[n].handle, g->dop);
              g->left[n].pitch = g->dop;
            }
            if (((signed char)g->chan[n].patchnum >= 64) && (g->sep != 0)) {
              if (g->right[n].handle == -1) {
                g->delay[n]--;
                if ((signed char)g->delay[n] == -1) {
                  playopts.azimuth = rightazim;
                  g->right[n].handle = SNDplay(&playopts);
                  g->right[n].vol = 0;
                  g->right[n].azim = rightazim;
                  g->right[n].pitch = g->dop;
                }
              }
              else {
                iVar8 = (signed char)g->right[n].vol;
                iVar9 = g->vol[n];
                if (iVar8 != iVar9) {
                  if (iVar9 < iVar8) {
                    iVar8 -= 2;
                    bVar3 = iVar8 < iVar9;
                  }
                  else {
                    iVar8 += 2;
                    bVar3 = iVar9 < iVar8;
                  }
                  if (bVar3) {
                    iVar8 = iVar9;
                  }
                  *(volatile char *)&g->right[n].vol = iVar8;
                  SNDvol(*(volatile int *)&g->right[n].handle,
                         (signed char)g->right[n].vol);
                }
                if (g->right[n].azim != rightazim) {
                  SND3dpos(g->right[n].handle, rightazim, 0);
                  g->right[n].azim = rightazim;
                }
                if (g->right[n].pitch != g->dop) {
                  SNDpitchmult(g->right[n].handle, g->dop);
                  g->right[n].pitch = g->dop;
                }
              }
            }
            else if (g->right[n].handle != -1) {
              SNDstop(g->right[n].handle);
              g->right[n].handle = -1;
              g->delay[n] = 2;
              }
          }
        }
          else if (g->left[n].handle != -1) {
            SNDstop(g->left[n].handle);
            if (g->right[n].handle != -1) {
              SNDstop(g->right[n].handle);
            }
            g->left[n].handle = -1;
            g->right[n].handle = -1;
          }
        }
        n++;
      }
    }
    player = player + 1;
  } while( true );
}

/* ---- AudioEng_LoadDef__FPcT0illPP13AudioEng_tDef  [@0x8007bddc] ---- */
void AudioEng_LoadDef(char *filename,char *name,int handle,long offset,long size,AudioEng_tDef **ed)
{
  AudioEng_tDef *pAVar1;
  
  pAVar1 = reservememadr(name,size,0x10);
  *ed = pAVar1;
  if (pAVar1 != (AudioEng_tDef *)0x0) {
    FILE_readsync(handle,offset,*ed,size,0x64);   /* oracle 0x8007be1c: a0=h a1=off a2=*ed a3=size stk=0x64 */
  }
  return;
}

/* ---- AudioEng_StartUp__FiPc  [@0x8007be54] ---- */
int AudioEng_StartUp(int player,char *carname)
{
  AudioEng_tDef*cruisedef;
  AudioEng_tDef*loaddef;
  int tablesize;
  int i;
  int bankloaded;
  int spu;
  char filename[64];
  AudioEng_t*g;
  char*header;
  int handle;
  long size;
  long offset;
  char*current;
  int c;
  AudioEng_tChanAttr*chan;
  int j;
  bool bVar1;
  int iVar2;
  AudioEng_t *pAVar3;
  int iVar4;
  void *pThis;
  char *pdata;
  AudioEng_tDef **ed;
  u_char *dest;
  short *psVar5;
  AudioEng_t *pAVar6;
  int iVar7;
  AudioEng_t *pAVar8;
  char *pcVar9;
  AudioEng_tDef *pAVar10;
  AudioEng_tDef *pAVar11;
  int iVar12;
  int iVar13;
  int iVar14;
  int iVar15;
  u_char *puVar16;
  u_int name;
  int iVar17;
  char acStack_80 [64];
  int local_40;
  long local_3c;
  u_int local_38;
  AudioEng_tDef *local_34;
  AudioEng_tDef *local_30 [2];
  
  if (1 < (u_int)player) {
    return 0;
  }
  name = 0;
  if (AudioEng_g[player] != (AudioEng_t *)0x0) {
    return 0;
  }
  iVar17 = 0;
  pAVar3 = reservememadr("Engine Audio",0x370,0);
  iVar15 = 0;
  AudioEng_g[player] = pAVar3;
  pAVar3->tables = (char *)0x0;
  pAVar3->tick = 0;
  pAVar3->azi = 0;
  pAVar3->sep = 0;
  pAVar3->dop = 0x1000;
  pAVar6 = pAVar3;
  pAVar8 = pAVar3;
  do {
    pAVar8->vol[0] = 0;
    pAVar6->left[0].handle = -1;
    pAVar6->right[0].handle = -1;
    pAVar6->chan[0].patchnum = -1;
    pAVar6->chan[0].min = 0x200;
    pAVar6->chan[0].max = 0x200;
    pAVar6->chan[0].xlate = (char *)0x0;
    pAVar6 = (AudioEng_t *)pAVar6->vol;
    iVar15 = iVar15 + 1;
    pAVar8 = (AudioEng_t *)&(pAVar8->adjust).rwdExhBoost;
  } while (iVar15 < 0x10);
  local_30[0] = (AudioEng_tDef *)0x0;
  local_34 = (AudioEng_tDef *)0x0;
  (pAVar3->adjust).inCarBoost = '2';
  (pAVar3->adjust).inCarExhaust = '\x1f';
  (pAVar3->adjust).outCarBoost = 0xa6;
  (pAVar3->adjust).outCarExhaust = '+';
  (pAVar3->adjust).fwdEngBoost = '@';
  (pAVar3->adjust).rwdExhBoost = 'y';
  (pAVar3->adjust).pitchScale = 'P';
  (pAVar3->adjust).timbreScale = 'h';
  pAVar3->setpos = '\0';
  pAVar3->plypos = '\0';
  bVar1 = false;
  if (GameSetup_gData.commMode == 1) {
    pcVar9 = "%s%sens.viv";
  }
  else {
    pcVar9 = "%s%seng.viv";
  }
  sprintf(acStack_80,pcVar9,Paths_Paths[28],carname);
  pcVar9 = (char *)loadbigfileheader(acStack_80,(void *)0x10);
  if (pcVar9 == (char *)0x0) {
    if (GameSetup_gData.commMode == 1) {
      pcVar9 = "%sp993ens.viv";
    }
    else {
      pcVar9 = "%sp993eng.viv";
    }
    sprintf(acStack_80,pcVar9,Paths_Paths[28]);
    pcVar9 = (char *)loadbigfileheader(acStack_80,(void *)0x10);
    if (pcVar9 == (char *)0x0) goto LAB_8007c1ac;
  }
  FILE_opensync(acStack_80,1,0x64,&local_40);   /* oracle 0x8007c03c: a3=&handle out */
  for (iVar15 = 0; iVar4 = bigcount(pcVar9), iVar15 < iVar4;
      iVar15 = iVar15 + 1) {
    pThis = locatebigentry(pcVar9,(char *)0x0,iVar15,&local_3c,&local_38);   /* oracle 0x8007c06c: a2=i a3=&offset stk=&size */
    iVar4 = wildcard((u_char *)pThis,"*.bnk");
    if ((iVar4 == 0) || (bVar1)) {
      iVar4 = wildcard((u_char *)pThis,"*.ltb");
      if ((iVar4 == 0) || (local_34 != (AudioEng_tDef *)0x0)) {
        iVar4 = wildcard((u_char *)pThis,"*.ctb");
        if ((iVar4 == 0) || (local_30[0] != (AudioEng_tDef *)0x0)) goto LAB_8007c190;
        ed = local_30;
      }
      else {
        ed = &local_34;
      }
      AudioEng_LoadDef(acStack_80,(char *)pThis,local_40,local_3c,local_38,ed);
    }
    else {
      pdata = reservememadr(pThis,local_38,0x10);
      if (pdata != (char *)0x0) {
        bVar1 = true;
        FILE_readsync(local_40,local_3c,pdata,local_38,0x64);   /* oracle 0x8007c0c8: a0=h a1=off a2=pdata a3=size stk=0x64 */
        iVar17 = AudioCmn_AddBank((char *)pThis,local_38,pdata,player);
        pAVar3->bhandle = (char)gSndBnk[player].bnkID;
      }
    }
LAB_8007c190: ;   /* empty stmt: gcc2.7.2 rejects label before '}' */
  }
  FILE_closesync(local_40,100);   /* oracle 0x8007c198/c1a0: a0=handle a1=0x64 (both were dropped) */
  purgememadr(pcVar9);
LAB_8007c1ac:
  if (!bVar1) {
    return iVar17;
  }
  if (local_30[0] == (AudioEng_tDef *)0x0) {
    return iVar17;
  }
  iVar15 = 0;
  if (local_34 == (AudioEng_tDef *)0x0) {
    return iVar17;
  }
  do {
    if (1 < iVar15) {
      dest = reservememadr("Engine Tables",name,0)
      ;
      pAVar3->tables = (char *)dest;
      for (iVar15 = 0; iVar15 < 2; iVar15 = iVar15 + 1) {
        iVar4 = 0;
        pAVar11 = local_30[0];
        if (iVar15 != 0) {
          pAVar11 = local_34;
        }
        iVar12 = 0;
        for (; iVar4 < 8; iVar4 = iVar4 + 1) {
          psVar5 = (short *)((int)&pAVar3->chan[0].min + iVar12);
          if (iVar15 != 0) {
            psVar5 = psVar5 + 0x30;
          }
          iVar13 = (int)*psVar5;
          puVar16 = dest;
          if (psVar5[1] != iVar13) {
            iVar14 = psVar5[1] - iVar13;
            *(u_char **)(psVar5 + 2) = dest;
            puVar16 = dest + iVar14;
            memcpy(dest,(u_char *)(pAVar11->pvoltable[0]->xlate + iVar13),iVar14);
          }
          pAVar11 = (AudioEng_tDef *)&pAVar11->ver;
          iVar12 = iVar12 + 0xc;
          dest = puVar16;
        }
      }
      purgememadr(local_34);
      purgememadr(local_30[0]);
      return iVar17;
    }
    pAVar11 = local_30[0];
    if (iVar15 != 0) {
      pAVar11 = local_34;
    }
    iVar4 = 0;
    if (pAVar11->resolved == '\0') {
      iVar14 = 0;
      iVar13 = 0x148;
      iVar12 = 0x128;
      pAVar10 = pAVar11;
      for (; iVar4 < 8; iVar4 = iVar4 + 1) {
        if (-1 < pAVar11->patchnum[iVar4]) {
          psVar5 = (short *)((int)&pAVar3->chan[0].min + iVar14);
          pAVar10->pvoltable[0] =
               (AudioEng_tTable *)
               (pAVar10->pvoltable[0]->xlate + (int)(pAVar11->patchnum + iVar12 + -0x20));
          pAVar10->pbendtable[0] =
               (AudioEng_tTable *)
               (pAVar10->pbendtable[0]->xlate + (int)(pAVar11->patchnum + iVar13 + -0x20));
          if (iVar15 != 0) {
            psVar5 = psVar5 + 0x30;
          }
          *(char *)(psVar5 + 4) = pAVar11->patchnum[iVar4];
          iVar7 = 0;
          if (pAVar10->pvoltable[0]->xlate[0] == '\0') {
            iVar2 = 1;
            do {
              iVar7 = iVar2;
              bVar1 = iVar7 < 0x200;
              if (!bVar1) goto LAB_8007c2c4;
              iVar2 = iVar7 + 1;
            } while (pAVar10->pvoltable[0]->xlate[iVar7] == '\0');
          }
          bVar1 = iVar7 < 0x200;
LAB_8007c2c4:
          *psVar5 = (short)iVar7;
          if (bVar1) {
            do {
              if (pAVar10->pvoltable[0]->xlate[iVar7] == '\0') break;
              iVar7 = iVar7 + 1;
            } while (iVar7 < 0x200);
          }
          psVar5[1] = (short)iVar7;
          name = name + ((int)(short)iVar7 - (int)*psVar5);
        }
        pAVar11->resolved = '\x01';
        pAVar10 = (AudioEng_tDef *)&pAVar10->ver;
        iVar14 = iVar14 + 0xc;
        iVar13 = iVar13 + 4;
        iVar12 = iVar12 + 4;
      }
    }
    iVar15 = iVar15 + 1;
  } while( true );
}

/* ---- AudioEng_StartServer__Fv  [@0x8007c434] ---- */
void AudioEng_StartServer(void)
{
  iSNDserveradd100hzclient((int)AudioEng_Update /* @0x8007b824 100Hz server callback */);
  return;
}

/* ---- AudioEng_StopServer__Fv  [@0x8007c458] ---- */
void AudioEng_StopServer(void)
{
  iSNDserverremove100hzclient((int)AudioEng_Update /* @0x8007b824 100Hz server callback */);
  return;
}

/* ---- AudioEng_Pause__Fv  [@0x8007c47c] ---- */
void AudioEng_Pause(void)
{
  int player;

  for (player = 0; player < 2; player++) {
    AudioEng_t *g = AudioEng_g[player];
    AudioEng_tState *s;

    if (g == (AudioEng_t *)0x0) break;
    if ((g->plypos == '\x0f') && ((g->setpos + 1U & 1) != 0)) break;
    s = g->queue + (u_char)g->setpos;
    s->vol = 0;
    s->esp = 0;
    s->dop = 0x1000;
    s->gas = '\0';
    s->exh = '\0';
    s->sep = 0;
    s->azi = 0;
    g->setpos = g->setpos + 1U & 0xf;
  }
  return;
}

/* ---- AudioEng_Resume__Fv  [@0x8007c52c] ---- */
void AudioEng_Resume(void)
{
  return;
}

/* ---- AudioEng_CleanUp__Fv  [@0x8007c534] ---- */
void AudioEng_CleanUp(void)
{
  /* SLD exposes only g=$s2 and i=$s1. Keeping the outer table as an array
     reference and indexing left/right from g reproduces retail's s5 base,
     s3 cursor, and s0=g anchor; the remaining four prologue diffs are the
     address-materialization scheduling choice (v0->s5 versus direct s5). */
  u_int noHandle;
  AudioEng_t *(&base)[2] = AudioEng_g;
  AudioEng_t **current;

  noHandle = 0xffffffff;
  current = base;
  while (true) {
    AudioEng_t *g;

    if ((int)(base + 2) <= (int)current) {
      return;
    }
    g = *current;
    if (g == (AudioEng_t *)0x0) {
      break;
    }
    {
      int i;

      for (i = 0; i < 0x10; i++) {
        if (g->left[i].handle != noHandle) {
          SNDstop(g->left[i].handle);
          if (g->right[i].handle != noHandle) {
            SNDstop(g->right[i].handle);
          }
          g->left[i].handle = noHandle;
          g->right[i].handle = noHandle;
        }
      }
    }
    purgememadr(g->tables);
    purgememadr(g);
    *current = (AudioEng_t *)0x0;
    current++;
  }
}
