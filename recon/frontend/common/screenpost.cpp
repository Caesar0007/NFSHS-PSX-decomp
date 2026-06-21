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
  
  if (numplaces == 6) {
    str = TextSys_Word(0x87);
    sprintf(string1,str,0,0);
  }
  else if (numplaces < 7) {
    if (numplaces == 3) {
      str = TextSys_Word(0x86);
      sprintf(string1,str,0);
    }
  }
  else if (numplaces == 9) {
    str = TextSys_Word(0x88);
    sprintf(string1,str,0,0,0);
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

  (this->_base_tScreen)._vf = (__vtbl_ptr_type (*)[10])tScreenTournamentStandings_vtable;
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
  
  this->_base_tScreen.Initialize();
  GetAwardInformation(&tournamentManager,&tInfo);
  this->gotmoney = 0;
  this->gotbonus = 0;
  this->gotbilled = 0;
  if (this->fDrawMoney == 0) {
    this->moneyFinal = tournamentManager.fMoney - tInfo.fTournMoney;
  }
  else {
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
  this->starttick = ticks;
  return;
}



/* ---- tScreenTournamentStandings::Cleanup  [SCREENPOST.CPP:124-129] ---- */
void tScreenTournamentStandings::Cleanup()

{
  this->fDrawMoney = 0;
  this->_base_tScreen.Cleanup();
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

  iVar1 = 2;
  if ((key_input == kInput_KeyType_Cross) && (iVar1 = 1, this->fCountedDown == 0)) {
    key_input = kInput_KeyType_AlreadyProcessed;
    this->fStartCountdownNOW = 1;
  }
  return iVar1;
}



/* ---- tScreenTournamentStandings::DrawBackground  [SCREENPOST.CPP:164-312] ---- */
void tScreenTournamentStandings::DrawBackground()

{
  short rank;
  char *str;
  int iVar3;
  int iVar4;
  tTexture_ShapeInfo *shape;
  tListIteratorTournament *this_00;
  long lVar5;
  int tt;
  int wwwww;
  int colb;
  tMenuTextState statedull;
  int j;
  int iVar6;
  int i;
  int iVar7;
  int colf;
  int lbx;
  int width;
  int wobble;
  tMenuTextState state;
  tMenuTextState textState_00;
  int iVar8;
  int fade;
  int iVar9;
  char sBuildOutput [80];
  tTrackInformation trackInfo;
  tDrawShapeExtended drawflags;
  short p;
  int fadeline;
  tTourneyInfo *tourneyInfo;
  int iStack_34;
  int iStack_30;
  
  iVar9 = (int)(this->_base_tScreen).fScreenFadeVal;
  iVar8 = 0x2fe;
  tourneyInfo = (tournamentManager.fDefinition)->fTournaments +
                (uint)(tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset
                + tournamentManager.fTournament;
  iStack_34 = (int)(((int)(short)tournamentManager.fNumRacers +
                    (uint)(tourneyInfo->fKnockout != '\0')) * 0x10000) >> 0x10;
  iStack_30 = iStack_34 + -1;
  fadeline = iVar9;
  for (iVar7 = 0; iVar7 < iStack_34; iVar7 = iVar7 + 1) {
    rank = PlayerRanking(&tournamentManager,(short)((uint)((iVar7 + 1) * 0x10000) >> 0x10));
    iVar6 = (int)rank;
    textState_00 = textState_Selected;
    if (iVar6 == 0) {
      textState_00 = textState_Hilighted;
      statedull = textState_Hilighted;
    }
    else {
      statedull = textState_Unselected;
    }
    str = TextSys_Word(iVar7 + 599);
    iVar3 = TextSys_WordX(0x2f7);
    iVar4 = TextSys_WordY(iVar8);
    FETextRender_FullTextFade(iVar9,str,(short)iVar3,(short)iVar4,textType_TrackRecords,statedull,0);
    if (iVar6 == 0) {
      str = PlayerName(0);
    }
    else {
      str = Stattool_GetAINameFromPersonality(tournamentManager.fCompetitors[iVar6].fPersonality);
    }
    iVar6 = TextSys_WordX(0x2f8);
    iVar3 = TextSys_WordY(iVar8);
    FETextRender_FullTextFade(iVar9,str,(short)iVar6,(short)iVar3,textType_TrackRecords,textState_00,0);
    p = rank;
    if (tourneyInfo->fKnockout == '\0') {
      rank = TournPointTotal(&tournamentManager,&p);
      str = TextSys_Word(0x31d);
      sprintf(sBuildOutput,"%d %s",(int)rank,str);
    }
    else {
      iVar6 = 0x31b;
      if (iVar7 == iStack_30) {
        iVar6 = 0x31c;
      }
      str = TextSys_Word(iVar6);
      sprintf(sBuildOutput,str);
    }
    iVar6 = TextSys_WordX(0x2fb);
    iVar3 = TextSys_WordY(iVar8);
    FETextRender_FullTextFade(iVar9,sBuildOutput,(short)iVar6,(short)iVar3,textType_TrackRecords,textState_00,1);
    iVar8 = iVar8 + 1;
  }
  rank = Front_GetTrackRaced();
  GetTrack(&trackManager,rank,&trackInfo);
  rank = Front_GetTrackRaced();
  str = TextSys_Word(rank + 0xd5);
  iVar7 = TextSys_WordX(0x2f6);
  iVar8 = TextSys_WordY(0x2fd);
  FETextRender_FullTextFade(iVar9,str,(short)iVar7,(short)iVar8,textType_TrackRecords,textState_Hilighted,2);
  if (frontEnd.tier == '\0') {
    this_00 = &menuDefs->iteratorTournament;
  }
  else {
    this_00 = &menuDefs->iteratorSpecialEvent;
  }
  iVar7 = TextValue(this_00,kPlayerBoth);
  iVar6 = (short)iVar7 + 0x13;
  iVar7 = TextSys_WordX(0x2f6);
  iVar8 = TextSys_WordY(0x2fc);
  FETextRender_MenuTextPositionedJustifyFade(iVar9,(short)((uint)(iVar6 * 0x10000) >> 0x10),(short)iVar7,(short)iVar8,2,
             textState_Hilighted,textType_TrackRecords);
  str = TextSys_Word(iVar6);
  iVar7 = textpixels(str);
  iVar8 = TextSys_WordX(0x2f6);
  iVar6 = TextSys_WordY(0x2fc);
  PSXDrawSquare(0,iVar8 - (iVar7 >> 1),iVar6 + -1,iVar7,9);
  width = gCurrentShapes[0x27].width;
  lbx = (width >> 1) - 2 - gCurrentShapes[0x27].centerx;
  wobble = ticks % (short)width;
  if ((width >> 1) < wobble) {
    wobble = width - wobble;
  }
  DrawShapeExtended(0x28,0,lbx + wobble,TextSys_WordY(0x2fc) + 1,
             (int)(this->_base_tScreen).fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  DrawShapeExtended(0x28,0,lbx - wobble,TextSys_WordY(0x2fc) + 1,
             (int)(this->_base_tScreen).fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  drawflags.tint[0] = 0x282828;
  DrawShapeExtended(0x27,0x400,0,-1,
             (int)(this->_base_tScreen).fScreenFadeVal,0,&drawflags);
  iVar7 = TextSys_WordX(0x2f6);
  iVar8 = TextSys_WordY(0x2fd);
  iVar8 = iVar8 + 10;
  PSXDrawBrightEndLine(0x232323,iVar7 + -0x96,iVar8,300,1,3,fadeline,0x1e);
  colf = CalcFadeVal(kRGBVals[(byte)textDefinitions[0xb][5]],iVar8);
  iVar8 = CalcFadeVal(0x232323,iVar8);
  if ((1000 < ticks - this->starttick) || (this->fStartCountdownNOW != 0)) {
    if ((0 < this->moneyAwarded) || ((0 < this->moneyDamage || (0 < this->moneyBonus)))) {
      AudioCmn_PlayFESFX(0x15);
    }
    iVar3 = this->fCountSpeed;
    iVar6 = this->moneyAwarded - iVar3;
    this->moneyAwarded = iVar6;
    if (iVar6 < 1) {
      this->moneyAwarded = 0;
      iVar6 = this->moneyDamage - iVar3;
      this->moneyDamage = iVar6;
      if (iVar6 < 1) {
        this->fCountedDown = 1;
        lVar5 = this->moneyBonus - iVar3;
        this->moneyDamage = 0;
        if (lVar5 < 0) {
          lVar5 = 0;
        }
        this->moneyBonus = lVar5;
      }
    }
  }
  if (this->fDrawMoney != 0) {
    str = TextSys_Word(0x312);
    iVar6 = TextSys_WordX(0x2fa);
    iVar3 = TextSys_WordY(0x312);
    FETextRender_FullTextFade(iVar9,str,(short)iVar6,(short)iVar3,textType_TrackRecords,
               (uint)(this->gotmoney != 0),1);
    iVar6 = TextSys_WordX(0x2fb);
    iVar3 = TextSys_WordY(0x312);
    DrawMoney(iVar6,iVar3,6,this->moneyAwarded,colf,iVar8);
    str = TextSys_Word(0x313);
    iVar6 = TextSys_WordX(0x2fa);
    iVar3 = TextSys_WordY(0x313);
    FETextRender_FullTextFade(iVar9,str,(short)iVar6,(short)iVar3,textType_TrackRecords,
               (uint)(this->gotbilled != 0),1);
    iVar6 = TextSys_WordX(0x2fb);
    iVar3 = TextSys_WordY(0x313);
    DrawMoney(iVar6,iVar3,6,this->moneyDamage,colf,iVar8);
    str = TextSys_Word(0x314);
    iVar6 = TextSys_WordX(0x2fa);
    iVar3 = TextSys_WordY(0x314);
    FETextRender_FullTextFade(iVar9,str,(short)iVar6,(short)iVar3,textType_TrackRecords,
               (uint)(this->gotbonus != 0),1);
    iVar6 = TextSys_WordX(0x2fb);
    iVar3 = TextSys_WordY(0x314);
    DrawMoney(iVar6,iVar3,6,this->moneyBonus,colf,iVar8);
  }
  str = TextSys_Word(0x315);
  iVar6 = TextSys_WordX(0x2fa);
  iVar3 = TextSys_WordY(0x315);
  FETextRender_FullTextFade(iVar9,str,(short)iVar6,(short)iVar3,textType_TrackRecords,textState_Hilighted,1);
  iVar9 = TextSys_WordX(0x2fb);
  iVar6 = TextSys_WordY(0x315);
  DrawMoney(iVar9,iVar6,9,
             ((this->moneyFinal - this->moneyAwarded) + this->moneyDamage) - this->moneyBonus,colf,
             iVar8);
  DrawBackgroundImage(&this->_base_tScreen,10,0x1d,gCurrentShapes,0);
  return;
}



/* ---- tScreenPinkSlipStandings::DrawBackground  [SCREENPOST.CPP:320-401] ---- */
void tScreenPinkSlipStandings::DrawBackground()

{
  int iVar1;
  int iVar2;
  char *str;
  int iVar4;
  tTexture_ShapeInfo *shape;
  tfrontEnd *index;
  int tt;
  int wwwww;
  int lbx;
  tDrawShapeExtended drawflags;
  int width;
  int wobble;
  uint i;
  tMenuTextState state;
  tMenuTextState textState;
  int fade;
  int iVar7;
  tMenuTextType type;
  char sBuildOutput [50];
  tTrackInformation trackInfo;
  char string [30];
  
  wwwww = 0x2fe;
  iVar7 = (int)(this->_base_tScreenTournamentStandings3item)._base_tScreenTournamentStandings._base_tScreen.
               fScreenFadeVal;
  for (i = 0; textState = textState_Hilighted,
      (int)i < (int)(uint)(byte)frontEnd.pinkSlipsNumTracks; i = i + 1) {
    if (i != (byte)frontEnd.pinkSlipsTrackIndex) {
      textState = (tMenuTextState)((int)i < (int)(uint)(byte)frontEnd.pinkSlipsTrackIndex);
    }
    GetTrack(&trackManager,(ushort)(byte)frontEnd.track[i],&trackInfo);
    iVar1 = TextSys_WordX(0x2f7);
    iVar2 = TextSys_WordY(wwwww);
    FETextRender_MenuTextPositionedJustifyFade((int)(this->_base_tScreenTournamentStandings3item)._base_tScreenTournamentStandings._base_tScreen.
                    fScreenFadeVal,trackInfo.fTrackID + 0xd5,(short)iVar1,(short)iVar2,0,textState,
               textType_TrackRecords);
    if (frontEnd.pinkSlipsWinner[i] == -1) {
      str = TextSys_Word(0x30d);
    }
    else {
      str = PlayerName((int)frontEnd.pinkSlipsWinner[i]);
    }
    sprintf(string,str);
    iVar1 = TextSys_WordX(0x2fb);
    iVar2 = TextSys_WordY(wwwww);
    FETextRender_FullTextFade(iVar7,string,(short)iVar1,(short)iVar2,textType_TrackRecords,textState,1);
    wwwww = wwwww + 1;
  }
  wwwww = 0;
  iVar1 = 0x313;
  do {
    str = PlayerName(wwwww);
    iVar2 = TextSys_WordX(0x2f8);
    iVar4 = TextSys_WordY(iVar1);
    FETextRender_FullTextFade(iVar7,str,(short)iVar2,(short)iVar4,textType_TrackRecords,textState_Hilighted,0);
    index = &frontEnd;
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
    FETextRender_FullTextFade(iVar7,sBuildOutput,(short)iVar2,(short)iVar4,textType_TrackRecords,
               textState_Hilighted,1);
    wwwww = wwwww + 1;
    iVar1 = iVar1 + 1;
  } while (wwwww < 2);
  wwwww = TextSys_WordX(0x2f6);
  iVar1 = TextSys_WordY(0x2fc);
  FETextRender_MenuTextPositionedJustifyFade(iVar7,0x2c1,(short)wwwww,(short)iVar1,2,textState_Hilighted,textType_TrackRecords);
  str = TextSys_Word(0x2c1);
  wwwww = textpixels(str);
  iVar7 = TextSys_WordX(0x2f6);
  iVar1 = TextSys_WordY(0x2fc);
  PSXDrawSquare(0,iVar7 - (wwwww >> 1),iVar1 + -1,wwwww,9);
  width = gCurrentShapes[0x27].width;
  lbx = (width >> 1) - 2 - gCurrentShapes[0x27].centerx;
  wobble = ticks % (short)width;
  if ((width >> 1) < wobble) {
    wobble = width - wobble;
  }
  drawflags.tint[0] = 0x282828;
  DrawShapeExtended(0x28,0,lbx + wobble,TextSys_WordY(0x2fc) + 1,
             (int)(this->_base_tScreenTournamentStandings3item)._base_tScreenTournamentStandings._base_tScreen.
                  fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  DrawShapeExtended(0x28,0,lbx - wobble,TextSys_WordY(0x2fc) + 1,
             (int)(this->_base_tScreenTournamentStandings3item)._base_tScreenTournamentStandings._base_tScreen.
                  fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  DrawShapeExtended(0x27,0x400,0,-1,
             (int)(this->_base_tScreenTournamentStandings3item)._base_tScreenTournamentStandings._base_tScreen.
                  fScreenFadeVal,0,&drawflags);
  DrawBackgroundImage((tScreen *)this,10,0x1d,gCurrentShapes,0);
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
  tScreen_dtor((tScreen *)this);
  return;
}



/* ---- tScreenTournamentStandings3item::dtor  [SCREENPOST.CPP:72-406] ---- */
tScreenTournamentStandings3item::~tScreenTournamentStandings3item()

{
  tScreen_dtor((tScreen *)this);
  return;
}



/* ---- tScreenTournamentStandings::dtor  [SCREENPOST.CPP:64-406] ---- */
tScreenTournamentStandings::~tScreenTournamentStandings()

{
  int tt;
  int wwwww;
  int colb;
  int colf;
  int i;
  char sBuildOutput [80];
  tTrackInformation trackInfo;
  char string [30];
  
  tScreen_dtor(&this->_base_tScreen);
  return;
}



/* end of screenpost.cpp */
