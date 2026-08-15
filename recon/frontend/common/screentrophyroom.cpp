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
     MATCH (2026-08-10, 18 -> PASS 118/118): the instrumented GCC dump plus allocsim
     reproduced all 13 global handouts and identified the only real mismatch as the
     `&frontEnd` / 6-or-8 constant priority crossing.  Four read-only references at
     the proven early placement give retail base=$v1 and constant=$a0; moving that
     zero-insn fence to `fe`'s last use lengthens the pseudo and loses the crossing.
     A separate `loopFe = fe` states retail's caller-saved-to-$s3 handoff; splitting
     `i = 0` before it gives the SLD-130 `$s1` then `$s3` order.  Finally, explicit
     `tournIdx`/`tourney` source temporaries make the SLD-132 address add retain its
     result in $v0.  The earlier structural falsifications remain valid: if/else for
     the ternary (27, +1 insn), Yoda compare (18), named `short numT` (18), swapped
     tier/count statements (21, 117 insns), and `(byte)frontEnd.tier != 0` (18). */
  int loaded;
  int curIdx;
  tfrontEnd *fe;
  tfrontEnd *loopFe;
  short i;

  this->tScreen::Initialize();
  do {
    systemtask(0);
    loaded = (int)::IsShapeFileLoaded((tScreen *)this,&this->fTrophyShapes);
  } while ((loaded ^ 1) != 0);
  fe = &frontEnd;
  __asm__("" : : "r"(fe), "r"(fe), "r"(fe), "r"(fe));
  this->tier = (uint)(byte)fe->tier;
  this->fNumTrophies = fe->tier != '\0' ? 8 : 6;
  this->fClearScreen = 1;
  i = 0;
  loopFe = fe;

  for (; i < this->fNumTrophies; i = i + 1) {
    int placement;
    int tournIdx;
    short place;
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
   text call is kept as one nested expression and pDrawFlags is published after it,
   letting sched1 place the pointer between TextSys_Word and CalcFadeVal.  Retail's
   loop came from duplicated branch-local ScaleShapeExtended calls which GCC then
   cross-jumps; spelling one shared call loses three argument-setup instructions.
   Finally, the source-order comparison `i >= fNumTrophies` produces the oracle's
   sign-extend-before-load sequence.  The two-reference fModNumber fence crosses
   its allocator step and restores the SLD s3 / pDrawFlags s4 handout. */
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
  __asm__("" : "=r"(texttoshow) : "0"(texttoshow));
  i = 0;
  FETextRender_FullTextRGB(TextSys_Word(texttoshow),0x100,200,
                           CalcFadeVal(0x505050,this->fScreenFadeVal),'\0',2);
  pDrawFlags = &drawFlags;
  __asm__("" : "=r"(pDrawFlags) : "0"(pDrawFlags));
  while (true) {
    if ((int)i >= (int)this->fNumTrophies) break;
    x = TROPHY_LEFTOFFSET + (i % fModNumber) * 0x5f;
    y = (i / fModNumber) * 45 + 70;
    if ((i == this->fRealCurrentTourn[this->tier]) &&
       ((this->fSwapShapes.fFlags & 1) != 0)) {
      drawFlags.custom_shapes = this->fSwapShapes.fShapes;
      texttoshow = ((ticks - this->startTicks) / 12) % 32;
      ScaleShapeExtended(texttoshow,0x600,x,y,(int)this->fScreenFadeVal,0,pDrawFlags);
    }
    else {
      drawFlags.custom_shapes = (this->fTrophyShapes).fShapes;
      texttoshow = i;
      ScaleShapeExtended(texttoshow,0x600,x,y,(int)this->fScreenFadeVal,0,pDrawFlags);
    }
    i = i + 1;
  }
  __asm__("" : : "r"(i));
  __asm__("" : : "r"(fModNumber), "r"(fModNumber));
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
