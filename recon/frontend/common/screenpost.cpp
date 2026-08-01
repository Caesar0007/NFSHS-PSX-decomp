/* frontend/screens/screenpost.cpp -- RECONSTRUCTED (tournament-standings screens + DrawMoney; C++ TU)
 *   3 classes (tScreenTournamentStandings -> 3item -> PinkSlipStandings) + free DrawMoney; 13 fns.
 */
#include "screenpost.h"


/* ---- (free)::DrawMoney  [SCREENPOST.CPP:47-75] ---- */

/* Decoded Phase 84: DrawMoney(int x, int y, int z, long amount, int, int) - render currency display($XX,XXX) (312 B, 11 callers - hot). Used in garage, dealer, postgame screens.
   
   [ghidra-meta] section: front.text */

void DrawMoney(int x,int y,int numplaces,long number,int colfore,int colback)

{
  char *str;
  char string1 [50];
  char string2 [50];
  
  switch (numplaces) {
  case 3:
    str = TextSys_Word(0x86);
    sprintf(string1,str,0);
    break;
  case 6:
    str = TextSys_Word(0x87);
    sprintf(string1,str,0,0);
    break;
  case 9:
    str = TextSys_Word(0x88);
    sprintf(string1,str,0,0,0);
    break;
  }
  FeTools_FormatMoney(string2,number);
  FETextRender_FullTextRGB(string2,(short)x,(short)y,colfore,'\0',1);
  FETextRender_FullTextRGB(string1,(short)x,(short)y,colback,'\0',1);
  return;
}



/* ---- tScreenTournamentStandings::ctor  [SCREENPOST.CPP:80-81] ---- */
tScreenTournamentStandings::tScreenTournamentStandings()
  /* base subobject _base_tScreen is constructed implicitly by g++ -> jal __7tScreen */
{

  this->_vf = (__vtbl_ptr_type (*)[10])tScreenTournamentStandings_vtable;
  this->fDrawMoney = 0;
  return;
}



/* ---- tScreenTournamentStandings::Initialize  [SCREENPOST.CPP:85-120] ---- */
void tScreenTournamentStandings::Initialize()

{
  int iVar1;
  int max_damage;
  int max_money;
  tAwardInformation tInfo;
  
  this->Initialize();
  GetAwardInformation(&tournamentManager,&tInfo);
  this->gotmoney = 0;
  this->gotbonus = 0;
  this->gotbilled = 0;
  if (this->fDrawMoney != 0) {
    if (tInfo.fMoney != 0) {
      this->gotmoney = 1;
    }
    iVar1 = tournamentManager.fMoney - tInfo.fTournMoney;
    this->moneyFinal = iVar1;
    if (tInfo.fCompletedGarageFull != 0) {
      this->moneyFinal = iVar1 - tInfo.fCompletedBonusMoney;
    }
    this->moneyAwarded = tInfo.fMoney;
    CalcTrackFinishDamageBill(&tournamentManager,false,&this->moneyDamage,&this->moneyBonus);
    if (0 < this->moneyBonus) {
      this->gotbonus = 1;
    }
    if (0 < this->moneyDamage) {
      this->gotbilled = 1;
    }
    this->fCountedDown = 0;
    if (((this->moneyBonus == 0) && (this->moneyDamage == 0)) && (this->moneyAwarded == 0)) {
      this->fCountedDown = 1;
    }
    max_money = this->moneyBonus;
    this->fStartCountdownNOW = 0;
    if (max_money < tInfo.fMoney) {
      max_money = tInfo.fMoney;
    }
    max_damage = this->moneyDamage;
    if (max_damage < max_money) {
      max_damage = max_money;
    }
    this->fCountSpeed = max_damage / 0x18;
  }
  else {
    this->moneyFinal = tournamentManager.fMoney - tInfo.fTournMoney;
  }
  this->starttick = ticks;
  return;
}



/* ---- tScreenTournamentStandings::Cleanup  [SCREENPOST.CPP:124-129] ---- */
void tScreenTournamentStandings::Cleanup()

{
  this->fDrawMoney = 0;
  this->Cleanup();
  return;
}



/* ---- tScreenTournamentStandings::GetShapeInfo  [SCREENPOST.CPP:133-137] ---- */
void tScreenTournamentStandings::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  numSwapShapes = 0;
  *swapFileName = (char *)0x0;
  numPermShapes = 0x29;
  *permFileName = "zTrnSt1";
  return;
}



/* ---- tScreenTournamentStandings3item::GetShapeInfo  [SCREENPOST.CPP:142-146] ---- */
void tScreenTournamentStandings3item::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  numSwapShapes = 0;
  *swapFileName = (char *)0x0;
  numPermShapes = 0x29;
  *permFileName = "zTrnStd";
  return;
}



/* ---- tScreenTournamentStandings::ProcessInput  [SCREENPOST.CPP:152-158] ---- */
int tScreenTournamentStandings::ProcessInput(tPlayer keyval,tInputKeyType &key_input,
              tMenuCommand &menu_cmd)

{
  int iVar1;

  if (key_input != kInput_KeyType_Cross) {
    return 2;
  }
  if (this->fCountedDown == 0) {
    key_input = kInput_KeyType_AlreadyProcessed;
    this->fStartCountdownNOW = 1;
  }
  return 1;
}



/* ---- tScreenTournamentStandings::DrawBackground  [SCREENPOST.CPP:164-312] ---- */
void tScreenTournamentStandings::DrawBackground()

{
  int fade;
  int fadeline;
  int i;
  int j;
  tTourneyInfo *tourneyInfo;
  char sBuildOutput[80];
  tMenuTextState state;
  tMenuTextState statedull;
  tTrackInformation trackInfo;
  int wwwww;
  tTexture_ShapeInfo *shape;
  int lbx;
  int tt;
  tDrawShapeExtended drawflags;
  int colf;
  int colb;
  short p;
  int numRacers;
  int lastRacer;
  int line;

  fade = this->fScreenFadeVal;
  fadeline = fade;
  i = 0;
  line = 0x2fe;
  tourneyInfo = &tournamentManager.fDefinition->fTournaments[
      tournamentManager.fDefinition->fTiers[tournamentManager.fTier].fTournOffset +
      tournamentManager.fTournament];
  numRacers = (short)(tournamentManager.fNumRacers + (tourneyInfo->fKnockout != 0));
  lastRacer = numRacers - 1;
  for (;;) {
    if (i >= numRacers) {
      break;
    }
    j = (short)PlayerRanking(&tournamentManager,(short)(i + 1));
    state = textState_Selected;
    if (j == 0) {
      state = textState_Hilighted;
      statedull = textState_Hilighted;
    }
    else {
      statedull = textState_Unselected;
    }
    FETextRender_FullTextFade(fade,TextSys_Word(i + 599),(short)TextSys_WordX(0x2f7),
                             (short)TextSys_WordY(line),textType_TrackRecords,statedull,0);
    if (j == 0) {
      FETextRender_FullTextFade(fade,PlayerName(0),(short)TextSys_WordX(0x2f8),
                               (short)TextSys_WordY(line),textType_TrackRecords,state,0);
    }
    else {
      FETextRender_FullTextFade(fade,
                               Stattool_GetAINameFromPersonality(tournamentManager.fCompetitors[j].fPersonality),
                               (short)TextSys_WordX(0x2f8),(short)TextSys_WordY(line),
                               textType_TrackRecords,state,0);
    }
    p = j;
    if (tourneyInfo->fKnockout != 0) {
      sprintf(sBuildOutput,TextSys_Word(i == lastRacer ? 0x31c : 0x31b));
    }
    else {
      sprintf(sBuildOutput,"%d %s",(int)TournPointTotal(&tournamentManager,&p),TextSys_Word(0x31d));
    }
    FETextRender_FullTextFade(fade,sBuildOutput,(short)TextSys_WordX(0x2fb),
                             (short)TextSys_WordY(line),textType_TrackRecords,state,1);
    line++;
    i++;
  }
  GetTrack(&trackManager,(short)Front_GetTrackRaced(),&trackInfo);
  FETextRender_FullTextFade(fade,TextSys_Word((short)Front_GetTrackRaced() + 0xd5),(short)TextSys_WordX(0x2f6),
                           (short)TextSys_WordY(0x2fd),textType_TrackRecords,textState_Hilighted,2);
  i = (short)TextValue(frontEnd.tier != '\0' ? &menuDefs->iteratorSpecialEvent :
                                               &menuDefs->iteratorTournament,kPlayerBoth) + 0x13;
  FETextRender_MenuTextPositionedJustifyFade(fade,(short)i,(short)TextSys_WordX(0x2f6),(short)TextSys_WordY(0x2fc),
                                             2,textState_Hilighted,textType_TrackRecords);
  wwwww = textpixels(TextSys_Word(i));
  PSXDrawSquare(0,TextSys_WordX(0x2f6) - (wwwww >> 1),TextSys_WordY(0x2fc) - 1,wwwww,9);
  shape = &gCurrentShapes[0x27];
  wwwww = shape->width;
  lbx = (wwwww >> 1) - 2 - shape->centerx;
  tt = ticks % (short)wwwww;
  if ((wwwww >> 1) < tt) {
    tt = wwwww - tt;
  }
  DrawShapeExtended(0x28,0,lbx + tt,TextSys_WordY(0x2fc) + 1,fade,1,(tDrawShapeExtended *)0x0);
  DrawShapeExtended(0x28,0,lbx - tt,TextSys_WordY(0x2fc) + 1,fade,1,(tDrawShapeExtended *)0x0);
  drawflags.tint[0] = 0x282828;
  DrawShapeExtended(0x27,0x400,0,-1,fade,0,&drawflags);
  PSXDrawBrightEndLine(0x232323,TextSys_WordX(0x2f6) - 0x96,TextSys_WordY(0x2fd) + 10,
                       300,1,3,fadeline,0x1e);
  colf = CalcFadeVal(kRGBVals[(byte)textDefinitions[0xb][5]],fade);
  colb = CalcFadeVal(0x232323,fade);
  if ((1000 < ticks - this->starttick) || (this->fStartCountdownNOW != 0)) {
    if ((0 < this->moneyAwarded) || ((0 < this->moneyDamage || (0 < this->moneyBonus)))) {
      AudioCmn_PlayFESFX(0x15);
    }
    int speed = this->fCountSpeed;
    this->moneyAwarded -= speed;
    if (this->moneyAwarded < 1) {
      this->moneyAwarded = 0;
      this->moneyDamage -= speed;
      if (this->moneyDamage < 1) {
        long bonus = this->moneyBonus - speed;
        this->fCountedDown = 1;
        this->moneyDamage = 0;
        if (bonus < 0) {
          bonus = 0;
        }
        this->moneyBonus = bonus;
      }
    }
  }
  if (this->fDrawMoney != 0) {
    FETextRender_FullTextFade(fade,TextSys_Word(0x312),TextSys_WordX(0x2fa),TextSys_WordY(0x312),
                             textType_TrackRecords,(uint)(this->gotmoney != 0),1);
    DrawMoney(TextSys_WordX(0x2fb),TextSys_WordY(0x312),6,this->moneyAwarded,colf,colb);
    FETextRender_FullTextFade(fade,TextSys_Word(0x313),TextSys_WordX(0x2fa),TextSys_WordY(0x313),
                             textType_TrackRecords,(uint)(this->gotbilled != 0),1);
    DrawMoney(TextSys_WordX(0x2fb),TextSys_WordY(0x313),6,this->moneyDamage,colf,colb);
    FETextRender_FullTextFade(fade,TextSys_Word(0x314),TextSys_WordX(0x2fa),TextSys_WordY(0x314),
                             textType_TrackRecords,(uint)(this->gotbonus != 0),1);
    DrawMoney(TextSys_WordX(0x2fb),TextSys_WordY(0x314),6,this->moneyBonus,colf,colb);
  }
  FETextRender_FullTextFade(fade,TextSys_Word(0x315),TextSys_WordX(0x2fa),TextSys_WordY(0x315),
                           textType_TrackRecords,textState_Hilighted,1);
  DrawMoney(TextSys_WordX(0x2fb),TextSys_WordY(0x315),9,
            ((this->moneyFinal - this->moneyAwarded) + this->moneyDamage) - this->moneyBonus,colf,colb);
  ::DrawBackgroundImage((tScreen *)this,10,0x1d,gCurrentShapes,0);
  return;
}



/* ---- tScreenPinkSlipStandings::DrawBackground  [SCREENPOST.CPP:320-401] ---- */
void tScreenPinkSlipStandings::DrawBackground()

{
  int fade;
  char sBuildOutput [50];
  uint i;
  tMenuTextState state;
  tMenuTextType type;
  int wwwww;
  tTexture_ShapeInfo *shape;
  int lbx;
  int tt;
  tDrawShapeExtended drawflags;
  int iVar1;
  int iVar2;
  char *str;
  int iVar4;
  tMenuTextState textState;
  int iVar7;

  wwwww = 0x2fe;
  fade = (int)this->
               fScreenFadeVal;
  type = textType_TrackRecords;
  for (i = 0; textState = textState_Hilighted,
      (int)i < (int)(uint)(byte)frontEnd.pinkSlipsNumTracks; i = i + 1) {
    tTrackInformation trackInfo;
    char string [30];

    if (i != (byte)frontEnd.pinkSlipsTrackIndex) {
      textState = (tMenuTextState)((int)i < (int)(uint)(byte)frontEnd.pinkSlipsTrackIndex);
    }
    GetTrack(&trackManager,(ushort)(byte)frontEnd.track[i],&trackInfo);
    iVar1 = TextSys_WordX(0x2f7);
    iVar2 = TextSys_WordY(wwwww);
    FETextRender_MenuTextPositionedJustifyFade(fade,trackInfo.fTrackID + 0xd5,(short)iVar1,(short)iVar2,0,textState,
               type);
    if (frontEnd.pinkSlipsWinner[i] == -1) {
      str = TextSys_Word(0x30d);
    }
    else {
      str = PlayerName((int)frontEnd.pinkSlipsWinner[i]);
    }
    sprintf(string,str);
    iVar1 = TextSys_WordX(0x2fb);
    iVar2 = TextSys_WordY(wwwww);
    FETextRender_FullTextFade(fade,string,(short)iVar1,(short)iVar2,type,textState,1);
    wwwww = wwwww + 1;
  }
  wwwww = 0;
  iVar1 = 0x313;
  do {
    str = PlayerName(wwwww);
    iVar2 = TextSys_WordX(0x2f8);
    iVar4 = TextSys_WordY(iVar1);
    FETextRender_FullTextFade(fade,str,(short)iVar2,(short)iVar4,type,textState_Hilighted,0);
    if (frontEnd.pinkSlipsWins[wwwww] == '\x01') {
      str = TextSys_Word(799);
      sprintf(sBuildOutput,str);
    }
    else {
      str = TextSys_Word(0x31e);
      sprintf(sBuildOutput,str,(uint)(byte)frontEnd.pinkSlipsWins[wwwww]);
    }
    iVar2 = TextSys_WordX(0x2fb);
    iVar4 = TextSys_WordY(iVar1);
    FETextRender_FullTextFade(fade,sBuildOutput,(short)iVar2,(short)iVar4,type,
               textState_Hilighted,1);
    wwwww = wwwww + 1;
    iVar1 = iVar1 + 1;
  } while (wwwww < 2);
  wwwww = TextSys_WordX(0x2f6);
  iVar1 = TextSys_WordY(0x2fc);
  FETextRender_MenuTextPositionedJustifyFade(fade,0x2c1,(short)wwwww,(short)iVar1,2,textState_Hilighted,type);
  str = TextSys_Word(0x2c1);
  wwwww = textpixels(str);
  iVar7 = TextSys_WordX(0x2f6);
  iVar1 = TextSys_WordY(0x2fc);
  PSXDrawSquare(0,iVar7 - (wwwww >> 1),iVar1 + -1,wwwww,9);
  shape = &gCurrentShapes[0x27];
  wwwww = shape->width;
  lbx = (wwwww >> 1) - 2 - shape->centerx;
  tt = ticks % (short)wwwww;
  if ((wwwww >> 1) < tt) {
    tt = wwwww - tt;
  }
  drawflags.tint[0] = 0x282828;
  DrawShapeExtended(0x28,0,lbx + tt,TextSys_WordY(0x2fc) + 1,
             (int)this->
                  fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  DrawShapeExtended(0x28,0,lbx - tt,TextSys_WordY(0x2fc) + 1,
             (int)this->
                  fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  DrawShapeExtended(0x27,0x400,0,-1,
             (int)this->
                  fScreenFadeVal,0,&drawflags);
  ::DrawBackgroundImage((tScreen *)this,10,0x1d,gCurrentShapes,0);
  return;
}



/* ---- tScreenPinkSlipStandings::ProcessInput  [SCREENPOST.CPP:80-80] ---- */
int tScreenPinkSlipStandings::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)

{
  return tScreen_ProcessInput((tScreen *)this,fromPlayer,keyval,command);
}



/* ---- tScreenPinkSlipStandings::dtor  [SCREENPOST.CPP:82-406] ---- */
tScreenPinkSlipStandings::~tScreenPinkSlipStandings()

{
  /* MATCH: empty body — the declared base dtor auto-fires (jal ___7tScreen). */
  return;
}



/* ---- tScreenTournamentStandings3item::dtor  [SCREENPOST.CPP:72-406] ---- */
tScreenTournamentStandings3item::~tScreenTournamentStandings3item()

{
  /* MATCH: empty body — the declared base dtor auto-fires (jal ___7tScreen). */
  return;
}



/* ---- tScreenTournamentStandings::dtor  [SCREENPOST.CPP:64-406] ---- */
tScreenTournamentStandings::~tScreenTournamentStandings()

{
  /* MATCH: empty body — Ghidra's dead locals (tt/wwwww/colb/colf/i/sBuildOutput/
     trackInfo/string) inflated the frame; the declared base dtor auto-fires. */
  return;
}



/* end of screenpost.cpp */
