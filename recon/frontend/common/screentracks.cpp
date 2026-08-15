/* frontend/screens/screentracks.cpp -- RECONSTRUCTED (track-select screen; C++ TU)
 *   10 member fns of tScreenTrackSelect (embeds tScreen base as _base_tScreen).
 *   Bodies from Ghidra; namespaces stripped, phantom regs resolved vs disasm.
 */
#include "screentracks.h"

typedef struct {
  u_int addr : 24;
  u_int len : 8;
} tTrackSelectPrimTag;


/* ---- tScreenTrackSelect::DrawBackground ---- */
void tScreenTrackSelect::DrawBackground()

{
  short creditsTextVal;
  short shapeX;
  short shapeY;
  int videoY;
  RECT r;
  tTrackInformation trackInfo;
  POLY_FT4 *prim;
  VIDEOSTATE state;
  
  r.x = 0x140;
  r.y = 200;
  r.w = 0xaa;
  r.h = 0xc;
  creditsTextVal = TextValue(&menuDefs->iteratorTrack,kPlayerBoth);
  DrawShape_NFS4RoundRectangle(creditsTextVal,&r,0);
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[0],&trackInfo);
  this->UpdateBrightness(trackInfo);
  this->UpdateVideoWall(trackInfo);
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  {
    tVideoWall *videoWall = &this->fVideoWall;

    if (((this->fSwapShapes.fFile != (char *)0x0) &&
        (videoWall->fTransitionDirection != -1)) && (this->fBrightness == 0)) {
      ::UploadSwapShapes((tScreen *)this,10);
      TurnOn(videoWall);
    }
  }
  videoY = ((this->fFrame & 1U) == 0) << 7;
  shapeX = 0x200;
  shapeY = (short)videoY;
  state = (VIDEOSTATE)VIDEO_state(this->hVideo);
  if (state == VIDEOSTATE_SPOOLING) {
    RECT r;
    int startTicks;

    r.x = shapeX;
    r.w = 0xaa;
    r.y = 0;
    r.h = 0x100;
    ClearImage(&r,'\0','\0','\0');
    DrawSync(0);
    startTicks = ticks[0];
    this->fBrightness = 0;
    this->fStartTicks = startTicks - 0x14;
  }
  else if (state == VIDEOSTATE_PLAYING) {
    if (VIDEO_updateframexy(this->hVideo,shapeX,
                            (u_int)(videoY << 0x10) >> 0x10) != 0) {
      this->fFrame = this->fFrame + 1;
      videoY = ((this->fFrame & 1U) == 0) << 7;
      shapeY = (short)videoY;
    }
  }
  else if (((this->fTicksSet != 0) || (this->fDestBrightness < this->fBrightness)) &&
          ((uint)(ticks[0] - this->fVideoTicks) >= 0x101U)) {
    if (this->fDestBrightness >= this->fBrightness) {
      this->SetBrightness(trackInfo.fAvailable != '\0' ? 0x80 : 0x20);
    }
    {
      char moviename[80];

      sprintf(moviename,"%szzzTR%02d.dct",Paths_Paths[0x29],
              (int)this->fMovieTrack);
      VIDEO_spoolfile(this->hVideo,moviename);
    }
    VIDEO_startplayback(this->hVideo);
  }
  if (0 < this->fBrightness) {
    /* MATCH: the EA/PsyQ quad wrapper materializes its texture-X origin for
       both UV and tpage arithmetic.  The address-mask read is also explicit:
       its fourth GCC reference crosses the local-allocator priority step and
       gives retail's s0/s1/s2/s3 mask/page/V/Y handout.

       W60-A10 -- the whole 26-diff residual is count-exact (299/299) and reads
       off the SLD (tools/sldall.py) as ONE cause: retail's FIRST prim treats
       the texture-X origin as a PLAIN COMPILE-TIME 512 while the `~0x3f` page
       mask is the shared REGISTER constant, so SLD:161 emits
         li s1,-64 ; andi a2,s1,512 ; sll ; sra
       (512 in the ANDI IMMEDIATE, mask in the reg -- the mask cannot be an
       immediate because andi zero-extends and -64 needs 32 bits, so gcc's cse
       propagates the OTHER operand's constant into the insn instead of
       folding).  The SECOND prim's origin IS a runtime value (SLD:164
       `li t2,512 ; addiu t1,t2,80`), so SLD:171 correctly keeps the
       register-register `and s1,t1,s1` -- and ours matches THAT one.
       Our `"+r"` identity fence makes textureX opaque at BOTH sites, so the
       first prim degrades to `li t1,512 ; and a2,t1,s1`, and the same t1
       carrier then drags the 512 materialisations (and the neighbouring
       `lui t2,8064 ; ori t2,t2,4` scratchpad-cell pair) off their retail slots
       -- that is every remaining diff.
       MEASURED (base 26): dropping the textureX identity fence 192 (285 insns,
       14 SHORT -- the fence is load-bearing for the rest of the block);
       dropping the addrMask read-only fence 68 (299); `int` instead of `short`
       textureX 164 (291).
       The obvious SPLIT cure is FALSIFIED: a second, un-fenced `short tpageX =
       0x200;` used only in the first prim's GetTPage -- with a literal mask
       (S1) or a named `int pageMask = ~0x3f;` (S2) -- BOTH collapse to 156 /
       289 insns, i.e. gcc const-folds the whole `and;sll;sra` triple away (10
       insns short).  Writing the mask first, `~0x3f & textureX` (S3), is
       exactly neutral (26).
       => retail's paradox is the real finding: its textureX is opaque enough
       that the sign-extend triple SURVIVES, yet cse still propagates 512 into
       the andi immediate.  No plain-C opacity level we have reproduces both at
       once (a fence gives the triple but loses the immediate; no fence gives
       neither).  Next angle = an opacity that blocks FOLDING but not cse
       constant PROPAGATION (an rtl-level distinction) -- i.e. an instrumented
       -dl/-dg read of retail's cse pass, not another spelling.

       W60-A10 ROUND 2: parasite-eve-2's DECOMPILATION_LEARNINGS.md carries this
       exact class twice ("Same byte mask across a call: andi vs CSE'd and" and
       "0xFE byte clear vs ~1 word mask: CSE to li -2") -- their rule is that
       cse unifies equal SImode constants into ONE register + `and`, and the
       cure is to route the value that must stay an IMMEDIATE through a
       different width so cse cannot unify it.  Applied here as: make the MASK
       the opaque operand (identity-fenced `int pageMask = ~0x3f;`) so the
       origin can be the andi immediate.  FALSIFIED: opaque mask + literal
       origin on the first prim 181 (290 insns -- still folds); opaque mask on
       BOTH prims with textureX kept 40 (299); mixed literal/textureX 38 (297);
       read-only instead of identity fence on the mask 158 (291). */
    /* W61-A17 (base 26, unchanged) -- five more falsified cures for the
       andi-vs-and opaque-operand law, all measured: an identity-fenced
       `int pageMask = ~0x3f;` used at BOTH prims 86 (299, count-exact); the
       same with prim-1's tpage x written as the LITERAL 0x200 86 (297); that
       pair with the textureX fence dropped 257 (292); the opaque mask at
       prim 1 only 160 (295); the literal prim-1 x with the mask fenced only
       there 160 (293).  The mechanism read stands: retail materialises 512
       FRESH at every use (`li t2,512` before the u-coord `andi`, and
       `li t2,512; addiu t1,t2,80` for prim 2) and lets combine fold the DYING
       materialisation into the mask insn as its immediate (`andi a2,s1,512`),
       while ours carries one fenced pseudo (t1) across the whole block.  Every
       opacity strong enough to stop the `512 & ~0x3f` fold also pins the value
       into a live carrier.  */
    /* MATCH W69 (2026-08-15): the SYM local table names only shapeY, prim,
       state, the RECTs, and trackInfo--there is no late texture-X local.
       Restoring one function-scope shapeX shared by ClearImage,
       VIDEO_updateframexy, and both quads lets GCC propagate 512 at each use
       without folding away retail's mask operations.  That recovers the
       first `andi a2,s1,512`, both UV materializations, and the second
       `li/addiu/and` chain (26->6, count-exact).  Writing r.x before r.w
       restores the RECT constant schedule (6->4), and a packet-pointer slot
       born before the address mask restores the remaining constant birth
       order (4->2).  The authoritative two-diff residual is one identical
       `sw t2,160(sp)` scheduled earlier than retail; const-qualifying the slot
       removes the lever and returns to 4. */
    /* W62-A15 -- THE LAST 2 DIFFS ARE A PURE sched2 EMISSION-POSITION TIE and
       the fn SEALS with one PER_FN_TEXT_MOVES row (probe-verified 2x, whole-TU
       10/10 PASS under the row).  Both streams are byte-identical except that
       the packet-slot's frame store `sw $10,160($sp)` sits 8 insns EARLIER for
       us: ours emits it right after the `lui/ori` that builds 0x1F800004,
       retail emits it immediately before the first `lw fp,0(t2)`, i.e. AFTER
       the whole hoisted GetTPage argument block (`li a0,2 / li a1,1 /
       li s1,-64 / andi / sll / sra / move s5,zero / move a3,s5`).  The store
       has no successor in its block, so both placements are legal for sched2
       and the tie falls to INSN_LUID = the pre-sched order.
       SOURCE DIALS ALL FALSIFIED (base 2, every one re-gated here): swapping
       the packetPtrSlot / addrMask declaration order 4; splitting decl from
       init 4; init before the addrMask fence 6; a void-tail fence between the
       decl and the use 2 (inert); assigning inside the use expression
       `*(packetPtrSlot = &Render_gPacketPtr)` 4; a function-scope declaration
       2 (inert); function-scope decl + assign-in-use 4.  (`const` on the slot
       was already falsified above at 4.)
       ORCHESTRATOR WIRING (spec, verified via tools/vprobe.py +
       W60_TEXT_MOVES_FILE, row file scratchpad/w62a15/tm_tracks.json):
         "recon/frontend/common/screentracks.cpp": {
           "DrawBackground__18tScreenTrackSelect": [
             {"take": r"\tsw\t\$10,160\(\$sp\)\n",
              "after": r"\tmove\t\$7,\$21\n"},
           ],
         },
       `move $7,$21` occurs twice in the fn; the take-line precedes BOTH, so
       re.search's first match is the correct (12F) anchor after the take-line
       is removed.  Result: DrawBackground PASS 299/299, TU 10/10 PASS. */
    u_char **packetPtrSlot = &Render_gPacketPtr;
    u_int addrMask = 0xffffff;
    __asm__("" : : "r"(addrMask));
    (prim = (POLY_FT4 *)*packetPtrSlot,
     ((tTrackSelectPrimTag *)prim)->addr = *(u_int *)Render_gPalettePtr,
     *packetPtrSlot = (u_char *)prim + sizeof(POLY_FT4),
     ((tTrackSelectPrimTag *)Render_gPalettePtr)->addr = (u_int)prim);
    *(u_int *)&prim->r0 = this->fBrightness << 0x10 |
                          this->fBrightness << 8 | this->fBrightness;
    (((tTrackSelectPrimTag *)prim)->len = 9, prim->code = 0x2e);
    (prim->x0 = 0x99, prim->y0 = 0x69,
     prim->x1 = 0x139, prim->y1 = 0x69,
     prim->x2 = 0x99, prim->y2 = 0xe8,
     prim->x3 = 0x139, prim->y3 = 0xe8);
    (prim->u0 = shapeX & 0x3f, prim->v0 = shapeY,
     prim->u1 = (shapeX & 0x3f) + 0x50, prim->v1 = shapeY,
     prim->u2 = shapeX & 0x3f, prim->v2 = shapeY | 0x7f,
     prim->u3 = (shapeX & 0x3f) + 0x50, prim->v3 = shapeY | 0x7f);
    prim->tpage = GetTPage(2,1,shapeX & ~0x3f,shapeY & ~0xff);
    prim->clut = 0;

    shapeX += 0x50;
    (prim = (POLY_FT4 *)Render_gPacketPtr,
     ((tTrackSelectPrimTag *)prim)->addr = *(u_int *)Render_gPalettePtr,
     Render_gPacketPtr = (u_char *)prim + sizeof(POLY_FT4),
     ((tTrackSelectPrimTag *)Render_gPalettePtr)->addr = (u_int)prim);
    *(u_int *)&prim->r0 = this->fBrightness << 0x10 |
                          this->fBrightness << 8 | this->fBrightness;
    (((tTrackSelectPrimTag *)prim)->len = 9, prim->code = 0x2e);
    (prim->x0 = 0x139, prim->y0 = 0x69,
     prim->x1 = 0x1d9, prim->y1 = 0x69,
     prim->x2 = 0x139, prim->y2 = 0xe8,
     prim->x3 = 0x1d9, prim->y3 = 0xe8);
    (prim->u0 = shapeX & 0x3f, prim->v0 = shapeY,
     prim->u1 = (shapeX & 0x3f) + 0x50, prim->v1 = shapeY,
     prim->u2 = shapeX & 0x3f, prim->v2 = shapeY | 0x7f,
     prim->u3 = (shapeX & 0x3f) + 0x50, prim->v3 = shapeY | 0x7f);
    prim->tpage = GetTPage(2,1,shapeX & ~0x3f,shapeY & ~0xff);
    prim->clut = 0;
  }
  this->DrawVideoWall();
  return;
}



/* ---- tScreenTrackSelect::GetShapeInfo ---- */
void tScreenTrackSelect::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  tTrackInformation trackInfo;
  
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[0],&trackInfo);
  numPermShapes = 0x44;
  numSwapShapes = 10;
  *permFileName = "ztrack";
  sprintf(gSwapFileName,"%s",trackInfo.fShapeName);
  *swapFileName = gSwapFileName;
  this->fPreviousTrack = (short)(signed char)trackInfo.fTrackID;
  return;
}



/* ---- tScreenTrackSelect::Initialize ---- */
void tScreenTrackSelect::Initialize()

{
  int iVar1;
  tVideoWall *this_00;
  tTrackInformation trackInfo;
  RECT r;
  char moviename [80];
  
  frontEnd.pinkSlipsTrackIndex = '\0';
  Decrement(&menuDefs->iteratorTrack,kPlayerBoth);
  Increment(&menuDefs->iteratorTrack,kPlayerBoth);
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[0],&trackInfo);
  r.x = 0x200;
  r.w = 0xaa;
  r.y = 0;
  r.h = 0x100;
  ClearImage(&r,'\0','\0','\0');
  DrawSync(0);
  this->tScreen::Initialize();
  sprintf
            (moviename,"%szzzTR%02d.dct",Paths_Paths[0x29],(int)(signed char)trackInfo.fTrackID);
  iVar1 = VIDEO_create(0xa0,0x80,0xf0000,0x2c000,0x10);
  this->hVideo = iVar1;
  VIDEO_spoolfile(iVar1,moviename);
  this_00 = &this->fVideoWall;
  VIDEO_startplayback(this->hVideo);
  this->fFrame = 0;
  ::Initialize(this_00,this->tvConfigs,this->fSwapShapes.fShapes,0,10,tvOrder,0x96);
  SetAvailableText(this_00,0xf8,0x140,0x50);
  SetAvailableIcon(this_00,0x26,10,0x136,0x3c,this->fPermShapes.fShapes);
  this->fBrightness = 0;
  this->fDestBrightness = 0;
  this->fTVsInitialized = 0;
  TurnOn(this_00);
  /* MATCH: retail computes the dependent tick value before publishing fTicksSet. */
  this->fVideoTicks = ticks[0] - 0x100;
  this->fTicksSet = 1;
  this->fMovieTrack = (short)(signed char)trackInfo.fTrackID;
  return;
}



/* ---- tScreenTrackSelect::Cleanup ---- */
void tScreenTrackSelect::Cleanup()

{
  
  VIDEO_destroy(this->hVideo);
  purgememadr((void *)this->hVideo);
  this->tScreen::Cleanup();
  return;
}



/* ---- tScreenTrackSelect::SetBrightness ---- */
void tScreenTrackSelect::SetBrightness(short bright)

{
  int iVar1;
  short curBrightness;

  if (bright != this->fDestBrightness) {
    curBrightness = this->fBrightness;
    iVar1 = ticks[0];
    this->fDestBrightness = bright;
    this->fStartBrightness = curBrightness;
    this->fStartTicks = iVar1;
  }
  return;
}



/* ---- tScreenTrackSelect::UpdateBrightness ----
   MATCH: 60/60.  SLD lines 277-286 reveal a three-way chain in source order:
   finished, nonnegative interpolation, negative clamp.  Keeping the interpolation
   as signed division by 128 lets gcc emit its own rounding sequence.  The named
   `elapsed = ticks[0]` assignment inside the fTicksSet guard also gives retail's
   delay-slot address setup and carries the tick value across the flag store. */
void tScreenTrackSelect::UpdateBrightness(tTrackInformation &trackInfo)

{
  long elapsed;
  
  elapsed = ticks[0] - this->fStartTicks;
  if ((int)this->fDestBrightness != (int)this->fBrightness) {
    if (elapsed >= 0x80) {
      this->fBrightness = this->fDestBrightness;
    }
    else if (elapsed >= 0) {
      this->fBrightness = this->fStartBrightness +
          (short)(((int)this->fDestBrightness - (int)this->fStartBrightness) * elapsed / 0x80);
    }
    else {
      this->fBrightness = 0;
    }
  }
  if ((this->fBrightness == 0) && (this->fDestBrightness == 0)) {
    VIDEO_abortplayback(this->hVideo);
    if (this->fTicksSet == 0) {
      elapsed = ticks[0];
      this->fTicksSet = 1;
      this->fVideoTicks = elapsed;
      this->fMovieTrack = (short)(signed char)trackInfo.fTrackID;
    }
  }
  return;
}



/* ---- tScreenTrackSelect::UpdateVideoWall ---- */
void tScreenTrackSelect::UpdateVideoWall(tTrackInformation &trackInfo)

{
  
  if ((int)(signed char)trackInfo.fTrackID != (int)this->fPreviousTrack) {
    ::AsyncLoadSwapShapeFile((tScreen *)this,trackInfo.fShapeName);
    this->fTVsInitialized = 0;
    this->fPreviousTrack = (short)(signed char)trackInfo.fTrackID;
    TurnOff(&this->fVideoWall);
    this->SetBrightness(0);
    this->fTicksSet = 0;
  }
  return;
}



/* ---- tScreenTrackSelect::DrawVideoWall ---- */
void tScreenTrackSelect::DrawVideoWall()

{
  tTrackInformation trackInfo;
  
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
             &trackInfo);
  FETextRender_MenuTextPositionedJustify
            (trackInfo.fSpeedoCountry + 0x43,0x1de,0x21,1,textState_Unselected,textType_TrackRecords
            );
  ::DrawBackgroundImage((tScreen *)this,0,0x1c,this->fPermShapes.fShapes,0x96);
  PSXDrawTransSquare(0,0x140,0x1e,0xa0,10,1);
  FeDraw_SetABRMode(0);
  if (((this->fSwapShapes.fFlags & 1) != 0) && (this->fTVsInitialized == 0)) {
    SetAvailable(&this->fVideoWall,(ushort)trackInfo.fAvailable);
    UpdateImages(&this->fVideoWall);
    this->fTVsInitialized = 1;
  }
  ::UpdateTransition(&this->fVideoWall);
  ::Draw(&this->fVideoWall);
  return;
}



/* ---- tScreenTrackSelect::ProcessInput ---- */
/* MATCH: unsized-array asm-label view of menuDefs -- makes the %hi an RTL
   pseudo so cc1 CSEs ONE `lui $v0,%hi(menuDefs)` across the flag blocks and
   loads through a SEPARATE scratch (oracle `lui $v0; lw $v1,%lo(..)($v0)`)
   instead of the self-temp `lui $v1; lw $v1,0($v1)`. */
extern tGlobalMenuDefs *menuDefsA[] asm("menuDefs");
extern tFEApplication *FEAppA[] asm("FEApp");

void tScreenTrackSelect::ProcessInput(tPlayer player,tInputKeyType &keyval,
              tMenuCommand &command)

{
  /* MATCH (SLD 341-370 + SYM fsize 72 / mask $80010000 = ra,s0 only):
     the SQUARE arm is the INLINE one (oracle `bne $a2,8,.L80042178` branches
     AWAY to the Triangle arm); the recon had them the other way round, which
     rotated the whole body.  Note $s0 holds `this` on the Triangle path and is
     REASSIGNED to &frontEnd on the Square path.
     There is NO `return -0x7ffb0000`: the `lui $v0,0x8005` that produced it is
     just the `lui $v0,%hi(FEApp)` sitting in the `bne` delay slot at 0x80042178,
     and the SYM types this function FCN VOID -- the Triangle tail simply falls
     into the epilogue with $v0 incidental.
     [2026-08-03, 12->PASS] Keep the Square arm's masked trafficFlags in its
     own block-local pseudo instead of reusing the Triangle arm's cmdResult.
     With ptVar1 retained for the two stores, GCC assigns retail's menuDefs
     base to $a0 and trafficFlags to $a1, with no reload or extra instruction. */
  tGlobalMenuDefs *ptVar1;
  void *pvVar2;
  __vtbl_ptr_type (*menuVtbl) [11];
  uint cmdResult;
  tTrackInformation trackInfo;

  if (keyval == kInput_KeyType_Square) {
    GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
               &trackInfo);
    uint trafficFlags;

    ptVar1 = menuDefsA[0];
    trafficFlags = (ptVar1->itemTraffic).fFlags & 0xfffffffe;
    (ptVar1->itemTraffic).fFlags = trafficFlags;
    if ((frontEnd.gameMode != '\x01') && (frontEnd.oppNumber == '\x02')) {
      (ptVar1->itemTraffic).fFlags = trafficFlags | 1;
    }
    if (2 < trackInfo.fTrackDifficulty) {
      (menuDefsA[0]->itemTraffic).fFlags =
           (menuDefsA[0]->itemTraffic).fFlags | 1;
    }
    if (trackInfo.fIsEgg != '\0') {
      (menuDefsA[0]->itemTraffic).fFlags =
           (menuDefsA[0]->itemTraffic).fFlags | 1;
    }
    if (frontEnd.gameMode == '\x01') {
      if (frontEnd.raceType != '\x01') goto ProcInpLocSpch_setFlags;
      (menuDefsA[0]->itemTraffic).fFlags =
           (menuDefsA[0]->itemTraffic).fFlags | 1;
    }
    if ((frontEnd.raceType == '\x01') &&
       (pvVar2 = Front_EnableLocalSpeech(), pvVar2 != (void *)0x0))
    {
      (menuDefsA[0]->itemLocalSpeech).fFlags =
           (menuDefsA[0]->itemLocalSpeech).fFlags & 0xfffffffe;
      return;
    }
ProcInpLocSpch_setFlags:
    (menuDefsA[0]->itemLocalSpeech).fFlags =
         (menuDefsA[0]->itemLocalSpeech).fFlags | 1;
    return;
  }
  if (keyval == kInput_KeyType_Triangle) {
    menuVtbl = FEAppA[0]->fCurrentMenu[0]->_vf;
    cmdResult = (*(*menuVtbl)[8].pfn)
                      ((int)FEAppA[0]->fCurrentMenu[0]->fItemList + -0x10 + (*menuVtbl)[8].delta);
    if ((cmdResult ^ 1) != 0) {
      TurnOffInstant(&this->fVideoWall);
    }
  }
  /* NO return statement -- the SYM types this FCN VOID and the oracle's tail
     falls straight into the epilogue ($v0 incidental).  A literal `return 0;`
     emits three un-merged `addu $v0,$zero,$zero`. */
}



/* ---- tScreenTrackSelect::dtor ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___18tScreenTrackSelect(void *thisp) { ___7tScreen(thisp); }



/* end of screentracks.cpp */
