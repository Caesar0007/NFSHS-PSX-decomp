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
  numPermShapes = 0x26;
  numSwapShapes = 0x20;
  /* MATCH: the SLD splits the THIS-dependent current-tournament read from the
     call.  Folding that read into the call scales the index terms separately
     and hands &tournamentManager a non-$a0 scratch; the remaining offset plus
     `cur` expression can stay in the call without changing code or SLD. */
  {
    /* SYM-CODEGEN-CARRIER: cur -- folding this member read into the index is
       FAIL27 (49/48); its own statement frees $a0 before the manager address
       is formed and reproduces retail's allocation order. */
    uint cur = (uint)(byte)this->fRealCurrentTourn[(byte)frontEnd.tier];

    GetTrophyName(&tournamentManager,
               (tournamentManager.fDefinition)->fTournaments +
                 ((uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset + cur),
               ts_Small,gSwapFileName,-1);
  }
  *permFileName = "zTrophy";
  *swapFileName = gSwapFileName;
  return;
}



/* ---- tScreenTrophyRoom::ProcessInput  [SCREENTROPHYROOM.CPP:64-99] ---- */
void tScreenTrophyRoom::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)

{
  /* MATCH: the SLD records no locals for this function.  In particular, the
     clamp is the expanded EA-style MIN(MAX(current, 0), fNumTrophies): the
     repeated inner expression is significant because retail recomputes and
     reloads the selected value instead of retaining a temporary. */
  if (keyval == kInput_KeyType_Cross) {
    command.type = kMenu_Command_GoToMenu;
    command.nextMenu = (tMenu *)&menuDefs->menuTrophyInfo;
  }
  if ((keyval != kInput_KeyType_Up) && (keyval != kInput_KeyType_Down))
  goto TrophyRoomProc_keyLeftCheck;
  if (this->fRealCurrentTourn[this->tier] < this->fNumTrophies / 2) {
    this->fRealCurrentTourn[this->tier] =
         this->fRealCurrentTourn[this->tier] + this->fNumTrophies / 2;
    AudioCmn_PlayFESFX(3);
  }
  else {
    this->fRealCurrentTourn[this->tier] =
         this->fRealCurrentTourn[this->tier] - this->fNumTrophies / 2;
    AudioCmn_PlayFESFX(4);
  }
  this->fRealCurrentTourn[this->tier] =
       ((0 < this->fRealCurrentTourn[this->tier]
         ? this->fRealCurrentTourn[this->tier] : 0) < this->fNumTrophies)
       ? (0 < this->fRealCurrentTourn[this->tier]
          ? this->fRealCurrentTourn[this->tier] : 0)
       : this->fNumTrophies;
TrophyRoomProc_keyLeftCheck:
  if (keyval == kInput_KeyType_Left) {
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
  ::PreLoad((tScreen *)this);
  (this->fTrophyShapes).fShapes = (tTexture_ShapeInfo *)0x0;
  ::InitializeShapes((tScreen *)this,&this->fTrophyShapes,8);
  ::AsyncLoadShapeFile((tScreen *)this,
      frontEnd.tier != '\0' ? "zCase2" : "zCase",&this->fTrophyShapes);
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
     MATCH (2026-08-10, 18 -> PASS 118/118): the instrumented GCC dump plus allocsim
     reproduced all 13 global handouts and isolated the frontEnd/constant priority
     crossing and the loop's caller-saved-to-$s3 handoff.  The later source-only SYM
     cleanup (2026-08-26) found the simpler original-looking form: direct
     `frontEnd.tier` reads plus `loopFe = &frontEnd` preserve that handoff at exact
     PASS, so the old `fe` alias and four-input opacity fence were unnecessary.
     The load-poll result also feeds its condition directly.  The six remaining
     SYM-omitted value webs have measured counterfactual receipts beside their
     declarations; explicit `tournIdx`/`tourney`, in particular, retain retail's
     address-add result and operand order. */
  /* SYM-CODEGEN-CARRIER: curIdx -- the direct EA `MIN(current,count - 1)`
     expansion is FAIL 16 at 120/118 because it reloads both operands; retail
     keeps one candidate and one current-tournament load. */
  int curIdx;
  /* SYM-CODEGEN-CARRIER: loopFe -- reusing `fe` directly is FAIL 21 at
     117/118; it loses retail's caller-saved-to-`$s3` handoff and rotates the
     tier/constant allocation web. */
  tfrontEnd *loopFe;
  short i;

  this->tScreen::Initialize();
  do {
    systemtask(0);
  } while (((int)::IsShapeFileLoaded((tScreen *)this,&this->fTrophyShapes) ^ 1) != 0);
  this->tier = (uint)(byte)frontEnd.tier;
  this->fNumTrophies = frontEnd.tier != '\0' ? 8 : 6;
  this->fClearScreen = 1;
  i = 0;
  loopFe = &frontEnd;

  for (; i < this->fNumTrophies; i = i + 1) {
    /* SYM-CODEGEN-CARRIER: placement -- loading directly into `short place`
       and clamping the invalid case is FAIL 12 at 120/118; it changes signed
       load width and reverses the retail branch/value initialization. */
    int placement;
    /* SYM-CODEGEN-CARRIER: tournIdx -- folding the tier offset into the
       tournament pointer is FAIL 15 at 125/118 and decomposes the scaled
       address into a longer shift/add web. */
    int tournIdx;
    /* SYM-CODEGEN-CARRIER: place -- folding the clamp into the texture-call
       argument is FAIL 8 at 114/118; it removes retail's independent short
       result and its sign-extension/value-selection web. */
    short place;
    /* SYM-CODEGEN-CARRIER: tourney -- direct indexed access is count-exact
       FAIL 4 and reverses retail's pointer-add destination/operand order. */
    tTourneyInfo *tourney;

    this->fTrophyList[i] = 1;
    tournIdx = (uint)(tournamentManager.fDefinition)->fTiers[(byte)loopFe->tier].fTournOffset +
               (uint)(byte)i;
    tourney = (tournamentManager.fDefinition)->fTournaments + tournIdx;
    placement = (signed char)tournamentManager.fBestPlacement[(signed char)tourney->fTournamentID];
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
  this->tScreen::Cleanup();
  return;
}



/* ---- tScreenTrophyRoom::DrawBackground  [SCREENTROPHYROOM.CPP:161-234] ---- */
/* MATCH (W66): 108 -> PASS (261/261).  The trophy-info comma-staging receipt gives
   the this-dependent current tournament its retail evaluation order, while the
   selectedTourn pointer prevents destructive reuse of the definition base.  The
   text call is kept as one nested expression and drawFlagsPtr is published after it,
   letting sched1 place the pointer between TextSys_Word and CalcFadeVal.  Retail's
   loop came from duplicated branch-local ScaleShapeExtended calls which GCC then
   cross-jumps; spelling one shared call loses three argument-setup instructions.
   Finally, the source-order comparison `i >= fNumTrophies` produces the oracle's
   sign-extend-before-load sequence.  The two-reference fModNumber fence crosses
   its allocator step and restores the SLD s3 / drawFlagsPtr s4 handout. */
void tScreenTrophyRoom::DrawBackground()

{
  /* Reliable SYM names every retained retail local and omits these five
     optimized-away source identities justified by the W66 receipt above:
     SYM-CODEGEN-CARRIER: feTier
     SYM-CODEGEN-CARRIER: currentTourn
     SYM-CODEGEN-CARRIER: tourn
     SYM-CODEGEN-CARRIER: selectedTourn
     SYM-CODEGEN-CARRIER: drawFlagsPtr */
  tDrawShapeExtended drawFlags3;
  int fModNumber;
  int TROPHY_LEFTOFFSET;
  tDrawShapeExtended drawFlags;
  tDrawShapeExtended *drawFlagsPtr;
  short i;
  short x;
  short y;
  int texttoshow;
  
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
  {
    uint feTier = (uint)(byte)frontEnd.tier;
    byte currentTourn;
    uint tourn;
    tTourneyInfo *selectedTourn;

    tourn = (currentTourn = (byte)this->fRealCurrentTourn[this->tier],
             (uint)(tournamentManager.fDefinition)->fTiers[feTier].fTournOffset +
                 currentTourn);
    selectedTourn = (tournamentManager.fDefinition)->fTournaments + tourn;
    FETextRender_MenuTextPositionedJustifyFade((int)this->fScreenFadeVal,
               (signed char)selectedTourn->fTournamentID + 0x354,0x100,0x2f,2,
               textState_Hilighted,textType_ScreenInfo);
  }
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
  i = 0;
  FETextRender_FullTextRGB(TextSys_Word(texttoshow),0x100,200,
                           CalcFadeVal(0x505050,this->fScreenFadeVal),'\0',2);
  drawFlagsPtr = &drawFlags;
  while (true) {
    if ((int)i >= (int)this->fNumTrophies) break;
    x = TROPHY_LEFTOFFSET + (i % fModNumber) * 0x5f;
    y = (i / fModNumber) * 45 + 70;
    if ((i == this->fRealCurrentTourn[this->tier]) &&
       ((this->fSwapShapes.fFlags & 1) != 0)) {
      drawFlags.custom_shapes = this->fSwapShapes.fShapes;
      texttoshow = ((ticks - this->startTicks) / 12) % 32;
      ScaleShapeExtended(texttoshow,0x600,x,y,(int)this->fScreenFadeVal,0,drawFlagsPtr);
    }
    else {
      drawFlags.custom_shapes = (this->fTrophyShapes).fShapes;
      texttoshow = i;
      ScaleShapeExtended(texttoshow,0x600,x,y,(int)this->fScreenFadeVal,0,drawFlagsPtr);
    }
    i = i + 1;
  }
  /* W85-S5: an `__asm__("" : : "r"(fModNumber), "r"(fModNumber))` liveness fence
     stood here.  Measured INERT -- deleting it leaves the whole TU 9/9 PASS
     (byte-identical object), so it was dead scaffolding, not a codegen device. */
  return;
}



/* ---- tScreenTrophyRoom::LoadTrophy  [SCREENTROPHYROOM.CPP:235-247 (body @240)] ---- */
void tScreenTrophyRoom::LoadTrophy()

{
  if (this->fRealCurrentTourn[this->tier] != (ushort)(byte)this->fPreviousTrophy) {
    /* MATCH: the two index terms are grouped into one x84 chain.  Direct
       gSwapFileName arguments still keep its address in $s0 across both calls;
       no source alias is required. */
    /* the frontEnd.tier read is its OWN local so its %hi lands in the beq
       delay slot (retail's eager steal) instead of tournamentManager's. */
    /* SYM-CODEGEN-CARRIER: tierIdx -- folding the frontend tier read into the
       index is measured FAIL2 (54/54): the eager delay-slot %hi switches from
       frontEnd to tournamentManager even though the instruction text matches. */
    uint tierIdx = (uint)(byte)frontEnd.tier;
    /* SYM-CODEGEN-CARRIER: tourn -- folding the grouped tournament index into
       GetTrophyName is measured FAIL29 with five extra instructions (59/54),
       changing the call argument and saved-register allocation. */
    uint tourn = (uint)(tournamentManager.fDefinition)->fTiers[tierIdx].fTournOffset +
                 (uint)(byte)this->fRealCurrentTourn[this->tier];

    GetTrophyName(&tournamentManager,
               (tournamentManager.fDefinition)->fTournaments + tourn,
               ts_Small,gSwapFileName,-1);
    ::AsyncLoadSwapShapeFile((tScreen *)this,gSwapFileName);
    this->fPreviousTrophy = (char)this->fRealCurrentTourn[this->tier];
  }
  return;
}



/* end of screentrophyroom.cpp */
