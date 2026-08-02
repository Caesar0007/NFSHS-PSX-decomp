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

/* ---- DrawGouraudShape  (psxfront.cpp:928, code lines 928-985) ---- */
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

  height = shp->height;
  width = shp->width;
  bpp = (byte)shp->depth;
  if ((flags & 2) != 0) {
    y = y + height;
    height = -height;
  }
  v = (byte)shp->shapey;
  vh = shp->height;
  if ((flags & 2) != 0) {
    v = (byte)shp->shapey - 1;
  }
  i = 0;
  while (i < shp->width) {
    int addw;
    int texX;
    int wsel;

    texX = (uint)(ushort)shp->shapex + (i * bpp) / 16;
    u = (i + ((int)((uint)(ushort)shp->shapex << 0x10) >> 0xc) / bpp) -
        ((int)((texX & 0xffffffc0U) << 0x10) >> 0xc) / bpp;
    wsel = 0xff - u;
    if (shp->width - i < wsel) {
      wsel = shp->width - i;
    }
    w = wsel;
    prim = Render_gPacketPtr;
    *(uint *)prim = *(uint *)prim & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
    Render_gPacketPtr = prim + 0x34;
    *(uint *)Render_gPalettePtr = *(uint *)Render_gPalettePtr & 0xff000000 | (uint)prim & 0xffffff;
    *(int *)(prim + 4) = color[0];
    *(int *)(prim + 0x10) = color[1];
    *(int *)(prim + 0x1c) = color[2];
    prim[7] = (flags & 1) * 2 + 0x3c;
    prim[3] = 0xc;
    *(int *)(prim + 0x28) = color[3];
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
    prim[0x19] = v;
    prim[0x24] = u;
    prim[0x30] = u + w1;
    prim[0x25] = vh + v;
    prim[0x31] = vh + v;
    if (w1 <= 0) {
      w1 = 1;
    }
    if ((flags & 4) != 0) {
      addw = addw - 1;    /* materialized ONCE ($v1) -- writing `+ (addw - 1)` per site lets gcc
                             reassociate the -1 out and re-add addw at each vertex (w42-a7) */
      *(short *)(prim + 8) = ((width + x) - i) + addw;
      *(short *)(prim + 10) = y;
      *(short *)(prim + 0x16) = y;
      *(short *)(prim + 0x14) = ((shp->width + x) - (i + w1)) + addw;
      *(short *)(prim + 0x22) = y + height;
      *(short *)(prim + 0x20) = ((shp->width + x) - i) + addw;
      *(short *)(prim + 0x2e) = y + height;
      *(short *)(prim + 0x2c) = ((shp->width + x) - (i + w1)) + addw;
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
  *(uint *)prim = *(uint *)prim & 0xff000000 | *pal & 0xffffff;
  Render_gPacketPtr = prim + 0x34;
  *pal = *pal & 0xff000000 | (uint)prim & 0xffffff;
  *(int *)(prim + 4) = color[0];
  *(int *)(prim + 0x10) = color[1];
  *(int *)(prim + 0x1c) = color[2];
  *(int *)(prim + 0x28) = color[3];
  SetPolyGT4((POLY_GT4 *)prim);
  SetSemiTrans(prim,flags & 1);
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
  *(short *)(prim + 0x14) = (x - 1) + fixedmult(scalex,width);
  *(short *)(prim + 0x16) = y;
  *(short *)(prim + 0x20) = x;
  *(short *)(prim + 0x22) = y + fixedmult(scaley,height);
  /* w44-a1 MATCH: retail keeps `x - 1` in a CALL-CROSSING pseudo ($s0) and MUTATES it in place at
     the 2nd right-edge vertex (`addiu s0,s6,-1` ... `addu s0,s0,v0`).  The named local must be BORN
     LAST among block-4's call-crossing local quantities -- local_alloc hands out s0,s1,s2 in REVERSE
     birth order, and retail's order is width-narrow, height-narrow, x-1.  Declaring/assigning xm1
     before the 0x14 store makes it born FIRST -> it takes s2, the height narrow takes s0 (which
     block-0's `abr` already owns) so `height` can no longer share it -> a 10th live value -> spill
     (177 insns).  Spelling `x - 1` inline at 0x14 and only naming it here keeps the birth last. */
  xm1 = x - 1;
  xm1 = xm1 + fixedmult(scalex,width);
  *(short *)(prim + 0x2c) = xm1;
  *(short *)(prim + 0x2e) = y + fixedmult(scaley,height);
  u = (((ushort)shp->shapex & 0x3f) << 4) / bpp;
  v = (byte)shp->shapey;
  if ((flags & 4U) != 0) {
    u = (((ushort)shp->shapex & 0x3f) << 4) / bpp - 1;
  }
  uw = u + (byte)shp->width;
  if ((flags & 2U) != 0) {
    v = (byte)shp->shapey - 1;
  }
  prim[0xd] = v;
  prim[0x19] = v;
  vh = v + (byte)shp->height;
  prim[0xc] = u;
  prim[0x18] = uw;
  prim[0x24] = u;
  prim[0x25] = vh;
  prim[0x30] = uw;
  prim[0x31] = vh;
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

/* ---- PSXDrawTransGouraudSquare  (psxfront.cpp:1377, code lines 1377-1398) ---- */
/* GPU packet: builds POLY_G4 (stride 0x24, code 0x39); prim=u_char* build cursor, prevPrim=u_char* link word */
void PSXDrawTransGouraudSquare(int x,int y,int w,int h,int opacity,int c1,int c2,int c3,int c4)

{
  /* SYM: opacity/c1..c4 (ARG->REG copies), prim (POLY_G4*), i (INT).  🔴 `opacityv` was NEVER
   * ASSIGNED and stood in for the real `x` param in all four packed vertex words (oracle $t5 = the
   * x REGPARM copy) -- every quad got a garbage X.  LICM hoists the two (x+w) words. w42-a7 */
  uint     otWord;
  int      i;
  POLY_G4 *prevPrim;
  POLY_G4 *prim;

  i = 0;
  if (0 < opacity) {
    do {
      prim = (POLY_G4 *)Render_gPacketPtr;
      prevPrim = (POLY_G4 *)Render_gPalettePtr;
      i = i + 1;
      prim->tag = prim->tag & 0xff000000 | prevPrim->tag & 0xffffff;
      otWord = prevPrim->tag;
      Render_gPacketPtr = (u_char *)prim + 0x24;
      prevPrim->tag = otWord & 0xff000000 | (uint)prim & 0xffffff;
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
  uint     otWord;
  short i;
  POLY_F4 *prevPrim;
  POLY_F4 *prim;

  i = 0;
  if (0 < opacity) {
    do {
      prim = (POLY_F4 *)Render_gPacketPtr;
      prevPrim = (POLY_F4 *)Render_gPalettePtr;
      i = i + 1;
      prim->tag = prevPrim->tag & 0xffffff | prim->tag & 0xff000000;
      otWord = prevPrim->tag;
      Render_gPacketPtr = (u_char *)prim + 0x18;
      prevPrim->tag = otWord & 0xff000000 | (uint)prim & 0xffffff;
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
   * every spelling tried, so the `addiu t4,t4,-5` vs retail's `addiu v1,t8,5` rides along. */
  u_char  *prim;
  u_char  *prevPrim;
  int      linkAddr;
  int      width;
  int      height;
  int      dv;
  int      yoff;
  int      ybase;
  int      hoff;
  int      ytop;

  prim = Render_gPacketPtr;
  prevPrim = Render_gPalettePtr;
  width = ch->width;
  height = ch->height;
  yoff = *(signed char *)&ch->yoffset;
  ybase = y - yoff;
  hoff = height + yoff;
  ytop = (ybase + 5) - hoff;
  dv = (((*(int *)((int)src + 0xc) << 4) >> 0x14) + v & 0xff) - 1;
  linkAddr = (uint)prim & 0xffffff;
  Render_gPacketPtr = prim + 0x28;
  *(uint *)prim = *(uint *)prim & 0xff000000 | *(uint *)prevPrim & 0xffffff;
  *(uint *)prevPrim = *(uint *)prevPrim & 0xff000000 | linkAddr;
  prim[3] = 9;
  /* MATCH: the font_tint store sits BETWEEN prim[3] and prim[7] -- that position puts its
   * %hi materialization ahead of the *prim link store and gives the link chain retail's $v1. */
  *(u_long *)(prim + 4) = font_tint;
  prim[7] = 0x2c;
  *(ushort *)(prim + 0xe) = gFontClut;
  prim[0xd] = dv;
  prim[0x15] = dv;
  prim[0xc] = u;
  prim[0x14] = u + width;
  prim[0x1c] = u;
  prim[0x1d] = dv + height;
  prim[0x24] = u + width;
  prim[0x25] = dv + height;
  *(short *)(prim + 8) = x;
  *(ushort *)(prim + 0x16) =
       (*(byte *)src & 3) << 7 | (uint)*(int *)((int)src + 0xc) >> 0x14 & 0x10 |
       (*(int *)((int)src + 0xc) & 0x3ff) >> 6;
  *(short *)(prim + 10) = ytop + height;
  *(short *)(prim + 0x10) = x + width;
  *(short *)(prim + 0x12) = ytop + height;
  *(short *)(prim + 0x18) = x;
  *(short *)(prim + 0x1a) = ytop;
  *(short *)(prim + 0x20) = x + width;
  *(short *)(prim + 0x22) = ytop;
  return;
}

/* end of psxfront.cpp */
