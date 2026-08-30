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
  /* SYM-CODEGEN-CARRIER: dayTimes2 -- collapsing both terms is measured FAIL 10
     (40/40) and swaps the retail byte-load/arithmetic destinations. */
  int dayTimes2 = (uint)(this->fTrack).fTimeOfDay * 2;
  /* SYM-CODEGEN-CARRIER: weatherPlus -- paired with dayTimes2 in that receipt. */
  int weatherPlus = (this->fTrack).fWeather + 0x61;
  sprintf(gSwapFileName,"TR%02d%c",(int)(signed char)(this->fTrack).fTrackNumber,
             dayTimes2 + weatherPlus);
  *swapFileName = gSwapFileName;
  return;
}

/* ---- tScreenTrackInfo::DrawBackground  (screentrackinfo.cpp:58) ---- */
/* PASS (162/162).  SYM identifies only i=$s0, trackInfo=$s5, and the local
   trackConditions array.  Expressing both loops with indexed operands lets
   GCC strength-reduce the retail pointer/Y induction variables itself; named
   pointer/Y locals left three scheduling residuals.  For the four justified
   labels, two post-use read-only references to screenInfo price the saved
   constants as retail s2=highlighted and s1=screenInfo without a pre-call
   barrier, leaving a3=1 available for the retail sllv index scale.  Folding
   state into the call conditional is FAIL37 at 165/162 instructions and
   rotates the loop's saved-register/address schedule. */
void tScreenTrackInfo::DrawBackground()

{
  /* Reliable SYM omits these optimized-away source identities:
     SYM-CODEGEN-CARRIER: trackList
     SYM-CODEGEN-CARRIER: state
     SYM-CODEGEN-CARRIER: highlighted
     SYM-CODEGEN-CARRIER: screenInfo */
  tTrackInformation *trackInfo;
  short *trackList;
  uint i;
  short trackConditions [4] = { 0xcc, 0xcd, 0xce, 0xcf };  /* .rodata @0x80011f6c: FE condition-label text IDs */
  
  
  trackInfo = GetTrackByID(&trackManager,(short)(this->fTrack).fTrackNumber);
  for (trackList = GetTrackList(&tournamentManager,(ushort)(byte)frontEnd.tier,
                            (ushort)(frontEnd.tier != '\0' ? frontEnd.specialevent : frontEnd.tournament)),
       i = 0; trackList[i] != 0; i = i + 1) {
    tMenuTextState state = textState_Selected;
    if (i == tournamentManager.fCurrentTrack) {
      state = textState_Hilighted;
    }
    FETextRender_MenuTextPositioned
              (trackList[i],0xaa,(short)(0x8f + (int)i * 9),
               state,textType_ScreenInfo);
  }
  for (i = 0; i < 4; i = i + 1) {
    FETextRender_MenuTextPositioned
              (trackConditions[i],0x154,(short)(0x8f + (int)i * 0x12),
               textState_Selected,textType_ScreenInfo);
  }
  tMenuTextState highlighted = textState_Hilighted;
  tMenuTextType screenInfo = textType_ScreenInfo;
  FETextRender_MenuTextPositionedJustify
            (SelectListTrackDirection[(this->fTrack).fDirection],0x1e0,0x98,1,highlighted,
             screenInfo);
  FETextRender_MenuTextPositionedJustify
            (SelectListOffOn[(this->fTrack).fMirrored],0x1e0,0xaa,1,highlighted,
             screenInfo);
  FETextRender_MenuTextPositionedJustify
            (SelectListOffOn[(this->fTrack).fTimeOfDay],0x1e0,0xbc,1,highlighted,
             screenInfo);
  FETextRender_MenuTextPositionedJustify
            (SelectListOffOn[(this->fTrack).fWeather],0x1e0,0xce,1,highlighted,
             screenInfo);
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
  this->tScreen::Initialize();
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
    /* SYM-CODEGEN-CARRIER: fee -- direct addition is measured FAIL 8 (39/39)
       because it swaps the retail value and accumulated-money registers. */
    long fee = *(long *)((char *)(tournamentManager.fDefinition) +
         ((uint)(tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset +
          tournamentManager.fTournament) * sizeof(tTourneyInfo) + 0x54);
    tournamentManager.fMoney = tournamentManager.fMoney + fee;
  }
  return;
}

/* ---- tScreenTrackInfo::~tScreenTrackInfo  (screentrackinfo.cpp:52) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___16tScreenTrackInfo(void *thisp) { ___7tScreen(thisp); }

/* end of screentrackinfo.cpp */
