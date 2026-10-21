/* game/common/audioeng.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   audioeng.obj (GAME\COMMON\AUDIOENG.CPP): 9 engine-audio functions.
 *   SYM-owned AudioEng_g state and the engine playback/update routines.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 *   Per-function anchors and in-body layout reproduce supplied source coordinates;
 *   coordinate equality is not a certificate of uniquely recovered original text.
 */
#include "audioeng_types.h"
#include "audioeng_externs.h"

/* SYM-INFERRED-MACRO-NAME: the mobile engine's sub_4DD240 retains the actual
 * allocation-failure printf and text below. Retail PSX has no call/string here,
 * but records its source line570 on the bank-arm exit. A disabled void-expression
 * diagnostic reproduces every byte, declaration, region and SLD tag; an empty
 * macro does not. This name is descriptive, not claimed as the original spelling.
 * The release form must not evaluate diagnostic arguments. */
#define AUDIOENG_DIAGNOSTIC(args) ((void)0)

/* Retail audioeng.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }


/* ---- audioeng.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
/* retail audioeng.obj .sdata: AudioEng_g @0x8013c734 comes BEFORE the "*.bnk" "*.tlb" "*.ctb"
 * literals AudioEng_StartUp uses (0x8013c73c..), so it is initialized (emitted at its
 * definition), not a deferred zero global. */
AudioEng_t   *AudioEng_g[2] = { 0, 0 };   /* @0x8013c734 */


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
/* P872: PASS159 with only SYM's parameters and locals g/a/s, no asm fences.
 * Native SLD224/226 support separate dop assignments in the two carType arms.
 * Keeping each complete call/store in its arm lets GCC merge their common tail
 * and retain the original argument homes. A shared temporary/call instead
 * required five argument aliases and two pitch carriers; all are removed. */
#line 204 "C:/nfs4/GAME/COMMON/AUDIOENG.CPP"
void AudioEng_Set(int player,int vol,int esp,int gas,int cam,int dop,int azi,int dir)
{ AudioEng_t *g; AudioEng_tAdjustments *a; AudioEng_tState *s;
  if ((u_int)player < 2) {


    g = AudioEng_g[player];

    if (g != (AudioEng_t *)0x0) {
      a = &g->adjust;



      if (g->plypos != '\x0f' || ((g->setpos + 1U & 1) == 0)) {


        s = g->queue + (u_char)g->setpos;
        s->esp = ((int)((u_int)a->timbreScale * esp) >> 0xe) < 0x200 ? (u_short)((int)((u_int)a->timbreScale * esp) >> 0xe)
        : 0x1ff;

        if (Cars_gList[player]->carInfo->carType == 0x1c) { s->dop = (u_short)((int)((u_int)g->adjust.pitchScale *
          fixedmult((esp >> 2) + 0xc000,dop)) >> 10);
        } else { s->dop = (u_short)((int)((u_int)g->adjust.pitchScale *
          fixedmult(esp + 0x3333,dop)) >> 10);
        }
        if (gas + (gas >> 5) + (gas >> 6) < 0x81) { s->gas = gas + (gas >> 5) + (gas >> 6); } else { s->gas = 0x80;
        }
        if (cam == 0) {

          s->exh = a->inCarExhaust;

          if (GameSetup_gData.commMode == 1) {

            s->sep = 0;
            s->azi = (u_short)azi;
          }
          else {

            s->azi = 0;
            s->sep = 0x3fff;
          } s->vol = ((int)(vol * (u_int)a->inCarBoost) >> 6) < 0x800 ? (u_short)((int)(vol * (u_int)a->inCarBoost) >> 6)
          : 0x7ff;
        }
        else {

          s->exh = a->outCarExhaust;

          if (dir < 0) { s->exh += ((int)(dir * (u_int)a->fwdEngBoost *
            (u_int)s->exh) >> 7) / 0x10000;
          } else { s->exh += ((int)(dir * (u_int)a->rwdExhBoost *
            (0x80 - (u_int)s->exh)) >> 7) / 0x10000;
          }
          s->azi = (u_short)azi;
          s->sep = 0;
          s->vol = ((int)(vol * (u_int)a->outCarBoost) >> 6) < 0x800 ? (u_short)((int)(vol * (u_int)a->outCarBoost) >> 6)
          : 0x7ff;
        }
        g->setpos = g->setpos + 1U & 0xf; } } } return;
}

/* ---- AudioEng_Update__Fv  [@0x8007b824] ---- */
/* P873: native SLD381/383 and 418/420 each hold one complete volume clamp.
 * Min/max lowering keeps the signed-byte value promoted to int through
 * the +/-2 adjustment, then store at each arm's tail. This removes the extra
 * rampedVolume local while preserving the retail signed reload for SNDvol;
 * PASS366. The old loop-head allocation operands were subsequently removed
 * in the 2026-10-19 ownership reconstruction below. */
/* Historical W55 receipt retained for provenance; its loop-shape and reference
 * requirements are superseded by the 2026-10-19 source ownership reconstruction. */
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
/* 2026-10-19: player is the real for-initializer object; pending-queue and
 * fresh-clock tests share one guard. n is only a channel counter, not a clock
 * result capture. Both channel loops are counted for loops. Playback options
 * and azimuths belong to the active valid-patch/nonzero-volume body.
 * This source form preserves all 366 words without the old empty memory-ref
 * asm. Ordinary conditional clamps use >= for max and <= for min, preserving
 * GCC's equality-selected operand order without GNU-only >?/<? operators.
 * 2026-10-20: all supplied SLD coordinates now match. Literal original
 * spelling remains unproved; no in-body line directives are used. */
#line 265 "C:/nfs4/GAME/COMMON/AUDIOENG.CPP"
void AudioEng_Update(void)
{








  for (int player = 0; player < 2; player++) {
    AudioEng_t *g; int n; AudioEng_tState *s; int tick;
    g = AudioEng_g[player];

    if (g == (AudioEng_t *)0x0) {
      return;
    }


    s = g->queue + (u_char)g->plypos;
    tick = gettick();

    if (g->plypos != g->setpos && g->tick < gettick())
    {
      g->tick = tick + 2;

      for (n = 0; n < 16; n++) {

        if ((signed char)g->chan[n].patchnum >= 0)
        {
          u_long vol;

          if ((s->esp >= g->chan[n].min) && (s->esp < g->chan[n].max)) {
            vol = (signed char)g->chan[n].xlate[s->esp - g->chan[n].min];
          } else {
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
              } else {
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

    for (n = 0; n < 16; n++) {

      if ((signed char)g->chan[n].patchnum >= 0)
      {
        if (g->vol[n] != 0)
        {
          SNDPLAYOPTS playopts;
          u_short leftazim;
          u_short rightazim;
          if ((signed char)g->chan[n].patchnum >= 64) {

            leftazim = g->azi - g->sep;
            rightazim = g->azi + g->sep;
          }
          else {
            leftazim = g->azi; rightazim = leftazim;
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

              if ((signed char)g->left[n].vol != g->vol[n]) {

                if (g->vol[n] < (signed char)g->left[n].vol) {
                  g->left[n].vol = (((signed char)g->left[n].vol - 2) >= g->vol[n] ? ((signed char)g->left[n].vol - 2) : g->vol[n]);
                } else {
                  g->left[n].vol = (((signed char)g->left[n].vol + 2) <= g->vol[n] ? ((signed char)g->left[n].vol + 2) : g->vol[n]);
                } SNDvol(g->left[n].handle,
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

                g->delay[n]--; if ((signed char)g->delay[n] == -1) {
                  playopts.azimuth = rightazim;

                  g->right[n].handle = SNDplay(&playopts);

                  g->right[n].vol = 0;
                  g->right[n].azim = rightazim;
                  g->right[n].pitch = g->dop;
                }
              }
              else {

                if ((signed char)g->right[n].vol != g->vol[n]) {

                  if (g->vol[n] < (signed char)g->right[n].vol) {
                    g->right[n].vol = (((signed char)g->right[n].vol - 2) >= g->vol[n] ? ((signed char)g->right[n].vol - 2) : g->vol[n]);
                  } else {
                    g->right[n].vol = (((signed char)g->right[n].vol + 2) <= g->vol[n] ? ((signed char)g->right[n].vol + 2) : g->vol[n]);
                  } SNDvol(g->right[n].handle,
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
            SNDstop(g->right[n].handle); }
          g->left[n].handle = -1;
          g->right[n].handle = -1;
        }
      }
    }
  } }

/* ---- AudioEng_LoadDef__FPcT0illPP13AudioEng_tDef  [@0x8007bddc] ---- */
#line 459 "C:/nfs4/GAME/COMMON/AUDIOENG.CPP"
void AudioEng_LoadDef(char *filename,char *name,int handle,long offset,long size,AudioEng_tDef **ed)
{
  *ed = (AudioEng_tDef *)reservememadr(name,size,0x10);

  if (*ed != (AudioEng_tDef *)0x0) {

    FILE_readsync(handle,offset,*ed,size,0x64);   /* oracle 0x8007be1c: a0=h a1=off a2=*ed a3=size stk=0x64 */
  }




  return; }

/* ---- AudioEng_StartUp__FiPc  [@0x8007be54] ---- */
/* 2026-10-19: the file handle belongs inside the header-success guard and
 * the file-entry i is a for-initializer. Successful bank/definition loading
 * owns current and the two c-scoped processing loops. The 2026-10-20 SLD pass
 * restores both c objects as for-initializer owners, removing the older explicit
 * scopes/while loops without changing code or declaration/region contracts.
 * Both inferred chanbase objects are removed: widen the actual channel-field
 * base, add the signed word-sized element offset, then narrow the full address
 * to the PSX pointer word. All 376 words match without an address-holder local.
 * Plain SI-only addresses and widened index multiplication do not share this
 * codegen. Exact original cast/macro spelling and full SLD remain unproved;
 * the older 374/376 direct-field failure was not a source-object necessity. */
/* 2026-10-20: the final two tag differences were the missing allocation-failure
 * diagnostic arm, independently retained by the mobile twin. Its disabled release
 * expansion supplies line570 without an explicit continue/goto or a changed pdata
 * owner. All supplied SLD coordinates now match; the macro's literal spelling and
 * its exact original definition remain unproven. No in-body line override. */
#line 477 "C:/nfs4/GAME/COMMON/AUDIOENG.CPP"
int AudioEng_StartUp(int player,char *carname)
{ AudioEng_tDef *cruisedef; AudioEng_tDef *loaddef; int tablesize; int i; int bankloaded; int spu; char filename[64]; AudioEng_t *g; char *header;
  if (1 < (u_int)player) {
    return 0;
  }
  if (AudioEng_g[player] != (AudioEng_t *)0x0) {
    return 0;
  }
  tablesize = 0;
  spu = tablesize;


  g = AudioEng_g[player] = (AudioEng_t *)reservememadr("Engine Audio",0x370,tablesize);

  g->tables = (char *)0x0;

  g->tick = 0;

  g->azi = 0;
  g->sep = 0;
  g->dop = 0x1000;

  for (i = tablesize; i < 16; i++) {

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
  if (GameSetup_gData.commMode == 1) {
    sprintf(filename,"%s%sens.viv",Paths_Paths[28],carname);
  } else {
    sprintf(filename,"%s%seng.viv",Paths_Paths[28],carname);
  }
  header = (char *)loadbigfileheader(filename,(void *)16);

  if (header == (char *)0x0) {

    if (GameSetup_gData.commMode == 1) {
      sprintf(filename,"%sp993ens.viv",Paths_Paths[28]);
    } else {
      sprintf(filename,"%sp993eng.viv",Paths_Paths[28]); }
    header = (char *)loadbigfileheader(filename,(void *)16);
  }

  if (header != (char *)0x0)
  {
    int handle;

    FILE_opensync(filename,1,100,&handle);

    for (int i = 0; i < bigcount(header); i++) {
      long size;
      long offset;
      char *name;

      name = (char *)locatebigentry(header,(char *)0x0,i,(int *)&offset,(unsigned int *)&size);

      if ((wildcard((u_char *)name,"*.bnk") != 0) && !bankloaded)
      {
        char *pdata;


        pdata = (char *)reservememadr(name,size,16);

        if (pdata != (char *)0x0) {

          FILE_readsync(handle,offset,pdata,size,100);
          spu = AudioCmn_AddBank(name,size,pdata,player);
          g->bhandle = (char)gSndBnk[player].bnkID;
          bankloaded = 1;
        } else {

          AUDIOENG_DIAGNOSTIC(("Out of memory loading '%s'\n",name));
        } }
      else if ((wildcard((u_char *)name,"*.ltb") != 0) && (loaddef == (AudioEng_tDef *)0x0)) {
        AudioEng_LoadDef(filename,name,handle,offset,size,&loaddef); } else if ((wildcard((u_char *)name,"*.ctb") != 0) &&
      (cruisedef == (AudioEng_tDef *)0x0)) {
        AudioEng_LoadDef(filename,name,handle,offset,size,&cruisedef);
      }

    }
    FILE_closesync(handle,100);
    purgememadr(header);
  }

  if (bankloaded && cruisedef != (AudioEng_tDef *)0x0 && loaddef != (AudioEng_tDef *)0x0)
  {
    char *current;  for (int c = 0; c < 2; c++) {
        AudioEng_tDef *ed;


        if (c != 0) { ed = loaddef; } else { ed = cruisedef;
        }

        if (ed->resolved == 0)
        {
          for (i = 0; i < 8; i++) {

            if ((signed char)ed->patchnum[i] >= 0)
            {
              AudioEng_tChanAttr *chan;
              int j; ed->pvoltable[i] = (AudioEng_tTable *)((char *)&ed->pvoltable[i] +
              (int)ed->pvoltable[i]);
              ed->pbendtable[i] =
              (AudioEng_tTable *)((char *)&ed->pbendtable[i] +

              (int)ed->pbendtable[i]);

              chan = (AudioEng_tChanAttr *)(int)((long long)(int)g->chan + i * (int)sizeof(AudioEng_tChanAttr)); if (c != 0) { chan += 8;
              }
              chan->patchnum = ed->patchnum[i];
              j = 0;


              while ((j < 512) && ((signed char)ed->pvoltable[i]->xlate[j] == 0))
              j++;
              chan->min = j;

              while ((j < 512) && ((signed char)ed->pvoltable[i]->xlate[j] != 0))
              j++;
              chan->max = j;

              tablesize += chan->max - chan->min;
            }
            ed->resolved = 1;
          }
        }
        }
     g->tables = (char *)reservememadr("Engine Tables",tablesize,0);
      current = g->tables;





      for (int c = 0; c < 2; c++) {
        AudioEng_tDef *ed;
        if (c != 0) { ed = loaddef; } else { ed = cruisedef;
        }
        for (i = 0; i < 8; i++) {
          AudioEng_tChanAttr *chan; chan = (AudioEng_tChanAttr *)(int)((long long)(int)g->chan + i * (int)sizeof(AudioEng_tChanAttr));
          if (c != 0) { chan += 8;
          }
          if (chan->max != chan->min)
          {
            int size; size = chan->max - chan->min;

            chan->xlate = current;
            memcpy(current,ed->pvoltable[i]->xlate + chan->min,size);
            current += size;
          }
        }
        }
    purgememadr(loaddef);
    purgememadr(cruisedef);
  }
  return spu;
}

/* ---- AudioEng_StartServer__Fv  [@0x8007c434] ----
 * One callback-registration call and implicit void fallthrough reproduce
 * all nine retail words, SLD tags and block/function-end lines. */
#line 659 "C:/nfs4/GAME/COMMON/AUDIOENG.CPP"
void AudioEng_StartServer(void)
{
  iSNDserveradd100hzclient((int)AudioEng_Update /* @0x8007b824 100Hz server callback */); }

/* ---- AudioEng_StopServer__Fv  [@0x8007c458] ----
 * The matching deregistration wrapper has the same nine-word/SLD receipt. */
#line 666 "C:/nfs4/GAME/COMMON/AUDIOENG.CPP"
void AudioEng_StopServer(void)
{
  iSNDserverremove100hzclient((int)AudioEng_Update /* @0x8007b824 100Hz server callback */); }

/* ---- AudioEng_Pause__Fv  [@0x8007c47c] ---- */
#line 673 "C:/nfs4/GAME/COMMON/AUDIOENG.CPP"
void AudioEng_Pause(void)
{
  for (int player = 0; player < 2; player++) {

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
  } return; }

/* ---- AudioEng_Resume__Fv  [@0x8007c52c] ---- */
#line 701 "C:/nfs4/GAME/COMMON/AUDIOENG.CPP"
void AudioEng_Resume(void)
{ return;
}

/* ---- AudioEng_CleanUp__Fv  [@0x8007c534] ---- */
/* SOURCE-REVIEW-UNRESOLVED: player is an inferred two-engine index, not a
 * supplied PSX local. The confirmed PC twin's explicit player argument supports
 * that role, not a unique original identifier or distinct source-object need.
 * The indexed loop is 56/56 PASS and replaced three older base/current/handle
 * aliases. Retail retains the table walk in s3 and base in s5 with no named
 * index record. Native CLEAN does not certify this source producer/spelling. */
#line 707 "C:/nfs4/GAME/COMMON/AUDIOENG.CPP"
void AudioEng_CleanUp(void)
{ int player;
  for (player = 0; player < 2; player++) {
    AudioEng_t *g;
    g = AudioEng_g[player];

    if (g == (AudioEng_t *)0x0) {
      break;
    }
    { int i; for (i = 0; i < 0x10; i++) {

        if (g->left[i].handle != 0xffffffff) {

          SNDstop(g->left[i].handle);
          if (g->right[i].handle != 0xffffffff) {
            SNDstop(g->right[i].handle); }
          g->left[i].handle = 0xffffffff;
          g->right[i].handle = 0xffffffff;
        }
      } }
    purgememadr(g->tables);
    purgememadr(g);
    AudioEng_g[player] = (AudioEng_t *)0x0;
  }
}
