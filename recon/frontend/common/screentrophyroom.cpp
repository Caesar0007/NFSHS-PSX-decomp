/* frontend/screens/screentrophyroom.cpp -- RECONSTRUCTED (trophy-room screen; C++ TU)
 *   9 member fns (incl ctor) of tScreenTrophyRoom (embeds tScreen base as _base_tScreen).
 *   Bodies from Ghidra; namespaces stripped, phantom stack-args resolved vs disasm.
 */
#include "screentrophyroom.h"


/* ---- tScreenTrophyRoom::ctor  [SCREENTROPHYROOM.CPP:40-43] ---- */
tScreenTrophyRoom::tScreenTrophyRoom()

{
  
  tScreen_ctor(&this->_base_tScreen);
  (this->_base_tScreen)._vf = (__vtbl_ptr_type (*)[10])tScreenTrophyRoom_vtable;
  this->fPreviousTrophy = '\0';
  this->fRealCurrentTourn[0] = 0;
  this->fRealCurrentTourn[1] = 0;
  return;
}



/* ---- tScreenTrophyRoom::dtor  [SCREENTROPHYROOM.CPP:44-48] ---- */
tScreenTrophyRoom::~tScreenTrophyRoom()

{
  (this->_base_tScreen)._vf = (__vtbl_ptr_type (*)[10])tScreenTrophyRoom_vtable;
  tScreen_dtor(&this->_base_tScreen);
  return;
}



/* ---- tScreenTrophyRoom::GetShapeInfo  [SCREENTROPHYROOM.CPP:49-63] ---- */
void tScreenTrophyRoom::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  
  numPermShapes = 0x26;
  numSwapShapes = 0x20;
  GetTrophyName(&tournamentManager,
             (tournamentManager.fDefinition)->fTournaments +
             (uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset +
             (uint)(byte)this->fRealCurrentTourn[(byte)frontEnd.tier],ts_Small,gSwapFileName,-1);
  *permFileName = "zTrophy";
  *swapFileName = gSwapFileName;
  return;
}



/* ---- tScreenTrophyRoom::ProcessInput  [SCREENTROPHYROOM.CPP:64-99] ---- */
void tScreenTrophyRoom::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)

{
  tGlobalMenuDefs *mdefs;
  short step;
  int half;
  tInputKeyType key;
  int tierIdx;
  
  mdefs = menuDefs;
  key = keyval;
  if (key == kInput_KeyType_Cross) {
    command.type = kMenu_Command_GoToMenu;
    command.nextMenu = (tMenu *)&mdefs->menuTrophyInfo;
    key = keyval;
  }
  if ((key != kInput_KeyType_Up) && (key != kInput_KeyType_Down))
  goto TrophyRoomProc_keyLeftCheck;
  tierIdx = this->tier;
  half = (uint)(ushort)this->fNumTrophies << 0x10;
  half = (half >> 0x10) - (half >> 0x1f) >> 1;
  step = (short)half;
  if (this->fRealCurrentTourn[tierIdx] < half) {
    this->fRealCurrentTourn[tierIdx] = this->fRealCurrentTourn[tierIdx] + step;
    half = 3;
  }
  else {
    this->fRealCurrentTourn[tierIdx] = this->fRealCurrentTourn[tierIdx] - step;
    half = 4;
  }
  AudioCmn_PlayFESFX(half);
  if (this->fRealCurrentTourn[this->tier] < 1) {
    if (0 < this->fNumTrophies) goto TrophyRoomProc_clampLowTourn;
TrophyRoomProc_useNumTrophies:
    step = this->fNumTrophies;
  }
  else {
    if (this->fNumTrophies <= this->fRealCurrentTourn[this->tier])
    goto TrophyRoomProc_useNumTrophies;
TrophyRoomProc_clampLowTourn:
    step = this->fRealCurrentTourn[this->tier];
    if (this->fRealCurrentTourn[this->tier] < 0) {
      step = 0;
    }
  }
  this->fRealCurrentTourn[this->tier] = step;
  key = keyval;
TrophyRoomProc_keyLeftCheck:
  if (key == kInput_KeyType_Left) {
    this->fRealCurrentTourn[this->tier] = this->fRealCurrentTourn[this->tier] + -1;
    if (this->fRealCurrentTourn[this->tier] < 0) {
      this->fRealCurrentTourn[this->tier] = this->fNumTrophies + -1;
    }
  }
  if (keyval == kInput_KeyType_Right) {
    this->fRealCurrentTourn[this->tier] = this->fRealCurrentTourn[this->tier] + 1;
    if (this->fNumTrophies <= this->fRealCurrentTourn[this->tier]) {
      this->fRealCurrentTourn[this->tier] = 0;
    }
  }
  ::ProcessInput(&this->_base_tScreen,fromPlayer,keyval,command);
  return;
}



/* ---- tScreenTrophyRoom::PreLoad  [SCREENTROPHYROOM.CPP:100-111] ---- */
void tScreenTrophyRoom::PreLoad()

{
  char *name;
  
  ::PreLoad(&this->_base_tScreen);
  (this->fTrophyShapes).fShapes = (tTexture_ShapeInfo *)0x0;
  InitializeShapes(&this->_base_tScreen,&this->fTrophyShapes,8);
  if (frontEnd.tier == '\0') {
    name = "zCase";
  }
  else {
    name = "zCase2";
  }
  AsyncLoadShapeFile(&this->_base_tScreen,name,&this->fTrophyShapes);
  return;
}



/* ---- tScreenTrophyRoom::Initialize  [SCREENTROPHYROOM.CPP:112-152] ---- */
void tScreenTrophyRoom::Initialize()

{
  short numT;
  void *loaded;
  int i_int;
  short n_trophies;
  int curIdx;
  int place;
  short i;
  uint tour_idx;
  
  this->_base_tScreen.Initialize();
  do {
    systemtask(0);
    loaded = IsShapeFileLoaded(&this->_base_tScreen,&this->fTrophyShapes);
  } while (loaded != (void *)0x1);
  this->tier = (uint)(byte)frontEnd.tier;
  n_trophies = 6;
  if (frontEnd.tier != '\0') {
    n_trophies = 8;
  }
  tour_idx = 0;
  this->fNumTrophies = n_trophies;
  this->fClearScreen = 1;
  i_int = 0;
  while( true ) {
    i = i_int >> 0x10;
    if (this->fNumTrophies <= i) break;
    this->fTrophyList[i] = 1;
    place = 0;
    if ((int)tournamentManager.fBestPlacement
             [(tournamentManager.fDefinition)->fTournaments
              [(uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset +
               (tour_idx & 0xff)].fTournamentID] - 1U < 3) {
      place = (int)tournamentManager.fBestPlacement
                   [(tournamentManager.fDefinition)->fTournaments
                    [(uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset
                     + (tour_idx & 0xff)].fTournamentID];
    }
    tour_idx = tour_idx + 1;
    FETexture_LoadPmxAtOffset((this->fTrophyShapes).fFile,i * 4 + (int)(short)place,
               (this->fTrophyShapes).fShapes + i,0,0);
    i_int = tour_idx * 0x10000;
  }
  purgememadr((this->fTrophyShapes).fFile);
  numT = this->fNumTrophies;
  (this->fTrophyShapes).fFile = (char *)0x0;
  this->fTrophyList[numT] = 0;
  curIdx = this->fNumTrophies + -1;
  if (this->fRealCurrentTourn[this->tier] < curIdx) {
    curIdx = (int)this->fRealCurrentTourn[this->tier];
  }
  this->fRealCurrentTourn[this->tier] = (short)curIdx;
  this->fPreviousTrophy = (char)this->fRealCurrentTourn[this->tier];
  this->startTicks = ticks;
  return;
}



/* ---- tScreenTrophyRoom::Cleanup  [SCREENTROPHYROOM.CPP:153-160] ---- */
void tScreenTrophyRoom::Cleanup()

{
  
  FreeShapes(&this->_base_tScreen,&this->fTrophyShapes);
  this->_base_tScreen.Cleanup();
  return;
}



/* ---- tScreenTrophyRoom::DrawBackground  [SCREENTROPHYROOM.CPP:161-234] ---- */
void tScreenTrophyRoom::DrawBackground()

{
  char *sMenuText;
  int texttoshow;
  short x;
  int amount;
  short y;
  short i;
  int fModNumber;
  int TROPHY_LEFTOFFSET = 0x114;
  int shapeArgB = 0, shapeArgC = 0;   /* ScaleShape y/scale args (stack-passed, lost by decompiler) */
  tDrawShapeExtended drawFlags3;
  tDrawShapeExtended drawFlags;
  
  drawFlags3.tint[0] = 0xcec844;
  DrawShapeExtended(ticks >> 0x1f,0x410,0x10,0x10,0,0,&drawFlags3);
  fModNumber = 3;
  if (frontEnd.tier != '\0') {
    fModNumber = 4;
  }
  DrawBackgroundImage(&this->_base_tScreen,0,0x18,gCurrentShapes,0);
  PSXDrawBrightEndLine(0x232323,0x6a,0x39,300,1,3,(int)(this->_base_tScreen).fScreenFadeVal,0x1e);
  this->LoadTrophy();
  IsShapeFileLoaded(&this->_base_tScreen,&(this->_base_tScreen).fSwapShapes);
  if ((this->_base_tScreen).fSwapShapes.fFile != (char *)0x0) {
    UploadSwapShapes(&this->_base_tScreen,0x20);
    this->startTicks = ticks;
  }
  FETextRender_MenuTextPositionedJustifyFade((int)(this->_base_tScreen).fScreenFadeVal,
             (tournamentManager.fDefinition)->fTournaments
             [(uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset +
              (uint)(byte)this->fRealCurrentTourn[this->tier]].fTournamentID + 0x354,0x100,0x2f,2,
             textState_Hilighted,textType_ScreenInfo);
  amount = 0x23;
  texttoshow = 0x3de;
  if (((gPadinfo.buf[0].ID == '#') &&
      ((gPadinfo.buf[4].ID == '#' || (gPadinfo.buf[4].nopad != '\0')))) ||
     ((gPadinfo.buf[4].ID == '#' && ((gPadinfo.buf[0].ID == '#' || (gPadinfo.buf[0].nopad != '\0')))
      ))) {
    texttoshow = 0x3df;
  }
  else if ((gPadinfo.buf[0].ID == '#') || (gPadinfo.buf[4].ID == '#')) {
    texttoshow = 0x3e0;
  }
  sMenuText = TextSys_Word(texttoshow);
  texttoshow = CalcFadeVal(0x505050,amount);
  FETextRender_FullTextRGB(sMenuText,0x100,200,texttoshow,'\0',2);
  for (i = 0; texttoshow = (int)i, texttoshow < this->fNumTrophies; i = i + 1) {
    if ((texttoshow == this->fRealCurrentTourn[this->tier]) &&
       (((this->_base_tScreen).fSwapShapes.fFlags & 1) != 0)) {
      drawFlags.custom_shapes = (this->_base_tScreen).fSwapShapes.fShapes;
    }
    else {
      drawFlags.custom_shapes = (this->fTrophyShapes).fShapes;
    }
    ScaleShapeExtended((TROPHY_LEFTOFFSET - (fModNumber * 0x5f >> 1)) + (texttoshow % fModNumber) * 0x5f,0x600,shapeArgB,shapeArgC,(int)(this->_base_tScreen).fScreenFadeVal,0,&drawFlags)
    ;
  }
  return;
}



/* ---- tScreenTrophyRoom::LoadTrophy  [SCREENTROPHYROOM.CPP:235-247 (body @240)] ---- */
void tScreenTrophyRoom::LoadTrophy()

{
  short x;
  char *fileName;
  short y;
  int fModNumber;
  int TROPHY_LEFTOFFSET;
  tDrawShapeExtended drawFlags3;
  tDrawShapeExtended drawFlags;
  
  if (this->fRealCurrentTourn[this->tier] != (ushort)(byte)this->fPreviousTrophy) {
    fileName = (char *)0x0;
    GetTrophyName(&tournamentManager,
               (tournamentManager.fDefinition)->fTournaments +
               (uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset +
               (uint)(byte)this->fRealCurrentTourn[this->tier],ts_Small,gSwapFileName,-1);
    AsyncLoadSwapShapeFile(&this->_base_tScreen,gSwapFileName);
    this->fPreviousTrophy = (char)this->fRealCurrentTourn[this->tier];
  }
  return;
}



/* end of screentrophyroom.cpp */
