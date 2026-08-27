/* frontend/screens/screentrophyinfo.cpp -- RECONSTRUCTED (trophy-info screen; C++ TU)
 *   3 member fns of tScreenTrophyInfo (embeds tScreen base as _base_tScreen).
 *   Bodies from Ghidra; namespaces stripped, phantom stack-args resolved vs disasm.
 */
#include "screentrophyinfo.h"


/* ---- tScreenTrophyInfo::GetShapeInfo  [SCREENTROPHYINFO.CPP:47-61] ---- */
void tScreenTrophyInfo::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  /* SYM 8c @0x80041008: the ONLY declared local is `tTourneyInfo *tourn` (REG $05); the
     tournOffset/curTourn/placement temps in the Ghidra body are compiler temps.  Crucially
     `tourn` is the ELEMENT pointer, not the array base -- the oracle folds the whole
     `fTournaments + idx*84` (plus the +0x24 field offset of fTournaments inside the
     definition) into ONE address and reuses it for both the fTournamentID load and the
     GetTrophyName argument; indexing an array-base `tourn[off+cur]` duplicates the
     index math (ours was 87 insns vs the oracle's 76).  fTournamentID is read SIGNED
     (`lb`) -- the shared-header plain `char` is unsigned on this build, hence the cast.
     71 -> 27 diffs, 75/76 insns.  RESIDUAL: retail materializes the screenTrophyRoom
     chain (lui/lw + `->tier` scale) BEFORE the frontEnd.tier/fDefinition chain; swapping
     the two addends of the index sum was measured WORSE (37), so the load order is an
     emission/statement-position dial that still needs a named angle.  (W55-A15)
     W56-A10 (27 -> 17): STAGING the index sum into one `uint idx` local (evaluated
     BEFORE `tourn = fTournaments + idx`) forces the screenTrophyRoom->tier load to
     emit first -- count-free (75/75, idx is a dying temp).
     W57-A7 (17 -> 6, now COUNT-EXACT 76/76) -- three independent defects:
       (a) fBestPlacement[] is a SIGNED byte (`lb 0x1F0`) -> per-use (signed char) view;
       (b) `placement` is a SHORT, not an int (retail's kBannerColors index is
           `sll 16; sra 14` = (short)placement * 4; an int local emits a bare `sll 2`);
       (c) the frontEnd.tier byte read in its OWN statement emits its lui/lbu pair FIRST,
           ahead of the tournamentManager address (statement-position/emission dial, 05A).
     W59: PER_FN_TEXT_MOVES moves the definition load before the final tier scale and the
     fRealCurrentTourn load after the fTournOffset load: 6 -> 4, still count-exact 76/76.
     The residual is now only the two byte-load destinations (`v0`/`v1`) being exchanged.
     Pointer/reference staging gives those loads the retail destinations and order but moves
     the same six diffs to the room-base/index allocation; qtytrace shows that spelling merges
     the final address with the index QTY instead of the room-base QTY.  A read-only room fence
     crosses the ref step but costs two instructions (16 diffs/78).  Falsified at this basin:
     reversed addends (20), named definition+fence (37/79), void-tail/feTier fences (35/79),
     pointer mutation (28), and unfenced pointer/reference staging (neutral 6).
     MATCH (W65): comma-staging the current tournament into a byte local makes GCC combine its
     copy web without extending its lifetime; retail v0/v1 ownership follows exactly (4 -> PASS,
     76/76).  A uint local instead inherits a0 and remains at 4. */
  tTourneyInfo *tourn;
  /* SYM-CODEGEN-CARRIER: placement -- folding the default/validated value
     into the banner lookup is measured FAIL27 with three missing instructions
     (73/76); the short carrier preserves retail's sign-extended table index. */
  short placement;
  /* SYM-CODEGEN-CARRIER: idx -- staging the complete tournament index before
     pointer formation was measured 27 -> 17 diffs and restores retail's
     screenTrophyRoom-first evaluation order without adding instructions. */
  uint idx;

  /* MATCH (W57-A7, 15 -> 9): naming the frontEnd.tier byte read in its OWN statement makes
     its `lui %hi / lbu %lo` pair emit FIRST (retail's order), ahead of the tournamentManager
     address materialisation -- pure statement-position/emission-order dial (05A family).
     Falsified here: swapping the two addends of the sum (25-27), staging the whole
     fTournOffset chain into a local (25), naming screenTrophyRoom->tier (19). */
  {
    /* SYM-CODEGEN-CARRIER: feTier -- the independent byte-read statement was
       measured 15 -> 9 diffs by placing its lui/lbu before fDefinition. */
    uint feTier = (uint)(byte)frontEnd.tier;
    /* SYM-CODEGEN-CARRIER: currentTourn -- comma-staging this byte was the
       measured final 4 -> PASS step, restoring retail's v0/v1 ownership. */
    byte currentTourn;
    idx = (currentTourn =
               (uint)(byte)screenTrophyRoom->TrophyRoomCurrentView()
                   [screenTrophyRoom->TrophyRoomTierView()],
           (uint)(tournamentManager.fDefinition)->fTiers[feTier].fTournOffset +
               currentTourn);
  }
  tourn = (tournamentManager.fDefinition)->fTournaments + idx;
  placement = 0;
  /* MATCH (W57-A7, 17 -> 15): fBestPlacement[] is a SIGNED byte in retail (`lb $v1,0x1F0`);
     the shared-header plain `char` is unsigned on this build, so the per-use (signed char)
     view is needed at BOTH reads (the oracle CSEs them into one `lb`). */
  if ((u_int)((signed char)tournamentManager.fBestPlacement[(signed char)tourn->fTournamentID] - 1) < 3) {
    placement = (signed char)tournamentManager.fBestPlacement[(signed char)tourn->fTournamentID];
  }
  this->BannerCol = kBannerColors[placement];
  GetTrophyName(&tournamentManager,tourn,ts_Large,gSwapFileNameTI,-1);
  numSwapShapes = 0x20;
  *swapFileName = gSwapFileNameTI;
  *permFileName = "zSTI";
  numPermShapes = 0xb;
  return;
}

/* ---- tScreenTrophyInfo::DrawBackground  [SCREENTROPHYINFO.CPP:64-153 (body @67)] ---- */
void tScreenTrophyInfo::DrawBackground()

{
  int FadePartI;
  int FadePartIITheRevenge;
  int col;
  int yyy;
  RECT r;
  tDrawShapeExtended drawFlags;
  tDrawShapeExtended drawFlags2;
  int i;
  
  {
    /* SYM-CODEGEN-CARRIER: fade -- reusing `FadePartI` as the pre-clamp value
       is count-exact FAIL 8 and assigns that temporary to `$s3`; retail keeps
       the pre-clamp value in `$a0` and publishes FadePartI only after shifting. */
    int fade = (int)this->fScreenFadeVal + -0x40;

    FadePartIITheRevenge = (int)this->fScreenFadeVal << 1;
    if (fade < 0) {
      fade = 0;
    }
    FadePartI = fade << 1;
  }
  if (FadePartIITheRevenge < 0) {
    FadePartIITheRevenge = 0;
  }
  if (0x80 < FadePartIITheRevenge) {
    FadePartIITheRevenge = 0x80;
  }
  /* SYM-CODEGEN-CARRIER: tournID -- reloading the tournament ID from `tourn`
     at each text call is FAIL 121 at 301/298 and expands/rotates the complete
     saved-register web; retail holds this signed byte once in `$s5`. */
  int tournID;
  /* SYM-CODEGEN-CARRIER: tourn -- retaining only `tournID` is FAIL 72 at
     296/298; retail keeps the selected element pointer through CalcFadeVal and
     reloads its title ID for the first heading. */
  tTourneyInfo *tourn;

  /* MATCH (W66): retail keeps the definition base in s0, the selected tournament ID in
     signed-byte s5, and the element pointer alive just long enough to reload the title ID
     after CalcFadeVal.  Staging currentTourn before the tier offset also reproduces the
     screenTrophyRoom/frontEnd load order.  Together with the direct fade expression this
     removes the former 106-diff allocation cascade (298/298 PASS). */
  {
    /* SYM-CODEGEN-CARRIER: feTier -- folding the frontend tier into the
       definition index is count-exact FAIL 10 and moves its global byte load
       across the retained definition-base materialization. */
    uint feTier;
    /* SYM-CODEGEN-CARRIER: currentTourn -- direct screen-room indexing is
       FAIL 43 at 303/298; comma-staging this byte is required for retail's
       room/tier load order and scaled-address ownership. */
    byte currentTourn;
    feTier = (uint)(byte)frontEnd.tier;
    tourn = tournamentManager.fDefinition->fTournaments +
        (currentTourn = (byte)screenTrophyRoom->TrophyRoomCurrentView()
                             [screenTrophyRoom->TrophyRoomTierView()],
         (uint)tournamentManager.fDefinition->fTiers[feTier].fTournOffset + currentTourn);
    tournID = (signed char)tourn->fTournamentID;
  }
  col = CalcFadeVal(kRGBVals[(byte)textDefinitions[4][5]],FadePartI);
  yyy = 0xaf;
  FETextRender_FullTextRGB(TextSys_Word((signed char)tourn->fTournamentID + 0x341),0x1e,0x19,col,'\x03',3);
  if (strlen(TextSys_Word(tournID + 0x37a)) != 0) {
    /* SYM-CODEGEN-CARRIER: word -- nesting this TextSys_Word call into the
       renderer is count-exact FAIL 66 and rotates the retained text/colour/Y
       registers; retail evaluates and holds the word before CalcFadeVal. */
    char *word;

    FETextRender_MenuTextPositionedJustifyFade(FadePartI,0x3db,0x8c,0xaf,1,textState_Hilighted,textType_ScreenInfo);
    word = TextSys_Word(tournID + 0x37a);
    col = CalcFadeVal(0x505050,FadePartI);
    FETextRender_FullTextRGB(word,0x91,0xaf,col,'\0',0);
    yyy = 0xb7;
  }
  if (strlen(TextSys_Word(tournID + 0x3a0)) != 0) {
    FETextRender_MenuTextPositionedJustifyFade(FadePartI,0x3dd,0x8c,yyy,1,textState_Hilighted,textType_ScreenInfo);
    r.x = 0x91;
    r.w = 0x15b;
    r.y = yyy;
    r.h = 100;
    FETextRender_WordWrapTextRGB(TextSys_Word(tournID + 0x3a0),r,
        CalcFadeVal(0x505050,FadePartI));
    /* WordWrapHeight returns int; the old short declaration inserted a false sign extend. */
    yyy = yyy + FETextRender_WordWrapHeight(0x15b,
        TextSys_Word(tournID + 0x3a0));
  }
  if (strlen(TextSys_Word(tournID + 0x38d)) != 0) {
    FETextRender_MenuTextPositionedJustifyFade(FadePartI,0x3dc,0x8c,yyy,1,textState_Hilighted,textType_ScreenInfo);
    r.x = 0x91;
    r.w = 0x15b;
    r.y = yyy;
    r.h = 100;
    FETextRender_WordWrapTextRGB(TextSys_Word(tournID + 0x38d),r,
        CalcFadeVal(0x505050,FadePartI));
    FETextRender_WordWrapHeight(0x15b,TextSys_Word(tournID + 0x38d));
  }
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  if (this->fSwapShapes.fFile != (char *)0x0) {
    ::UploadSwapShapes((tScreen *)this,0x20);
  }
  r.x = 0x23;
  r.y = 0x2d;
  r.w = 0x1c4;
  r.h = 100;
  FETextRender_WordWrapTextRGBJustify(TextSys_Word(tournID + 0x367),r,
      CalcFadeVal(0x505050,FadePartI),3,0,false);
  drawFlags.custom_shapes = this->fSwapShapes.fShapes;
  ScaleShapeExtended((ticks / 12) % 32,0x600,0x46,-5,FadePartI,0,&drawFlags);
  drawFlags2.tint[0] = this->BannerCol;
  i = 1;
  do {
    if ((i % 3) != 0) {
      DrawShapeExtended(0,0x410,i << 1,0,FadePartIITheRevenge,0,&drawFlags2);
    }
    i = i + 1;
  } while (i < 0x1e);
  i = 0x22;
  do {
    if ((i % 3) != 0) {
      DrawShapeExtended(0,0x410,i << 1,0,FadePartIITheRevenge,0,&drawFlags2);
    }
    i = i + 1;
  } while (i < 0x3f);
  return;
}



/* ---- tScreenTrophyInfo::dtor  [SCREENTROPHYINFO.CPP:153 (~dtor inlined from SCREENTROPHYINFO.H:30)] ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___17tScreenTrophyInfo(void *thisp) { ___7tScreen(thisp); }



/* end of screentrophyinfo.cpp */
