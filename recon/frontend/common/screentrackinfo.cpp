/* frontend/screens/screentrackinfo.cpp  --  RECONSTRUCTED  (track-records screen; C++ TU)
 *   5 member fns of tScreenTrackInfo : tScreen. Member-fn decls in nfs4_types.h. Bodies: Ghidra.
 */
#include "screentrackinfo_types.h"
#include "screentrackinfo_externs.h"

/* ---- tScreenTrackInfo::GetShapeInfo  (screentrackinfo.cpp:46) ---- */
void tScreenTrackInfo::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName
               ,char **swapFileName)

{

  numPermShapes = 0x2b;
  numSwapShapes = 10;
  tournamentManager.GetTrackToRace(this->fTrack);
  *permFileName = "zInfo";
  /* P866: SYM has no locals.  Widen the grouped day contribution to preserve
     the retail evaluation order without dayTimes2/weatherPlus carriers.
     Both input fields are UCHAR: the result is 97..862, and the final int
     cast preserves sprintf's single-word argument.  PASS 40/40, exact -g
     twin and one SLD-53 call expression; original spelling is not proven. */
  sprintf(gSwapFileName,"TR%02d%c",(int)(signed char)(this->fTrack).fTrackNumber,
             (int)((long long)((int)(this->fTrack).fTimeOfDay * 2) +
                   ((this->fTrack).fWeather + 0x61)));
  *swapFileName = gSwapFileName;
  return;
}

/* ---- tScreenTrackInfo::DrawBackground  (screentrackinfo.cpp:58) ---- */
/* Native locals/scope contract and 162 words verified. The current-track
   getter and direct state/enum arguments remove three source-only captures;
   the older reference-price/folding failure notes no longer describe this
   source. Full SLD attribution and literal original spelling remain unsealed.
   SOURCE-REVIEW-UNRESOLVED: trackList is a real saved getter result used across
   drawing calls, but retail records no caller-local name for that value.
   ORIGINAL-NAME-UNRESOLVED: trackList; this role-derived spelling is not a
   uniquely recovered original identifier or a blanket carrier exemption. */
void tScreenTrackInfo::DrawBackground()

{
  uint i;
  short trackConditions [4] = { 0xcc, 0xcd, 0xce, 0xcf };  /* .rodata @0x80011f6c: FE condition-label text IDs */
  tTrackInformation *trackInfo;
  short *trackList;
  
  
  trackInfo = trackManager.GetTrackByID((short)(this->fTrack).fTrackNumber);
  trackList = tournamentManager.GetTrackList((ushort)(byte)frontEnd.tier,
                         (ushort)(frontEnd.tier != '\0' ? frontEnd.specialevent : frontEnd.tournament));
  for (i = 0; trackList[i] != 0; i = i + 1) {
    FETextRender_MenuTextPositioned
              (trackList[i],0xaa,(short)(0x8f + (int)i * 9),
               i == tournamentManager.CurrentTrack() ? textState_Hilighted : textState_Selected,
               textType_ScreenInfo);
  }
  for (i = 0; i < 4; i = i + 1) {
    FETextRender_MenuTextPositioned
              (trackConditions[i],0x154,(short)(0x8f + (int)i * 0x12),
               textState_Selected,textType_ScreenInfo);
  }
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
  this->tScreen::Initialize();
  ::Initialize(&this->fVideoWall,this->tvConfigs,this->fSwapShapes.fShapes,0,10,tvOrder,0);
  UpdateImages(&this->fVideoWall);
  TurnOn(&this->fVideoWall);
  return;
}

/* ---- tScreenTrackInfo::ProcessInput  (screentrackinfo.cpp:108) ---- */
/* Native local/scope contract and 39 words verified. Getter/mutator spellings
   remain inferred; full SLD attribution is not sealed. The negated fee passed
   to the unsigned mutator preserves the retail fee-first/money-second loads. */
void tScreenTrackInfo::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)

{
  if (keyval == kInput_KeyType_Triangle) {
    TurnOffInstant(&this->fVideoWall);
    if (tournamentManager.CurrentTrack() == 0) {
      tournamentManager.SubtractMoney(-(u_long)tournamentManager.CurrentTourney()->fEntranceFee);
    }
  }
  return;
}

/* ---- tScreenTrackInfo::~tScreenTrackInfo  (screentrackinfo.cpp:52) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);

/* end of screentrackinfo.cpp */
