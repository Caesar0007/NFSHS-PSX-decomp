/* game/common/audioeng.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "audioeng_types.h"
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
/* MATCH: PASS 159/159.  The carType arms require their explicit retail layout:
 * shifted pitch first, normal pitch out-of-line.  Zero-insn arm/use fences keep
 * reorg from speculating the normal add into the branch slot; the post-dop
 * statement fence keeps gas>>6 on its SLD statement. */
void AudioEng_Set(int player,int vol,int esp,int gas,int cam,int dop,int azi,int dir)
{
  AudioEng_t *g;
  AudioEng_tAdjustments *a;
  AudioEng_tState *s;
  /* MATCH: snapshot the consumed parameters in retail source order.  GCC then
     emits the exact s7/s5/a1/s6/s3/s4 prologue handout and load sequence. */
  const int volume = vol;
  const int camera = cam;
  const int doppler = dop;
  const int azimuth = azi;
  const int gasLevel = gas;
  const int direction = dir;
  int adjustedEsp;
  int shiftedEsp;

  if ((u_int)player < 2) {
    g = AudioEng_g[player];
    if (g != (AudioEng_t *)0x0) {
      a = &g->adjust;
      if (g->plypos != '\x0f' || ((g->setpos + 1U & 1) == 0)) {
        s = g->queue + (u_char)g->setpos;
        s->esp = ((int)((u_int)a->timbreScale * esp) >> 0xe) < 0x200
                     ? (u_short)((int)((u_int)a->timbreScale * esp) >> 0xe)
                     : 0x1ff;
        if (Cars_gList[player]->carInfo->carType == 0x1c) {
          shiftedEsp = esp >> 2;
          /* MATCH: issue the shift before the independent 0xc000 materialization. */
          __asm__("" : : "r"(shiftedEsp));
          adjustedEsp = 0xc000;
          adjustedEsp += shiftedEsp;
        }
        else {
          /* MATCH: arm-head barrier keeps the normal add out of the branch slot. */
          adjustedEsp = esp + 0x3333;
        }
        s->dop = (u_short)((int)((u_int)g->adjust.pitchScale *
            fixedmult(adjustedEsp,doppler)) >> 10);
        /* MATCH: SLD boundary; prevents gas>>6 from crossing the dop store. */
        __asm__("" : : "i"(0));
        if (gasLevel + (gasLevel >> 5) + (gasLevel >> 6) < 0x81) {
          s->gas = gasLevel + (gasLevel >> 5) + (gasLevel >> 6);
        }
        else {
          s->gas = 0x80;
        }
        if (camera == 0) {
          s->exh = a->inCarExhaust;
          if (AudioEng_GameSetupWords[3] == 1) {
            s->sep = 0;
            s->azi = (u_short)azimuth;
          }
          else {
            s->azi = 0;
            s->sep = 0x3fff;
          }
          s->vol = ((int)(volume * (u_int)a->inCarBoost) >> 6) < 0x800
                       ? (u_short)((int)(volume * (u_int)a->inCarBoost) >> 6)
                       : 0x7ff;
        }
        else {
          s->exh = a->outCarExhaust;
          if (direction < 0) {
            s->exh += ((int)(direction * (u_int)a->fwdEngBoost *
                             (u_int)s->exh) >> 7) / 0x10000;
          }
          else {
            s->exh += ((int)(direction * (u_int)a->rwdExhBoost *
                             (0x80 - (u_int)s->exh)) >> 7) / 0x10000;
          }
          s->azi = (u_short)azimuth;
          s->sep = 0;
          s->vol = ((int)(volume * (u_int)a->outCarBoost) >> 6) < 0x800
                       ? (u_short)((int)(volume * (u_int)a->outCarBoost) >> 6)
                       : 0x7ff;
        }
        g->setpos = g->setpos + 1U & 0xf;
      }
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
      /* MATCH (w55-a12 + 2026-08-11, 28 -> 26 -> PASS 366/366): retail's
       * second channel loop is UN-rotated -- `slti;beqz;nop` at the loop head
       * and an unconditional `j` back-edge with the increment in its slot.
       * `for (;;) { if (n >= 16) break; ... }` lets gcc-2.8 prove n==0 on
       * entry, peel the first test and rotate the loop (test at the bottom,
       * 2 insns short).  The `while (1) { if (!(n < 16)) break; ... }`
       * spelling reproduces retail's top-test + j back-edge.  The remaining
       * 26 were only the three induction variables colored in the wrong
       * order.  allocsim priced the generated walks at n=p98 refs29/live237,
       * delay=p573 refs20/live159 and vol=p578 refs17/live158.  Empty memory
       * operands at the LOOP HEAD buy the weighted refs without emitting
       * loads: vol x2 + delay x3 gives retail delay=$s4, vol=$s5, n=$s6.
       * Placement is essential: the identical operand set at the loop tail
       * reached 8 diffs but retained the wrong base-copy chain and moved the
       * s0+=12 increment; at the head both schedules match exactly. */
      while (1) {
        if (!(n < 16)) {
          break;
        }
        __asm__("" : : "m"(g->vol[n]), "m"(g->vol[n]),
                         "m"(g->delay[n]), "m"(g->delay[n]),
                         "m"(g->delay[n]));
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
  AudioEng_tDef *cruisedef;
  AudioEng_tDef *loaddef;
  int tablesize;
  int i;
  int bankloaded;
  int spu;
  char filename[64];
  AudioEng_t *g;
  AudioEng_t **gslot;
  char *header;
  
  if (1 < (u_int)player) {
    return 0;
  }
  gslot = &AudioEng_g[player];
  if (*gslot != (AudioEng_t *)0x0) {
    return 0;
  }
  tablesize = 0;
  spu = tablesize;
  g = (AudioEng_t *)reservememadr("Engine Audio",0x370,tablesize);
  i = tablesize;
  *gslot = g;
  g->tables = (char *)0x0;
  g->tick = 0;
  g->azi = 0;
  g->sep = 0;
  g->dop = 0x1000;
  for (; i < 16; i++) {
    g->vol[i] = 0;
    g->left[i].handle = -1;
    g->right[i].handle = -1;
    *(signed char *)&g->chan[i].patchnum = -1;
    g->chan[i].min = 0x200;
    g->chan[i].max = 0x200;
    g->chan[i].xlate = (char *)0x0;
  }
  cruisedef = (AudioEng_tDef *)0x0;
  loaddef = (AudioEng_tDef *)0x0;
  (g->adjust).inCarBoost = '2';
  (g->adjust).inCarExhaust = '\x1f';
  (g->adjust).outCarBoost = 0xa6;
  (g->adjust).outCarExhaust = '+';
  (g->adjust).fwdEngBoost = '@';
  (g->adjust).rwdExhBoost = 'y';
  (g->adjust).pitchScale = 'P';
  (g->adjust).timbreScale = 'h';
  g->setpos = '\0';
  g->plypos = '\0';
  bankloaded = 0;
  if (AudioEng_GameSetupWords[3] == 1) {
    sprintf(filename,"%s%sens.viv",Paths_Paths[28],carname);
  }
  else {
    sprintf(filename,"%s%seng.viv",Paths_Paths[28],carname);
  }
  header = (char *)loadbigfileheader(filename,(void *)16);
  if (header == (char *)0x0) {
    if (AudioEng_GameSetupWords[3] == 1) {
      sprintf(filename,"%sp993ens.viv",Paths_Paths[28]);
    }
    else {
      sprintf(filename,"%sp993eng.viv",Paths_Paths[28]);
    }
    header = (char *)loadbigfileheader(filename,(void *)16);
  }
  {
    int handle;

    if (header != (char *)0x0) {
      FILE_opensync(filename,1,100,&handle);
      {
        int i;

        for (i = 0; i < bigcount(header); i++) {
          long size;
          long offset;
          char *name;

          name = (char *)locatebigentry(header,(char *)0x0,i,&offset,&size);
          if ((wildcard((u_char *)name,"*.bnk") != 0) && !bankloaded) {
            char *pdata;

            pdata = (char *)reservememadr(name,size,16);
            if (pdata != (char *)0x0) {
              bankloaded = 1;
              FILE_readsync(handle,offset,pdata,size,100);
              spu = AudioCmn_AddBank(name,size,pdata,player);
              g->bhandle = (char)AudioEng_gSndBnkWords[player][0];
            }
          }
          else if ((wildcard((u_char *)name,"*.ltb") != 0) &&
                   (loaddef == (AudioEng_tDef *)0x0)) {
            AudioEng_LoadDef(filename,name,handle,offset,size,&loaddef);
          }
          else if ((wildcard((u_char *)name,"*.ctb") != 0) &&
                   (cruisedef == (AudioEng_tDef *)0x0)) {
            AudioEng_LoadDef(filename,name,handle,offset,size,&cruisedef);
          }
        }
      }
      FILE_closesync(handle,100);
      purgememadr(header);
    }
  }
  if (!bankloaded) {
    return spu;
  }
  if (cruisedef == (AudioEng_tDef *)0x0) {
    return spu;
  }
  if (loaddef == (AudioEng_tDef *)0x0) {
    return spu;
  }
  {
    char *current;
    {
      AudioEng_tChanAttr *chanbase;
      int c;

      c = 0;
      chanbase = g->chan;
      for (; c < 2; c++) {
        AudioEng_tDef *ed;

        if (c != 0) {
          ed = loaddef;
        }
        else {
          ed = cruisedef;
        }
        if (ed->resolved == 0) {
          for (i = 0; i < 8; i++) {
            if ((signed char)ed->patchnum[i] >= 0) {
              AudioEng_tChanAttr *chan;
              int j;

              ed->pvoltable[i] =
                  (AudioEng_tTable *)((char *)&ed->pvoltable[i] +
                                      (int)ed->pvoltable[i]);
              ed->pbendtable[i] =
                  (AudioEng_tTable *)((char *)&ed->pbendtable[i] +
                                      (int)ed->pbendtable[i]);
              chan = chanbase + i;
              if (c != 0) {
                chan += 8;
              }
              chan->patchnum = ed->patchnum[i];
              j = 0;
              while ((j < 512) &&
                     ((signed char)ed->pvoltable[i]->xlate[j] == 0)) {
                j++;
              }
              chan->min = j;
              while ((j < 512) &&
                     ((signed char)ed->pvoltable[i]->xlate[j] != 0)) {
                j++;
              }
              chan->max = j;
              tablesize += chan->max - chan->min;
            }
            ed->resolved = 1;
          }
        }
      }
    }
    {
      AudioEng_tChanAttr *chanbase;
      int c;

      current = g->tables =
          (char *)reservememadr("Engine Tables",tablesize,0);
      c = 0;
      chanbase = g->chan;
      for (; c < 2; c++) {
        AudioEng_tDef *ed;

        if (c != 0) {
          ed = loaddef;
        }
        else {
          ed = cruisedef;
        }
        for (i = 0; i < 8; i++) {
          AudioEng_tChanAttr *chan;

          chan = chanbase + i;
          if (c != 0) {
            chan += 8;
          }
          if (chan->max != chan->min) {
            int size;

            size = chan->max - chan->min;
            chan->xlate = current;
            memcpy(current,ed->pvoltable[i]->xlate + chan->min,size);
            current += size;
          }
        }
      }
    }
    purgememadr(loaddef);
    purgememadr(cruisedef);
  }
  return spu;
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
