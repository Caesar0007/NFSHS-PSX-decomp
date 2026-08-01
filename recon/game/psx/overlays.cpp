/* game/psx/overlays.cpp -- RECONSTRUCTED (NFS4 PSX race-summary / stats HUD; C++ TU)
 *   5 fns: OptionsBarThing, Hud_RenderStatsView, RaceSummary, RaceStatistics, Hud_BTCStats
 *   -- all reconstructed with full SYM-locals applied (0 missing, audited). No GTE.
 */
#include "../../nfs4_types.h"
#include "overlays_externs.h"

/* gp-rel owning-TU defs (section 3.12 #6): overlays.obj OWNS these (the SYM's overlays.obj
   band defines Hud_NextPerp @0x8013d994 and StatsTimer @0x8013d998), and the oracles reach
   them via %gp_rel -- which only happens for a <=G4 object defined (not just declared) in
   this TU.  StatsTimer's two words are separate 4-byte symbols for exactly that reason.
   CAUTION (documented dual-model tradeoff, catalog section E): hud_externs.h still declares
   StatsTimer as `int StatsTimer[2]`.  The two 4-byte .comm symbols land adjacently in .sbss
   in declaration order, so that array view still reaches both words -- but if StatsTimer or
   D_8013D99C ever gains an initializer or another owner, re-check that adjacency. */
short Hud_NextPerp[2];
int StatsTimer;
int D_8013D99C;


/* ---- OptionsBarThing__Fiiii  [OVERLAYS.CPP:39-47] SLD-VERIFIED ---- */
void OptionsBarThing(int x,int y,int w,int h)

{
  char *str;
  int width;

  Hud_GoTpage(1);
  str = TextSys_Word(0x40);
  width = Hud_BuildString(TextSys_Word(0x40),0,0,0,0,1);
  Hud_BuildString(str,0xa0 - (width >> 1),y + h + -6,0xbebe,0,0);
  Hud_FBuildF4(0,x,y + h + -8,w,8,0,'\0','\0');
  Hud_GoTpage(0);
  return;
}

/* ---- RaceSummary__Fv  [OVERLAYS.CPP:53-158] SLD-VERIFIED ---- */
void RaceSummary(void)

{
  short i;
  int pos;
  short HUD_STATS_POS_X;
  short HUD_STATS_SIZE_W;
  short HUD_STATS_SIZE_H;
  short HUD_STATS_POS_Y;
  short colpos;
  short colname;
  short colcar;
  short coltime;
  short colbestlap;
  char string [40];
  int halfH;
  int titleY;
  int headerY;
  int dataY;
  int barH;
  int titleX;
  int color;

  HUD_STATS_POS_X = 8;
  if (GameSetup_gData.numLaps == 1) {
    HUD_STATS_POS_X = 0x28;
  }
  HUD_STATS_SIZE_W = 0x130;
  if (GameSetup_gData.numLaps == 1) {
    HUD_STATS_SIZE_W = 0xef;
  }
  HUD_STATS_SIZE_H = (short)((Cars_gNumRaceCars + 1) * 0xc + 0x1e);
  halfH = (int)(HUD_STATS_SIZE_H << 0x10) >> 0x11;
  HUD_STATS_POS_Y = (short)(0x78 - halfH);
  colpos = HUD_STATS_POS_X;
  colname = HUD_STATS_POS_X + 0x11;
  colcar = HUD_STATS_POS_X + 0x5f;
  coltime = HUD_STATS_POS_X + 0xa7;
  colbestlap = HUD_STATS_POS_X + 0xe1;
  titleX = 0xa0 - (textpixels(TextSys_Word(0x38)) >> 1);
  titleY = 0x76 - halfH;
  Font_TextColor(6);
  Font_TextXY(TextSys_Word(0x38),titleX * 0x10000 >> 0x10,titleY);
  Font_TextColor(3);
  headerY = (titleY + 0xf) * 0x10000 >> 0x10;
  Font_TextXY(TextSys_Word(0x2e),colname,headerY);
  Font_TextXY(TextSys_Word(0x3a),colcar,headerY);
  Font_TextXY(TextSys_Word(0x3b),coltime,headerY);
  if (GameSetup_gData.numLaps != 1) {
    Font_TextXY(TextSys_Word(0x3c),colbestlap,headerY);
  }
  dataY = (titleY + 0x11) * 0x10000 >> 0x10;
  Hud_FBuildF4(0,HUD_STATS_POS_X,dataY + 0xc,(u_short)HUD_STATS_SIZE_W,1,0,'\0','\0');
  barH = HUD_STATS_SIZE_H + -8;
  Hud_FBuildF4(0,colname + -2,HUD_STATS_POS_Y,1,barH,0,'\0','\0');
  Hud_FBuildF4(0,colcar + -2,HUD_STATS_POS_Y,1,barH,0,'\0','\0');
  Hud_FBuildF4(0,coltime + -2,HUD_STATS_POS_Y,1,barH,0,'\0','\0');
  if (GameSetup_gData.numLaps != 1) {
    Hud_FBuildF4(0,colbestlap + -2,HUD_STATS_POS_Y,1,barH,0,'\0','\0');
  }
  i = 0;
  while (1) {
    if (Cars_gNumRaceCars <= i) break;
    pos = Cars_gRaceCarList[i]->stats.finalPosition;
    if (pos * 2 + 4 < StatsTimer) {
      color = 4;
      if ((Cars_gRaceCarList[i]->carFlags & 4U) != 0) {
        color = 3;
      }
      Font_TextColor(color);
      sprintf(string,"%d",pos);
      Font_TextXY(string,colpos | 1,dataY + pos * 0xc);
      Font_TextColor(3);
      sprintf(string,"%s",(char *)(*(int *)((int)Cars_gRaceCarList[i] + 0x288) + 0x5c));
      Font_TextXY(string,colname,dataY + pos * 0xc);
      color = 4;
      if ((*(u_int *)((int)Cars_gRaceCarList[i] + 0x260) & 4) != 0) {
        color = 3;
      }
      Font_TextColor(color);
      sprintf(string,"%s",Cars_gRaceCarList[i]->carNameLocalized);
      Font_TextXY(string,colcar,dataY + pos * 0xc);
      if (GameSetup_gData.pinkSlipsForfeit == i) {
        sprintf(string,TextSys_Word(0x36));
      }
      else if ((GameSetup_gData.raceType == 1) &&
               (Cars_gRaceCarList[i]->stats.finalNumArrests != 0)) {
        sprintf(string,TextSys_Word(0x3d));
      }
      else if (*(int *)((int)Cars_gRaceCarList[i] + 0x3cc) != 2) {
        sprintf(string,TextSys_Word(0x35));
      }
      else {
        Hud_ParseTime(*(int *)((int)Cars_gRaceCarList[i] + 0x3d4),string);
      }
      Font_TextXY(string,coltime,dataY + pos * 0xc);
      if (GameSetup_gData.numLaps != 1) {
        Hud_ParseTime(*(int *)((int)Cars_gRaceCarList[i] + 0x3e8),string);
        Font_TextXY(string,colbestlap,dataY + pos * 0xc);
      }
    }
    i = i + 1;
  }
  OptionsBarThing(HUD_STATS_POS_X,HUD_STATS_POS_Y,(u_short)HUD_STATS_SIZE_W,(int)HUD_STATS_SIZE_H);
  Hud_RenderPauseBox(HUD_STATS_POS_X,HUD_STATS_POS_Y,(u_short)HUD_STATS_SIZE_W,(int)HUD_STATS_SIZE_H);
  return;
}

/* ---- RaceStatistics__Fv  [OVERLAYS.CPP:165-321] SLD-VERIFIED ---- */
void RaceStatistics(void)

{
  short i;
  short j;
  short col1;
  short col2;
  int colmid;
  short HUD_STATS_POS_X;
  short HUD_STATS_SIZE_W;
  short HUD_STATS_SIZE_H;
  short HUD_STATS_POS_Y;
  short HUD_STATS_HOTPURSUIT_Y;
  char string [40];
  int halfH;
  int titleX;
  int titleY;
  int posy;
  int dataY;
  int barH;
  int color;
  int rowY;
  Car_tObj *car;
  int t;

  HUD_STATS_SIZE_W = (short)(Cars_gNumHumanRaceCars * 0x96);
  HUD_STATS_SIZE_H = (GameSetup_gData.numLaps + 1) * 0xc + 0x28;
  HUD_STATS_POS_X = (short)(0xa0 - Cars_gNumHumanRaceCars * 0x4b);
  if (GameSetup_gData.numLaps == 1) {
    HUD_STATS_SIZE_H = 0x34;
  }
  if (GameSetup_gData.raceType == 1) {
    HUD_STATS_SIZE_H = HUD_STATS_SIZE_H + 0x1b;
  }
  halfH = (int)((u_int)(u_short)HUD_STATS_SIZE_H << 0x10) >> 0x11;
  posy = 0x78 - halfH;
  HUD_STATS_POS_Y = (short)posy;
  titleX = 0xa0 - (textpixels(TextSys_Word(0x39)) >> 1);
  col1 = HUD_STATS_POS_X + 0xa;
  col2 = 0xa0;
  titleY = 0x76 - halfH;
  HUD_STATS_HOTPURSUIT_Y = (short)(titleY + (GameSetup_gData.numLaps + 2) * 0xc + 0x13);
  if (1 < Cars_gNumHumanRaceCars) {
    col2 = 0x55;
  }
  Font_TextColor(6);
  Font_TextXY(TextSys_Word(0x39),titleX * 0x10000 >> 0x10,titleY);
  dataY = (titleY + 0x11) * 0x10000 >> 0x10;
  Hud_FBuildF4(0,HUD_STATS_POS_X,dataY + 0xb,(int)HUD_STATS_SIZE_W,1,0,'\0','\0');
  if (GameSetup_gData.raceType == 1) {
    Hud_FBuildF4(0,HUD_STATS_POS_X,(int)HUD_STATS_HOTPURSUIT_Y * 0x10000 >> 0x10,(int)HUD_STATS_SIZE_W,1,0,'\0','\0');
  }
  i = 0;
  barH = (int)((u_int)(u_short)HUD_STATS_SIZE_H << 0x10) >> 0x10;
  while (1) {
    if (Cars_gNumHumanRaceCars <= (int)i) break;
    car = Cars_gRaceCarList[i];
    colmid = col2 - ((textpixels(car->carInfo->driver) >> 1) + 2);
    Hud_FBuildF4(0,col2 + -2,dataY + 0xb,1,barH - ((dataY - posy) + 0x13),0,'\0','\0');
    if (0 < (int)i) {
      Hud_FBuildF4(0,col1 + -2,posy,1,barH + -8,0,'\0','\0');
    }
    if (2 < D_8013D99C) {
      Font_TextColor(3);
      sprintf(string,"%s",Cars_gRaceCarList[i]->carInfo->driver);
      /* CORRECTNESS (w39-a4): the Y arg is dataY-4, NOT (-halfH)-4.  Raw oracle
         @0x800DA2D0 `addiu $a2,$s3,-0x4` with $s3 = dataY (set once @0x800DA1AC from
         the (titleY+0x11) sign-extend).  The old `negH + -4` drew the driver name
         0x87 px too high. */
      Font_TextXY(string,colmid,dataY + -4);
    }
    /* NOT `a && b`: the oracle keeps two separate compares off ONE load
       (`beq $v0,1` @0x800DA2E0 then `blez $v0` @0x800DA2EC); the &&-form lets gcc
       range-fold them into a single `slti v0,v0,2`. */
    if (GameSetup_gData.numLaps != 1) {
     if (0 < GameSetup_gData.numLaps) {
      j = 0;
      do {
        if ((int)j * 2 + 4 < D_8013D99C) {
          t = (Cars_gHumanRaceCarList[i]->stats).finalLapTime[j];
          if ((t == 0) || (color = 3, t != (Cars_gHumanRaceCarList[i]->stats).finalBestLap)) {
            color = 4;
          }
          Font_TextColor(color);
          sprintf(string,TextSys_Word(0x34),(int)j + 1);
          Font_TextXY(string,(int)col1,dataY + (int)j * 0xc + 0xc);
          t = (Cars_gHumanRaceCarList[i]->stats).finalLapTime[j];
          if (t == 0) {
            t = 0;
          }
          Hud_ParseTime(t,string);
          Font_TextXY(string,col2 + 5,dataY + (int)j * 0xc + 0xc);
        }
        j = j + 1;
      } while ((int)j < GameSetup_gData.numLaps);
     }
    }
    if (GameSetup_gData.numLaps * 2 + 4 < D_8013D99C) {
      sprintf(string,TextSys_Word(0x37));
      Font_TextColor(3);
      rowY = dataY + GameSetup_gData.numLaps * 0xc;
      if (GameSetup_gData.numLaps != 1) {
        rowY = rowY + 0xc;
      }
      Font_TextXY(string,(int)col1,rowY);
      car = Cars_gHumanRaceCarList[i];
      if (GameSetup_gData.pinkSlipsForfeit == i) {
        sprintf(string,TextSys_Word(0x36));
      }
      else if ((car->stats).finalFinishType != 2) {
        if ((GameSetup_gData.raceType == 1) && ((car->stats).finalNumArrests != 0)) {
          sprintf(string,TextSys_Word(0x3d));
        }
        else {
          sprintf(string,TextSys_Word(0x35));
        }
      }
      else {
        Hud_ParseTime((car->stats).finalTotalTime,string);
      }
      rowY = dataY;
      if (GameSetup_gData.numLaps != 1) {
        rowY = dataY + GameSetup_gData.numLaps * 0xc;
      }
      Font_TextXY(string,col2 + 5,rowY + 0xc);
    }
    if (GameSetup_gData.raceType == 1) {
      if (GameSetup_gData.numLaps * 2 + 6 < D_8013D99C) {
        sprintf(string,TextSys_Word(0x3e));
        Font_TextColor(3);
        rowY = HUD_STATS_HOTPURSUIT_Y + 1;
        Font_TextXY(string,(int)col1,rowY);
        sprintf(string,"%d",*(int *)((int)Cars_gHumanRaceCarList[i] + 0x3c0));
        Font_TextXY(string,col2 + 5,rowY);
      }
      if (GameSetup_gData.numLaps * 2 + 8 < D_8013D99C) {
        sprintf(string,TextSys_Word(0x3f));
        Font_TextColor(3);
        rowY = HUD_STATS_HOTPURSUIT_Y + 0xd;
        Font_TextXY(string,(int)col1,rowY);
        sprintf(string,"%d",*(int *)((int)Cars_gHumanRaceCarList[i] + 0x3c4));
        Font_TextXY(string,col2 + 5,rowY);
      }
    }
    col1 = col1 + 0x96;
    col2 = col2 + 0x96;
    i = i + 1;
  }
  OptionsBarThing(HUD_STATS_POS_X,(int)HUD_STATS_POS_Y,(int)HUD_STATS_SIZE_W,(int)HUD_STATS_SIZE_H);
  Hud_RenderPauseBox(HUD_STATS_POS_X,(int)HUD_STATS_POS_Y,(int)HUD_STATS_SIZE_W,(int)HUD_STATS_SIZE_H);
  return;
}

/* ---- Hud_BTCStats__Fsb  [OVERLAYS.CPP:326-441] SLD-VERIFIED ---- */
/* HIDDEN-PHANTOM FIX (w14-a2): oracle mangles __Fsb (short,bool) -- 2nd param was `int`, mangling
 * __Fsi, a NAME MISMATCH invisible to the gate (same class as the AudioCmn_GetAsyncSfx precedent).
 * SYM confirms `class ARG type BOOL name postgame`. */
void Hud_BTCStats(short player,bool postgame)

{
  short i;
  short col [4];
  short startY;
  char string [40];
  bool chasinghuman;
  bool showname;
  short PLAYERWIDTH;
  bool showtimeleft;
  short HUD_STATS_POS_X;
  short HUD_STATS_SIZE_W;
  short HUD_STATS_SIZE_H;
  short HUD_STATS_POS_Y;
  short HUD_STATS_TEXT_START_X;
  short HUD_STATS_TITLE_START_X;
  short HUD_STATS_TITLE_START_Y;
  short HUD_STATS_TEXT_START_Y;

  chasinghuman = 0;
  showname = 0;
  if (1 < Cars_gNumHumanRaceCars) {
    if ((Cars_gHumanRaceCarList[1 - player]->carFlags & 0x200U) == 0) {
      chasinghuman = 1;
    }
    else {
      showname = 1;
    }
  }
  PLAYERWIDTH = 0xe7;
  if (chasinghuman) {
    PLAYERWIDTH = 0xa1;
  }
  showtimeleft = 0;
  /* the oracle indexes row `player` and element `Hud_NextPerp[player] - 1`
     (`addiu $v1,$v1,-1` @0x800DA810, no -1 on the row). */
  if ((postgame == 0) || (BTCPerpInfo[player][Hud_NextPerp[player] - 1].caught != 0)) {
    showtimeleft = 1;
  }
  HUD_STATS_SIZE_W = PLAYERWIDTH + 6;
  /* w40-a4: the oracle builds POS_X directly as `0xa0 - (PLAYERWIDTH>>1)` (`li $s5,0xA0`
     CSE'd with the TITLE_START_X centring below, then `subu $s1,$s5,$v0` @0x800DA87C) and
     derives TEXT_START_X from it (`addiu $s2,$s1,0x7`).  The old `-(PW>>1)` + `+0xa0`
     spelling was numerically equal but cost a `negu` and re-based every column constant. */
  HUD_STATS_POS_X = 0xa0 - (PLAYERWIDTH >> 1);
  HUD_STATS_SIZE_H = (Hud_NextPerp[player] + 1) * 0xc + 0x16;
  if (showtimeleft) {
    HUD_STATS_SIZE_H = (Hud_NextPerp[player] + 1) * 0xc + 0x22;
  }
  if (postgame) {
    HUD_STATS_SIZE_H = HUD_STATS_SIZE_H + 8;
  }
  if (showname) {
    HUD_STATS_SIZE_H = HUD_STATS_SIZE_H + 0xc;
  }
  HUD_STATS_POS_Y = 0x78 - (HUD_STATS_SIZE_H >> 1);
  HUD_STATS_TEXT_START_X = HUD_STATS_POS_X + 7;
  HUD_STATS_TITLE_START_X = 0xa0 - (textpixels(TextSys_Word(postgame ? 0x48 : 0x47)) >> 1);
  HUD_STATS_TITLE_START_Y = 0x76 - (HUD_STATS_SIZE_H >> 1);
  HUD_STATS_TEXT_START_Y = HUD_STATS_TITLE_START_Y + 0xf;
  col[0] = HUD_STATS_POS_X + 3;
  col[1] = HUD_STATS_TEXT_START_X + (chasinghuman ? 0xc : 0xf);
  col[2] = HUD_STATS_TEXT_START_X + (chasinghuman ? 0xc : 0x50);
  col[3] = HUD_STATS_TEXT_START_X + (chasinghuman ? 0x50 : 0x96);
  startY = HUD_STATS_TEXT_START_Y;
  Font_TextColor(6);
  Font_TextXY(TextSys_Word(postgame ? 0x48 : 0x47),HUD_STATS_TITLE_START_X,HUD_STATS_TITLE_START_Y);
  if (showname) {
    Font_TextColor(4);
    Font_TextXY(Cars_gRaceCarList[player]->carInfo->driver,col[2],startY);
    startY = startY + 0xc;
  }
  Font_TextColor(3);
  if (!chasinghuman) {
    Font_TextXY(TextSys_Word(0x4a),col[1],startY);
  }
  Font_TextXY(TextSys_Word(0x4b),col[2],startY);
  Font_TextXY(TextSys_Word(0x4c),col[3],startY);
  Hud_FBuildF4(0,HUD_STATS_POS_X,startY + 0xf,HUD_STATS_SIZE_W,1,0,'\0','\0');
  /* w40-a4 CORRECTNESS: the vertical rules run i = 1..3 (`li $s5,1` in the jal delay slot
     @0x800DAA34, loop `slti $v0,$v0,4`), NOT 0..3 -- col[0] gets no rule.  And the height is
     SIZE_H minus the bar inset, not a flat SIZE_H-8: oracle @0x800DAAAC picks
     `s2 - (s1 + 8)` under postgame vs `s2 - s1`, then `-0x10` under showtimeleft, with
     s2 = (int)SIZE_H and s1 = y - POS_Y. */
  for (i = 1; i < 4; i = i + 1) {
    Hud_FBuildF4(0,col[i] - 2,startY + 0xf,1,
                 HUD_STATS_SIZE_H - ((startY + 0xf - HUD_STATS_POS_Y) + (postgame ? 8 : 0)) -
                 (showtimeleft ? 0x10 : 0),0,'\0','\0');
  }
  if (showtimeleft) {
    Hud_FBuildF4(0,HUD_STATS_POS_X,
                 startY + 0xf + HUD_STATS_SIZE_H - (startY + 0xf - HUD_STATS_POS_Y) -
                 (postgame ? 0x18 : 0x10),HUD_STATS_SIZE_W,1,0,'\0','\0');
  }
  /* in-place `startY += 0xf` (`addiu $a0,$s6,0xF; addu $s6,$a0,$zero` @0x800DAB9C) -- there is
     no separate dataY local (SYM lists only i/col/startY/string/chasinghuman/showname/
     PLAYERWIDTH/showtimeleft/HUD_STATS_*). */
  startY = startY + 0xf;
  for (i = 0; i < Hud_NextPerp[player]; i = i + 1) {
    if (StatsTimer_arr[player] > (int)i * 2 + 4) {
      Font_TextColor(4);
      sprintf(string,"%d",(int)i + 1);
      Font_TextXY(string,col[0],startY + (int)i * 0xc);
      if (!chasinghuman) {
        sprintf(string,"%s",BTCPerpInfo[player][i].name);
        Font_TextXY(string,col[1],startY + (int)i * 0xc);
      }
      Hud_ParseTime(BTCPerpInfo[player][i].time,string);
      Font_TextXY(string,col[2],startY + (int)i * 0xc);
      Font_TextXY(TextSys_Word(BTCPerpInfo[player][i].caught != 0 ? 0x3d : 0x49),col[3],
                  startY + (int)i * 0xc);
    }
  }
  if (showtimeleft && (StatsTimer_arr[player] > (int)i * 2 + 4)) {
    Font_TextColor(3);
    Hud_ParseTime(FinalBTC_Countdown,string);
    Font_TextXY(TextSys_Word(0x4d),col[0],startY + (int)i * 0xc + 2);
    /* oracle selects the COLUMN (`lh $a1,0x26(sp)` vs `lh $a1,0x24(sp)` @0x800DADC0), it does
       not overwrite col[2] with col[3]. */
    Font_TextXY(string,chasinghuman ? col[3] : col[2],startY + (int)i * 0xc + 2);
  }
  if (postgame) {
    OptionsBarThing(HUD_STATS_POS_X,HUD_STATS_POS_Y,HUD_STATS_SIZE_W,HUD_STATS_SIZE_H);
  }
  Hud_RenderPauseBox(HUD_STATS_POS_X,HUD_STATS_POS_Y,HUD_STATS_SIZE_W,HUD_STATS_SIZE_H);
  return;
}

/* ---- Hud_RenderStatsView__Fv  [OVERLAYS.CPP:450-507] SLD-VERIFIED ---- */
void Hud_RenderStatsView(void)

{
  short player;
  int screen;
  int t;

  screen = simGlobal.gameTicks >> 9 & 1;
  /* Block order + branch polarity transcribed from the oracle CFG (0x800DAE94..0x800DAFE8):
     the flags!=0 arm is the if-BODY (oracle `beqz` skips to the ==0 block), the shared
     screen=0 block sits EARLY at .L800DAED0, and the "one player" tail (.L800DAFE4)
     falls out of the numRaceCars test at .L800DAFD0. */
  if ((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) != 0) {
    if (GameSetup_gData.commMode == 1) goto HudStats_common;
HudStats_setUserZero:
    screen = 0;
    goto HudStats_finalize;
  }
  if (GameSetup_gData.commMode != 1) goto HudStats_checkNumCars;
HudStats_common:
  if ((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) != 0) {
    if ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) != 0) goto HudStats_check200B;
    goto HudStats_setUserZero;
  }
  if ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0) goto HudStats_secondCar;
HudStats_check200B:
  if ((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0) goto HudStats_setUserOne;
  if (Hud_NextPerp[0] != 0) goto HudStats_setUserZero;
  if (GameSetup_gData.commMode != 1) goto HudStats_setUserZero;
HudStats_secondCar:
  if ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0) goto HudStats_finalize;
  if (GameSetup_gData.commMode != 1) goto HudStats_finalize;
  if (Hud_NextPerp[1] == 0) goto HudStats_finalize;
  screen = 1;
  goto HudStats_finalize;
HudStats_checkNumCars:
  if (Cars_gNumRaceCars != 1) goto HudStats_finalize;
HudStats_setUserOne:
  screen = 1;
HudStats_finalize:
  if (screen == 0) {
    D_8013D99C = 0;
    /* the oracle keeps the incremented value in its own pseudo and stores it BOTH
       before and after the clamp (`addu $v1,$v0,$zero` / two `sw $v1,%gp_rel(...)`);
       the plain `X = X + 1; if (K < X) X = K;` form stores straight out of $v0. */
    StatsTimer = StatsTimer + 1;
    t = StatsTimer;
    if (10000 < t) {
      t = 10000;
    }
    StatsTimer = t;
    player = 0;
    if ((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0) {
      RaceSummary();
      return;
    }
  }
  else {
    StatsTimer = 0;
    D_8013D99C = D_8013D99C + 1;
    t = D_8013D99C;
    if (10000 < t) {
      t = 10000;
    }
    D_8013D99C = t;
    if ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0) {
      RaceStatistics();
      return;
    }
    player = 1;
    if (GameSetup_gData.commMode != 1) {
      RaceStatistics();
      return;
    }
  }
  Hud_BTCStats(player,true);
  return;
}

/* end of overlays.cpp */
