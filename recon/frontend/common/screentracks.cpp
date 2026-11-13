/* frontend/screens/screentracks.cpp -- RECONSTRUCTED (track-select screen; C++ TU)
 *   10 member fns of tScreenTrackSelect (: public tScreen).
 *   Bodies from Ghidra; namespaces stripped, phantom regs resolved vs disasm.
 */
#include "screentracks_types.h"
#include "screentracks_externs.h"

/* retail's SYM records an inline-call pair at every tick read in this TU */
#line 10 "feticks.h"
static inline void MenuItem_Enable(tMenuItem *item) { item->fFlags &= ~1; }
static inline void MenuItem_Disable(tMenuItem *item) { item->fFlags |= 1; }
static inline int FE_Ticks(void) { return ticks; }
#line 14 "C:\\Temp\\nfs4-decomp\\recon\\frontend\\common\\screentracks.cpp"

/* Retail screentracks.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

typedef struct tTrackSelectPrimTag {
  u_int addr : 24;
  u_int len : 8;
} tTrackSelectPrimTag;


/* ---- tScreenTrackSelect::DrawBackground ---- */
    /* SYM-CODEGEN-CARRIER: packetPtrSlot -- direct Render_gPacketPtr use is
       count-exact FAIL 4 and hoists the scratchpad address before retail. */
    /* MATCH W79 (2026-08-26, source-only 2->PASS 299/299): the remaining
       spill-position tie was caused by the allocation fence itself.  GCC makes
       an output-less asm implicitly volatile; sched2 therefore put an anti-dep
       from it onto packetPtrSlot's `sw t2,160(sp)` and forced that store ahead
       of the GetTPage argument packet.  Expressing literal 0xffffff directly
       in the first 24-bit packet-link assignment supplies the load-bearing
       mask reference naturally, while removing the false source identity and
       scheduling barrier.  sched2 then emits the store at retail
       SLD:155, after the SLD:161 argument setup.  strict_branch: 12/12 clean;
       all 10 TU functions remain PASS.  This supersedes the diagnostic-only
       PER_FN_TEXT_MOVES receipt above; no post-cc1 move is used. */
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
    /* MATCH: the EA/PsyQ quad wrapper materializes its texture-X origin for
       both UV and tpage arithmetic.  The first packet-link's 24-bit bitfield
       write naturally materializes the 0xffffff address mask and gives
       retail's s0/s1/s2/s3 mask/page/V/Y handout without a source local.
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
    /* P867: SYM 691546/69154f/69156d owns moviename (AUTO -128, char[80])
       in the whole 800417f8-80041864 block, source 143-150: before the
       brightness guard through VIDEO_startplayback. PASS 299, exact debug twin. */
    /* SYM-CODEGEN-CARRIER: startTicks -- P891 base scalar direct store is
       PASS299 but merges native SLD129/132 (six pairs); field staging
       remains FAIL1 at 300/299. Original source is still unresolved.
       With the former array interface, direct field assignment is FAIL 3
       at 300/299 and moves the tick load after the brightness store.
       P867: staging through fStartTicks adds one sw (FAIL1, 300/299);
       embedding the brightness store in subtraction is FAIL3 (300/299),
       or FAIL8 (305/299) with a widened tick operand. All restored. */
    /* SYM-CODEGEN-CARRIER: videoWall -- direct member spellings are
       count-exact FAIL 6; the original inline-receiver source is unresolved.
       P867: pointer-to-member field spelling also FAIL6 at 299/299. */
  /* SYM-CODEGEN-CARRIER: videoY -- using only SYM-visible `shapeY` is
     FAIL 10 at 297/299 and loses retail's distinct `$s0`/`$s6` value webs. */
  /* SYM-CODEGEN-CARRIER: shapeX -- replacing its two-stage 0x200/0x250
     value web with literals is FAIL 190 at 285/299 and collapses the mask,
     UV, tpage, frame, and saved-register structure documented below. */
  /* W86-S4: SYM `8c` order is r (AUTO sp+16), trackInfo (AUTO sp+24),
     shapeY (REG $22 s6), prim (REG $30 fp), state (REG $3 v1) -- the two
     SYM-ABSENT carriers are quarantined after them.  Re-gated PASS. */
#line 80 "C:/nfs4/FRONTEND/COMMON/SCREENTRACKS.CPP"
void tScreenTrackSelect::DrawBackground()


{
  RECT r;
  tTrackInformation trackInfo;
  short shapeY;
  POLY_FT4 *prim;
  VIDEOSTATE state; short shapeX; short shapeX2; int videoY; r.x = 0x140;
  r.y = 200;
  r.w = 0xaa;
  r.h = 0xc;





  DrawShape_NFS4RoundRectangle(((tListIteratorTrack *)((char *)menuDefs + 0xc88))->tListIteratorTrack::TextValue((tPlayer)kPlayerBoth),r,0);

  trackManager.GetTrack((ushort)(byte)frontEnd.track[0],trackInfo);

  this->UpdateBrightness(trackInfo);
  this->UpdateVideoWall(trackInfo);

  this->IsShapeFileLoaded(this->fSwapShapes);
  if (((this->fSwapShapes.fFile != (char *)0x0) && (this->fVideoWall.TransitionDirection() != -1)) && (this->fBrightness == 0)) {

      this->UploadSwapShapes(10);
      this->fVideoWall.TurnOn(); }
    
  




  shapeX = 0x200;
  videoY = ((state = state, ((this->fFrame & 1U) == 0) << 7) ?: 0) + ((videoY = 0) != 0);

  shapeY = (short)videoY; state = (VIDEOSTATE)VIDEO_state(this->hVideo);

  if (state == VIDEOSTATE_SPOOLING)
  {
    RECT r;
    int startTicks;
    r.x = shapeX;
    r.y = 0;
    r.w = 0xaa;
    r.h = 0x100;
    ClearImage(&r,'\0','\0','\0');
    DrawSync(0);
    startTicks = (startTicks = 0, FE_Ticks());
    this->fBrightness = 0;
    this->fStartTicks = startTicks - 0x14;
  }
  else if (state == VIDEOSTATE_PLAYING) {
    if (VIDEO_updateframexy(this->hVideo,shapeX,
                            (u_int)(videoY << 0x10) >> 0x10) != 0) {

      this->fFrame = this->fFrame + 1;
      videoY = (videoY = 0, ((this->fFrame & 1U) == 0) << 7); shapeY = (short)videoY;
    }
  }
  else if (((this->fTicksSet != 0) || (this->fDestBrightness < this->fBrightness)) && ((uint)(FE_Ticks() - this->fVideoTicks) >= 0x101U))
  {
    char moviename[80];
    if (this->fDestBrightness >= this->fBrightness) {
      this->SetBrightness(trackInfo.fAvailable != '\0' ? 0x80 : 0x20);
    }
    sprintf(moviename,"%szzzTR%02d.dct",Paths_Paths[0x29], (int)this->fMovieTrack);
    VIDEO_spoolfile(this->hVideo,moviename);
    VIDEO_startplayback(this->hVideo);
  }

  int packetPtrSlot; if (0 < this->fBrightness) {

    packetPtrSlot = ((prim = prim, (int)&Render_gPacketPtr) ?: 0) + ((packetPtrSlot = 0) != 0); (prim = (POLY_FT4 *)*(u_char **)packetPtrSlot, ((tTrackSelectPrimTag *)prim)->addr = *(u_int *)Render_gPalettePtr, *(u_char **)packetPtrSlot = (u_char *)prim + sizeof(POLY_FT4), ((tTrackSelectPrimTag *)Render_gPalettePtr)->addr = (u_int)prim & 0xffffff);
    *(u_int *)&prim->r0 = this->fBrightness << 0x10 | this->fBrightness << 8 | this->fBrightness;
    (((tTrackSelectPrimTag *)prim)->len = 9, prim->code = 0x2e);
    (prim->x0 = 0x99, prim->y0 = 0x69,
     prim->x1 = 0x139, prim->y1 = 0x69, prim->x2 = 0x99, prim->y2 = 0xe8, prim->x3 = 0x139, prim->y3 = 0xe8);
    (prim->u0 = shapeX & 0x3f, prim->v0 = shapeY, prim->u1 = (shapeX & 0x3f) + 0x50, prim->v1 = shapeY, prim->u2 = shapeX & 0x3f, prim->v2 = shapeY | 0x7f, prim->u3 = (shapeX & 0x3f) + 0x50, prim->v3 = shapeY | 0x7f);
    prim->tpage = GetTPage(2,1,shapeX & ~0x3f,shapeY & ~0xff);
    prim->clut = 0;

    shapeX2 = (shapeX2 = 0, ((short)(shapeX += 0x50) ?: (short)0));
    (prim = (POLY_FT4 *)Render_gPacketPtr, ((tTrackSelectPrimTag *)prim)->addr = *(u_int *)Render_gPalettePtr, Render_gPacketPtr = (u_char *)prim + sizeof(POLY_FT4), ((tTrackSelectPrimTag *)Render_gPalettePtr)->addr = (u_int)prim);
    *(u_int *)&prim->r0 = this->fBrightness << 0x10 | this->fBrightness << 8 | this->fBrightness;
    (((tTrackSelectPrimTag *)prim)->len = 9, prim->code = 0x2e);
    (prim->x0 = 0x139, prim->y0 = 0x69,
     prim->x1 = 0x1d9, prim->y1 = 0x69, prim->x2 = 0x139, prim->y2 = 0xe8, prim->x3 = 0x1d9, prim->y3 = 0xe8);
    (prim->u0 = shapeX2 & 0x3f, prim->v0 = shapeY, prim->u1 = (shapeX2 & 0x3f) + 0x50, prim->v1 = shapeY, prim->u2 = shapeX2 & 0x3f, prim->v2 = shapeY | 0x7f, prim->u3 = (shapeX2 & 0x3f) + 0x50, prim->v3 = shapeY | 0x7f);
    prim->tpage = GetTPage(2,1,shapeX2 & ~0x3f,shapeY & ~0xff);
    prim->clut = 0;
  }



  this->DrawVideoWall(); return;
}



/* ---- tScreenTrackSelect::GetShapeInfo ---- */
#line 179 "C:/nfs4/FRONTEND/COMMON/SCREENTRACKS.CPP"
void tScreenTrackSelect::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)


{
  tTrackInformation trackInfo;
  
  trackManager.GetTrack((ushort)(byte)frontEnd.track[0],trackInfo);

  numPermShapes = 0x44;
  numSwapShapes = 10;

  *permFileName = "ztrack";
  sprintf(gSwapFileName,"%s",trackInfo.fShapeName);
  *swapFileName = gSwapFileName;

  this->fPreviousTrack = (short)(signed char)trackInfo.fTrackID; return;
}



/* ---- tScreenTrackSelect::Initialize ---- */
  /* MATCH: retail computes the dependent tick value before publishing fTicksSet. */
#line 197 "C:/nfs4/FRONTEND/COMMON/SCREENTRACKS.CPP"
void tScreenTrackSelect::Initialize()


{
  tTrackInformation trackInfo;
  RECT r;
  char moviename [80];
  

  frontEnd.pinkSlipsTrackIndex = '\0';
  ((tListIteratorTrack *)((char *)menuDefs + 0xc88))->tListIteratorTrack::Decrement((tPlayer)kPlayerBoth);
  ((tListIteratorTrack *)((char *)menuDefs + 0xc88))->tListIteratorTrack::Increment((tPlayer)kPlayerBoth);

  trackManager.GetTrack((ushort)(byte)frontEnd.track[0],trackInfo);




  r.x = 0x200;
  r.y = 0;
  r.w = 0xaa;
  r.h = 0x100;
  ClearImage(&r,'\0','\0','\0');
  DrawSync(0);


  this->tScreen::Initialize();
  sprintf



            (moviename,"%szzzTR%02d.dct",Paths_Paths[0x29],(int)(signed char)trackInfo.fTrackID);
  this->hVideo = VIDEO_create(0xa0,0x80,0xf0000,0x2c000,0x10);
  VIDEO_spoolfile(this->hVideo,moviename);
  VIDEO_startplayback(this->hVideo);
  this->fFrame = 0;
  this->fVideoWall.Initialize(this->tvConfigs,this->fSwapShapes.fShapes,


               0,10,tvOrder,0x96);
  this->fVideoWall.SetAvailableText(0xf8,0x140,0x50);
  this->fVideoWall.SetAvailableIcon(0x26,10,0x136,0x3c,
                   this->fPermShapes.fShapes);

  this->fBrightness = 0;
  this->fDestBrightness = 0;
  this->fTVsInitialized = 0;
  this->fVideoWall.TurnOn();
  this->fVideoTicks = FE_Ticks() - 0x100;
  this->fTicksSet = 1;
  this->fMovieTrack = (short)(signed char)trackInfo.fTrackID; return;
}



/* ---- tScreenTrackSelect::Cleanup ---- */
#line 248 "C:/nfs4/FRONTEND/COMMON/SCREENTRACKS.CPP"
void tScreenTrackSelect::Cleanup()


{
  
  VIDEO_destroy(this->hVideo);
  purgememadr((void *)this->hVideo);

  this->tScreen::Cleanup();
}



/* ---- tScreenTrackSelect::SetBrightness ---- */
#line 258 "C:/nfs4/FRONTEND/COMMON/SCREENTRACKS.CPP"
void tScreenTrackSelect::SetBrightness(short bright)


{
  if (bright != this->fDestBrightness)
  {
    this->fStartBrightness = this->fBrightness;
    this->fDestBrightness = bright;
    this->fStartTicks = FE_Ticks(); } return; }



/* ---- tScreenTrackSelect::UpdateBrightness ----
   MATCH: 60/60.  SLD lines 277-286 reveal a three-way chain in source order:
   finished, nonnegative interpolation, negative clamp.  Keeping the interpolation
   as signed division by 128 lets gcc emit its own rounding sequence.  The named
   `elapsed = ticks` assignment inside the fTicksSet guard also gives retail's
   delay-slot address setup and carries the tick value across the flag store. */
#line 269 "C:/nfs4/FRONTEND/COMMON/SCREENTRACKS.CPP"
void tScreenTrackSelect::UpdateBrightness(tTrackInformation &trackInfo)


{
  long elapsed; elapsed = FE_Ticks() - this->fStartTicks;

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

  if ((this->fBrightness == 0) && (this->fDestBrightness == 0))
  {
    VIDEO_abortplayback(this->hVideo);
    if (this->fTicksSet == 0)
    {
      this->fTicksSet = 1;
      this->fVideoTicks = elapsed = FE_Ticks();
      this->fMovieTrack = (short)(signed char)trackInfo.fTrackID; } } return; }



/* ---- tScreenTrackSelect::UpdateVideoWall ---- */
#line 302 "C:/nfs4/FRONTEND/COMMON/SCREENTRACKS.CPP"
void tScreenTrackSelect::UpdateVideoWall(tTrackInformation &trackInfo)


{
  if ((int)(signed char)trackInfo.fTrackID != (int)this->fPreviousTrack) {

    this->AsyncLoadSwapShapeFile(trackInfo.fShapeName);
    this->fTVsInitialized = 0;

    this->fPreviousTrack = (short)(signed char)trackInfo.fTrackID;
    this->fVideoWall.TurnOff();
    this->SetBrightness(0);
    this->fTicksSet = 0; } return; }



/* ---- tScreenTrackSelect::DrawVideoWall ---- */
#line 316 "C:/nfs4/FRONTEND/COMMON/SCREENTRACKS.CPP"
void tScreenTrackSelect::DrawVideoWall()


{
  tTrackInformation trackInfo;
  trackManager.GetTrack((ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
             trackInfo);
  FETextRender_MenuTextPositionedJustify
            (trackInfo.fSpeedoCountry + 0x43,0x1de,0x21,1,textState_Unselected,textType_TrackRecords
            );
  this->DrawBackgroundImage(0,0x1c,this->fPermShapes.fShapes,0x96);
  PSXDrawTransSquare(0,0x140,0x1e,0xa0,10,1);
  FeDraw_SetABRMode(0);

  if ((this->fSwapShapes.fFlags & 1) != 0) {

    if (this->fTVsInitialized == 0) {

    this->fVideoWall.SetAvailable((ushort)trackInfo.fAvailable);
    this->fVideoWall.UpdateImages();
    this->fTVsInitialized = 1;
  } }


  this->fVideoWall.UpdateTransition();
  this->fVideoWall.Draw(); return;
}



/* ---- tScreenTrackSelect::ProcessInput ---- */
/* P872: native scalar menuDefs replaces the old menuDefsA array alias.
   The frontend -G0 lane preserves its separate-temp loads directly. */



#line 344 "C:/nfs4/FRONTEND/COMMON/SCREENTRACKS.CPP"
void tScreenTrackSelect::ProcessInput(tPlayer,tInputKeyType &keyval,tMenuCommand &)
{
  tTrackInformation trackInfo;

  if (keyval == kInput_KeyType_Square)
  {
    trackManager.GetTrack((ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex], trackInfo); MenuItem_Enable((tMenuItemOptionsTwoItemChoice *)((char *)menuDefs + 0xf4c));




    if ((frontEnd.gameMode != '\x01') && (frontEnd.oppNumber == '\x02'))
    { MenuItem_Disable((tMenuItemOptionsTwoItemChoice *)((char *)menuDefs + 0xf4c)); }
    if (2 < trackInfo.fTrackDifficulty)
    { MenuItem_Disable((tMenuItemOptionsTwoItemChoice *)((char *)menuDefs + 0xf4c)); }
    if (trackInfo.fIsEgg != '\0')
    { MenuItem_Disable((tMenuItemOptionsTwoItemChoice *)((char *)menuDefs + 0xf4c)); }
    if ((frontEnd.gameMode == '\x01') && (frontEnd.raceType == RaceType_HotPursuit))
    { MenuItem_Disable((tMenuItemOptionsTwoItemChoice *)((char *)menuDefs + 0xf4c)); }
    if ((frontEnd.raceType == RaceType_HotPursuit) && Front_EnableLocalSpeech())
    { MenuItem_Enable((tMenuItemOptionsTwoItemChoice *)((char *)menuDefs + 0xf70)); } else
    { MenuItem_Disable((tMenuItemOptionsTwoItemChoice *)((char *)menuDefs + 0xf70)); }

  } else if (keyval == kInput_KeyType_Triangle)
  {
    if (!FEApp->CurrentMenu(kPlayerOne)->IsSubMenu())
    { this->fVideoWall.TurnOffInstant(); } } }






extern "C" void ___7tScreen(void *);



/* end of screentracks.cpp */
