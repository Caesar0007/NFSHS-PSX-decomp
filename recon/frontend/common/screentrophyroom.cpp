/* frontend/screens/screentrophyroom.cpp -- RECONSTRUCTED (trophy-room screen; C++ TU)
 *   9 member fns (incl ctor) of tScreenTrophyRoom (: public tScreen).
 *   Bodies from Ghidra; namespaces stripped, phantom stack-args resolved vs disasm.
 */
#include "screentrophyroom_types.h"
#include "screentrophyroom_externs.h"

/* retail's SYM records an inline-call pair at every tick read in this TU: the tick counter is read
   through an inline getter, not directly */
static inline int FE_Ticks(void) { return ticks; }


/* Retail screentrophyroom.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }
extern "C" int sprintf(char *buffer, char *fmt, ...);


/* ---- tScreenTrophyRoom::ctor  [SCREENTROPHYROOM.CPP:40-43] ---- */
#line 37 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
tScreenTrophyRoom::tScreenTrophyRoom()


{
  this->fPreviousTrophy = '\0';
  this->fRealCurrentTourn[0] = 0;
  this->fRealCurrentTourn[1] = 0;
}



/* ---- tScreenTrophyRoom::dtor  [SCREENTROPHYROOM.CPP:44-48] ---- */
/* MATCH: NO manual tScreen_dtor call — the declared base dtor auto-fires
     (gcc-2.8 derived-dtor shape: vptr store in the base-dtor jal delay slot,
      original __in_chrg forwarded in $a1 untouched).  cf. catalog D/wave-3. */

#line 48 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
tScreenTrophyRoom::~tScreenTrophyRoom() { }



/* ---- tScreenTrophyRoom::GetShapeInfo  [SCREENTROPHYROOM.CPP:49-63] ---- */
/* retail's SYM shows an inline-call pair (no `this`) inside GetShapeInfo's block and inside LoadTrophy's
   if-compound: the tier/tournament lookup is an inline accessor, not an open-coded index chain */
static inline tTourneyInfo *TourneyInTier(uint tier, uint cur)
{
  return (tournamentManager.fDefinition)->fTournaments +
         ((uint)(tournamentManager.fDefinition)->fTiers[tier].fTournOffset + cur);
}
#line 245 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
static inline tTourneyInfo *TourneyInTierSelf(int self) {
#line 50 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
  int d; unsigned int tier; unsigned int cur; tier = ((d = 0, (uint)(byte)frontEnd.tier) ?: 0U) + ((tier = 0) != 0); cur = ((d = 0, (uint)(byte)((tScreenTrophyRoom *)self)->fRealCurrentTourn[((tScreenTrophyRoom *)self)->tier]) ?: 0U) + ((cur = 0) != 0); return (tournamentManager.fDefinition)->fTournaments + ((uint)(tournamentManager.fDefinition)->fTiers[tier].fTournOffset + cur); }
#if 0
{
  /* */
  /* */
  return (tournamentManager.fDefinition)->fTournaments +
  /* */
}

#endif
#line 50 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
void tScreenTrophyRoom::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)


{


  numPermShapes = 0x26;
  numSwapShapes = 0x20;
  /* retail's tree is the function level plus one inline-call pair: no block, no `cur` local */
  tTourneyInfo *const tourn = TourneyInTier((byte)frontEnd.tier,(byte)this->fRealCurrentTourn[(byte)frontEnd.tier]);
  tournamentManager.GetTrophyName(tourn,ts_Small,gSwapFileName,-1);
  *permFileName = "zTrophy";
  *swapFileName = gSwapFileName; return;
}



/* ---- tScreenTrophyRoom::ProcessInput  [SCREENTROPHYROOM.CPP:64-99] ---- */
  /* MATCH: the SLD records no locals for this function.  In particular, the
     clamp is the expanded EA-style MIN(MAX(current, 0), fNumTrophies): the
     repeated inner expression is significant because retail recomputes and
     reloads the selected value instead of retaining a temporary. */
#line 63 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
void tScreenTrophyRoom::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)


{
  if (keyval == kInput_KeyType_Cross) {

    command.type = kMenu_Command_GoToMenu;
    command.nextMenu = (tMenu *)&(*(tMenuBlank *)((char *)menuDefs + 0x200));
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
       ((0 < this->fRealCurrentTourn[this->tier] ? this->fRealCurrentTourn[this->tier] : 0) < this->fNumTrophies) ? (0 < this->fRealCurrentTourn[this->tier] ? this->fRealCurrentTourn[this->tier] : 0) : this->fNumTrophies;
TrophyRoomProc_keyLeftCheck:
  if (keyval == kInput_KeyType_Left) {

    this->fRealCurrentTourn[this->tier] = this->fRealCurrentTourn[this->tier] + -1;
    if (this->fRealCurrentTourn[this->tier] < 0) { this->fRealCurrentTourn[this->tier] = this->fNumTrophies + -1;
    }
  } if (keyval == kInput_KeyType_Right) {

    this->fRealCurrentTourn[this->tier] = this->fRealCurrentTourn[this->tier] + 1;
    if (this->fNumTrophies <= this->fRealCurrentTourn[this->tier]) { this->fRealCurrentTourn[this->tier] = 0;
    }
  }
  this->tScreen::ProcessInput(fromPlayer,keyval,command); return;
}



/* ---- tScreenTrophyRoom::PreLoad  [SCREENTROPHYROOM.CPP:100-111] ---- */
#line 100 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
void tScreenTrophyRoom::PreLoad()


{
  this->tScreen::PreLoad();


  (this->fTrophyShapes).fShapes = (tTexture_ShapeInfo *)0x0;
  this->InitializeShapes(this->fTrophyShapes,8);

  this->AsyncLoadShapeFile(
      frontEnd.tier != '\0' ? "zCase2" : "zCase",this->fTrophyShapes);
}



/* ---- tScreenTrophyRoom::Initialize  [SCREENTROPHYROOM.CPP:112-152] ---- */
    /* Historical tourney trial: the old indexed-access failure is superseded;
       no tourney declaration or active carrier remains in this source. */
    /* SYM-CODEGEN-CARRIER: place -- folding the clamp into the texture-call
       argument is FAIL 8 at 114/118; it removes retail's independent short
       result and its sign-extension/value-selection web. */
    /* Historical tournIdx trial: the old folded-offset failure is superseded;
       no tournIdx declaration remains. That earlier result did not prove an
       original source object or a requirement of the current expression. */
    /* SYM-CODEGEN-CARRIER: placement -- loading directly into `short place`
       and clamping the invalid case is FAIL 12 at 120/118; it changes signed
       load width and reverses the retail branch/value initialization. */
  /* SYM-CODEGEN-CARRIER: loopFe -- reusing `fe` directly is FAIL 21 at
     117/118; it loses retail's caller-saved-to-`$s3` handoff and rotates the
     tier/constant allocation web. */
  /* 2026-11-01: remove former curIdx with bound-first GNU minimum. The older
     repeated EA `MIN(current,count - 1)` expansion was FAIL16 at120/118;
     that did not establish a source object. The selected minimum evaluates
     both genuine inputs once and preserves the complete normal ELF/SLD. */
  /* SYM records exactly one function-scope local here: i REG17 SHORT.
     loopFe remains unprovided source-recovery work, not an exemption. */
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
     `FrontEnd().tier` reads plus `loopFe = &frontEnd` preserved that handoff at exact
     PASS, so the old `fe` alias and four-input opacity fence were unnecessary.
     The load-poll result also feeds its condition directly. Three unprovided
     source objects remain: loopFe, placement and place. Failed isolated trials
     do not establish original objects. The former indexed-pointer captures
     are absent; supplied short i remains unchanged.
     2026-11-01: direct frontEnd.tier reads remove the two unexpected early
     inline pairs, preserve all code and seal118/118 word tags. The actual
     existing Definition getter now restores both actual loop pairs at+0x98
     and eight missing manager-family type copies, without a new named row.
     All nine provided region tuples agree. Remaining object provenance stays
     open; Definition-only loopFe removal is9dif/118, not necessity proof. */
#line 112 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
void tScreenTrophyRoom::Initialize()


{
  short i;

  int loopFe;
  this->tScreen::Initialize();
  do {



    systemtask(0);
  } while (((int)this->IsShapeFileLoaded(this->fTrophyShapes) ^ 1) != 0);
  this->tier = (uint)(byte)frontEnd.tier;
  this->fNumTrophies = frontEnd.tier != '\0' ? 8 : 6;
  this->fClearScreen = 1;

  i = 0; for (; i < this->fNumTrophies; i = i + 1) {
    int placement;
    short place; this->fTrophyList[i] = 1; loopFe = (i = i, (int)&frontEnd) + ((loopFe = 0) != 0); placement = ((i = i, (signed char)tournamentManager.fBestPlacement[(signed char)((tournamentManager.Definition())->fTournaments + ((uint)(tournamentManager.Definition())->fTiers[(byte)((tfrontEnd *)loopFe)->tier].fTournOffset + (uint)(byte)i))->fTournamentID]) ?: 0) + ((placement = 0) != 0);
    place = (place = 0, (




    (u_int)(placement - 1) < 3) ? (short)placement : (short)0);

    FETexture_LoadPmxAtOffset((this->fTrophyShapes).fFile,i * 4 + place, (this->fTrophyShapes).fShapes + i,0,0);
  }


  purgememadr((this->fTrophyShapes).fFile);
  (this->fTrophyShapes).fFile = (char *)0x0;

  this->fTrophyList[this->fNumTrophies] = 0;

  this->fRealCurrentTourn[this->tier] = (this->fNumTrophies - 1) <? (int)this->fRealCurrentTourn[this->tier];
  this->fPreviousTrophy = (char)this->fRealCurrentTourn[this->tier];

  this->startTicks = FE_Ticks(); return;
}



/* ---- tScreenTrophyRoom::Cleanup  [SCREENTROPHYROOM.CPP:153-160] ---- */
#line 154 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
void tScreenTrophyRoom::Cleanup()


{
  this->FreeShapes(this->fTrophyShapes);

  this->tScreen::Cleanup(); return;
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
  /* W85-S5: an `__asm__("" : : "r"(fModNumber), "r"(fModNumber))` liveness fence
     stood here.  Measured INERT -- deleting it leaves the whole TU 9/9 PASS
     (byte-identical object), so it was dead scaffolding, not a codegen device. */
  /* W86-S4: the eight locals above are now in the SYM `8c` order exactly
     (drawFlags3 AUTO sp+32, fModNumber REG $19 s3, TROPHY_LEFTOFFSET REG $21 s5,
     drawFlags AUTO sp+56, i REG $17 s1, x REG $6 a2, y REG $7 a3, texttoshow
     REG $4 a0). 2026-11-01 direct &drawFlags arguments preserve code/locals/
     regions/SLD, but lose one supplied completed tDrawShapeExtended typedef
     copy. Restored, not an original-pointer exemption: investigate the shared
     completed-type producer before repricing this source-only pointer. */
  /* Reliable SYM names every retained retail local and omits these five
     source identities, which remain unresolved rather than exempted:
     SYM-CODEGEN-CARRIER: feTier
     SYM-CODEGEN-CARRIER: currentTourn
     SYM-CODEGEN-CARRIER: tourn
     SYM-CODEGEN-CARRIER: selectedTourn
     SYM-CODEGEN-CARRIER: drawFlagsPtr */
#line 168 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
void tScreenTrophyRoom::DrawBackground()


{ tTourneyInfo *devLocal_tTourneyInfo; /* DEVICE (exact-only): record-less unused local; retail screentrophyroom.obj type record #493 (TPDEF tTourneyInfo) between tDrawShapeExtended and tScreenTrophyRoom, inside DrawBackground__17tScreenTrophyRoom's record run (locals-before-params, GSDATA_state 7h) */
  tDrawShapeExtended drawFlags3;
  int fModNumber; int TROPHY_LEFTOFFSET; tDrawShapeExtended drawFlags; short i; short x; short y; int texttoshow; drawFlags3.tint[0] = 0xcec844;
  DrawShapeExtended((FE_Ticks() >> 4) % 10 + 0x1c, 0x410,0x10,0x10,0,0,&drawFlags3);
  fModNumber = 3;

  if (frontEnd.tier != '\0') { fModNumber = 4;
  } TROPHY_LEFTOFFSET = 0x114 - (fModNumber * 0x5f >> 1);






  this->DrawBackgroundImage(0,0x18,gCurrentShapes,0);
  PSXDrawBrightEndLine(0x232323,0x6a,0x39,300,1,3,(int)this->fScreenFadeVal,0x1e);

  this->LoadTrophy();

  this->IsShapeFileLoaded(this->fSwapShapes);
  if (this->fSwapShapes.fFile != (char *)0x0)
  {
    this->UploadSwapShapes(0x20);
#line 193 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
    for ({ int dummy; for ({ extern int dummy; int drawFlagsPtr; int st; } 0; ) ; } 0; ) ; st = ticks;
#line 194 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
    this->startTicks = st;
  }
  unsigned int feTier; unsigned char currentTourn; unsigned int currentTournU; unsigned int tourn; int selectedTourn;
  feTier = ((i = 0, (uint)(byte)frontEnd.tier) ?: 0U) + ((feTier = 0) != 0); currentTourn = (currentTourn = 0, ((unsigned char)(i = 0, (byte)this->fRealCurrentTourn[this->tier]) ?: (unsigned char)0)); tourn = ((i = 0, (uint)(tournamentManager.Definition())->fTiers[feTier].fTournOffset) ?: 0U) + ((tourn = 0) != 0); currentTournU = ((i = 0, (uint)currentTourn) ?: 0U) + ((currentTournU = 0) != 0);


  selectedTourn = ((i = 0, (int)((tournamentManager.fDefinition)->fTournaments + (tourn + currentTournU))) ?: 0) + ((selectedTourn = 0) != 0); FETextRender_MenuTextPositionedJustifyFade((int)this->fScreenFadeVal, (signed char)((tTourneyInfo *)selectedTourn)->fTournamentID + 0x354,0x100,0x2f,2, textState_Hilighted,textType_ScreenInfo);

  texttoshow = 0x3de;
  if (((gPadinfo.buf[0].ID == '#') &&
      ((gPadinfo.buf[4].ID == '#' || (gPadinfo.buf[4].nopad != '\0')))) ||
     ((gPadinfo.buf[4].ID == '#' && ((gPadinfo.buf[0].ID == '#' || (gPadinfo.buf[0].nopad != '\0')))
      ))) {
    texttoshow = 0x3df;
  } else if ((gPadinfo.buf[0].ID == '#') || (gPadinfo.buf[4].ID == '#')) {
    texttoshow = 0x3e0;
  }

  i = 0; FETextRender_FullTextRGB(TextSys_Word(texttoshow),0x100,200, CalcFadeVal(0x505050,this->fScreenFadeVal),'\0',2);


  for (drawFlagsPtr = (int)&drawFlags; ; i = i + 1) { if ((int)i >= (int)this->fNumTrophies) break;

    x = TROPHY_LEFTOFFSET + (i % fModNumber) * 0x5f;
    y = (i / fModNumber) * 45 + 70;
    if ((i == this->fRealCurrentTourn[this->tier]) && ((this->fSwapShapes.fFlags & 1) != 0))
    {
      drawFlags.custom_shapes = this->fSwapShapes.fShapes;


      texttoshow = ((FE_Ticks() - this->startTicks) / 12) % 32; ScaleShapeExtended(texttoshow,0x600,x,y,(int)this->fScreenFadeVal,0,(tDrawShapeExtended *)drawFlagsPtr);
    }
    else {

      drawFlags.custom_shapes = (this->fTrophyShapes).fShapes;

      texttoshow = i; ScaleShapeExtended(texttoshow,0x600,x,y,(int)this->fScreenFadeVal,0,(tDrawShapeExtended *)drawFlagsPtr);
    }


    } return; }



/* ---- tScreenTrophyRoom::LoadTrophy  [SCREENTROPHYROOM.CPP:235-247 (body @240)] ---- */
  /* MATCH: the two index terms are grouped into one x84 chain.  Direct
     gSwapFileName arguments still keep its address in $s0 across both calls;
     no source alias is required. */
#line 237 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
void tScreenTrophyRoom::LoadTrophy()


{


  if (this->fRealCurrentTourn[this->tier] != (ushort)(byte)this->fPreviousTrophy)
  {
    int d;
#line 245 "C:/nfs4/FRONTEND/COMMON/SCREENTROPHYROOM.CPP"
    tTourneyInfo *const tourn = TourneyInTierSelf(((d = 0, (int)this) ?: 0));
    tournamentManager.GetTrophyName(tourn,ts_Small,gSwapFileName,-1);
    this->AsyncLoadSwapShapeFile(gSwapFileName);
    this->fPreviousTrophy = (char)this->fRealCurrentTourn[this->tier];
  }
}



/* end of screentrophyroom.cpp */
