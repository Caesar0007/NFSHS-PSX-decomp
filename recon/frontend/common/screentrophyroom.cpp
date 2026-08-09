/* frontend/screens/screentrophyroom.cpp -- RECONSTRUCTED (trophy-room screen; C++ TU)
 *   9 member fns (incl ctor) of tScreenTrophyRoom (embeds tScreen base as _base_tScreen).
 *   Bodies from Ghidra; namespaces stripped, phantom stack-args resolved vs disasm.
 */
#include "screentrophyroom.h"


/* ---- tScreenTrophyRoom::ctor  [SCREENTROPHYROOM.CPP:40-43] ---- */
tScreenTrophyRoom::tScreenTrophyRoom()

{

  this->_vf = (__vtbl_ptr_type (*)[10])tScreenTrophyRoom_vtable;
  this->fPreviousTrophy = '\0';
  this->fRealCurrentTourn[0] = 0;
  this->fRealCurrentTourn[1] = 0;
  return;
}



/* ---- tScreenTrophyRoom::dtor  [SCREENTROPHYROOM.CPP:44-48] ---- */
tScreenTrophyRoom::~tScreenTrophyRoom()

{
  /* MATCH: NO manual tScreen_dtor call — the declared base dtor auto-fires
     (gcc-2.8 derived-dtor shape: vptr store in the base-dtor jal delay slot,
      original __in_chrg forwarded in $a1 untouched).  cf. catalog D/wave-3. */
  this->_vf = (__vtbl_ptr_type (*)[10])tScreenTrophyRoom_vtable;
  return;
}



/* ---- tScreenTrophyRoom::GetShapeInfo  [SCREENTROPHYROOM.CPP:49-63] ---- */
void tScreenTrophyRoom::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  /* MATCH (S3.12 #16): retail holds gSwapFileName's ADDRESS in a callee-saved
     reg ($s0) ACROSS the GetTrophyName call and reuses it for *swapFileName
     (oracle `addu $a3,$s0,$zero` ... `sw $s0,0($s2)`); materializing the
     address twice costs an extra lui/addiu pair. */
  char *swapName = gSwapFileName;

  numPermShapes = 0x26;
  numSwapShapes = 0x20;
  /* MATCH: the SLD splits this in two - line 60 computes the tournament INDEX
     (both lbu's + the shared tier*2), line 61 is the call.  As one expression
     gcc scales each index term separately (two x84 chains) and hands
     &tournamentManager a non-$a0 scratch. */
  {
    /* the THIS-dependent read must be its own statement FIRST: it frees $a0
       for &tournamentManager (oracle `addu $a1,$a0,$v0` then `lui $a0`). */
    uint cur = (uint)(byte)this->fRealCurrentTourn[(byte)frontEnd.tier];
    uint tourn = (uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset + cur;

    GetTrophyName(&tournamentManager,
               (tournamentManager.fDefinition)->fTournaments + tourn,ts_Small,swapName,-1);
  }
  *permFileName = "zTrophy";
  *swapFileName = swapName;
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
  ::ProcessInput((tScreen *)this,fromPlayer,keyval,command);
  return;
}



/* ---- tScreenTrophyRoom::PreLoad  [SCREENTROPHYROOM.CPP:100-111] ---- */
void tScreenTrophyRoom::PreLoad()

{
  char *name;
  
  ::PreLoad((tScreen *)this);
  (this->fTrophyShapes).fShapes = (tTexture_ShapeInfo *)0x0;
  ::InitializeShapes((tScreen *)this,&this->fTrophyShapes,8);
  if (frontEnd.tier != '\0') {
    name = "zCase2";
  }
  else {
    name = "zCase";
  }
  ::AsyncLoadShapeFile((tScreen *)this,name,&this->fTrophyShapes);
  return;
}



/* ---- tScreenTrophyRoom::Initialize  [SCREENTROPHYROOM.CPP:112-152] ---- */
void tScreenTrophyRoom::Initialize()

{
  /* MATCH (W54-A7, from the SYM SLD map 0x80040910..0x80040AE4): retail's
     statements are 119 base-Initialize / 124 systemtask / 125 the load poll /
     126 tier / 127 fNumTrophies (a ONE-line select) / 128 fClearScreen /
     130 the `short i` for-loop / 132..138 ONE placement read + select /
     140 the texture load / 144..152 the tail.  No <<16 fixed-point counter,
     no `numT` temp, and the placement is read ONCE (the if-body reuses it).
     RESIDUAL 18 (count-exact 118/118) -- W57-A7: a clean TWO-PSEUDO HOME SWAP, the
     `&frontEnd` base and the 6/8 trophy-count constant trade $a0 and $v1 (retail
     base=$v1, const=$a0; ours base=$a0, const=$v1), which then drags the `addu s3,..`
     copy with it.  Nothing structural: falsified this basin -- if/else instead of the
     ternary (27, +1 insn), Yoda `'\0' != frontEnd.tier` (18), a named `short numT` temp
     (18), swapping the `this->tier` / `fNumTrophies` statement order (21, 117 insns),
     `(byte)frontEnd.tier != 0` (18).  Local-alloc QTY class (4.6 instrument gap). */
  int loaded;
  int curIdx;
  short i;

  this->Initialize();
  do {
    systemtask(0);
    loaded = (int)::IsShapeFileLoaded((tScreen *)this,&this->fTrophyShapes);
  } while ((loaded ^ 1) != 0);
  this->tier = (uint)(byte)frontEnd.tier;
  this->fNumTrophies = frontEnd.tier != '\0' ? 8 : 6;
  this->fClearScreen = 1;

  for (i = 0; i < this->fNumTrophies; i = i + 1) {
    int placement;
    short place;

    this->fTrophyList[i] = 1;
    placement = (signed char)tournamentManager.fBestPlacement
             [(signed char)(tournamentManager.fDefinition)->fTournaments
              [(uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset +
               (uint)(byte)i].fTournamentID];
    place = 0;
    if ((u_int)(placement - 1) < 3) {
      place = placement;
    }
    FETexture_LoadPmxAtOffset((this->fTrophyShapes).fFile,i * 4 + place,
               (this->fTrophyShapes).fShapes + i,0,0);
  }
  purgememadr((this->fTrophyShapes).fFile);
  (this->fTrophyShapes).fFile = (char *)0x0;
  this->fTrophyList[this->fNumTrophies] = 0;
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
  
  ::FreeShapes((tScreen *)this,&this->fTrophyShapes);
  this->Cleanup();
  return;
}



/* ---- tScreenTrophyRoom::DrawBackground  [SCREENTROPHYROOM.CPP:161-234] ---- */
/* W66 (2026-08-10): 158 -> 108 diffs (257/261 insns).  Three guide-sanctioned
   empty-template fences preserve retail lifetimes without emitting instructions
   or pinning registers: pDrawFlags remains live across the fade/text calls, the
   extra final use gives i=s1 and this=s2, and the texttoshow identity barrier
   removes two more scheduling differences.  The remaining residual is localized
   to the tournament-index expression, texttoshow's a0 handoff, and grid-loop
   call setup. */
void tScreenTrophyRoom::DrawBackground()

{
  tDrawShapeExtended drawFlags3;
  int fModNumber;
  int TROPHY_LEFTOFFSET;
  tDrawShapeExtended drawFlags;
  tDrawShapeExtended *pDrawFlags;
  short i;
  short x;
  short y;
  int texttoshow;
  char *sMenuText;
  
  drawFlags3.tint[0] = 0xcec844;
  DrawShapeExtended((ticks >> 4) % 10 + 0x1c,
                    0x410,0x10,0x10,0,0,&drawFlags3);
  fModNumber = 3;
  if (frontEnd.tier != '\0') {
    fModNumber = 4;
  }
  TROPHY_LEFTOFFSET = 0x114 - (fModNumber * 0x5f >> 1);
  ::DrawBackgroundImage((tScreen *)this,0,0x18,gCurrentShapes,0);
  PSXDrawBrightEndLine(0x232323,0x6a,0x39,300,1,3,(int)this->fScreenFadeVal,0x1e);
  this->LoadTrophy();
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  if (this->fSwapShapes.fFile != (char *)0x0) {
    ::UploadSwapShapes((tScreen *)this,0x20);
    this->startTicks = ticks;
  }
  FETextRender_MenuTextPositionedJustifyFade((int)this->fScreenFadeVal,
             (signed char)(tournamentManager.fDefinition)->fTournaments
             [(uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset +
               (uint)(byte)this->fRealCurrentTourn[this->tier]].fTournamentID + 0x354,0x100,0x2f,2,
             textState_Hilighted,textType_ScreenInfo);
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
  __asm__("" : "=r"(texttoshow) : "0"(texttoshow));
  i = 0;
  sMenuText = TextSys_Word(texttoshow);
  pDrawFlags = &drawFlags;
  __asm__("" : "=r"(pDrawFlags) : "0"(pDrawFlags));
  texttoshow = CalcFadeVal(0x505050,this->fScreenFadeVal);
  FETextRender_FullTextRGB(sMenuText,0x100,200,texttoshow,'\0',2);
  while (true) {
    texttoshow = (int)i;
    if (this->fNumTrophies <= texttoshow) break;
    x = TROPHY_LEFTOFFSET + (texttoshow % fModNumber) * 0x5f;
    y = (texttoshow / fModNumber) * 45 + 70;
    if ((texttoshow == this->fRealCurrentTourn[this->tier]) &&
       ((this->fSwapShapes.fFlags & 1) != 0)) {
      drawFlags.custom_shapes = this->fSwapShapes.fShapes;
      texttoshow = ((ticks - this->startTicks) / 12) % 32;
    }
    else {
      drawFlags.custom_shapes = (this->fTrophyShapes).fShapes;
    }
    ScaleShapeExtended(texttoshow,0x600,x,y,(int)this->fScreenFadeVal,0,pDrawFlags);
    i = i + 1;
  }
  __asm__("" : : "r"(i));
  return;
}



/* ---- tScreenTrophyRoom::LoadTrophy  [SCREENTROPHYROOM.CPP:235-247 (body @240)] ---- */
void tScreenTrophyRoom::LoadTrophy()

{
  if (this->fRealCurrentTourn[this->tier] != (ushort)(byte)this->fPreviousTrophy) {
    /* MATCH: same shape as GetShapeInfo -- the THIS-dependent index read is
       its own statement, the two index terms are GROUPED (one x84 chain), and
       gSwapFileName's address is held in a local across both calls ($s0). */
    /* the frontEnd.tier read is its OWN local so its %hi lands in the beq
       delay slot (retail's eager steal) instead of tournamentManager's. */
    uint tierIdx = (uint)(byte)frontEnd.tier;
    char *swapName = gSwapFileName;
    uint cur = (uint)(byte)this->fRealCurrentTourn[this->tier];
    uint tourn = (uint)(tournamentManager.fDefinition)->fTiers[tierIdx].fTournOffset + cur;

    GetTrophyName(&tournamentManager,
               (tournamentManager.fDefinition)->fTournaments + tourn,ts_Small,swapName,-1);
    ::AsyncLoadSwapShapeFile((tScreen *)this,swapName);
    this->fPreviousTrophy = (char)this->fRealCurrentTourn[this->tier];
  }
  return;
}



/* end of screentrophyroom.cpp */
