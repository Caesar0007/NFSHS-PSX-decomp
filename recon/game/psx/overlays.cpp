/* game/psx/overlays.cpp -- RECONSTRUCTED (NFS4 PSX race-summary / stats HUD; C++ TU)
 *   5 fns: OptionsBarThing, Hud_RenderStatsView, RaceSummary, RaceStatistics, Hud_BTCStats
 *   -- all reconstructed with full SYM-locals applied (0 missing, audited). No GTE.
 */
#include "../../nfs4_types.h"
#include "overlays_externs.h"


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
  int headerY;
  int dataY;
  int barH;
  int color;
  Car_tObj *car;
  char *word;

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
  word = TextSys_Word(0x38);
  color = textpixels(word);
  Font_TextColor(6);
  Font_TextXY(TextSys_Word(0x38),(0xa0 - (color >> 1)) * 0x10000 >> 0x10,-halfH + 0x76);
  Font_TextColor(3);
  headerY = (-halfH + 0x85) * 0x10000 >> 0x10;
  Font_TextXY(TextSys_Word(0x2e),colname,headerY);
  Font_TextXY(TextSys_Word(0x3a),colcar,headerY);
  Font_TextXY(TextSys_Word(0x3b),coltime,headerY);
  if (GameSetup_gData.numLaps != 1) {
    Font_TextXY(TextSys_Word(0x3c),colbestlap,headerY);
  }
  dataY = (-halfH + 0x87) * 0x10000 >> 0x10;
  Hud_FBuildF4(0,HUD_STATS_POS_X,dataY + 0xc,(u_short)HUD_STATS_SIZE_W,1,0,'\0','\0');
  barH = HUD_STATS_SIZE_H + -8;
  Hud_FBuildF4(0,colname + -2,HUD_STATS_POS_Y,1,barH,0,'\0','\0');
  Hud_FBuildF4(0,colcar + -2,HUD_STATS_POS_Y,1,barH,0,'\0','\0');
  Hud_FBuildF4(0,coltime + -2,HUD_STATS_POS_Y,1,barH,0,'\0','\0');
  if (GameSetup_gData.numLaps != 1) {
    Hud_FBuildF4(0,colbestlap + -2,HUD_STATS_POS_Y,1,barH,0,'\0','\0');
  }
  i = 0;
  do {
    if (Cars_gNumRaceCars <= i) {
      OptionsBarThing(HUD_STATS_POS_X,HUD_STATS_POS_Y,(u_short)HUD_STATS_SIZE_W,(int)HUD_STATS_SIZE_H);
      Hud_RenderPauseBox(HUD_STATS_POS_X,HUD_STATS_POS_Y,(u_short)HUD_STATS_SIZE_W,(int)HUD_STATS_SIZE_H);
      return;
    }
    car = Cars_gRaceCarList[i];
    pos = car->stats.finalPosition;
    if (pos * 2 + 4 < StatsTimer[0]) {
      color = 4;
      if ((car->carFlags & 4U) != 0) {
        color = 3;
      }
      Font_TextColor(color);
      sprintf(string,"%d",pos);
      Font_TextXY(string,colpos | 1,dataY + pos * 0xc);
      Font_TextColor(3);
      sprintf(string,"%s",(char *)(*(int *)((int)car + 0x288) + 0x5c));
      Font_TextXY(string,colname,dataY + pos * 0xc);
      color = 4;
      if ((*(u_int *)((int)car + 0x260) & 4) != 0) {
        color = 3;
      }
      Font_TextColor(color);
      sprintf(string,"%s",car->carNameLocalized);
      Font_TextXY(string,colcar,dataY + pos * 0xc);
      if (GameSetup_gData.pinkSlipsForfeit == i) {
        sprintf(string,TextSys_Word(0x36));
      }
      else if ((GameSetup_gData.raceType == 1) && (car->stats.finalNumArrests != 0)) {
        sprintf(string,TextSys_Word(0x3d));
      }
      else if (*(int *)((int)car + 0x3cc) != 2) {
        sprintf(string,TextSys_Word(0x35));
      }
      else {
        Hud_ParseTime(*(int *)((int)car + 0x3d4),string);
      }
      Font_TextXY(string,coltime,dataY + pos * 0xc);
      if (GameSetup_gData.numLaps != 1) {
        Hud_ParseTime(*(int *)((int)car + 0x3e8),string);
        Font_TextXY(string,colbestlap,dataY + pos * 0xc);
      }
    }
    i = i + 1;
  } while (1);
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
  int negH;
  int titleY;
  int dataY;
  int barH;
  int color;
  int rowY;
  Car_tObj *car;
  char *word;
  int t;

  HUD_STATS_SIZE_W = (short)(Cars_gNumHumanRaceCars * 0x96);
  HUD_STATS_SIZE_H = ((short)GameSetup_gData.numLaps + 1) * 0xc + 0x28;
  HUD_STATS_POS_X = (short)(Cars_gNumHumanRaceCars * -0x4b + 0xa0);
  if (GameSetup_gData.numLaps == 1) {
    HUD_STATS_SIZE_H = 0x34;
  }
  if (GameSetup_gData.raceType == 1) {
    HUD_STATS_SIZE_H = HUD_STATS_SIZE_H + 0x1b;
  }
  halfH = (int)((u_int)(u_short)HUD_STATS_SIZE_H << 0x10) >> 0x11;
  HUD_STATS_POS_Y = (short)(0x78 - halfH);
  word = TextSys_Word(0x39);
  color = textpixels(word);
  col1 = HUD_STATS_POS_X + 0xa;
  col2 = 0xa0;
  negH = -halfH;
  titleY = negH + 0x76;
  HUD_STATS_HOTPURSUIT_Y = (short)(titleY + (GameSetup_gData.numLaps + 2) * 0xc + 0x13);
  if (1 < Cars_gNumHumanRaceCars) {
    col2 = 0x55;
  }
  Font_TextColor(6);
  Font_TextXY(TextSys_Word(0x39),(0xa0 - (color >> 1)) * 0x10000 >> 0x10,titleY);
  dataY = (negH + 0x87) * 0x10000 >> 0x10;
  Hud_FBuildF4(0,HUD_STATS_POS_X,dataY + 0xb,(int)HUD_STATS_SIZE_W,1,0,'\0','\0');
  if (GameSetup_gData.raceType == 1) {
    Hud_FBuildF4(0,HUD_STATS_POS_X,(int)HUD_STATS_HOTPURSUIT_Y * 0x10000 >> 0x10,(int)HUD_STATS_SIZE_W,1,0,'\0','\0');
  }
  i = 0;
  barH = (int)((u_int)(u_short)HUD_STATS_SIZE_H << 0x10) >> 0x10;
  do {
    if (Cars_gNumHumanRaceCars <= (int)i) {
      OptionsBarThing(HUD_STATS_POS_X,(int)HUD_STATS_POS_Y,(int)HUD_STATS_SIZE_W,(int)HUD_STATS_SIZE_H);
      Hud_RenderPauseBox(HUD_STATS_POS_X,(int)HUD_STATS_POS_Y,(int)HUD_STATS_SIZE_W,(int)HUD_STATS_SIZE_H);
      return;
    }
    car = Cars_gRaceCarList[i];
    colmid = col2 - ((textpixels(car->carInfo->driver) >> 1) + 2);
    Hud_FBuildF4(0,col2 + -2,dataY + 0xb,1,barH - ((dataY - (0x78 - halfH)) + 0x13),0,'\0','\0');
    if (0 < (int)i) {
      Hud_FBuildF4(0,col1 + -2,0x78 - halfH,1,barH + -8,0,'\0','\0');
    }
    if (2 < StatsTimer[1]) {
      Font_TextColor(3);
      sprintf(string,"%s",Cars_gRaceCarList[i]->carInfo->driver);
      Font_TextXY(string,colmid,negH + -4);
    }
    if ((GameSetup_gData.numLaps != 1) && (0 < GameSetup_gData.numLaps)) {
      j = 0;
      do {
        if ((int)j * 2 + 4 < StatsTimer[1]) {
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
    if (GameSetup_gData.numLaps * 2 + 4 < StatsTimer[1]) {
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
      if (GameSetup_gData.numLaps * 2 + 6 < StatsTimer[1]) {
        sprintf(string,TextSys_Word(0x3e));
        Font_TextColor(3);
        rowY = HUD_STATS_HOTPURSUIT_Y + 1;
        Font_TextXY(string,(int)col1,rowY);
        sprintf(string,"%d",*(int *)((int)Cars_gHumanRaceCarList[i] + 0x3c0));
        Font_TextXY(string,col2 + 5,rowY);
      }
      if (GameSetup_gData.numLaps * 2 + 8 < StatsTimer[1]) {
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
  } while (1);
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
  int chasinghuman;
  int showname;
  short PLAYERWIDTH;
  int showtimeleft;
  short HUD_STATS_POS_X;
  short HUD_STATS_SIZE_W;
  short HUD_STATS_SIZE_H;
  short HUD_STATS_POS_Y;
  short HUD_STATS_TEXT_START_X;
  short HUD_STATS_TITLE_START_X;
  short HUD_STATS_TITLE_START_Y;
  short HUD_STATS_TEXT_START_Y;
  int halfH;
  int negH;
  int perpH;
  int dataY;
  int y;
  int nperps;
  int wnum;
  int k;
  char *word;

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
  if (chasinghuman != 0) {
    PLAYERWIDTH = 0xa1;
  }
  showtimeleft = 0;
  if ((postgame == 0) || (BTCPerpInfo[player + -1][Hud_NextPerp[player] + 9].caught != 0)) {
    showtimeleft = 1;
  }
  HUD_STATS_SIZE_W = PLAYERWIDTH + 6;
  HUD_STATS_TEXT_START_X = -(PLAYERWIDTH >> 1);
  perpH = (Hud_NextPerp[player] + 1) * 0xc + 0x16;
  if (showtimeleft != 0) {
    perpH = (Hud_NextPerp[player] + 1) * 0xc + 0x22;
  }
  if (postgame != 0) {
    perpH = perpH + 8;
  }
  HUD_STATS_SIZE_H = (short)perpH;
  if (showname != 0) {
    HUD_STATS_SIZE_H = (short)(perpH + 0xc);
  }
  halfH = (int)((u_int)(u_short)HUD_STATS_SIZE_H << 0x10) >> 0x11;
  HUD_STATS_POS_Y = (short)(0x78 - halfH);
  negH = -halfH;
  HUD_STATS_TEXT_START_Y = (short)(negH + 0x76);
  HUD_STATS_TITLE_START_Y = (short)(negH + 0x85);
  HUD_STATS_POS_X = HUD_STATS_TEXT_START_X + 0xa0;
  col[0] = HUD_STATS_TEXT_START_X + 0xa3;
  if (chasinghuman != 0) {
    col[1] = HUD_STATS_TEXT_START_X + 0xb3;
    col[2] = HUD_STATS_TEXT_START_X + 0xa7 + 0xc;
    col[3] = HUD_STATS_TEXT_START_X + 0xa7 + 0x50;
  }
  else {
    col[1] = HUD_STATS_TEXT_START_X + 0xb6;
    col[2] = HUD_STATS_TEXT_START_X + 0xa7 + 0x50;
    col[3] = HUD_STATS_TEXT_START_X + 0xa7 + 0x96;
  }
  word = TextSys_Word((postgame != 0) ? 0x48 : 0x47);
  HUD_STATS_TITLE_START_X = (short)(0xa0 - (textpixels(word) >> 1));
  Font_TextColor(6);
  Font_TextXY(TextSys_Word((postgame != 0) ? 0x48 : 0x47),(int)HUD_STATS_TITLE_START_X,(int)HUD_STATS_TEXT_START_Y);
  startY = HUD_STATS_TITLE_START_Y;
  if (showname != 0) {
    Font_TextColor(4);
    Font_TextXY(Cars_gRaceCarList[player]->carInfo->driver,(int)col[2],(int)startY);
    startY = (short)(negH + 0x91);
  }
  Font_TextColor(3);
  if (chasinghuman == 0) {
    Font_TextXY(TextSys_Word(0x4a),(int)col[1],(int)startY);
  }
  Font_TextXY(TextSys_Word(0x4b),(int)col[2],(int)startY);
  Font_TextXY(TextSys_Word(0x4c),(int)col[3],(int)startY);
  y = startY + 0xf;
  Hud_FBuildF4(0,(int)HUD_STATS_POS_X,y,(int)HUD_STATS_SIZE_W,1,0,'\0','\0');
  for (k = 0; k < 4; k = k + 1) {
    Hud_FBuildF4(0,col[k] + -2,y,1,(int)HUD_STATS_SIZE_H + -8,0,'\0','\0');
  }
  if (showtimeleft != 0) {
    Hud_FBuildF4(0,(int)HUD_STATS_POS_X,y + (int)HUD_STATS_SIZE_H + -8,(int)HUD_STATS_SIZE_W,1,0,'\0','\0');
  }
  dataY = startY + 0xf;
  nperps = Hud_NextPerp[player];
  i = 0;
  if (0 < nperps) {
    do {
      if ((int)i * 2 + 4 < StatsTimer[player]) {
        Font_TextColor(4);
        sprintf(string,"%d",(int)i + 1);
        y = dataY + (int)i * 0xc;
        Font_TextXY(string,(int)col[0],y);
        if (chasinghuman == 0) {
          sprintf(string,"%s",BTCPerpInfo[player][i].name);
          Font_TextXY(string,(int)col[1],y);
        }
        Hud_ParseTime(BTCPerpInfo[player][i].time,string);
        Font_TextXY(string,(int)col[2],y);
        wnum = 0x49;
        if (BTCPerpInfo[player][i].caught != 0) {
          wnum = 0x3d;
        }
        Font_TextXY(TextSys_Word(wnum),(int)col[3],y);
      }
      i = i + 1;
    } while ((int)i < nperps);
  }
  if ((showtimeleft != 0) && ((int)i * 2 + 4 < StatsTimer[player])) {
    Font_TextColor(3);
    Hud_ParseTime(FinalBTC_Countdown,string);
    Font_TextXY(TextSys_Word(0x4d),(int)col[0],dataY + (int)i * 0xc + 2);
    if (chasinghuman != 0) {
      col[2] = col[3];
    }
    Font_TextXY(string,(int)col[2],dataY + (int)i * 0xc + 2);
  }
  if (postgame != 0) {
    OptionsBarThing((int)HUD_STATS_POS_X,(int)HUD_STATS_POS_Y,(int)HUD_STATS_SIZE_W,(int)HUD_STATS_SIZE_H);
  }
  Hud_RenderPauseBox((int)HUD_STATS_POS_X,(int)HUD_STATS_POS_Y,(int)HUD_STATS_SIZE_W,(int)HUD_STATS_SIZE_H);
  return;
}

/* ---- Hud_RenderStatsView__Fv  [OVERLAYS.CPP:450-507] SLD-VERIFIED ---- */
void Hud_RenderStatsView(void)

{
  short player;
  int screen;

  screen = simGlobal.gameTicks >> 9 & 1;
  if ((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0) {
    if (GameSetup_gData.commMode == 1) goto HudStats_check200;
    if (Cars_gNumRaceCars != 1) goto HudStats_finalize;
HudStats_setUserOne:
    screen = 1;
  }
  else {
    if (GameSetup_gData.commMode != 1) {
HudStats_setUserZero:
      screen = 0;
      goto HudStats_finalize;
    }
HudStats_check200:
    if ((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0) {
      if ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) != 0) goto HudStats_check200B;
    }
    else {
      if ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0) {
        screen = 0;
        goto HudStats_finalize;
      }
HudStats_check200B:
      if ((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0) goto HudStats_setUserOne;
      if ((Hud_NextPerp[0] != 0) || (GameSetup_gData.commMode != 1)) goto HudStats_setUserZero;
    }
    if (((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) != 0) &&
       ((GameSetup_gData.commMode == 1) && (Hud_NextPerp[1] != 0))) {
      screen = 1;
    }
  }
HudStats_finalize:
  if (screen == 0) {
    StatsTimer[1] = 0;
    StatsTimer[0] = StatsTimer[0] + 1;
    if (10000 < StatsTimer[0]) {
      StatsTimer[0] = 10000;
    }
    player = 0;
    if ((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0) {
      RaceSummary();
      return;
    }
  }
  else {
    StatsTimer[0] = 0;
    StatsTimer[1] = StatsTimer[1] + 1;
    if (10000 < StatsTimer[1]) {
      StatsTimer[1] = 10000;
    }
    if (((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0) ||
       (player = 1, GameSetup_gData.commMode != 1)) {
      RaceStatistics();
      return;
    }
  }
  Hud_BTCStats(player,true);
  return;
}

/* end of overlays.cpp */
