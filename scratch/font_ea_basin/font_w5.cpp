/* frontend/psx/psxfront.cpp  --  RECONSTRUCTED  (PSX frontend / shape drawing; C++ TU)
 *   Bodies: Ghidra decompiler. Line numbers: PsyQ SLD (8c-start, SLD-max end).
 *   25 functions; C++ linkage (cfront-mangled in SYM). Externs declared from Ghidra sigs.
 */
#include "psxfront.h"
#include "psxfront_externs.h"

/* ---- PSXFront.obj STAT (file-local) globals ---- */
static char     *STR_FRMT[2];                       /* 0x80052a54 (sized>G4 -> .bss/absolute, not
                                                       .sbss/gp-rel -- same device as rendering3DEnvInit__) */
static u_short   ofs[2];                            /* 0x80052a5c */
static char      rendering3DEnvInit__[8];           /* 0x80052a60 (sized>G4 -> .bss/absolute, not .sbss/gp-rel) */
#define rendering3DEnvironmentInitialized rendering3DEnvInit__[0]

/* lines 1-96: file header, #includes, static data, macros (no symbols emitted) */

/* ---- Quick_DD  (psxfront.cpp:97, code lines 97-98) ---- */
void Quick_DD(int a,int b,int c)

{
  Draw_DirectSetEnvironment(0,0,0x200,0xf0,a,b,c,0,0,0);
  return;
}

/* lines 99-140: (static data / macros / comments - no emitted code) */

/* ---- PSXFront_AllocateDrawMemory  (psxfront.cpp:141, code lines 141-154) ---- */
void PSXFront_AllocateDrawMemory(void)

{
  Draw_InitViewOT();
  gEnviro[0].server = (char *)reservememadr("ps0",80000,0x10);
  gEnviro[1].server = (char *)reservememadr("ps1",80000,0x10);
  Draw_SetViewMemBudget(Draw_gPlayer1View[0],80000);
  return;
}

/* lines 155-157: (static data / macros / comments - no emitted code) */

/* ---- PSXFront_FreeDrawMemory  (psxfront.cpp:158, code lines 158-159) ---- */
void PSXFront_FreeDrawMemory(void)

{
  ClearPrimitivesBuffer();
  return;
}

/* lines 160-162: (static data / macros / comments - no emitted code) */

/* ---- InitializeSpinningCars  (psxfront.cpp:163, code lines 163-224) ---- */
void InitializeSpinningCars(void)

{
  /* SYM: the ONLY local is `i` (INT).  carData_walk/obj_walk were fabricated -- retail indexes
   * GameSetup_gData.carInfo[i] / gCarObj[i] and loop.c strength-reduces both into givs ($s2 stride
   * 0xB4, $s3 stride 4).  Loop is TOP-tested with a `j` back-edge, not gcc's rotated do-while. */
  Car_tObj *carObj;
  int i;

  if (rendering3DEnvironmentInitialized == '\0') {
    R3DCar_InMenu[0] = 1;
    Platform_ResetDCTBuffer();
    Texture_InitMenuTexture();
    inFrontEnd[0] = 1;
    CarIO_StartUp();
    R3DCar_StartUp();
    inFrontEnd[0] = 0;
    DrawC_ReadeMapData();
    Fe3D_InitShowroom();
    GameSetup_gData.Weather = 0;
    i = 0;
    while (1) {
      if (2 <= i) break;
      carObj = (Car_tObj *)reservememadr("carObj",0x8dc,0);
      gCarObj[i] = carObj;
      blockclear(carObj,0x8dc);
      carObj->carInfo = &GameSetup_gData.carInfo[i];
      carObj->carInfo->carType = 1;
      strcpy(carObj->carName,GameSetup_gCarNames[carObj->carInfo->carType]);
      (carObj->N).objID = i | 0x100;
      R3DCar_Instantiate3DCar(carObj,i);
      (carObj->N).active = '\x01';
      i = i + 1;
    }
    R3DCar_PostStartUp();
    gMenuRotate[1] = 0;
    gMenuRotate[0] = 0;
    blockclear(&gCView,0x8c);
    DrawC_gMenuColor[1] = -1;
    DrawC_gMenuColor[0] = -1;
    DrawC_gMenuLights[0] = 0;
    DrawC_gMenuLightsDirection[0] = 0;
    rendering3DEnvironmentInitialized = '\x01';
  }
  return;
}

/* lines 225-226: (static data / macros / comments - no emitted code) */

/* ---- CleanupSpinningCars  (psxfront.cpp:227, code lines 227-275) ---- */
void CleanupSpinningCars(void)

{
  /* SYM: i, handle, fname[60] -- that is ALL.  `ppCar`/`addr`/`status` were fabricated; retail
   * indexes gCarObj[i] (loop.c turns the walker into a giv) and RE-READS it for purgememadr, so the
   * handle then lands in the walker's dead $s0 rather than in i's $s1. w42-a7. */
  int handle;
  int i;
  char fname [60];
  
  if (rendering3DEnvironmentInitialized != '\0') {
    DrawSync(0);
    for (i = 0; i < 2; i = i + 1) {
      R3DCar_DeInstantiate3DCar(gCarObj[i]);
      purgememadr(gCarObj[i]);
    }
    inFrontEnd[0] = 1;
    R3DCar_CleanUp();
    CarIO_CleanUp();
    inFrontEnd[0] = 0;
    Texture_KillMenuTexture();
    PSXFront_FreeDrawMemory();
    R3DCar_InMenu[0] = 0;
    gFlip[0] = -1;
    rendering3DEnvironmentInitialized = '\0';
    Platform_ResetDCTBuffer();
    sprintf(fname,"%sDCT.BIN",Paths_Paths[0x20]);
    handle = asyncloadfileat(fname,CF_DVLC);
    while (getasyncreadstatus(handle) == 0) {
      systemtask(0);
    }
  }
  return;
}

/* lines 276-280: (static data / macros / comments - no emitted code) */

/* ---- CleanupSpinningCarsMenu  (psxfront.cpp:281, code lines 281-299) ---- */
void CleanupSpinningCarsMenu(void)

{
  Car_tObj *carObj;
  Car_tObj **ppCar;
  int i;
  
  if (rendering3DEnvironmentInitialized != '\0') {
    DrawSync(0);
    i = 0;
    ppCar = gCarObj;
    do {
      carObj = *ppCar;
      ppCar = ppCar + 1;
      i = i + 1;
      R3DCar_DeInstantiate3DCarMenu(carObj);
    } while (i < 2);
    Texture_CleanupMenuTexture();
    CarIO_ReStart();
  }
  return;
}

/* lines 300-303: (static data / macros / comments - no emitted code) */

/* ---- DoTitleScreen  (psxfront.cpp:304, code lines 304-356) ---- */
void DoTitleScreen(void)

{
  void *shape;
  shapetbl *tempShp2;
  char fileName [48];
  char artfilename [20];
  
  elapsedticks();
  if (creditShapeFile[0] == (char *)0x0) {
    sprintf(artfilename,"title.psh");
    sprintf(fileName,STR_FRMT[0],Paths_Paths[0x20],artfilename);
    creditShapeFile[0] = (char *)loadshapeadr(fileName,(void *)0x0);
    systemtask(0);
    if (creditShapeFile[0] == (char *)0x0) {
      return;
    }
  }
  shape = (tTexture_ShapeInfo *)locateshapez(creditShapeFile[0],(void *)"back");
  Quick_DD(1,0,1);
  settrans(0);
  movfxya(shape,0,0);
  settrans(1);
  Quick_DD(0,1,0);
  purgememadr(creditShapeFile[0]);
  creditShapeFile[0] = (char *)0x0;
  titleScreenDisplayed[0] = '\x01';
  return;
}

/* lines 357-438: (static data / macros / comments - no emitted code) */

/* ---- DoLanguageScreen  (psxfront.cpp:439, code lines 439-569) ---- */
void DoLanguageScreen(void)

{
  Front_InitialMemCardCheck();
  if ((u_char)frontEnd.language == 0xff) {   /* sentinel: -1 == 0xFF as unsigned byte (this build's char is unsigned -> lbu;bne 0xFF) */
    frontEnd.language = '\0';
  }
  return;
}

/* lines 570-665: (static data / macros / comments - no emitted code) */

/* ---- PSXExitFrontend  (psxfront.cpp:666, code lines 666-678) ---- */
void PSXExitFrontend(void)

{
  CleanupSpinningCars();
  deltimer(PAD_update);
  Audio_DeInitDriver();
  if (gHelpShapes[0] != (tTexture_ShapeInfo *)0x0) {
    purgememadr(gHelpShapes[0]);
    gHelpShapes[0] = (tTexture_ShapeInfo *)0x0;
  }
  ComingIntoTheFrontEndTheVeryFirstTime[0] = 0;
  return;
}

/* lines 679-681: (static data / macros / comments - no emitted code) */

/* ---- PSX_AllocShapes  (psxfront.cpp:682, code lines 682-684) ---- */
void PSX_AllocShapes(void)

{
  tTexture_ShapeInfo **slot = gHelpShapes;   /* &gHelpShapes[0] computed BEFORE the call -> held in a
                                                callee-saved reg (s0) across reservememadr, like the oracle */
  *slot = (tTexture_ShapeInfo *)reservememadr("gHelpShapes",0x760,0);
  blockclear(*slot,0x760);
  return;
}

/* lines 685-695: (static data / macros / comments - no emitted code) */

/* ---- Init_RenderingEnvironment  (psxfront.cpp:696, code lines 696-720) ---- */
void Init_RenderingEnvironment(void)

{
  SetDefDispEnv(&gEnviro[0].disp,0,0x100,0x200,0xf0);
  SetDefDispEnv(&gEnviro[1].disp,0,0,0x200,0xf0);
  Draw_InitViews();
  Draw_gRearView[0] = -1;
  /* DISGUISED BARE-VA FIX (w14-a2): raw @0x8004dd64-98 shows the true args are
   * (x0=0,y0=0,x1=0,y1=0x100,w=0x200,h=0xf0,dtd=0,isbg=1,otsize=10) -- y0 was a bogus fabricated
   * literal -0x7fec0000==0x80140000 (not a real symbol; just wrong) and y1 read an UNINITIALIZED
   * `stackv` local where the oracle passes the plain constant 0x100 ($a3, set once and never
   * touched again before the call). */
  Draw_gPlayer1View[0] =
       Draw_SetView
                 (0,0,0,0x100,0x200,0xf0,0,1,10);
  blockclear(&gCView,0x8c);
  gCView.id = Draw_gPlayer1View[0];
  PSXFront_AllocateDrawMemory();
  Draw_gDoVSync[0] = 1;
  FETextRender_SetABR(0,false);
  gFlip[0] = 0;
  return;
}

/* lines 721-725: (static data / macros / comments - no emitted code) */

/* ---- Init_PSX_FrontEnd  (psxfront.cpp:726, code lines 726-783) ---- */
void Init_PSX_FrontEnd(void)

{
  /* SYM lists NO locals here (movieRes was fabricated -- retail compares play_movie's $v0 directly).
   * 🔴 initlinkmode takes THREE args (oracle sets $a2 at every site: `addu a2,a1,zero` / `addu a2,a0,
   * zero`) -- the recon passed only two, dropping the 3rd (§3.12 #18).  Polarity: the FIRST-TIME
   * (!= 0) arm is the FALL-THROUGH in retail (`beqz v1` skips to the short arm). w42-a7. */
  gFlip[0] = -1;
  addtimer(PAD_update);
  InitGeom();
  PSX_AllocShapes();
  Texture_InitMenuClut();
  screenwidth[0] = 0x200;
  screenbpp[0] = 0x10;
  if (ComingIntoTheFrontEndTheVeryFirstTime[0] != 0) {
    if (play_movie('\x04') != 1) {
      play_movie('\0');
    }
    initlinkmode(0,1,1);
    Init_RenderingEnvironment();
    initlinkmode(0,0x14,0);
    DoLanguageScreen();
    TextSys_LoadWords((uint)(byte)frontEnd.language);
    DoTitleScreen();
    initlinkmode(0,1,1);
    Front_SecondaryMemCardCheck();
  }
  else {
    Init_RenderingEnvironment();
    TextSys_LoadWords((uint)(byte)frontEnd.language);
  }
  FeTools_init();
  Audio_InitDriver(0xd800,0x18000);
  SetPlayList(frontEnd.GotAPlayList);
  AudioCmn_LoadFESamples();
  LoadAllHelpShapes();
  return;
}

/* lines 784-838: (static data / macros / comments - no emitted code) */

/* ---- AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended  (psxfront.cpp:839, code lines 839-922) ---- */
extern "C" void AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended(tTexture_ShapeInfo *tShp,int *x,int *y,int *flags,int bright,int *color,
               tDrawShapeExtended *extra)

{
  /* SYM 8c block lists exactly FIVE locals: fadetop/fadebottom (SHORT), i (SHORT),
   * fbot/ftop (INT) -- plus the REG copies of the stack params bright/color/extra.
   * The former recon carried 9 fabricated temps (adjY/cHi/cMid/cLo/cB/cG/fadeC1/fadeC2/shpAddr).
   * 🔴 `shpAddr` was NEVER ASSIGNED and every shape-field read went through it (wild reads); the
   * oracle's `addu $t0,$a0,$zero` is the tShp REGPARM copy -- all 0x1N($t0) reads are tShp fields. */
  /* SYM BLOCK STRUCTURE (90/92 records): fadetop($a3)/fadebottom($a0) at function block start;
   * `i`($t0) declared in the block at 0x8004E0CC (the 0x80 arm); fbot($v0)/ftop($a1) declared in
   * the block at 0x8004E178 (the 0x40 arm).  Block-local scope is the allocno-CLASS lever (w41 §A). */
  short fadetop;
  short fadebottom;

  if ((*flags & 0x400U) != 0) {
    *x = *x - tShp->centerx;
    *y = *y - tShp->centery;
  }
  else if (*y <= 0) {
    *x = *x - tShp->centerx;
    *y = -(tShp->centery + *y);
  }
  if ((*flags & 0x100U) != 0) {
    *x = *x - ((int)((uint)(ushort)tShp->width << 0x10) >> 0x11);
    *y = *y - ((int)((uint)(ushort)tShp->height << 0x10) >> 0x11);
  }
  if ((*flags & 0x20U) != 0) {
    *y = (extra->flip_axis * 2 - (*y + tShp->height)) + 1;
    *flags = *flags | 2;
  }
  if ((*flags & 0x10U) != 0) {
    /* byte-2 term spelled (w>>16)&0xff so combine narrows IT to `lbu +2` and leaves the >>8 term
     * on the full word load (`lw; sra 8; andi 0xff`) -- retail's exact 3-load mix (w42-a7). */
    *color = (((extra->tint[0] >> 0x10) & 0xff) * bright / 128) << 0x10 |
             ((extra->tint[0] >> 8 & 0xff) * bright / 128) << 8 |
             (int)*(byte *)((int)extra->tint) * bright / 128;
  }
  else if ((*flags & 0x80U) != 0) {
    short i;
    for (i = 0; i < 4; i = i + 1) {
      color[i] = (((extra->tint[i] >> 0x10) & 0xff) * bright / 128) << 0x10 |
                 ((extra->tint[i] >> 8 & 0xff) * bright / 128) << 8 |
                 (int)*(byte *)((int)(extra->tint + i)) * bright / 128;
    }
  }
  else if ((*flags & 0x40U) != 0) {
    int fbot;
    int ftop;
    /* MATCH: rawT/rawB are the PRE-ABS values.  SYM's fbot($v0)/ftop($a1) hold ONLY the final
     * `0x80 - fade*` results -- keeping the raw in the same variable made ftop's allocno outrank
     * the flip_axis CSE temp and rotated $a0/$a1 through the whole arm (70 diffs).  Split = PASS. */
    int rawT;
    int rawB;
    /* the abs runs on the INT (ftop/fbot); only the DOUBLED value lands in the short fade var --
     * that is why the oracle's `sll v0,a3,1` carries no sign-extension of the source (w42-a7). */
    rawT = ((uint)(ushort)extra->flip_axis - (uint)(ushort)*y) + 1;
    fadetop = rawT;
    if (rawT * 0x10000 < 0) {
      fadetop = -rawT;
    }
    fadetop = fadetop << 1;
    if (0x80 < fadetop) {
      fadetop = 0x80;
    }
    rawB = ((uint)(ushort)extra->flip_axis - ((uint)(ushort)*y + (uint)(ushort)tShp->height)) + 1;
    fadebottom = rawB;
    if (rawB * 0x10000 < 0) {
      fadebottom = -rawB;
    }
    fadebottom = fadebottom << 1;
    if (0x80 < fadebottom) {
      fadebottom = 0x80;
    }
    /* the 0x80 is ONE constant that ends up mutated in place into `ftop` (SYM ftop=$a1: the oracle
     * does `li a1,0x80` -> `subu v0,a1,v0` (fbot) -> `subu a1,a1,v0` (ftop)). */
    fbot = 0x80 - fadebottom;
    ftop = 0x80 - fadetop;
    *color = fbot << 0x10 | fbot << 8 | fbot;
    color[1] = fbot << 0x10 | fbot << 8 | fbot;
    color[2] = ftop << 0x10 | ftop << 8 | ftop;
    color[3] = ftop << 0x10 | ftop << 8 | ftop;
  }
  else {
    *color = bright << 0x10 | bright << 8 | bright;
  }
  return;
}

/* lines 923-927: (static data / macros / comments - no emitted code) */

/* PsyQ libgpu P_TAG head word (addr:24 | len:8).  The tag-link code is the SDK
 * addPrim()/setaddr()/getaddr() macro family over this bitfield -- the shape that cracked
 * libgpu P06.c AddPrim, where the hand-masked-OR spelling put the two mask constants in the
 * wrong registers.  Inside a LOOP the same lowering also fixes the LICM PREHEADER ORDER: a
 * bitfield store generates the masked VALUE (& 0xffffff) BEFORE the destination mask
 * (& 0xff000000), so loop.c hoists the two constants in retail's order (LO then HI); the
 * hand-written `dest & 0xff000000 | src & 0xffffff` OR generates HI first.  w44-a2 */
typedef struct { unsigned addr : 24, len : 8; } PSXFront_PTag;

/* ---- DrawGouraudShape  (psxfront.cpp:928, code lines 928-985) ---- */
/* ---- w44-a1 RESIDUAL 198 (count EXACT 245/245, frame 104 == SYM fsize, brcensus CLEAN) ----
 * MECHANISM (quantified from `tools/rtl_dump.py -dL`, loop 85..652, 170 real insns):
 *   loop.c hoists SIX movables where retail hoists ONE.  Its savings-1 verdicts here are
 *   life-driven with a razor at life 10:
 *     insn 191 regno 158 (life 16) = const 0x1F800004  -> MOVED   (retail: rematerialised in-loop)
 *     insn 205 regno 162 (life 12) = const 0x00FFFFFF  -> MOVED   (retail: hoisted, $t3)  <-- the only one retail hoists
 *     insn 210 regno 165 (life 10) = const 0xFF000000  -> MOVED   (retail: rematerialised in-loop)
 *     insn 269 regno 183 (life  1), 462 regno 245 (life 1) -> "not desirable"
 *   The two EXTRA hoisted constants are live across the in-loop GetClut call, so reload spills
 *   $t7/$t8 as well as $t1-$t6:  rove_op `sw 25v23  lw 30v28` == exactly TWO extra spill pairs.
 *   Kill those two hoists and the spill pairs vanish 1:1.
 * FALSIFIED this wave (all measured, gate + posdiff + rove_op):
 *   - bump-early (`prim = Render_gPacketPtr; Render_gPacketPtr = prim + 0x34;` adjacent) DOES kill
 *     both address hoists (life 16 -> 4) and both spill pairs (sw/lw census then MATCHES), but the
 *     lowered pressure also lets `vh`/`width` leave their AUTO slots: frame 104 -> 96 (SYM fsize is
 *     104) and the `lhu 18(s4); sh 24(sp)` vh re-read pair is CSE'd away -> 241/245, gate 230.
 *   - RMW operand-order swaps (4-way matrix): each swap alone removes ONE hoist (243 insns,
 *     gate 196-202); both together restore 245 but the hoist set is unchanged (gate 196).
 *   - bump-last / bump-after-pal: 243, gate 196-198.
 *   - `char`/`u_char` u,v,vh (to chase retail's QImode `sb t4,32(sp)` AUTO): 244, gate 285
 *     (confirms the w43 PROMOTE_MODE negative for this fn).
 *   - fresh-dest `sy` temp for the shapey load (retail `addu t4,v0,zero` + `addiu t4,v0,-1`): 246.
 * ---- UPDATE (same wave, after the a7 blocking-register-cascade forward: RE-TEST SHELVED
 *      NEGATIVES).  bump-early was shelved at 230 because it dropped the frame to 96; adding the
 *      SYM-fsize filler restores 104 and the SAME edit now gates 164 (was 198).  L1 state:
 *        - 0x1F800004 movable life 16 -> 4, DECLINED: the loop now rematerialises `lui;ori` at its
 *          top exactly like retail, and BOTH extra spill pairs are gone (rove_op sw/lw MATCH).
 *        - residual census: `lhu 9v10  sh 19v20` = the ONE `lhu 0x12(s4); sh 0x18(sp)` vh-AUTO pair
 *          retail keeps and we no longer emit (ours 241 vs 245).
 *        - the mask inversion is now SOLVED by addr24-EARLY (see the loop body): -dL's moved list is
 *          exactly {short-sign-extend pair, 0xFFFFFF, 2 address givs} = retail's.  164 -> 160.
 *          RMW operand-order swaps to trade the two masks' lives measured 174 (all three
 *          combinations) -- worse; the a4 do{}while(0) depth dial does NOT reach loop.c at all
 *          ("Loop from 189 to 248 is phony" -- the wrapper is recognised and stripped, hoist set
 *          byte-identical); volatile on the cursor read/write/both = no change (the movable is the
 *          CONSTANT insn, not the MEM); a7's unsized/sized asm-label views do not apply -- these are
 *          LITERAL scratchpad addresses, not symbols, so there is no %hi/%lo pseudo pair to remove.
 * NEW NAMED ANGLE #1 (vh): the filler is a stand-in.  The real fix is to make `vh` need memory --
 *   untried: give `vh` a second, later use inside the loop (retail reloads it per vertex row), or
 *   declare the three AUTOs in the SYM's slot order so reload's pseudo-regno slot assignment lands
 *   width@16/vh@24/v@32 without a filler (DECL POSITION IS THE FRAME LAYOUT, w41).  Note the filler
 *   is an ARRAY, so it is slotted at expand and steals 16(sp) -- every sp displacement is shifted by
 *   8; a NON-array 8-byte filler (or a real vh use) would also fix ~10 displacement diffs.
 * NEW NAMED ANGLE #2 (masks): with the addresses out of the movable set only TWO savings-1
 *   constants compete and the measured cut is life 10 (0xFF000000 moved at 10, 0xFFFFFF declined at
 *   7 under bump-early).  Aim 0xFFFFFF ABOVE 10 and 0xFF000000 BELOW: split the first RMW so the
 *   0xFFFFFF term is evaluated into its own named temp at the TOP of the loop body (addr24-EARLY,
 *   w41) while the 0xFF000000 term stays fused inside both RMW expressions -- that lengthens one and
 *   shortens the other independently, which the operand-order swaps could not do (they move BOTH).
 * NEW NAMED ANGLE (untried, for the next pass): the two goals are SEPARABLE -- kill the two address
 *   hoists WITHOUT lowering whole-loop pressure.  loop.c's verdict is per-movable LIFE, so shorten
 *   ONLY the 0x1F800004 and 0xFF000000 lives while ADDING an unrelated long-lived in-loop value to
 *   hold the frame at 104:  (a) bump-early PLUS a source-level pressure restorer -- e.g. keep the
 *   `vh` AUTO alive by re-reading `shp->height` at its USE site inside the loop (the oracle's
 *   `lhu`/`sh` pair) instead of before it; (b) split the 0xFF000000 term so its two uses sit
 *   adjacent (life <= 9 = the measured razor) while leaving 0xFFFFFF spanning the whole RMW block;
 *   (c) probe the razor directly per the w43 giv-worth recipe -- inject N dummy statements into a
 *   scratch copy and re-dump -dL to find the exact life cut, then aim each constant at it.
 */
/* GPU packet: builds POLY_GT4 (stride 0x34, code 0x3c); prim=u_char* build cursor, prevPrim=u_char* link word */
void DrawGouraudShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int *color,int abr)

{
  /* SYM 8c block: prim(POLY_GT4* $s0) width(AUTO -0x58) height($v1) u($s2) v($t4) vh(AUTO -0x50)
   * bpp($a1) i($s1) w($s5) w1($a1); addw(INT $a2) declared in the LOOP block @0x8004E2FC.
   * Params: shp=$s4 flags=$t6 x=$t2 y=$s7 color=$t5.  The old recon carried ~35 fabricated locals
   * and, critically, a NEVER-ASSIGNED `xoff` in the vertex-X math where the real `x` param belongs
   * (oracle $t2 = the x REGPARM copy) -- x was silently dropped from every emitted quad. w42-a7. */
  u_char  *prim;
  short    width;
  short    height;
  short    u;
  short    v;
  short    vh;
  short    bpp;
  short    i;
  int      w;
  short    w1;
  u_char   vraw;    /* MATCH (2026-08-03, angle #C' LANDED, 21->20 count-EXACT 245/245):
                     * retail's separate raw-shapey pseudo (`addu t4,v0,zero` +
                     * `addiu t4,v0,-1` both off $v0).  vraw alone measures 0 (cse
                     * copy-props `v = vraw`); the OUTLIVING SECOND CONSUMER is the
                     * zero-insn USE fence after the if/else -- make_regs_eqv keeps
                     * the copy because vraw now outlives v's birth on BOTH paths. */
  u_char   vb;      /* MATCH (w46-a1): retail gives `v` TWO homes -- $t4 for the
                     * prim[0xd]/prim[0x19] stores AND a byte slot 0x20(sp) reloaded
                     * into $t7 for the `vh + v` bottom row.  This second u_char copy
                     * IS that spilled pseudo; it supplies the third stack slot the
                     * retired `deadfrm[2]` filler used to fake (slots are now
                     * width@16 / vh@24 / v@32, frame 104 == SYM fsize, natively).
                     * u_char is load-bearing: `short` gates 37, `int` 38. */

  height = shp->height;
  width = shp->width;
  bpp = (byte)shp->depth;
  if ((flags & 2) != 0) {
    y = y + height;
    height = -height;
  }
  vraw = (byte)shp->shapey;
  v = vraw;
  vh = shp->height;
  /* 2026-08-02 INLINE ADDENDA (angle #1 measured, 3 falsifications + 2 ORACLE FACTS):
   * retail's vh pair is PRE-loop: `lhu $t8,0x12($s4)` with the spill `sh $t8,0x18($sp)`
   * in the flags&2 beqz DELAY SLOT, then ONE in-loop reload `lhu $t8,0x18($sp)` @8004E53C
   * feeding a single addu for both sb's => vh is a SPILLED PSEUDO (assigned pre-loop,
   * loses the callee-saved contest), not an in-loop re-read.  FALSIFIED: in-loop re-read
   * at use site (226 @239, vh leaves memory entirely, frame 96); in-loop re-read at loop
   * top (163 @242, register rotation); `(void)&vh` address-taken (195 @240 -- TREE_
   * ADDRESSABLE forces ALL accesses through memory, over-shoots).  LIVE ROUTE: ours has
   * only 9 call-crossing candidates so vh WINS a reg; retail had 10 -- find the 10th
   * crossing value (or demote vh's allocno below the 9th) without adding insns.
   * DISPOSITIONS MEASURED (-dg, 2026-08-02): our s-pool = s0:p86(prim) s1:p93 s2:p89
   * s3:p141 s4:p80(shp) s5:p94 s6:p115 s7:p83; arg-home-equiv pseudos ride t-regs
   * (p81>t5 p82>t3 p84>t4 p90>t2 = retail's SYM flags:$t6/x:$t2/color:$t5 pattern,
   * reload-served).  vh ~= p87 (3refs/166live, call-crossing) is ABSENT from the
   * dispositions -> gcc gave it REG_EQUIV to its defining `shp->height` MEM, so reload
   * re-reads lhu 0x12(s4) per use with NO sh -- retail instead has a REAL AUTO home
   * (sh 0x18(sp) + lhu reload).  So the question is not the s-pool contest at all:
   * it is why retail's vh pseudo did NOT get the REG_EQUIV-to-source-mem treatment
   * (update_equiv_regs requires a SINGLE def whose source mem is unchanged -- retail's
   * source must WRITE vh a second time, or read it through a shape that blocks the
   * equivalence: e.g. `vh = shp->height; if (flags&2) vh = vh;`-class second def, or
   * the height field aliased by the prim stores).  NEXT: a second CONDITIONAL def of
   * vh (mirroring the v-1 guard) breaks single-def REG_EQUIV at zero insn cost if the
   * arm folds -- same femenudefs update_equiv_regs family as the tGlobalMenuDefs this
   * question.
   * 🏆 ROOT UNIFIED (2026-08-02, labeled census in the addPrim basin): the WHOLE 120
   * cascades from ONE root -- retail keeps BOTH v (byte AUTO @32(sp)) and vh (half AUTO
   * @24(sp)) MEMORY-RESIDENT across the in-loop calls (spill sb/sh + per-region reloads,
   * v's reload feeding addu v0,t8,t7 with t7=lbu 32(sp)), freeing $t2 for x -- ours keeps
   * v LIVE IN $t2, displacing x->t3, mask->t4 (the 3-cycle), shifting bpp's slot 16->24,
   * and dropping the vh pair.  So the question is v's allocation, not vh's: why does
   * retail's v pseudo (8+ loop-weighted refs) get NO register?  Same allocator-exclusion
   * class as femenudefs `this`.  MEASURED here: sy-temp neutral (cse folds); deadfrm
   * filler still load-bearing in this basin (without it 192/frame-96).
   * SCALE-RECIPE PORTS FALSIFIED (2026-08-02): sb-tail depth dial 147 (promotes u/v/vh =
   * the WRONG side of the v-vs-x contest); aimed flags&4-arm wrapper 152 (the LOOP-NOTE
   * barrier inside the arm costs more than the x-rank gain).  The t2/t3/t4 3-cycle is
   * barrier-sensitive -- depth-dial family CLOSED for this fn; route = own permuter round
   * (queue after Font) or the instrumented-cc1 decision-trace instrument.
   * ---- w45-a1: 113 -> 103.  PERMUTER ROUND RUN (the wave's one job, ~7k iters, -j 2).
   * Its best (score 825) carried THREE semantically-valid mutations; bisected site-by-site
   * per the trust rules, TWO measured EXACTLY 0 on the gate and were rejected as scaffolding
   * (`nvi = 0x30; prim[nvi] = u+w1`, and `(texX & 0xffffffc0U) << 3 << 13`).  The whole gain
   * is the ONE honest shape now landed above: latch color[3] into `c3` BEFORE the tag stores.
   * 🏆 THE SLOT MAP IS NOW EXACT (ourdis vs oracle .s) -- this supersedes the guesswork above:
   *        ours                          retail (== SYM: width AUTO -0x58, vh AUTO -0x50)
   *   16   deadfrm[2] filler             width   (sh, halfword)
   *   24   width       (sh)              vh      (sh, halfword)
   *   32   vh          (sb, NARROWED)    v       (sb, caller-save byte slot)
   *   40-60 caller-save t1..t6           caller-save t1..t6   <-- BYTE-IDENTICAL, both builds
   *   ORACLE FACTS: retail loads shp->height TWICE (`lhu v1,0x12(s4)` for height, `lhu
   *   t8,0x12(s4)` for vh) and spills vh in the flags&2 `beqz` DELAY SLOT; it also keeps the
   *   raw shapey in its own pseudo (`addu t4,v0,zero` + `addiu t4,v0,-1`), where ours mutates
   *   the load's register in place.  Ours byte-NARROWS vh's spill (only consumer is a u_char
   *   store); retail keeps it HImode.  So retail has THREE memory-homed values (width/vh/v)
   *   and ours has TWO + an array filler -- and the filler, being an aggregate, is slotted at
   *   EXPAND and therefore STEALS 16(sp), pushing width and vh one slot down each.
   * 🔑 QUANTIFIED TARGET (allocno_compare, confirmed against tools/prio.py):
   *   ours  v=p90 refs 9 live 159 pri .1698 -> t2 | x=p82 refs 11 live 340 .0971 -> t3
   *         mask=p166 refs 7 live 153 .0915 -> t4     (handout is numeric-order by priority)
   *   retail wants x -> t2, mask -> t3, v -> t4, i.e. v must fall BELOW mask.
   *   The reachable points are floor_log2 STEPS (w44 ref-step family):
   *     v refs 9 -> 7  => .0881  < mask .0915   (refs 8 still .1509 -- the 8->7 step IS the cut)
   *     or x refs 11 -> 16 (.1882) AND mask 7 -> 9 (.1765), both above v .1698.
   *   v's 9 refs = 2 pre-loop defs + 4 in-loop uses at loop weight 2 minus cse merging; the
   *   two `vh + v` texts are ALREADY cse-merged pre-flow, so hoisting them into one temp does
   *   NOT remove a ref (measured: refs stayed 9, gate 113 -> 128).  A legal -2 must delete a
   *   whole in-loop USE, and all four (prim 0xd/0x19/0x25/0x31) are in the oracle.
   * FALSIFIED THIS WAVE (all re-gated from the NEW 103 basin, so not basin-stale):
   *   noflr 175 | noflr+vbot-before-call 239 | vbot-before-call+filler 259 | PTAG value-side
   *   plain-read 147 | bump-BETWEEN 165 | shift-split 103 (exactly 0) | nvi index 103 (0) |
   *   `int vbot` at the store site 128 | volatile vh read 113 (0 -- does NOT block the
   *   REG_EQUIV as hoped) | vh 2nd def `vh = -height` in the arm 186.
   * 🎯 NEW NAMED ANGLE #A (the strongest lead, UNTRIED as an attack base): the variant
   *   `noflr + vbot hoisted BEFORE the GetClut call` reaches **ours 244 vs oracle 245**,
   *   frame **104**, and slots **sh 16(sp) + sh 24(sp)** -- i.e. it reproduces retail's FRAME
   *   and BOTH halfword AUTOs at the exact retail offsets, and is 1 insn from count-exact.
   *   Its gate is worse (239) purely because the register rotation differs.  Attack the
   *   rotation FROM THAT BASIN rather than from this one: it already has the frame/slot
   *   structure that this basin can only fake with the aggregate filler.  Needed there: v's
   *   byte slot at 32(sp) (= one more memory-homed value) + the t2/t3/t4 assignment.
   * 🎯 NEW NAMED ANGLE #B: run a10's `tools/allocsim.py --solve p82=t2,p166=t3,p90=t4` on
   *   this fn's -dg/-dl dumps.  a10 validated the simulator's full 30/30 handout for exactly
   *   this function (v->t2/x->t3/mask->t4 reproduced), so its minimal (drefs, dlive) receipt
   *   is directly actionable; pair each required delta with the w44 zero-insn inflators
   *   (no-op re-mask / deliberate arm duplication / do{}while(0) depth) chosen for that pseudo.
   * ==== w45-a1 RESULT: 113 -> 103 -> 83.  THE v-ROOT ABOVE IS SOLVED. ====
   * The `prim[0x19] = prim[0xd]` read-back (see the MATCH note in the loop body) delivered
   * the simulator's required delta exactly (p90 refs 9 -> 7) and the handout is now RETAIL'S:
   * x -> $t2, mask -> $t3, v -> $t4.  Everything above about "the v-vs-x contest" is now
   * HISTORY -- do not re-grind it.  tools/prio.py + a10's allocsim both re-confirm the new
   * table; the ALLOCATION question is CLOSED for this function.
   * WHAT THE REMAINING 83 IS (re-measured, not inherited): ours 240 vs oracle 245 and a
   * STACK-SLOT displacement mismatch.  Retail has THREE memory-homed values (width@16,
   * vh@24 halfword, v@32 byte) and frame 104; ours has TWO (width@24, vh@32 byte-narrowed)
   * plus the aggregate filler that is slotted at EXPAND and therefore steals 16(sp).
   * Removing the filler DOES move width->16 and vh->24 (= retail) but drops the frame to 96,
   * which then shifts every prologue/epilogue and caller-save displacement (gate 155).  So
   * the ONE thing still missing is a THIRD genuine memory-homed value to occupy 32(sp) --
   * expand-time slots always sort below reload spill slots, so the filler can never be made
   * to land last from source; it has to be a real spilled pseudo instead.
   * 🎯 NEW NAMED ANGLE #A' (supersedes #A, now measured from the 83 basin): the variant
   *   `noflr + vbot hoisted before the GetClut call` is now **COUNT-EXACT 245/245** with
   *   frame **104** and both halfword AUTOs at **16/24(sp)** -- structurally the closest this
   *   function has ever been -- but its gate is 240 because the register assignment diverges
   *   wholesale.  That is a textbook PERMUTER MULTI-BASIN re-seed target (a structurally
   *   different base at a worse score, exactly the LocateNextGroupType/SetScreen pattern),
   *   and it is now cheap to aim: run a10's `tools/allocsim.py --solve` in THAT basin to get
   *   its per-pseudo required deltas first, then spend the permuter round there rather than
   *   in this basin (this basin's permuter round is SPENT -- see the harvest note above).
   * 🎯 NEW NAMED ANGLE #C: retail's separate raw-shapey pseudo (`addu t4,v0,zero`) is the
   *   w40 uncoalesced-temp identity -- model it as a real local COPIED FROM (`vraw`), noting
   *   make_regs_eqv keeps the copy only when it OUTLIVES its source.  (Scripted probe skipped
   *   this wave: the `v = (byte)shp->shapey;` anchor is NOT unique in the TU -- slice the file
   *   at this function's definition first.)
   * ==== w46-a1 RESULT: 83 -> 67 -> 37 -> 33 -> 21 (ours 244 / oracle 245).  THE SLOT MAP,
   *      THE SYM-fsize FILLER AND THE WHOLE ALLOCNO HANDOUT ARE CLOSED -- do not re-grind. ====
   * FOUR levers landed, in order (each verified whole-TU, 22 PASS, zero regressions):
   *  (1) 83->67  texX STATEMENT SPLIT: `ibp = (i * bpp) / 16; texX = shapex + ibp;`.
   *      Retail issues the mult/mflo/bgez/addiu-15/sra-4 divide chain BEFORE the `lhu
   *      0x18(s4)` shapex load (whose load-delay it then NOPs); the fused single expression
   *      let gcc hoist the load and fill the bgez slot with the sll.  (w43 "independent-chain
   *      issue order is fixed by STATEMENT SPLIT, not operand order" -- the bare operand swap
   *      `(i*bpp)/16 + shapex` only reaches 69.)
   *  (2) 67->37  FRESH-DEST `addwm1`: retail emits `addiu v1,a2,-1`, i.e. it keeps `addw`
   *      alive in $a2 and puts addw-1 in a FRESH $v1; our in-place `addw = addw - 1;`
   *      mutated $a1 and rotated the whole flags&4 arm's a-band down one register
   *      (ours {w1=a0,addw=a1,u+w1=v0} vs retail {w1=a1,addw=a2,u+w1=v1}).  Writing the
   *      decrement into a NEW local restores retail's entire a-band in one edit.
   *  (3) 37->33  `vb` = a SECOND u_char copy of `v` feeding ONLY the `vh + v` bottom row,
   *      + RETIREMENT of the `deadfrm[2]` SYM-fsize filler.  Retail gives `v` TWO homes --
   *      the register $t4 (feeds prim[0xd]/prim[0x19]) AND a byte stack slot 0x20(sp)
   *      reloaded into $t7 for `addu v0,t8,t7` -- so the "third memory-homed value" the
   *      w45 receipt said the filler could only FAKE is a real second pseudo.  With `vb`
   *      present the aggregate filler is unnecessary and the slot map is retail's NATIVELY:
   *      width@16 (sh/lhu), vh@24 (sh in the flags&2 beqz DELAY SLOT, lhu reload), v@32
   *      (sb/lbu), caller-save t1..t6 @40-60, frame 104 == SYM fsize.  `u_char` is
   *      load-bearing (short vb = 37, int vb = 38).
   * 🔴 BUG CAUGHT THIS WAVE (process, not code): the scripted `noflr` probe helper searched
   *   for the next `;` AFTER the filler decl's trailing comment and deleted through it,
   *   silently swallowing `height = shp->height;` -- an UNINITIALISED height read that the
   *   byte gate cannot see (it scored BETTER, 34, than the correct 33 form).  Caught only by
   *   reading `tools/ourdis.py` output against the oracle.  Scripted edits must delete an
   *   EXACT decl+comment span; and every probe win must be read, not just gated.
   *  (4) 33->21  ANGLE #D LANDED -- the $t4<->$t5 `v`-vs-`color` swap.  allocsim/reqdelta
   *      (validated 29/29 on the 33 basin) priced it EXACTLY: v = p90 refs 6 live 160
   *      pri .0750 vs color = p84 refs 9 live 338 .0798, and the minimal delta was
   *      `p90 refs 6 -> 7` -- ONE **non-loop** reference (an extra IN-LOOP use carries loop
   *      weight 2 -> refs 8 -> .1500, which vaults v back over x/mask and restores the OLD
   *      3-cycle; that is exactly why dropping the prim[0x19] read-back measures 47).
   *      Every cse-visible inflator measured EXACTLY 0 (`vb = v & 0xff` / `& 0xffff` /
   *      `(u_char)v`, `v = v - 1;` self-decrement in the arm, `vb = v | (v & 0)`, moving
   *      `vb = v;` after the arm).  What works is the w43 CROSS-JUMPED DUPLICATE applied
   *      OUTSIDE the loop: write `vb = v;` in BOTH arms of the flags&2 if/else.  cross_jump
   *      merges the two identical stores back into one insn (count unchanged, 244) but
   *      flow.c counts BOTH refs -> p90 hits 7 -> .0875, landing between color .0798 and
   *      mask .0915.  33 -> 21, and the extra `move v1,t4` cascade went with it.
   * REMAINING 21 (count 244 vs 245) -- named items:
   *   b. the vraw copy `addu t4,v0,zero` (angle #C) is STILL missing: `vraw` as short /
   *      u_char / byte all measure EXACTLY 0 (cse copy-props them, re-confirmed from the 21
   *      basin); `int vraw` adds the insn but costs 11 diffs (32).  make_regs_eqv keeps a
   *      copy only when it OUTLIVES its source -- here the source dies at the copy.
   *      🎯 ANGLE #C': give `vraw` a SECOND consumer that outlives v (e.g. the flags&2 arm
   *      reads vraw AND a later pre-loop statement does) -- untried.
   *   c. `-addu v0,s2,a1 / +addu v1,s2,a1` (`u + w1` lands in $v0, retail $v1) with the
   *      dependent `sb 0x18/0x30` pair; plus our extra `addu v1,t4,zero` before
   *      `sb v1,25(s0)` (the prim[0x19] read-back costs a copy where retail stores $t4
   *      twice -- still NET POSITIVE, removing it = 47).  🎯 ANGLE #F: this is now the ONLY
   *      register pair left; run reqdelta for it on a fresh dump of THIS basin.
   *      2026-08-03 MEASURED (20 basin): allocsim 30/30 on the fresh dump; vraw=p96 rides
   *      $v0 like retail; the u+w1 dest is NOT in the global table = a BLOCK-LOCAL QTY
   *      sharing its block with the read-back's forwarded-value copy (ours uw1->$v0,
   *      copy->$v1; retail uw1->$v1, no copy).  QTY birth-order probes ALL FALSIFIED:
   *      read-back statement moved before the 0x18 store 46 / named v2 temp born before
   *      46 / named v2 at site 20 (exactly 0 -- same pseudo) / named uw1 temp 67 @248
   *      (basin-retry of the old 78 -- still negative).  🎯 ANGLE #F': the block's qty
   *      ORDER must be read, not probed -- run the instrumented cc1 (C:/Temp/
   *      nfs4-instr-cc1, GCC_TRACE_ALLOC=1) on psxfront.i and read [qty_order]/
   *      [find_free_reg] for this block: if it is a <=3-qty block the broken-sort law
   *      applies and the dial is the 3<->4 boundary, not birth order.  (Draw is a C++
   *      trace-divergent fn -- use the trace for qty structure only, not bytes.)
   *   d. one `nop` + `sh s7,10(s0)` ordering and `sll v0,s5,16` vs `sll v0,a1,16` (ours
   *      tests `w`, retail `w1`).  `w1 = wsel` / dropping `w` = 168 (the two-variable
   *      w/w1 pair is load-bearing); `(int)w1` cast = 0; a `uw1` temp for `u + w1` = 78.
   * PERMUTER (the wave's one job, -j 2, TWO rounds, both bisected per the trust rules):
   *   round 1 seeded from the count-exact-245 `noflr + vbot-before-call` basin of angle #A'
   *   (~2000 iters, base 1420 -> best 1000).  Its best candidate carried exactly TWO valid
   *   mutations: `volatile int vbot;` and `prim - -0x10` (an encoding no-op).  Transplanted
   *   and gated in the real tree: volatile vbot = 122/53/71/138 depending on placement --
   *   REJECTED.  ⇒ angle #A' is now CLOSED: that basin is both worse AND permuter-spent.
   *   round 2 re-seeded from the 37 basin (base 485 -> best 470); its THREE distinct valid
   *   mutations were each transplanted and gated in the real tree:
   *     `prim[0x30] = (prim[0x18] = u + w1);`      -> 47  (rejected)
   *     `prim[0x25] = vb; prim[0x25] = vh + prim[0x25];` -> 21 (exactly 0 = scaffolding)
   *     a `u_char *nv = prim;` alias for the last three flags&4 stores + hoisting
   *     `*(short*)(prim+10) = y;` out of both arms  -> anchor-ambiguous, not landed
   *   i.e. 2 of 3 measured ZERO, the third negative -- the same "mostly incidental noise"
   *   ratio the w45 trust rules predict.  The `prim[0x30] = prim[0x18];` read-back variant
   *   is count-EXACT 245/245 at 34 -- parked as a second basin for a future round. */
  if ((flags & 2) != 0) {
    v = vraw - 1;
    vb = v;
  }
  else {
    vb = v;
  }
  __asm__ volatile("" : : "r"(vraw));   /* vraw's outliving consumer (see decl note) */
  /* PROBE FALSIFIED (2026-08-02): an identical `vh = shp->height;` 2nd def in the
   * flags&2 arm is CSE-DELETED before local-alloc (160 unchanged) -- breaking the
   * single-set REG_EQUIV needs a def cse cannot merge (volatile view / different
   * lvalue shape), each of which costs a real insn in the arm; measure vs the
   * missing-pair budget (+2) next pass.  Also PENDING: confirm p87==vh in the
   * lreg insn stream before further REG_EQUIV surgery. */
  i = 0;
  while (i < shp->width) {
    int addw;
    int texX;
    int wsel;
    int c3;
    int addwm1;
    int ibp;

    /* MATCH (w46-a1, 83->67): the divide chain is its OWN statement, so it gets the
     * lower luid and issues BEFORE the `lhu 0x18(s4)` shapex load whose load-delay
     * retail then NOPs.  The fused one-expression form hoists that load instead and
     * fills the bgez slot with the sll (83); the bare operand swap only reaches 69. */
    ibp = (i * bpp) / 16;
    texX = (uint)(ushort)shp->shapex + ibp;
    u = (i + ((int)((uint)(ushort)shp->shapex << 0x10) >> 0xc) / bpp) -
        ((int)((texX & 0xffffffc0U) << 0x10) >> 0xc) / bpp;
    wsel = 0xff - u;
    if (shp->width - i < wsel) {
      wsel = shp->width - i;
    }
    w = wsel;
    uint *pal;   /* w44-a1: retail keeps the palette-cursor POINTER in $a0 across both RMWs
                    (`lui a0,0x1F80; lw a0,0(a0)` once, then lw/lw/sw off $a0) -- 246 -> 245
                    count-EXACT.  The w43 "straight-line emitters want the purge" rule does NOT
                    apply in a LOOP: here the oracle caches (w43 loop-vs-straight-line row). */
    uint  addr24;

    prim = Render_gPacketPtr;
    Render_gPacketPtr = prim + 0x34;   /* bump-early: kills the 0x1F800004 movable's hoist (w44-a1), holds in the addPrim basin too (120 vs 182 for bump-between) */
    /* w44-a1 addr24-EARLY (w41 family): giving the 2nd RMW's 24-bit link term its OWN temp at
       the top of the loop body lengthens the 0xFFFFFF movable and shortens 0xFF000000 --
       INDEPENDENTLY, which the OR-operand swaps could not do (they move both).  -dL now shows
       the movable set retail has: 0xFFFFFF is the ONLY hoisted constant, both scratchpad
       addresses AND 0xFF000000 are rematerialised in-loop. */
    pal = (uint *)Render_gPalettePtr;
    /* EA-1998 addPrim(): P_TAG bitfield setaddr pair (house idiom). */
    ((PSXFront_PTag *)prim)->addr = ((PSXFront_PTag *)pal)->addr;
    ((PSXFront_PTag *)pal)->addr = (uint)prim;
    *(int *)(prim + 4) = color[0];
    *(int *)(prim + 0x10) = color[1];
    *(int *)(prim + 0x1c) = color[2];
    /* MATCH (w45-a1, permuter-derived then bisected to this ONE site): reading
     * color[3] into a named temp HERE -- before the prim[7]/prim[3] tag stores --
     * rather than at its store site.  Lengthening c3's live range across the tag
     * stores is what re-colors the region (113 -> 103, posdiff 63 -> 58); the
     * other two mutations in the permuter's score-825 candidate (a `nvi = 0x30`
     * index variable and a `<<3 <<13` shift split) measured EXACTLY 0 each and
     * were rejected as scaffolding.  Natural 1998 shape: latch the colour, then
     * build the packet header. */
    c3 = color[3];
    prim[7] = (flags & 1) * 2 + 0x3c;
    prim[3] = 0xc;
    *(int *)(prim + 0x28) = c3;
    *(short *)(prim + 0xe) = GetClut((shp->clutID & 0x3fU) << 4,shp->clutID >> 6);
    *(ushort *)(prim + 0x1a) =
         ((byte)shp->type & 3) << 7 | (abr & 3U) << 5 |
         (shp->shapey & 0x100) >> 4 |
         (texX & 0x3c0U) >> 6 | ((ushort)shp->shapey & 0x200) << 2;
    addw = 0;
    if (((flags & 4) != 0) && (shp->width < 0xff)) {
      u = u - 1;
      addw = 1;
    }
    w1 = w;
    prim[0xc] = u;
    prim[0xd] = v;
    prim[0x18] = u + w1;
    /* 🏆 MATCH (w45-a1) -- THE v-ROOT CRACK.  Vertex 1's V equals vertex 0's V, so the
     * quad's second row is written by READING BACK the byte just stored at prim[0xd]
     * rather than referencing `v` again (store-then-read-back, w40/w42 family: cc1
     * forwards the stored value, so this costs ZERO instructions -- count stays 240).
     * WHY IT IS LOAD-BEARING: it deletes one IN-LOOP use of `v`, and in-loop refs carry
     * loop weight 2, so v's REG_N_REFS drops 9 -> 7.  That crosses the floor_log2 step at
     * 8 (allocno_compare pri = floor_log2(refs)*refs/live): v .1698 -> .0881, which lands
     * BELOW mask (.0915) and x (.0971).  Since find_reg hands out caller-saved regs in
     * NUMERIC order by descending priority, the whole t2/t3/t4 3-cycle inverts to retail's:
     *     before  v->t2  x->t3  mask->t4        after  x->t2  mask->t3  v->t4
     * This delta was predicted independently two ways BEFORE it was written: by hand from
     * tools/prio.py, and by a10's validated allocator replica, which answered
     * `--solve 82=t2,167=t3,90=t4`  ->  `p90 refs 9 -> 7 (|d|=2)` -- a single-pseudo,
     * single-dial requirement.  103 -> 83. */
    prim[0x19] = prim[0xd];
    prim[0x24] = u;
    prim[0x30] = u + w1;
    prim[0x25] = vh + vb;
    prim[0x31] = vh + vb;
    if (w1 <= 0) {
      w1 = 1;
    }
    if ((flags & 4) != 0) {
      /* MATCH (w46-a1, 67->37): a FRESH DEST, never an in-place `addw = addw - 1;`.
       * Retail emits `addiu v1,a2,-1` -- addw stays live in $a2 -- whereas the in-place
       * mutate rotated the whole flags&4 arm's a-band down one register
       * ({w1=a0,addw=a1,u+w1=v0} ours vs {w1=a1,addw=a2,u+w1=v1} retail). */
      addwm1 = addw - 1;    /* materialized ONCE ($v1) -- writing `+ (addw - 1)` per site lets gcc
                             reassociate the -1 out and re-add addw at each vertex (w42-a7) */
      *(short *)(prim + 8) = ((width + x) - i) + addwm1;
      *(short *)(prim + 10) = y;
      *(short *)(prim + 0x14) = ((shp->width + x) - (i + w1)) + addwm1;
      *(short *)(prim + 0x16) = y;
      *(short *)(prim + 0x20) = ((shp->width + x) - i) + addwm1;
      *(short *)(prim + 0x22) = y + height;
      *(short *)(prim + 0x2c) = ((shp->width + x) - (i + w1)) + addwm1;
      *(short *)(prim + 0x2e) = y + height;
    }
    else {
      *(short *)(prim + 8) = i + x;
      *(short *)(prim + 10) = y;
      *(short *)(prim + 0x14) = w1 + (i + x);
      *(short *)(prim + 0x16) = y;
      *(short *)(prim + 0x20) = i + x;
      *(short *)(prim + 0x22) = y + height;
      *(short *)(prim + 0x2c) = w1 + (i + x);
      *(short *)(prim + 0x2e) = y + height;
    }
    i = i + w1;
  }
  return;
}

/* lines 986-990: (static data / macros / comments - no emitted code) */

/* ---- DrawFlatShape  (psxfront.cpp:991, code lines 991-994) ---- */
void DrawFlatShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int *color,int abr)

{
  int c0;

  c0 = *color;
  color[3] = c0;
  color[2] = c0;
  color[1] = c0;
  /* @0x8004E660: tail-call DrawGouraudShape with the SAME incoming args -- shp/flags/x/y/color/abr are
   * never modified in DrawFlatShape. The recon passed uninitialized Ghidra locals abrv/flagsv in the
   * flags/x slots, dropping the real flags and x parameters (M14). */
  DrawGouraudShape(shp,flags,x,y,color,abr);
  return;
}

/* lines 995-1059: (static data / macros / comments - no emitted code) */

/* ---- DrawShapeExtended  (psxfront.cpp:1060, code lines 1060-1084) ---- */
void DrawShapeExtended(int index,int flags,int x,int y,int fade,int abr,tDrawShapeExtended *extra)

{
  /* SYM: the only locals are tShp (REG) + color[4] (AUTO) -- there is NO `shapeTbl`.  Retail wrote
   * the table select as a real if/ELSE that lands `tShp = table + index` in each arm (oracle emits
   * `sll v0,index,5` in BOTH arms + a shared `addu s0,v1,v0` join, then recomputes it in the 0x200
   * arm), with flags&8 as the FALL-THROUGH side. w42-a7. */
  tTexture_ShapeInfo *tShp;
  int color [4];
  int bright;

  if ((flags & 8) != 0) {
    tShp = gHelpShapes[0] + index;
  }
  else {
    tShp = gCurrentShapes[0] + index;
  }
  bright = 0x80 - fade;
  if ((flags & 0x200) != 0) {
    tShp = extra->custom_shapes + index;
  }
  AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended(tShp,&x,&y,&flags,bright * 0x10000 >> 0x10,color,extra);
  /* retail polarity: the GOURAUD arm is the fall-through (`beqz v0` jumps to the flat arm) --
     brcensus beqz 2v3 / bnez 1v0 on BOTH twins was this one flip. w42-a7 */
  if ((flags & 0xc0U) != 0) {
    DrawGouraudShape(tShp,flags,x,y,color,abr);
  }
  else {
    DrawFlatShape(tShp,flags,x,y,color,abr);
  }
  return;
}

/* lines 1085-1088: (static data / macros / comments - no emitted code) */

/* ---- ScaleGouraudShape  (psxfront.cpp:1089, code lines 1089-1138) ---- */
/* ---- w44-a1: 157 -> 60 (count EXACT 175/175, frame 64 == oracle, brcensus + rove_op CLEAN,
 *      ALL NINE callee-saved registers now oracle-exact; posdiff first-use order IDENTICAL).
 * The three landed levers are commented at their sites (palette-pointer cache / late-born xm1 /
 * 0x20-store-last / batched width+height byte reads).  MECHANISM behind the register landing
 * (measured with tools/rtl_dump.py -dg -dl + tools/prio.py):
 *   block 4 owns THREE call-crossing local quantities -- the width sign-extend, the height
 *   sign-extend and `x-1`.  local_alloc hands out $s0,$s1,$s2 in REVERSE BIRTH ORDER, so retail's
 *   birth order (width-narrow, height-narrow, x-1) yields x-1=$s0, height-narrow=$s1,
 *   width-narrow=$s2 -- and only THEN can global_alloc give `height` $s1 and `width` $s2 (each
 *   dies exactly where its own narrow is born).  Naming `x-1` any earlier makes it born first, the
 *   height narrow takes $s0 (already owned by block 0's `abr`), `height` can no longer share it,
 *   and a 10th live value spills (177 insns, frame 72).  Measured for 8 spellings.
 *   The x-vs-y home is an allocno_compare razor: x 7 refs/99 live = .1414 beats y 7/110 = .1273,
 *   so x took the lower reg; moving the `prim+0x20 = x` store to the END lengthens x past y and
 *   flips the pair to retail's (x=$s6, y=$s5).  One ref less on x does it too, but the only way to
 *   drop that ref is to feed the 0x14 vertex from xm1 -- which re-triggers the early-birth spill.
 * RESIDUAL 60, three clusters:
 *   (a) ~13 diffs: `pal` and the 0xFFFFFF mask hold $a1/$a2 the other way round from retail.
 *       Both are block-0 local quantities; OR-operand swaps measured 58/60/70 (noise, not the
 *       mechanism), prim/pal statement swap = no change.
 *   (b) ~6 diffs: retail feeds BOTH right-edge vertices from $s0 (`addu v0,s0,v0` then
 *       `addu s0,s0,v0`); ours reassociates the inline `(x-1)` at 0x14 into `addiu v0,v0,-1;
 *       addu v0,s6,v0`.  Blocked by the birth-order constraint above.
 *   (c) ~7 diffs: the divide result / u / uw rotate $a1<->$v1 (`mflo a1` vs `mflo v1`) -- the
 *       w43 local_alloc qty birth-order + fresh-dest class, untried here.
 * NEW NAMED ANGLE: (b) and (c) are the SAME dial.  Retail's `x-1` is born late AND used twice, so
 *   it must be born late WITHOUT its def being scheduled up.  Untried lever: make the def's
 *   dependency chain shorter than the two sign-extends' so sched1 leaves it in place -- e.g. feed
 *   the 0x14 vertex from a SECOND named local initialised from xm1 (`xr = xm1;`) so the xm1 def
 *   itself keeps only ONE dependent chain, or split the two right-edge vertices into their own
 *   block scope.  For (a): dump -dl for block 0 and compare the pal/mask quantity lifetimes --
 *   the pair is a two-quantity tie of exactly the kind the w43 birth-order row cracks.
 * 2026-08-02 INLINE SESSION ADDENDA (measured):
 *   - ORACLE FACT: retail's `prim+0x20 = x` store is MID-sequence (call-2's delay slot, between
 *     the 0x16 and 0x22 statements), NOT at the end -- and retail feeds BOTH right-edge vertices
 *     from ONE late-born x-1 in $s0 (`addu v0,s0,v0` @0x14, then in-place `addu s0,s0,v0` @0x2c).
 *   - FALSIFIED x2: full retail statement order (xm1 stmt before 0x14, 0x20 mid) = 177/frame-72
 *     early-birth spill, AND the embedded-def form `fixedmult(..) + (xm1 = x - 1)` = SAME 177 --
 *     cc1 expands the call-free operand FIRST regardless of side (expand_expr saves nothing
 *     across the call), so xm1's addiu always lands pre-call-1 from source.  Retail's late
 *     `addiu s0,s6,-1` (after call 1, after the height sign-extend) is a SCHED1 SINK of a
 *     low-priority def that OUR sched instead hoists as a delay-slot filler => the reachable
 *     dial is sched-pressure around call 1, not statement position.  Block-0 (a) tie measured:
 *     pal p97 4refs/19live=.421 -> $a1, mask p105 3refs/23live=.130 -> $a2; retail needs the
 *     mask FIRST -- mask cannot reach .421 at 3 refs (needs live<=7); pal cannot drop below
 *     mask without losing the cache shape => (a) is priority-inversion territory, permuter or
 *     a 4th mask ref.  Field-reads-before-prim/pal statement order: NEUTRAL (60).
 */
/* GPU packet: builds POLY_GT4 (stride 0x34, SetPolyGT4); prim=u_char* build cursor, prevPrim=u_char* link word */
void ScaleGouraudShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int scalex,int scaley,int *color,
               int abr)

{
  /* SYM 8c block: prim(POLY_GT4* $s3) width($s2) height($s1) u/v/uw/vh (CHAR) bpp(AUTO SHORT
   * @sp+0x10) + the color/abr REG copies -- 9 locals, not the 28 the old recon declared.
   * x($s6) and y($s5) are the REGPARMs, MUTATED IN PLACE by the flip arms; width/height likewise
   * (`negu $s2,$s2`).  The bpp divide is SIGNED (div + break 7 + break 6). w42-a7 */
  u_char  *prim;
  short    width;
  short    height;
  short    bpp;
  char     u;
  char     v;
  char     uw;
  char     vh;
  int      xm1;
  int      one;   /* permuter find (score 620->305): the shared -1 subtrahend is a
                   * NAMED constant materialized ONCE between the SetSemiTrans and
                   * GetClut calls -- it lives in a reg across the calls like retail. */
  uint    *pal;   /* w44-a1 MATCH: retail holds the PALETTE-CURSOR POINTER in $a2 across the whole
                     RMW pair (`lui a2,0x1F80; lw a2,0(a2)` ONCE, then `lw v1,0(a2)` / `lw v0,0(a2)` /
                     `sw v0,0(a2)`).  Reading the scratchpad literal `Render_gPalettePtr` three times
                     makes cc1 reload the POINTER after the may-aliasing `*prim` store (+1 insn) --
                     the straight-line-emitter purge rule does NOT apply here (w43 loop-vs-
                     straight-line row): the oracle caches.  176 -> 175 = COUNT-EXACT. */

  prim = Render_gPacketPtr;
  pal = (uint *)Render_gPalettePtr;
  width = shp->width;
  height = shp->height;
  bpp = (byte)shp->depth;
  /* EA-1998 addPrim(): P_TAG bitfield setaddr pair, bump between (house idiom). */
  ((PSXFront_PTag *)prim)->addr = ((PSXFront_PTag *)pal)->addr;
  Render_gPacketPtr = prim + 0x34;
  ((PSXFront_PTag *)pal)->addr = (uint)prim;
  *(int *)(prim + 4) = color[0];
  *(int *)(prim + 0x10) = color[1];
  *(int *)(prim + 0x1c) = color[2];
  *(int *)(prim + 0x28) = color[3];
  SetPolyGT4((POLY_GT4 *)prim);
  SetSemiTrans(prim,flags & 1);
  one = 1;
  *(short *)(prim + 0xe) = GetClut((shp->clutID & 0x3fU) << 4,shp->clutID >> 6);
  *(ushort *)(prim + 0x1a) =
       ((byte)shp->type & 3) << 7 | (abr & 3U) << 5 |
       (shp->shapey & 0x100) >> 4 |
       ((ushort)shp->shapex & 0x3c0U) >> 6 | ((ushort)shp->shapey & 0x200) << 2;
  if ((flags & 4U) != 0) {
    x = x + fixedmult(scalex,width);
    width = -width;
  }
  if ((flags & 2U) != 0) {
    y = y + fixedmult(scaley,height);
    height = -height;
  }
  *(short *)(prim + 8) = x;
  *(short *)(prim + 10) = y;
  *(short *)(prim + 0x14) = (x - one) + fixedmult(scalex,width);
  *(short *)(prim + 0x16) = y;
  *(short *)(prim + 0x20) = x;
  *(short *)(prim + 0x22) = y + fixedmult(scaley,height);
  xm1 = x - one;
  xm1 = xm1 + fixedmult(scalex,width);
  *(short *)(prim + 0x2c) = xm1;
  *(short *)(prim + 0x2e) = y + fixedmult(scaley,height);
  {
    /* w44-a1 MATCH: retail BATCHES the two byte field reads (`lbu a2,0x10(s4)` = width,
       `lbu a0,0x12(s4)` = height) ahead of the u/v flip guards so `vh = v + height` can be an
       IN-PLACE mutation of v's register right after the two v stores (`addu v0,v0,a0`).  Reading
       the fields at their use sites sinks the height load past the u/uw stores and re-orders the
       whole sb run (36/48/37/49 instead of retail's 36/37/48/49). */
    int sw = (byte)shp->width;
    int sh_ = (byte)shp->height;
    u = (((ushort)shp->shapex & 0x3f) << 4) / bpp;
    v = (byte)shp->shapey;
    if ((flags & 4U) != 0) {
      u = u - one;   /* 2026-08-02: == re-divide spelling and == kept-q-temp spelling (all 32,
                    * copy-prop folds); kept as the simplest.  Retail's mflo-v1/u-a1 mirror
                    * is not spelling-reachable -- allocator identity. */
    }
    uw = u + sw;
    if ((flags & 2U) != 0) {
      v = (byte)shp->shapey - one;
    }
    prim[0xd] = v;
    prim[0x19] = v;
    vh = v + sh_;
    prim[0xc] = u;
    do {   /* permuter r2 find (score 230->175): depth dial on the sb tail -- doubles
            * the loop-weighted refs of u/uw/vh for the caller-save contest */
      prim[0x18] = uw;
      prim[0x24] = u;
      prim[0x25] = vh;
      prim[0x30] = uw;
      prim[0x31] = vh;
    } while (0);
  }
  return;
}

/* lines 1139-1142: (static data / macros / comments - no emitted code) */

/* ---- ScaleFlatShape  (psxfront.cpp:1143, code lines 1143-1146) ---- */
void ScaleFlatShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int scalex,int scaley,int *color,
               int abr)

{
  int c0;
  
  c0 = *color;
  color[3] = c0;
  color[2] = c0;
  color[1] = c0;
  ScaleGouraudShape(shp,flags,x,y,scalex,scaley,color,abr);
  return;
}

/* lines 1147-1204: (static data / macros / comments - no emitted code) */

/* ---- ScaleShapeExtended  (psxfront.cpp:1205, code lines 1205-1230) ---- */
void ScaleShapeExtended(int index,int flags,int x,int y,int fade,int abr,tDrawShapeExtended *extra)

{
  /* SYM: scalex/scaley are REAL INT locals ($s2/$s3 -- the oracle materializes 0x20000/0x10000 into
   * callee-saved regs in the prologue and passes THOSE at both call sites), tShp REG, color[4] AUTO.
   * No `shapeTbl`: the table select is an if/ELSE assigning tShp per arm (flags&8 = fall-through). */
  tTexture_ShapeInfo *tShp;
  int scalex = 0x20000;
  int scaley = 0x10000;
  int color [4];
  int bright;

  if ((flags & 8) != 0) {
    tShp = gHelpShapes[0] + index;
  }
  else {
    tShp = gCurrentShapes[0] + index;
  }
  bright = 0x80 - fade;
  if ((flags & 0x200) != 0) {
    tShp = extra->custom_shapes + index;
  }
  AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended(tShp,&x,&y,&flags,bright * 0x10000 >> 0x10,color,extra);
  if ((flags & 0xc0U) != 0) {
    ScaleGouraudShape(tShp,flags,x,y,scalex,scaley,color,abr);
  }
  else {
    ScaleFlatShape(tShp,flags,x,y,scalex,scaley,color,abr);
  }
  return;
}

/* lines 1231-1235: (static data / macros / comments - no emitted code) */

/* ---- LoadAllHelpShapes  (psxfront.cpp:1236, code lines 1236-1260) ---- */
void LoadAllHelpShapes(void)

{
  char *f;
  int i;
  int index;
  char *permFile;
  char fullName [48];
  
  sprintf(fullName,"%szperm.psh",Paths_Paths[0x20]);
  f = (char *)loadshapeadr(fullName,(void *)0x0);
  if (f != (char *)0x0) {
    index = 0;
    do {
      FETexture_LoadPmx(f,index,gHelpShapes[0] + index);
      index = index + 1;
    } while (index < 0x3b);
    purgememadr(f);
  }
  return;
}

/* lines 1261-1337: (static data / macros / comments - no emitted code) */

/* ---- PSXDrawSquare  (psxfront.cpp:1338, code lines 1338-1349) ---- */
/* GPU packet: builds POLY_F4 (stride 0x18, code 0x28); prim=u_char* build cursor, prevPrim=u_char* link word */
void PSXDrawSquare(int col,int x,int y,int w,int h)

{
  /* SYM 8c: fsize=0 mask=0 = TRUE frameless LEAF; the ONLY local is `prim` (REG $8 = $t0,
   * type PTR STRUCT POLY_F4 size 24) and `h` gets a REG home ($0xd = $t5).  x_s/x1/y1/linkAddr/
   * prevPrim were FABRICATED -- retail stores straight out of the parm regs ($a1 x, $a2 y->y+h,
   * $a3 x+w mutated in place) and lets cse hold the OT-slot POINTER in one anonymous temp while
   * DE-referencing it twice (the 1st setaddr store may alias).  w43-a3 */
  POLY_F4 *prim;
  uint link;

  prim = (POLY_F4 *)Render_gPacketPtr;
  /* setaddr(prim, getaddr(OT)) -- 24-bit tag bitfield RMW */
  prim->tag = prim->tag & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
  /* The OT word is RE-READ for the second setaddr (the store above may alias it), and that read
   * happens BEFORE the packet-cursor store: gcc cannot float a load above a may-aliasing store to
   * 0x1F800004, so the oracle's `lw v0,0(t2); ...; sw v1,0(t4); ...; sw v0,0(t2)` order is only
   * reachable if the source reads the OT word first.  Bump-between / bump-first / `+= 0x18`
   * spellings all measured worse (52 / 34 / 31 vs 12 for bump-last).  w43-a3 */
  link = *(uint *)Render_gPalettePtr;
  Render_gPacketPtr = (u_char *)prim + 0x18;
  *(uint *)Render_gPalettePtr = link & 0xff000000 | (uint)prim & 0xffffff;
  *(int *)&prim->r0 = col;
  prim->code = 0x28;
  *((u_char *)prim + 3) = 5;
  prim->y0 = y;
  prim->y1 = y;
  prim->x0 = x;
  prim->x1 = x + w;
  prim->x2 = x;
  prim->y2 = y + h;
  prim->x3 = x + w;
  prim->y3 = y + h;
  return;
}

/* lines 1350-1353: (static data / macros / comments - no emitted code) */

/* ---- PSXDrawGouraudSquare  (psxfront.cpp:1354, code lines 1354-1368) ---- */
/* GPU packet: builds POLY_G4 (stride 0x24, SetPolyG4); prim=u_char* build cursor, prevPrim=u_char* link word */
void PSXDrawGouraudSquare(int x,int y,int w,int h,int c1,int c2,int c3,int c4)

{
  /* SYM 8c: the ONLY local is prim (REG $0x10 = $s0, PTR STRUCT size 36 tag POLY_G4);
   * x/y/w/h are REGPARM $s3/$s1/$s2/$s4 and c1..c4 REG $a3/$t0/$t1/$t2.  linkAddr,
   * x_s, y_s, x_plus_w and y_plus_h were Ghidra fabrications: retail MUTATES the w
   * and y params in place (addu $s2,$s3,$s2 / addu $s1,$s1,$s4) and lets the `sh`
   * stores do the narrowing -- no (short) casts, no extra pseudos. */
  uint     otWord;
  POLY_G4 *prevPrim;
  POLY_G4 *prim;

  prim = (POLY_G4 *)Render_gPacketPtr;
  prevPrim = (POLY_G4 *)Render_gPalettePtr;
  prim->tag = prim->tag & 0xff000000 | prevPrim->tag & 0xffffff;
  otWord = prevPrim->tag;
  Render_gPacketPtr = (u_char *)prim + 0x24;
  prevPrim->tag = otWord & 0xff000000 | (uint)prim & 0xffffff;
  *(int *)&prim->r0 = c1;
  *(int *)&prim->r1 = c2;
  *(int *)&prim->r2 = c3;
  *(int *)&prim->r3 = c4;
  SetPolyG4(prim);
  prim->x0 = x;
  prim->y0 = y;
  prim->x1 = x + w;
  prim->y1 = y;
  prim->x2 = x;
  prim->y2 = y + h;
  prim->x3 = x + w;
  prim->y3 = y + h;
  return;
}

/* lines 1369-1376: (static data / macros / comments - no emitted code) */

/* (PSXFront_PTag typedef moved above DrawGouraudShape, 2026-08-02 EA-style sweep) */

/* ---- PSXDrawTransGouraudSquare  (psxfront.cpp:1377, code lines 1377-1398) ---- */
/* GPU packet: builds POLY_G4 (stride 0x24, code 0x39); prim=u_char* build cursor, prevPrim=u_char* link word */
void PSXDrawTransGouraudSquare(int x,int y,int w,int h,int opacity,int c1,int c2,int c3,int c4)

{
  /* SYM: opacity/c1..c4 (ARG->REG copies), prim (POLY_G4*), i (INT).  🔴 `opacityv` was NEVER
   * ASSIGNED and stood in for the real `x` param in all four packed vertex words (oracle $t5 = the
   * x REGPARM copy) -- every quad got a garbage X.  LICM hoists the two (x+w) words. w42-a7 */
  int      i;
  POLY_G4 *prevPrim;
  POLY_G4 *prim;

  i = 0;
  if (0 < opacity) {
    do {
      prim = (POLY_G4 *)Render_gPacketPtr;
      prevPrim = (POLY_G4 *)Render_gPalettePtr;
      i = i + 1;
      /* setaddr(prim, getaddr(OT)) / setaddr(OT, prim) -- the P_TAG 24-bit bitfield
       * stores.  The VALUE side must NOT be a bitfield READ (`((PTag *)prevPrim)->addr`):
       * that masks twice, lifting the 0xffffff allocno's loop-weighted ref count 5 -> 7
       * past the `i` counter's .2745 and stealing its $t0 (measured 14 diffs).  w44-a2 */
      ((PSXFront_PTag *)prim)->addr = prevPrim->tag;
      Render_gPacketPtr = (u_char *)prim + 0x24;
      ((PSXFront_PTag *)prevPrim)->addr = (uint)prim;
      *(int *)&prim->r0 = c1;
      *(int *)&prim->r1 = c2;
      *(int *)&prim->r2 = c3;
      *(int *)&prim->r3 = c4;
      prim->code = 0x39;
      ((u_char *)prim)[3] = 8;
      *(uint *)&prim->x0 = y << 0x10 | x;
      *(uint *)&prim->x2 = (y + h) << 0x10 | x;
      *(uint *)&prim->x1 = y << 0x10 | (x + w);
      *(uint *)&prim->x3 = (y + h) << 0x10 | (x + w);
    } while (i < opacity);
  }
  return;
}

/* lines 1399-1403: (static data / macros / comments - no emitted code) */

/* ---- PSXDrawTransSquare  (psxfront.cpp:1404, code lines 1404-1416) ---- */
/* GPU packet: builds POLY_F4 (stride 0x18, code 0x2a); prim=u_char* build cursor, prevPrim=u_char* link word */
void PSXDrawTransSquare(int col,int x,int y,int w,int h,short opacity)

{
  /* SYM locals: h (ARG->REG copy), prim (POLY_F4 *), i (SHORT). Everything else the old recon
   * declared was fabricated -- including `xv`/`yv`, which were NEVER ASSIGNED and fed the vertex
   * stores in place of the real x/y params (oracle: $t5=$a1=x, $t6=$a2=y). w42-a7. */
  short i;
  POLY_F4 *prevPrim;
  POLY_F4 *prim;

  i = 0;
  if (0 < opacity) {
    do {
      prim = (POLY_F4 *)Render_gPacketPtr;
      prevPrim = (POLY_F4 *)Render_gPalettePtr;
      i = i + 1;
      /* setaddr(prim, getaddr(OT)) / setaddr(OT, prim) -- the full P_TAG bitfield
       * addPrim() shape.  Here the value side IS a bitfield READ (unlike
       * PSXDrawTransGouraudSquare, which needs the plain word): the second 0xffffff mask
       * is what lifts that constant's loop-weighted allocno onto retail's $t0 ahead of
       * the (y+h) vertex value.  Probe: plain-word value 14, hand-masked OR 22/34.  w44-a2 */
      ((PSXFront_PTag *)prim)->addr = ((PSXFront_PTag *)prevPrim)->addr;
      Render_gPacketPtr = (u_char *)prim + 0x18;
      ((PSXFront_PTag *)prevPrim)->addr = (uint)prim;
      *(int *)&prim->r0 = col;
      prim->code = 0x2a;
      ((u_char *)prim)[3] = 5;
      prim->x0 = x;
      prim->y0 = y;
      prim->x1 = x + w;
      prim->y1 = y;
      prim->x2 = x;
      prim->y2 = y + h;
      prim->x3 = x + w;
      prim->y3 = y + h;
    } while (i < opacity);
  }
  return;
}

/* lines 1417-1433: (static data / macros / comments - no emitted code) */

/* ---- FontUpsideDownBlit  (psxfront.cpp:1434, code lines 1434-1466) ---- */
/* GPU packet: builds POLY_FT4 (stride 0x28, code 0x2c); prim=u_char* build cursor, prevPrim=u_char* link word */
void FontUpsideDownBlit(int x,int y,void *src,int u,int v,charactertbl *ch,int arg6)

{
  /* SYM 8c block: prim (POLY_FT4*), width, height, dv -- all INT -- plus the v/ch REG copies.
   * 🔴 ch->yoffset is read with `lb` in retail (SIGNED) -- this build's plain `char` is unsigned,
   * so it needs an explicit (signed char); and retail never doubles it: the top-Y is built as
   * (y - yoff + 5) - (height + yoff), keeping `height + yoff` as its own shared term. w42-a7
   * ---- w43-a2 residual 68 (count EXACT 82/82, brcensus clean, rove_op clean) ----
   * The whole fn is ONE basic block (no branches), so local_alloc decides every home and the
   * residual is a single register rotation: ytop lands in $a1 (gcc reuses the dying `y` REGPARM)
   * where retail uses a fresh $t8, which then frees $a1 for the SECOND `src+0xc` read (retail
   * `lw a1,12(a2)`; ours self-temps `lw a2,12(a2)`) and flips the $v0/$v1 roles of the second
   * OT-link chain vs the font_tint load.  MEASURED NEGATIVE (all re-gated): ytop as one/two/three
   * named locals, fully inlined at all 4 use sites, `ybase+5` as its own MODIFY_EXPR statement,
   * `5 + (y-yoff)`, `(y+5)-yoff`, hoff computed first, hoff mutated into `yoff` in place, the
   * ytop computation deferred to 4 different later statement positions, a named local for the
   * second `src+0xc` read, and 5 positions for the font_tint store (the between-prim[3]-and-
   * prim[7] slot below is the best of those, 72->68).  gcc folds `(A+5)-B` to `A-(B-5)` through
   * every spelling tried, so the `addiu t4,t4,-5` vs retail's `addiu v1,t8,5` rides along.
   * ---- w44-a2 residual 64 (count still EXACT 82/82) ----
   * STATEMENT POSITION is the live lever here, not expression shape: a greedy per-statement
   * position hill-climb (scratch/font_climb_a2.py -- every movable statement x every slot)
   * took 68 -> 66 (font_tint store moved BELOW the gFontClut store) -> 64 (`width = ch->width;`
   * hoisted to the very top, ahead of `prim = Render_gPacketPtr;`), then plateaued over all 14
   * movable statements.  Then a10's SPREAD-THE-USES relay took 64 -> 60: move ONE USE (not the
   * def) toward the top of the block -- `prim[0xc] = u;` hoisted to slot 2.  Re-running the climb
   * with EVERY statement movable (scratch/font_climb2_a2.py) then took 60 -> 56 (the prim+0x16
   * tpage word up to slot 18) -> 52 (font_tint store to slot 13) -> 50 (the prim+0x1a ytop store
   * to slot 22); it was still descending when the wave's time cap stopped it, so RESUME THAT
   * CLIMB FIRST next pass -- position, not spelling, is what is moving this function.
   * ---- 2026-08-02 INLINE: climb RESUMED (tools/stmtclimb.py); its round-1 '46' move was
   * BOGUS -- it moved the `ytop = (ybase+5) - hoff;` DEF past the prim+0x1a store that READS
   * ytop (use-before-def, uninitialized store; the gate can't see semantics).  REVERTED --
   * honest converged baseline = 50.  ⚠️ stmtclimb is DATAFLOW-BLIND: any accepted move must
   * be def-use audited before adoption (tool TODO: reject moves that lift a def past a use).
   * ---- w45-a1: the climb is CONVERGED, not "still descending".  Re-ran the full
   * single-move neighbourhood under a NEW def-use-guarded climber (tools/stmtclimb2.py,
   * which parses the fn's locals, derives per-statement (defs,uses) and REJECTS any order
   * that uses a local before defining it -- validated: it accepts the baseline order and
   * rejects exactly the `ytop`-def-past-its-use move that w45 had to revert by hand).  It
   * found NOTHING: the best body is byte-identical to this one.  Since the guard can only
   * REMOVE candidates the unguarded climb already tried, 50 is a true single-move local
   * optimum and w44's "still descending when the cap hit" note is CLOSED -- the descent had
   * already terminated; its apparent continuation was the invalid move.
   * Residual 50 = the receipted emission-order + one-hard-register-short; route = permuter
   * multi-basin or compound multi-move (COMPOUND is now the only unexplored positional
   * neighbourhood: every SINGLE move is exhausted, so the next pass should climb PAIRS of
   * statements -- restrict the pair search to the ~8 statements the receipt names as
   * emission-order-relevant (the font_tint store, the two OT-link RMWs, the dv chain, the
   * prim+0x16 tpage word) to keep it O(8^2 * slots) rather than O(34^2 * slots)).  a10's zero-insn
   * REF-STEP INFLATOR (no-op `& 0xffff` re-mask) measured NEUTRAL on all four ytop/(ytop+height)
   * store sites and on width (64 -> 64); on ybase it costs an insn (65/83).
   * ALSO MEASURED NEGATIVE this wave (all re-gated): the P_TAG 24-bit
   * bitfield addPrim spellings that cracked BOTH PSXDrawTrans*Square (72 / 132), dropping the
   * `prevPrim` local for inline Render_gPalettePtr (79), the cursor bump hoisted to 4 earlier
   * slots (80 / 124), `dv` deferred past the link block (78 insns -- cse then MERGES the two
   * src+0xc loads the oracle keeps SEPARATE, so dv must stay early), ytop via embedded
   * MODIFY_EXPR / two statements / in-place mutation / a named `five` (80-88), inlining the
   * yoff+ybase+hoff+ytop temps per the SYM local list (68-109), and the permuter's own
   * score-755 candidate (gates 89 -- scorer/gate disagreement, cf. tools/PERMUTER.md).
   * MECHANISM: this is NOT a register rotation -- an a1<->t8 permblind swap only takes 68->62
   * and posdiff's alpha-renamed LCS is 15/82, so most of the residual is EMISSION ORDER inside
   * the single block: retail issues the packet-cursor store + the first OT-link RMW BEFORE the
   * dv chain and hoists `and t3,t1,t3` (linkAddr) + `lui %hi(font_tint)` ABOVE the first `sw`,
   * while ours runs the dv chain first and emits both after it.  Ours also runs ONE HARD
   * REGISTER SHORT (15 vs 16 first-use registers): retail keeps ybase/ytop in a fresh $t8 and
   * (ybase+5) in $v1, ours folds the +5 into hoff and mutates the dying `y` REGPARM in place,
   * which frees $a1 so the 2nd src+0xc read self-temps into $a2 instead of retail's $a1.
   * ==== w46-a1: 50 -> 48.  THE QTY LAYER IS NOW INSTRUMENTED -- read this before touching it.
   * LANDED (the only mover): `ybase = ybase + 5;` as its OWN statement, mutating ybase in
   *   place, then `ytop = ybase - hoff;`.  w45 §C says fold's constant reassociation
   *   (`(A+5)-B -> A-(B-5)`) is STATEMENT-GRANULAR -- parentheses do nothing.  w43 had
   *   measured "`ybase+5` as its own MODIFY_EXPR" NEGATIVE; that falsification was
   *   BASIN-RELATIVE and is now retired (`ybase = y - yoff + 5` in two statements = 48 too;
   *   a THIRD named local `ybase5` = 50; `ybase - (hoff - 5)` = 50).
   * 🔬 THE QTY PRIORITY TABLE (new tool `tools/qtyprio.py`; this fn has ZERO global allocnos,
   *   so §A0's `QTY_CMP_PRI == allocno_compare` governs everything).  50 quantities; the
   *   contested ones, with `floor_log2(refs)*refs/live`:
   *     p96  ytop        refs 4 live 25  .3200 -> $a1   (retail: $t8)
   *     p94  ybase       refs 4 live 27  .2963 -> $a1
   *     p128 2nd src+0xc refs 3 live 21  .1429 -> $a2   (retail: $a1)
   *     p111 0xFF000000  refs 3 live 28  .1071 -> $t5
   *     p106 0x00FF0000  refs 3 live 27  .1111 -> $t3
   *     p87  prim        refs 26 live 69 1.5072 -> $t1  (== retail)
   *     p84  ch (stack)  refs 2  live 74 .0270 -> $s0   (allocated LAST; the LOWEST priority
   *                                                      qty takes the callee-saved reg --
   *                                                      the §A0 proof, reproduced here)
   *   ⇒ THE REQUIRED DELTA IS ONE STEP, EITHER SIDE OF ONE RAZOR:
   *     (a) p128 refs 3 -> 4  (floor_log2 1->2: .1429 -> 2*4/21 = .3809) clears ytop's .3200,
   *         so the 2nd src+0xc read is allocated first and takes $a1 = retail's `lw a1,0xC(a2)`,
   *         forcing ybase/ytop off $a1; or
   *     (b) p96 refs 4 -> 3  (.3200 -> 1*3/25 = .1200) or live 25 -> >56, dropping ytop below
   *         p128 from the other side.
   * FALSIFIED FROM THE 48 BASIN (all re-gated; the basin is stated per the w45 law):
   *   - ONE variable carrying y-yoff -> +5 -> -hoff (a single long qty, which is what retail's
   *     58-insn $t8 range looks like): 62 / 60 -- WORSE, the long qty does not sink far enough.
   *   - ytop ref-DELETERS (the w45 store-read-back that cracked DrawGouraudShape):
   *     `prim+0x22 <- prim+0x1a` and `prim+0x12 <- prim+10` each cost a REAL insn here
   *     (83/84 insns, gate 109/101/110) -- cc1 forwards a just-stored BYTE, not a halfword.
   *   - p128 inflators: naming the 2nd read in a local `src2` = 48 (exactly 0), `| (src2 & 0)`
   *     = 48 (fold kills it), a triple re-mask = 58.
   * 🎯 NEW NAMED ANGLE #E: the +1 ref on p128 must be created where cse/fold CANNOT merge it.
   *   The one shape not yet tried is the w43/w44 CROSS-JUMPED DUPLICATE (`flow.c` counts both
   *   arms while cross_jump merges the code): wrap the tpage word in a two-arm if/else whose
   *   arms are textually identical apart from a term that re-reads `src+0xc`.  Second, cheaper
   *   route: shorten p128's LIVE range instead of raising its refs (.1429 -> >.32 needs live
   *   21 -> <=9), i.e. move the tpage word's two uses adjacent to the read.
   *   2026-08-05 #E round 3: the w47 IDENTITY FENCE on a named src2 (the one cse-proof
   *   +1-ref device the earlier probes predate) = 78@82 -- the mono-block bluntness
   *   holds for ALL fence modes (use/opacity/identity) at every placement tried; the
   *   fence family is EXHAUSTED on this fn.  Remaining route = the #E' instruments
   *   ONLY: qtytrace --want p128=a1 solver, or the instrumented-cc1 [qty_order]/
   *   [find_free_reg] traced run (Font is lab-byte-identical; its trace is a receipt).
   *   2026-08-05 #F ALT-BODY ADOPTION ROUND (user: five-view bodies at C:/Temp/nfs4-psx;
   *   the "missing" scratchpad 0x1F800004 is NOT missing -- it IS our Render_gPacketPtr
   *   macro, nfs4_types.h).  Verbatim adoptions, all re-gated: m2c retail-emission-order
   *   transcription 86@82 / IDA 92@82 / Redec (-2*yoff algebraic fold) 144@80 (2 insns
   *   SHORT -- the fold is not retail's shape) / JEB = decompilation error.  Feeding cc1
   *   the retail EMISSION order is strongly NEGATIVE (+38/+44 vs our climbed order): the
   *   48-basin order pre-compensates cc1's own scheduler; retail order does not survive it.
   *   HYBRID ATOMS in the 48 basin: named temps for the CSE'd halfword pairs
   *   (du=u+width / ydv=dv+height / yh=ytop+height / xw=x+width), probed as yh-only,
   *   all-4, and 3-without-yh -- ALL exactly 48.  yh-only was the receipt's route (b)
   *   p96-refs-4->3 attempt; its neutrality PROVES the qty ref counts are cse's RTL
   *   counts, not source counts (src2=48 precedent generalized, 3 combos x 4 temps).
   *   => route (b) by source spelling is CLOSED; #E' instruments remain the ONLY route.
   *   🏆 2026-08-05 #E round 5 -- THE EA-NATURAL CLEAN-ROOM RECONSTRUCTION (user order:
   *   "reconstruct it like the EA programmer using only the symdump disasm oracle").
   *   Bodies at scratch/font_ea_basin/ (e1..e5); the SYM-TRUE shape is e3/e4: locals
   *   EXACTLY prim/width/height/dv (raw SYM 8c block: prim $t1, width $t7, height $t6,
   *   dv $t0, v REG $s0, ch REG $v0, and param y REGPARM reg 24 = $T8), retail-SLD
   *   statement order (1440 width / 1441 height / 1444 dv / 1446-1447 y-mutation /
   *   1449 ONE-LINE prim-alloc+bump+addPrim macro / 1452 font_tint / 1455 codes / tpage
   *   / UV / XY), y-chain carried by MUTATING PARAM y, and -- the discovery --
   *   🔴 NEW LAW (gcc2.x cse struct-alias rule): a store through a SCALAR lvalue
   *   (`*(uint *)prim = ...`) invalidates ALL memory equivalences incl. the scratchpad
   *   cell reads => the 2nd `Render_gPalettePtr` cell read RELOADS (+1 insn, 83/82,
   *   e1 = 105@83); spelling both link RMWs as P_TAG BITFIELD stores
   *   (`((PSXFront_PTag*)p)->addr = ...`, MEM_IN_STRUCT_P) does NOT invalidate scalar
   *   fixed-address MEMs, so the cell load stays SINGLE with NO local -- byte-structure
   *   equal to retail (e2 = 132@82 count-EXACT).  This is how retail single-loads the
   *   palette ptr with no prevPrim local, and it retires the old "bitfield falsified
   *   144@84" verdict as BASIN-RELATIVE (it was measured with the prevPrim local).
   *   e3 (+5 UNFOLDED as separate `y = y + 5;`) 132->124; e4 (-1 moved into UV args per
   *   the SLD-1463 hint) neutral 124; e5 (fresh ytop var to break y's $a1 arg
   *   suggestion) neutral 124 -- y stays $a1 at source level, so retail's y@$t8 is
   *   pure allocation order (the same p128 razor: retail's 2nd src+0xc read owns $a1).
   *   STATE: residual 124 = ONE GLOBAL REGISTER ROTATION (width/height/v already in
   *   retail's regs; prim t0-vs-t1, dv v1-vs-t0, ch t2-vs-v0, pal t3-vs-t2, mask
   *   t4-vs-t3, y a1-vs-t8), zero structural diffs.  The 48-body is a closer-scoring
   *   LOOKALIKE in a SYM-false basin (extra locals); the E-basin is the TRUE source
   *   shape.  => run the instrumented-cc1 [qty_order]/[find_free_reg] trace ON e3/e4,
   *   not on the 48 body -- its qty-order diff vs retail is now meaningful 1:1.
   *   2026-08-05 #E round 4 (user: "fix the prologue -- wrong types/declarations?"; all
   *   probes via the new tools/diffsrc.py attribution): PROLOGUE DIFFS ARE POSITION-ONLY
   *   ECHOES -- every prologue insn (ori t3 pair-split, lui t5 drift, early lw t0, early
   *   sb from our w44 prim[0xc] hoist) is byte-identical to retail's, just scheduled into
   *   different slots downstream of the SAME $a1-vs-$t8 rotation; no type/declaration
   *   mismatch exists (dv/width/height/yoff/v-copy/constant regs all verified identical).
   *   FALSIFIED THIS ROUND: (a) ALT-BODY ADOPTION ranking -- ours 48 < m2c-verbatim 86 <
   *   IDA 92 < Redec 144@80 < JEB(error); feeding cc1 RETAIL EMISSION ORDER is strongly
   *   negative; (b) named-CSE-temps yh/du/ydv/xw all exactly 48 (neutral -- qty refs are
   *   cse's RTL counts, not source counts; generalizes src2); (c) THE SYM-FAITHFUL BODY
   *   (locals = ONLY prim/width/height/dv per SYM 8c block, retail-SLD statement order
   *   1444->1466, and PARAM-MUTATION `y = y - yoff; y = y+5 - (height+yoff);` -- the one
   *   spelling that would explain SYM annotating param y at $t8 AND the missing ybase/ytop
   *   locals) = 105@83 / 3-stmt 105@83; (d) the mutation ATOM alone in the 48 basin = 62 /
   *   60 (reproduces the falsified single-long-qty numbers) -- and diffsrc PROVES mutated y
   *   STILL colors to $a1 (sh a1,26 vs retail sh t8,26): cc1 keeps a mutated param in its
   *   arrival reg; retail's $t8 is an ALLOCATION-ORDER outcome, not a spelling; (e)
   *   scheduling-flag identity: nosched1 124 / nosched2 83@83 / both 138@92 -- retail used
   *   DEFAULT scheduling.  ⇒ the prologue snaps in only when the rotation does; route
   *   unchanged: #E' instruments (instrumented-cc1 [qty_order]/[find_free_reg] trace).
   *   2026-08-03 ANGLE #E FALSIFIED AS SPELLED (48 basin, 4 probes): fence-before-tpage
   *   "r"(prim) 108 / "r"(src) 74 / fence-after 110 / cross-jump duplicate if(width) 143@81.
   *   MECHANISM: in a mono-block 50-qty function the fence is TOO BLUNT -- it pins every
   *   value crossing it, and the collateral live-range shifts rotate far more than p128
   *   (the CONFLICT-SET boundary from the PrimMenu receipt, single-block form).  The
   *   cross-jump duplicate loses an insn (81/82) -- the cond folds.  🎯 #E': the dial must
   *   touch ONLY p128 or ONLY ytop: (1) qtytrace --want "p128=a1" (the solver's first live
   *   test) for an exact minimal delta; (2) instrumented-cc1 [qty_order]/[find_free_reg]
   *   trace (Font IS in the byte-identical set -- its trace is a RECEIPT) to read who takes
   *   $a1 first and which single qty to demote; (3) route (b) untried half: ytop live
   *   25 -> >56 via a LATE ytop consumer (the last store at prim+0x22 already reads it --
   *   a post-return-adjacent use does not exist; needs a real spelling idea).
   * 🔬 POSITIONAL NEIGHBOURHOOD (tools/stmtclimb3.py, committed this wave): from the 50 basin
   *   PHASE 1 gated ALL 625 def-use-valid single moves (every one = 50, confirming w45's
   *   single-move optimum EXHAUSTIVELY rather than greedily) and PHASE 2 gated 825 COMPOUND
   *   PAIR moves built from the 45 best singles -- best still 50.  ⇒ 50 was also a TWO-move
   *   local optimum; position is EXHAUSTED as a lever from that basin, which is why the win
   *   came from expression shape instead.  RE-RUN FROM THE 48 BASIN (35 statements): 650
   *   valid singles + 586 pairs gated, best still 48 -- so 48 is ALSO a single- AND two-move
   *   positional optimum.  ⇒ for this function, position is a CLOSED dial in both basins;
   *   only refs/live (the qty table above) and expression shape remain.
   * 🔑 a10 (gcc lane) CONFIRMATIONS for this table, w46: (i) it VALIDATES 27/27 against the
   *   real CC1PLPSX `.lreg` -- q4/p84 ranks DEAD LAST at .0294, which is exactly WHY it sits
   *   on $s0 (the §A0 law reproduced on this function); (ii) FOUR of the qtys are pass-1
   *   "suggestion" allocations that the ref dial CANNOT reach -- aim only at the qsort-ordered
   *   rest; (iii) 🔴 NEW LAW: `local-alloc.c:1588` hand-rolls the ordering for `next_qty <= 3`
   *   with a BROKEN comparator, so any 3-quantity BLOCK is NOT priority-ordered (38/38
   *   corpus-validated, 32% non-descending) -- in such a block the dials are BIRTH ORDER and
   *   crossing the 3-vs-4 qty-count boundary (add/remove one block-local temp).  This whole
   *   function is ONE block with 50 qtys, so (iii) does not bite here, but it does bite any
   *   small arm.  a10 also ships `tools/qtytrace.py` (branch w46-a10: `--steps` ref-step math,
   *   `--want` delta solver, solver UNTESTED) and a near-oracle instrumented `cc1plus-ecoff.exe`
   *   at C:/Temp/nfs4-instr-cc1 (`-mgas -msplit-addresses -funsigned-char -fno-exceptions
   *   -fno-rtti`; psxfront 22/25 byte-identical -- FontUpsideDownBlit is in the identical set,
   *   DrawGouraudShape is one of the 3 inline-GTE divergences, so use it for qty/allocno traces
   *   on Draw, never as a byte oracle). */
  /* ==== 🏆 2026-08-05 ROUND 6 — THE BODY BELOW REPLACED THE 48-DIFF LOOKALIKE ====
   * This is V10 of the EA-natural clean-room campaign (scratch/font_ea_basin/, rounds
   * 1-6 in TRACE_NOTES.md): the SYM-true shape (locals EXACTLY prim/width/height/dv),
   * retail-SLD statement order with font_tint BEFORE addPrim, the P_TAG-bitfield link
   * RMWs (gcc2.x cse struct-alias law), and the y-chain LIVE-RANGE SPLIT via the dead
   * 7th param (`arg6 = y + 5;` -- fold is statement-granular and cannot associate
   * across a different variable; the 2-death y pseudo fails local-alloc's
   * REG_N_DEATHS==1 gate and is allocated by GLOBAL.c, which prefers call-used regs).
   * GATE: FAIL 44 (82/82) vs the old tuned body's 48 -- and STRUCTURALLY TRUE:
   * dv@t0, prim@t1, pal@t2, m1@t3, yoff@t4, m2@t5, height@t6, width@t7, y@T8,
   * +5-temp@v1, p128@a1, tint@v0, v@s0 ALL RETAIL-EXACT (14/16). Residual 44 = the
   * 0x1F800004 addr-temp (ours t0-early vs retail v1) + ch (ours v1 vs retail v0)
   * renames and their head-region position echoes; tail from `sh t6,10` byte-exact.
   * ⚠ CAVEAT: SYM shows NO ARG record for the 7th param (unnamed in EA source), so
   * `arg6 = y + 5` is a stand-in for EA's true +5 carrier (round-7 hunt). The OLD
   * 48-body (SYM-false basin: extra locals ybase/hoff/ytop/linkAddr/prevPrim) is
   * preserved in git history @79865d5a and its full receipt remains above.
   * ==== 2026-08-08 ROUND 7 — 44 -> 28 (V21): the WHOLE y-chain (all 3 statements)
   * moved BEFORE `prim = ...` (retail SLD order: 1446-1447 y-mutation precedes the
   * 1449 alloc/link line). MECHANISM (diffsrc-proven): our `lb t4` (yoffset) had been
   * emitting AFTER the packet-bump store, stretching ch's live window over the bump
   * temp's v0 slot -> ch fell to v1 and the 0x1F800004 addr-temp to t0; grouping all
   * three ch reads ahead of the bump lets ch die on V0 and the addr-temp take V1 --
   * BOTH remaining register renames retail-exact in one move (16/16 now match).
   * FALSIFIED same round (all re-gated): y-=yoff alone moved up (V20, 59@85 -- the
   * chain must move TOGETHER or y's split degrades); tint after addPrim (V22, 112 --
   * tint-early is still the fill seed); tint between the addPrim halves (V23, 116);
   * tint before dv (V24, 122 -- tint's slot is exactly after dv).
   * RESIDUAL 28 = pure emission-order echoes of ONE cluster: ours hoists the
   * font_tint load (17-18) + sinks the palette-ptr load (26-27); retail hoists the
   * palette-ptr load (16-17) + sinks the whole tint/li-9/li-44 group into the 2nd
   * OT-link RMW (33-41), + the `sh t6,10` tail echo. Same statements, same regs,
   * same count -- a sched1 hoist-choice identity; no source spelling reached it this
   * round. Route: instrumented-cc1 sched trace (the #E' lane) or accept. */
  POLY_FT4 *prim;
  int       width;
  int       height;
  int       dv;

  width = ch->width;
  height = ch->height;
  dv = ((*(int *)((int)src + 0xc) << 4) >> 0x14) + v & 0xff;
  y = y - *(signed char *)&ch->yoffset;
  y = 5 - (height + *(signed char *)&ch->yoffset) + y;
  prim = (POLY_FT4 *)Render_gPacketPtr;
  Render_gPacketPtr = (u_char *)prim + 0x28;
  ((PSXFront_PTag *)prim)->addr = ((PSXFront_PTag *)Render_gPalettePtr)->addr,
  ((PSXFront_PTag *)Render_gPalettePtr)->addr = (uint)prim;
  *(u_long *)&prim->r0 = font_tint;
  ((u_char *)prim)[3] = 9;
  prim->code = 0x2c;
  prim->clut = gFontClut;
  prim->tpage = (*(byte *)src & 3) << 7 | (uint)*(int *)((int)src + 0xc) >> 0x14 & 0x10 |
                (*(int *)((int)src + 0xc) & 0x3ff) >> 6;
  dv -= 1,
  prim->u0 = u, prim->v0 = dv,
  prim->u1 = u + width, prim->v1 = dv,
  prim->u2 = u, prim->v2 = dv + height,
  prim->u3 = u + width, prim->v3 = dv + height;
  prim->x0 = x, prim->y0 = y + height,
  prim->x1 = x + width, prim->y1 = y + height,
  prim->x2 = x, prim->y2 = y,
  prim->x3 = x + width, prim->y3 = y;
  return;
}

/* end of psxfront.cpp */
