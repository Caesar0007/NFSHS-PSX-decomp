/* frontend/screens/screentrackinfo.cpp  --  RECONSTRUCTED  (track-records screen; C++ TU)
 *   5 member fns of tScreenTrackInfo : tScreen. Member-fn decls in nfs4_types.h. Bodies: Ghidra.
 */
#include "screentrackinfo.h"

/* ---- tScreenTrackInfo::GetShapeInfo  (screentrackinfo.cpp:46) ---- */
void tScreenTrackInfo::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName
               ,char **swapFileName)

{

  numPermShapes = 0x2b;
  numSwapShapes = 10;
  GetTrackToRace(&tournamentManager,&this->fTrack);
  *permFileName = "zInfo";
  int dayTimes2 = (uint)(this->fTrack).fTimeOfDay * 2;
  int weatherPlus = (this->fTrack).fWeather + 0x61;
  sprintf(gSwapFileName,"TR%02d%c",(int)(signed char)(this->fTrack).fTrackNumber,
             dayTimes2 + weatherPlus);
  *swapFileName = gSwapFileName;
  return;
}

/* ---- tScreenTrackInfo::DrawBackground  (screentrackinfo.cpp:58) ---- */
void tScreenTrackInfo::DrawBackground()

{
  byte useSpecial;
  short condTextId;
  tTrackInformation *trackInfo;
  short *pList;
  tMenuTextState textState;
  int listIndex;
  uint condCount;
  int trackY;
  short trackConditions [4] = { 0xcc, 0xcd, 0xce, 0xcf };  /* .rodata @0x80011f6c: FE condition-label text IDs */
  
  
  trackInfo = GetTrackByID(&trackManager,(short)(this->fTrack).fTrackNumber);
  useSpecial = frontEnd.tournament;
  if (frontEnd.tier != '\0') {
    useSpecial = frontEnd.specialevent;
  }
  listIndex = 0;
  pList = GetTrackList(&tournamentManager,(ushort)(byte)frontEnd.tier,(ushort)useSpecial);
  trackY = 0x8f0000;
  for (; *pList != 0; pList = pList + 1) {
    textState = textState_Selected;
    if (listIndex == tournamentManager.fCurrentTrack) {
      textState = textState_Hilighted;
    }
    FETextRender_MenuTextPositioned(*pList,0xaa,(short)((uint)trackY >> 0x10),textState,textType_ScreenInfo);
    trackY = trackY + 0x90000;
    listIndex = listIndex + 1;
  }
  condCount = 0;
  trackY = 0x8f0000;
  pList = trackConditions;
  do {
    condTextId = *pList;
    pList = pList + 1;
    condCount = condCount + 1;
    FETextRender_MenuTextPositioned
              (condTextId,0x154,(short)((uint)trackY >> 0x10),textState_Selected,textType_ScreenInfo);
    trackY = trackY + 0x120000;
  } while (condCount < 4);
  FETextRender_MenuTextPositionedJustify
            (SelectListTrackDirection[(this->fTrack).fDirection],0x1e0,0x98,1,textState_Hilighted,
             textType_ScreenInfo);
  FETextRender_MenuTextPositionedJustify
            (SelectListOffOn[(this->fTrack).fMirrored],0x1e0,0xaa,1,textState_Hilighted,
             textType_ScreenInfo);
  FETextRender_MenuTextPositionedJustify
            (SelectListOffOn[(this->fTrack).fTimeOfDay],0x1e0,0xbc,1,textState_Hilighted,
             textType_ScreenInfo);
  FETextRender_MenuTextPositionedJustify
            (SelectListOffOn[(this->fTrack).fWeather],0x1e0,0xce,1,textState_Hilighted,
             textType_ScreenInfo);
  FETextRender_MenuTextPositionedJustify
            (trackInfo->fSpeedoCountry + 0x43,0x1de,0x21,1,textState_Unselected,textType_TrackRecords);
  ::DrawBackgroundImage((tScreen *)this,0,0x21,this->fPermShapes.fShapes,0);
  PSXDrawTransSquare(0,0x140,0x1e,0xa0,10,1);
  FeDraw_SetABRMode(0);
  ::UpdateTransition(&this->fVideoWall);
  ::Draw(&this->fVideoWall);
  return;
}

/* ---- tScreenTrackInfo::Initialize  (screentrackinfo.cpp:97) ---- */
void tScreenTrackInfo::Initialize()

{
  this->Initialize();
  ::Initialize(&this->fVideoWall,this->tvConfigs,this->fSwapShapes.fShapes,0,10,tvOrder,0);
  UpdateImages(&this->fVideoWall);
  TurnOn(&this->fVideoWall);
  return;
}

/* ---- tScreenTrackInfo::ProcessInput  (screentrackinfo.cpp:108) ---- */
void tScreenTrackInfo::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)

{
  if ((keyval == kInput_KeyType_Triangle) &&
     (TurnOffInstant(&this->fVideoWall), tournamentManager.fCurrentTrack == 0)) {
    long fee = *(long *)((char *)(tournamentManager.fDefinition) +
         ((uint)(tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset +
          tournamentManager.fTournament) * sizeof(tTourneyInfo) + 0x54);
    tournamentManager.fMoney = tournamentManager.fMoney + fee;
  }
  return;
}

/* ---- tScreenTrackInfo::~tScreenTrackInfo  (screentrackinfo.cpp:52) ---- */
tScreenTrackInfo::~tScreenTrackInfo()

{
  return;
}

/* end of screentrackinfo.cpp */