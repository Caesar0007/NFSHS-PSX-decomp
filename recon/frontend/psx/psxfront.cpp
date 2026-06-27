/* frontend/psx/psxfront.cpp  --  RECONSTRUCTED  (PSX frontend / shape drawing; C++ TU)
 *   Bodies: Ghidra decompiler. Line numbers: PsyQ SLD (8c-start, SLD-max end).
 *   25 functions; C++ linkage (cfront-mangled in SYM). Externs declared from Ghidra sigs.
 */
#include "psxfront.h"
#include "psxfront_externs.h"

/* ---- PSXFront.obj STAT (file-local) globals ---- */
static char     *STR_FRMT;                          /* 0x80052a54 */
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
  Draw_SetViewMemBudget(Draw_gPlayer1View,80000);
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
  Car_tObj *carObj;
  int i;
  uint index;
  GameSetup_tCarData *carData_walk;
  Car_tObj **obj_walk;
  
  if (rendering3DEnvironmentInitialized == '\0') {
    R3DCar_InMenu = 1;
    Platform_ResetDCTBuffer();
    Texture_InitMenuTexture();
    inFrontEnd = 1;
    CarIO_StartUp();
    R3DCar_StartUp();
    inFrontEnd = 0;
    DrawC_ReadeMapData();
    Fe3D_InitShowroom();
    carData_walk = GameSetup_gData.carInfo;
    obj_walk = gCarObj;
    GameSetup_gData.Weather = 0;
    for (index = 0; (int)index < 2; index = index + 1) {
      carObj = (Car_tObj *)reservememadr("carObj",0x8dc,0);
      *obj_walk = carObj;
      blockclear(carObj,0x8dc);
      carObj->carInfo = carData_walk;
      carData_walk->carType = 1;
      carData_walk = carData_walk + 1;
      obj_walk = obj_walk + 1;
      strcpy(carObj->carName,GameSetup_gCarNames[carObj->carInfo->carType]);
      (carObj->N).objID = index | 0x100;
      R3DCar_Instantiate3DCar(carObj,index);
      (carObj->N).active = '\x01';
    }
    R3DCar_PostStartUp();
    gMenuRotate[1] = 0;
    gMenuRotate[0] = 0;
    blockclear(&gCView,0x8c);
    DrawC_gMenuColor[1] = -1;
    DrawC_gMenuColor[0] = -1;
    DrawC_gMenuLights = 0;
    DrawC_gMenuLightsDirection = 0;
    rendering3DEnvironmentInitialized = '\x01';
  }
  return;
}

/* lines 225-226: (static data / macros / comments - no emitted code) */

/* ---- CleanupSpinningCars  (psxfront.cpp:227, code lines 227-275) ---- */
void CleanupSpinningCars(void)

{
  int status;
  Car_tObj *addr;
  int handle;
  Car_tObj **ppCar;
  int i;
  char fname [60];
  
  if (rendering3DEnvironmentInitialized != '\0') {
    DrawSync(0);
    i = 0;
    ppCar = gCarObj;
    do {
      i = i + 1;
      R3DCar_DeInstantiate3DCar(*ppCar);
      addr = *ppCar;
      ppCar = ppCar + 1;
      purgememadr(addr);
    } while (i < 2);
    inFrontEnd = 1;
    R3DCar_CleanUp();
    CarIO_CleanUp();
    inFrontEnd = 0;
    Texture_KillMenuTexture();
    PSXFront_FreeDrawMemory();
    R3DCar_InMenu = 0;
    gFlip = -1;
    rendering3DEnvironmentInitialized = '\0';
    Platform_ResetDCTBuffer();
    sprintf(fname,"%sDCT.BIN",Paths_Paths[0x20]);
    i = asyncloadfileat(fname,CF_DVLC);
    while (status = getasyncreadstatus(i), status == 0) {
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
  if (creditShapeFile == (char *)0x0) {
    sprintf(artfilename,"title.psh");
    sprintf(fileName,STR_FRMT,Paths_Paths[0x20],artfilename);
    creditShapeFile = (char *)loadshapeadr(fileName,(void *)0x0);
    systemtask(0);
    if (creditShapeFile == (char *)0x0) {
      return;
    }
  }
  shape = (tTexture_ShapeInfo *)locateshapez(creditShapeFile,(void *)"back");
  Quick_DD(1,0,1);
  settrans(0);
  movfxya(shape,0,0);
  settrans(1);
  Quick_DD(0,1,0);
  purgememadr(creditShapeFile);
  titleScreenDisplayed = '\x01';
  creditShapeFile = (char *)0x0;
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
  gHelpShapes[0] = (tTexture_ShapeInfo *)reservememadr("gHelpShapes",0x760,0);
  blockclear(gHelpShapes[0],0x760);
  return;
}

/* lines 685-695: (static data / macros / comments - no emitted code) */

/* ---- Init_RenderingEnvironment  (psxfront.cpp:696, code lines 696-720) ---- */
void Init_RenderingEnvironment(void)

{
  int stackv;
  
  SetDefDispEnv(&gEnviro[0].disp,0,0x100,0x200,0xf0);
  SetDefDispEnv(&gEnviro[1].disp,0,0,0x200,0xf0);
  Draw_InitViews();
  Draw_gRearView = -1;
  Draw_gPlayer1View =
       Draw_SetView
                 (0,-0x7fec0000,0,stackv,0x200,0xf0,0,1,10);
  blockclear(&gCView,0x8c);
  gCView.id = Draw_gPlayer1View;
  PSXFront_AllocateDrawMemory();
  Draw_gDoVSync = 1;
  FETextRender_SetABR(0,false);
  gFlip = 0;
  return;
}

/* lines 721-725: (static data / macros / comments - no emitted code) */

/* ---- Init_PSX_FrontEnd  (psxfront.cpp:726, code lines 726-783) ---- */
void Init_PSX_FrontEnd(void)

{
  int movieRes;
  
  gFlip = -1;
  addtimer(PAD_update);
  InitGeom();
  PSX_AllocShapes();
  Texture_InitMenuClut();
  screenwidth = 0x200;
  screenbpp = 0x10;
  if (ComingIntoTheFrontEndTheVeryFirstTime[0] == 0) {
    Init_RenderingEnvironment();
    TextSys_LoadWords((uint)(byte)frontEnd.language);
  }
  else {
    movieRes = play_movie('\x04');
    if (movieRes != 1) {
      play_movie('\0');
    }
    initlinkmode(0,1);
    Init_RenderingEnvironment();
    initlinkmode(0,0x14);
    DoLanguageScreen();
    TextSys_LoadWords((uint)(byte)frontEnd.language);
    DoTitleScreen();
    initlinkmode(0,1);
    Front_SecondaryMemCardCheck();
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
  short fadetop;
  int fbot;
  int adjY;
  short i;
  int ftop;
  int cHi;
  int cLo;
  short fadebottom;
  int shpAddr;
  int cMid;
  int cB;
  int cG;
  uint fadeC1;
  uint fadeC2;
  
  fbot = *flags;
  if ((fbot & 0x400U) == 0) {
    if (0 < *y) goto AdjShape_applyOffset;
    *x = *x - (int)*(short *)(shpAddr + 0x14);
    adjY = -((int)*(short *)(shpAddr + 0x16) + *y);
  }
  else {
    *x = *x - (int)*(short *)(shpAddr + 0x14);
    adjY = *y - (int)*(short *)(shpAddr + 0x16);
  }
  *y = adjY;
AdjShape_applyOffset:
  if ((*flags & 0x100U) != 0) {
    *x = *x - ((int)((uint)*(ushort *)(shpAddr + 0x10) << 0x10) >> 0x11);
    *y = *y - ((int)((uint)*(ushort *)(shpAddr + 0x12) << 0x10) >> 0x11);
  }
  if ((*flags & 0x20U) != 0) {
    *y = (extra->flip_axis * 2 - (*y + (int)*(short *)(shpAddr + 0x12))) + 1;
    *flags = *flags | 2;
  }
  fadeC2 = *flags;
  if ((fadeC2 & 0x10) != 0) {
    cHi = (uint)*(byte *)((int)extra->tint + 2) * bright;
    if (cHi < 0) {
      cHi = cHi + 0x7f;
    }
    cMid = (extra->tint[0] >> 8 & 0xffU) * bright;
    if (cMid < 0) {
      cMid = cMid + 0x7f;
    }
    cLo = (uint)(byte)extra->tint[0] * bright;
    if (cLo < 0) {
      cLo = cLo + 0x7f;
    }
    *color = (cHi >> 7) << 0x10 | (cMid >> 7) << 8 | cLo >> 7;
    return;
  }
  if ((fadeC2 & 0x80) != 0) {
    i = 0;
    cMid = 0;
    do {
      cMid = cMid >> 0xe;
      cLo = (uint)*(byte *)((int)extra->tint + cMid + 2) * bright;
      if (cLo < 0) {
        cLo = cLo + 0x7f;
      }
      cG = (*(int *)((int)extra->tint + cMid) >> 8 & 0xffU) * bright;
      if (cG < 0) {
        cG = cG + 0x7f;
      }
      cB = (uint)*(byte *)((int)extra->tint + cMid) * bright;
      if (cB < 0) {
        cB = cB + 0x7f;
      }
      *(int *)(cMid + (int)color) = (cLo >> 7) << 0x10 | (cG >> 7) << 8 | cB >> 7;
      i = i + 1;
      cMid = i * 0x10000;
    } while (i * 0x10000 >> 0x10 < 4);
    return;
  }
  if ((fadeC2 & 0x40) != 0) {
    ftop = ((uint)(ushort)extra->flip_axis - (uint)(ushort)*y) + 1;
    if (ftop * 0x10000 < 0) {
      ftop = -ftop;
    }
    fadetop = (short)(ftop << 1);
    if (0x80 < (ftop << 0x11) >> 0x10) {
      fadetop = 0x80;
    }
    fbot = ((uint)(ushort)extra->flip_axis - ((uint)(ushort)*y + (uint)*(ushort *)(shpAddr + 0x12)))
            + 1;
    if (fbot * 0x10000 < 0) {
      fbot = -fbot;
    }
    cMid = fbot << 0x11;
    if (0x80 < (fbot << 0x11) >> 0x10) {
      cMid = 0x800000;
    }
    fadeC2 = 0x80 - (cMid >> 0x10);
    fadeC2 = fadeC2 * 0x10000 | fadeC2 * 0x100 | fadeC2;
    fadeC1 = 0x80 - (int)fadetop;
    *color = fadeC2;
    color[1] = fadeC2;
    fadeC1 = fadeC1 * 0x10000 | fadeC1 * 0x100 | fadeC1;
    color[2] = fadeC1;
    color[3] = fadeC1;
    return;
  }
  *color = bright << 0x10 | bright << 8 | bright;
  return;
}

/* lines 923-927: (static data / macros / comments - no emitted code) */

/* ---- DrawGouraudShape  (psxfront.cpp:928, code lines 928-985) ---- */
/* GPU packet: builds POLY_GT4 (stride 0x34, code 0x3c); prim=u_char* build cursor, prevPrim=u_char* link word */
void DrawGouraudShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int *color,int abr)

{
  byte tc6;
  short colX;
  short clut;
  int texXp;
  short uvAdj;
  short x1;
  byte v_byte;
  int linkAddr;
  short height;
  int verts_done;
  int remW;
  int c3;
  short w1;
  int bpp;
  int bitOff;
  short xoff;
  short tmpH;
  int addw;
  int col;
  int stripW;
  int texX;
  byte u_byte;
  short v;
  short i;
  int accW;
  short u;
  int shape_x;
  short w;
  short dstY0;
  short dstY1;
  short width;
  short vh;
  byte tc1;
  u_char  *prevPrim;
  u_char  *prim;
  short srcH;
  short shpW2;
  short shpW;
  short ts4;
  short colX1;
  
  dstY0 = (short)y;
  tmpH = shp->height;
  shpW = shp->width;
  bpp = (int)(byte)shp->depth;
  if ((flags & 2) != 0) {
    dstY0 = dstY0 + tmpH;
    tmpH = -tmpH;
  }
  u_byte = (byte)shp->shapey;
  srcH = shp->height;
  if ((flags & 2) != 0) {
    u_byte = u_byte - 1;
  }
  accW = 0;
  dstY1 = tmpH + dstY0;
  while( true ) {
    prim = Render_gPacketPtr;
    prevPrim = Render_gPalettePtr;
    colX = (short)accW;
    col = (int)colX;
    bitOff = col * bpp;
    if (shp->width <= col) break;
    if (bitOff < 0) {
      bitOff = bitOff + 0xf;
    }
    verts_done = (int)((uint)(ushort)shp->shapex << 0x10) >> 0xc;
    if (bpp == 0) {
      trap(0x1c00);
    }
    if ((bpp == -1) && (verts_done == -0x80000000)) {
      trap(0x1800);
    }
    texX = (uint)(ushort)shp->shapex + (bitOff >> 4);
    texXp = (int)((texX & 0xffffffc0U) << 0x10) >> 0xc;
    if (bpp == 0) {
      trap(0x1c00);
    }
    if ((bpp == -1) && (texXp == -0x80000000)) {
      trap(0x1800);
    }
    shape_x = (accW + verts_done / bpp) - texXp / bpp;
    stripW = 0xff - (shape_x * 0x10000 >> 0x10);
    remW = shp->width - col;
    if (remW < stripW) {
      stripW = remW;
    }
    *(uint *)Render_gPacketPtr =
         *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
    linkAddr = (uint)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x34;
    *(uint *)prevPrim = *(uint *)prevPrim & 0xff000000 | linkAddr;
    *(int *)(prim + 4) = *color;
    *(int *)(prim + 0x10) = color[1];
    *(int *)(prim + 0x1c) = color[2];
    c3 = color[3];
    prim[7] = (flags & 1) * '\x02' + '<';
    prim[3] = 0xc;
    *(int *)(prim + 0x28) = c3;
    clut = GetClut((shp->clutID & 0x3fU) << 4,shp->clutID >> 6);
    *(short *)(prim + 0xe) = clut;
    *(ushort *)(prim + 0x1a) =
         ((byte)shp->type & 3) << 7 | (ushort)((abr & 3U) << 5) |
         (short)(shp->shapey & 0x100U) >> 4 | (ushort)((texX & 0x3c0U) >> 6) |
         (shp->shapey & 0x200U) << 2;
    tmpH = 0;
    if (((flags & 4) != 0) && (shp->width < 0xff)) {
      shape_x = shape_x + -1;
      tmpH = 1;
    }
    tc1 = (byte)shape_x;
    v_byte = tc1 + (char)stripW;
    prim[0xc] = tc1;
    prim[0xd] = u_byte;
    prim[0x18] = v_byte;
    prim[0x19] = u_byte;
    prim[0x24] = tc1;
    prim[0x30] = v_byte;
    tc6 = (char)srcH + u_byte;
    prim[0x25] = tc6;
    prim[0x31] = tc6;
    if (stripW << 0x10 < 1) {
      stripW = 1;
    }
    uvAdj = tmpH + -1;
    if ((flags & 4) == 0) {
      tmpH = colX + xoff;
      x1 = (short)stripW + tmpH;
      *(short *)(prim + 8) = tmpH;
      *(short *)(prim + 10) = dstY0;
      *(short *)(prim + 0x14) = x1;
      *(short *)(prim + 0x16) = dstY0;
      *(short *)(prim + 0x20) = tmpH;
      *(short *)(prim + 0x22) = dstY1;
      *(short *)(prim + 0x2c) = x1;
      *(short *)(prim + 0x2e) = dstY1;
    }
    else {
      *(short *)(prim + 8) = ((shpW + xoff) - colX) + uvAdj;
      *(short *)(prim + 10) = dstY0;
      shpW2 = shp->width;
      colX1 = colX + (short)stripW;
      *(short *)(prim + 0x16) = dstY0;
      *(short *)(prim + 0x14) = ((shpW2 + xoff) - colX1) + uvAdj;
      tmpH = shp->width;
      *(short *)(prim + 0x22) = dstY1;
      *(short *)(prim + 0x20) = ((tmpH + xoff) - colX) + uvAdj;
      tmpH = shp->width;
      *(short *)(prim + 0x2e) = dstY1;
      *(short *)(prim + 0x2c) = ((tmpH + xoff) - colX1) + uvAdj;
    }
    accW = accW + stripW;
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
  tTexture_ShapeInfo *shapeTbl;
  tTexture_ShapeInfo *tShp;
  int color [4];

  /* @0x8004E678: the incoming flags/x/y params are forwarded to AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended (via &flags/&x/&y)
   * and the draw calls. The recon overwrote them with never-assigned Ghidra locals flagsv/xv/yv right
   * before the call, feeding garbage flags/x/y. Use the real params (M15). */
  shapeTbl = gCurrentShapes;
  if ((flags & 8) != 0) {
    shapeTbl = gHelpShapes[0];
  }
  if ((flags & 0x200) != 0) {
    shapeTbl = extra->custom_shapes;
  }
  /* @0x8004E6C4-C8: tShp = shapeTbl + index (index*0x20; sizeof tTexture_ShapeInfo=32), computed once
   * and passed to all three calls. (M16) the gouraud branch @0x8004E740 passed uninitialized abrv (as
   * flags) and (int)extra (as x) -> use the real flags/x. The shape pointer also used an uninitialized
   * Ghidra local `shp` for shapeTbl+(int)shp -> use tShp. (The shp/index uninit was a side-finding NOT
   * in the audit's M16, confirmed vs oracle: $s0=tShp=shapeTbl+index, passed to all 3 calls.) */
  tShp = shapeTbl + index;
  AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended(tShp,&x,&y,&flags,(0x80 - fade) * 0x10000 >> 0x10,color,extra);
  if ((flags & 0xc0U) == 0) {
    DrawFlatShape(tShp,flags,x,y,color,abr);
  }
  else {
    DrawGouraudShape(tShp,flags,x,y,color,abr);
  }
  return;
}

/* lines 1085-1088: (static data / macros / comments - no emitted code) */

/* ---- ScaleGouraudShape  (psxfront.cpp:1089, code lines 1089-1138) ---- */
/* GPU packet: builds POLY_GT4 (stride 0x34, SetPolyGT4); prim=u_char* build cursor, prevPrim=u_char* link word */
void ScaleGouraudShape(tTexture_ShapeInfo *shp,int flags,int x,int y,int scalex,int scaley,int *color,
               int abr)

{
  char v;
  byte v_byte;
  byte u_byte;
  short clut;
  int scaledW;
  int scaledH;
  int scaledX;
  int scaledY;
  int tpage_word;
  byte v1_byte;
  char vh;
  char u;
  char u1_byte;
  char uw;
  uint linkAddr;
  int vert_dx;
  short height;
  short srcH;
  short width;
  short srcW;
  short dstY;
  short dstX;
  short bpp;
  u_char  *prevPrim;
  u_char  *prim;
  short srcH2;
  byte depth;
  
  prim = Render_gPacketPtr;
  prevPrim = Render_gPalettePtr;
  dstX = (short)x;
  dstY = (short)y;
  srcW = shp->width;
  srcH = shp->height;
  depth = shp->depth;
  *(uint *)Render_gPacketPtr =
       *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
  linkAddr = (uint)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x34;
  *(uint *)prevPrim = *(uint *)prevPrim & 0xff000000 | linkAddr;
  *(int *)(prim + 4) = *color;
  *(int *)(prim + 0x10) = color[1];
  *(int *)(prim + 0x1c) = color[2];
  *(int *)(prim + 0x28) = color[3];
  SetPolyGT4((POLY_GT4 *)prim);
  SetSemiTrans(prim,flags & 1);
  clut = GetClut((shp->clutID & 0x3fU) << 4,shp->clutID >> 6);
  *(short *)(prim + 0xe) = clut;
  *(ushort *)(prim + 0x1a) =
       ((byte)shp->type & 3) << 7 | (ushort)((abr & 3U) << 5) |
       (short)(shp->shapey & 0x100U) >> 4 | (ushort)(((ushort)shp->shapex & 0x3c0) >> 6) |
       (shp->shapey & 0x200U) << 2;
  if ((flags & 4U) != 0) {
    scaledW = fixedmult(scalex,(int)srcW);
    dstX = dstX + (short)scaledW;
    srcW = -srcW;
  }
  if ((flags & 2U) != 0) {
    scaledH = fixedmult(scaley,(int)srcH);
    dstY = dstY + (short)scaledH;
    srcH = -srcH;
  }
  *(short *)(prim + 8) = dstX;
  *(short *)(prim + 10) = dstY;
  scaledX = fixedmult(scalex,(int)srcW);
  *(short *)(prim + 0x14) = dstX + -1 + (short)scaledX;
  *(short *)(prim + 0x16) = dstY;
  *(short *)(prim + 0x20) = dstX;
  scaledY = fixedmult(scaley,(int)srcH);
  *(short *)(prim + 0x22) = dstY + (short)scaledY;
  scaledY = fixedmult(scalex,(int)srcW);
  *(short *)(prim + 0x2c) = dstX + -1 + (short)scaledY;
  scaledY = fixedmult(scaley,(int)srcH);
  *(short *)(prim + 0x2e) = dstY + (short)scaledY;
  vert_dx = (int)depth;
  tpage_word = (ushort)shp->shapex & 0x3f;
  u1_byte = (char)((uint)(tpage_word << 4) / (uint)vert_dx);
  if (vert_dx == 0) {
    trap(0x1c00);
  }
  if ((vert_dx == -1) && (tpage_word == 0x8000000)) {
    trap(0x1800);
  }
  srcH2 = shp->height;
  v_byte = (byte)shp->shapey;
  if ((flags & 4U) != 0) {
    u1_byte = u1_byte + -1;
  }
  v1_byte = u1_byte + (char)shp->width;
  if ((flags & 2U) != 0) {
    v_byte = v_byte - 1;
  }
  prim[0xd] = v_byte;
  prim[0x19] = v_byte;
  u_byte = v_byte + (char)srcH2;
  prim[0xc] = u1_byte;
  prim[0x18] = v1_byte;
  prim[0x24] = u1_byte;
  prim[0x25] = u_byte;
  prim[0x30] = v1_byte;
  prim[0x31] = u_byte;
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
  tTexture_ShapeInfo *shapeTbl;
  tTexture_ShapeInfo *tShp;
  int scalex;
  int scaley;
  int color [4];

  /* ScaleShapeExtended: same uninit-local-shadow pattern -- forward the real flags/x/y params to
   * AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended, not the never-assigned Ghidra locals flagsv/xv/yv (M15). */
  shapeTbl = gCurrentShapes;
  if ((flags & 8) != 0) {
    shapeTbl = gHelpShapes[0];
  }
  if ((flags & 0x200) != 0) {
    shapeTbl = extra->custom_shapes;
  }
  /* @0x8004EAE4-E8 / EB14 / EB50: tShp = shapeTbl + index (index*0x20) is passed as $a0 to
   * AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended and both Scale draw calls. The recon used (tTexture_ShapeInfo*)(0x80-fade) as the
   * AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended shape arg (the bright value mis-decoded into the pointer slot) and an
   * uninitialized `shp` for shapeTbl+shp in both Scale calls -- all should be tShp (the same uninit
   * shape-pointer class fixed in DrawShapeExtended/M16; this is the ScaleShapeExtended sibling). */
  tShp = shapeTbl + index;
  AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended(tShp,&x,&y,&flags,(0x80 - fade) * 0x10000 >> 0x10,color,extra);
  if ((flags & 0xc0U) == 0) {
    ScaleFlatShape(tShp,flags,x,y,0x20000,0x10000,color,abr);
  }
  else {
    ScaleGouraudShape(tShp,flags,x,y,0x20000,0x10000,color,abr);
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
  short y1;
  short x1;
  int linkAddr;
  u_char  *prim;
  u_char  *prevPrim;
  short x_s;
  
  prim = Render_gPacketPtr;
  prevPrim = Render_gPalettePtr;
  x_s = (short)x;
  x1 = x_s + (short)w;
  *(uint *)Render_gPacketPtr =
       *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
  linkAddr = (uint)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x18;
  *(uint *)prevPrim = *(uint *)prevPrim & 0xff000000 | linkAddr;
  *(int *)(prim + 4) = col;
  prim[7] = 0x28;
  y1 = (short)y;
  *(short *)(prim + 10) = y1;
  *(short *)(prim + 0xe) = y1;
  y1 = y1 + (short)h;
  prim[3] = 5;
  *(short *)(prim + 8) = x_s;
  *(short *)(prim + 0xc) = x1;
  *(short *)(prim + 0x10) = x_s;
  *(short *)(prim + 0x12) = y1;
  *(short *)(prim + 0x14) = x1;
  *(short *)(prim + 0x16) = y1;
  return;
}

/* lines 1350-1353: (static data / macros / comments - no emitted code) */

/* ---- PSXDrawGouraudSquare  (psxfront.cpp:1354, code lines 1354-1368) ---- */
/* GPU packet: builds POLY_G4 (stride 0x24, SetPolyG4); prim=u_char* build cursor, prevPrim=u_char* link word */
void PSXDrawGouraudSquare(int x,int y,int w,int h,int c1,int c2,int c3,int c4)

{
  int linkAddr;
  short y_s;
  short y_plus_h;
  short x_plus_w;
  short x_s;
  u_char  *prevPrim;
  u_char  *prim;
  
  prim = Render_gPacketPtr;
  prevPrim = Render_gPalettePtr;
  *(uint *)Render_gPacketPtr =
       *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
  linkAddr = (uint)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x24;
  *(uint *)prevPrim = *(uint *)prevPrim & 0xff000000 | linkAddr;
  *(int *)(prim + 4) = c1;
  *(int *)(prim + 0xc) = c2;
  *(int *)(prim + 0x14) = c3;
  *(int *)(prim + 0x1c) = c4;
  SetPolyG4((POLY_G4 *)prim);
  x_s = (short)x;
  x_plus_w = x_s + (short)w;
  y_s = (short)y;
  *(short *)(prim + 10) = y_s;
  *(short *)(prim + 0x12) = y_s;
  y_plus_h = y_s + (short)h;
  *(short *)(prim + 8) = x_s;
  *(short *)(prim + 0x10) = x_plus_w;
  *(short *)(prim + 0x18) = x_s;
  *(short *)(prim + 0x1a) = y_plus_h;
  *(short *)(prim + 0x20) = x_plus_w;
  *(short *)(prim + 0x22) = y_plus_h;
  return;
}

/* lines 1369-1376: (static data / macros / comments - no emitted code) */

/* ---- PSXDrawTransGouraudSquare  (psxfront.cpp:1377, code lines 1377-1398) ---- */
/* GPU packet: builds POLY_G4 (stride 0x24, code 0x39); prim=u_char* build cursor, prevPrim=u_char* link word */
void PSXDrawTransGouraudSquare(int x,int y,int w,int h,int opacity,int c1,int c2,int c3,int c4)

{
  int linkAddr;
  uint opacityv;
  uint y_plus_h_pack;
  int i;
  int iter;
  u_char  *prevPrim;
  u_char  *prim;
  
  iter = 0;
  if (0 < opacity) {
    y_plus_h_pack = (y + h) * 0x10000;
    do {
      prim = Render_gPacketPtr;
      prevPrim = Render_gPalettePtr;
      iter = iter + 1;
      *(uint *)Render_gPacketPtr =
           *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
      linkAddr = (uint)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0x24;
      *(uint *)prevPrim = *(uint *)prevPrim & 0xff000000 | linkAddr;
      *(uint *)(prim + 8) = y << 0x10 | opacityv;
      *(uint *)(prim + 0x18) = y_plus_h_pack | opacityv;
      *(int *)(prim + 4) = c1;
      *(int *)(prim + 0xc) = c2;
      *(int *)(prim + 0x14) = c3;
      *(int *)(prim + 0x1c) = c4;
      prim[7] = 0x39;
      prim[3] = 8;
      *(uint *)(prim + 0x10) = y << 0x10 | opacityv + w;
      *(uint *)(prim + 0x20) = y_plus_h_pack | opacityv + w;
    } while (iter < opacity);
  }
  return;
}

/* lines 1399-1403: (static data / macros / comments - no emitted code) */

/* ---- PSXDrawTransSquare  (psxfront.cpp:1404, code lines 1404-1416) ---- */
/* GPU packet: builds POLY_F4 (stride 0x18, code 0x2a); prim=u_char* build cursor, prevPrim=u_char* link word */
void PSXDrawTransSquare(int col,int x,int y,int w,int h,short opacity)

{
  int linkAddr;
  short x_plus_w;
  short xv;
  short yv;
  short y_plus_h;
  short i;
  int iter;
  short ts1;
  short ts2;
  u_char  *prevPrim;
  u_char  *prim;
  
  iter = 0;
  if (0 < opacity) {
    x_plus_w = xv + (short)w;
    y_plus_h = yv + (short)h;
    do {
      prim = Render_gPacketPtr;
      prevPrim = Render_gPalettePtr;
      iter = iter + 1;
      *(uint *)Render_gPacketPtr =
           *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
      linkAddr = (uint)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0x18;
      *(uint *)prevPrim = *(uint *)prevPrim & 0xff000000 | linkAddr;
      *(int *)(prim + 4) = col;
      prim[7] = 0x2a;
      prim[3] = 5;
      *(short *)(prim + 8) = xv;
      *(short *)(prim + 10) = yv;
      *(short *)(prim + 0xc) = x_plus_w;
      *(short *)(prim + 0xe) = yv;
      *(short *)(prim + 0x10) = xv;
      *(short *)(prim + 0x12) = y_plus_h;
      *(short *)(prim + 0x14) = x_plus_w;
      *(short *)(prim + 0x16) = y_plus_h;
    } while (iter * 0x10000 >> 0x10 < (int)opacity);
  }
  return;
}

/* lines 1417-1433: (static data / macros / comments - no emitted code) */

/* ---- FontUpsideDownBlit  (psxfront.cpp:1434, code lines 1434-1466) ---- */
/* GPU packet: builds POLY_FT4 (stride 0x28, code 0x2c); prim=u_char* build cursor, prevPrim=u_char* link word */
int FontUpsideDownBlit(int x,int y,void *src,int u,int v,charactertbl *ch,int arg6)

{
  byte uv_y_top;
  uint tpageBit;
  short w1;
  int tpage_clut;
  byte uv_y_bottom;
  int dv;
  int c4;
  int linkAddr;
  int h;
  short x_plus_w;
  int height;
  int width;
  char *permFile;
  short w;
  short vh;
  char fullName [48];
  u_char  *next_pkt;
  u_char  *prim;
  u_char  *prevPrim;
  byte char_w;
  byte char_h;
  byte uv_offset;
  short dstX;
  u_long fontTint;
  byte char_x;
  short y_top;
  byte tc2;
  
  prim = Render_gPacketPtr;
  prevPrim = Render_gPalettePtr;
  char_w = ch->width;
  char_h = ch->height;
  uv_offset = ch->yoffset;
  uv_y_bottom = ((char)((*(int *)((int)src + 0xc) << 4) >> 0x14) + (char)v) - 1;
  linkAddr = (uint)Render_gPacketPtr & 0xffffff;
  next_pkt = Render_gPacketPtr + 0x28;
  *(uint *)Render_gPacketPtr =
       *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
  Render_gPacketPtr = next_pkt;
  fontTint = font_tint;
  *(uint *)prevPrim = *(uint *)prevPrim & 0xff000000 | linkAddr;
  *(u_long *)(prim + 4) = fontTint;
  prim[3] = 9;
  prim[7] = 0x2c;
  y_top = ((short)y + (char)uv_offset * -2 + 5) - (ushort)char_h;
  *(ushort *)(prim + 0xe) = gFontClut;
  char_x = *(byte *)src;
  tpage_clut = *(int *)((int)src + 0xc);
  tc2 = (byte)u;
  uv_y_top = tc2 + char_w;
  prim[0xd] = uv_y_bottom;
  prim[0x15] = uv_y_bottom;
  dstX = (short)x;
  x_plus_w = dstX + (ushort)char_w;
  prim[0xc] = tc2;
  prim[0x14] = uv_y_top;
  prim[0x1c] = tc2;
  prim[0x1d] = uv_y_bottom + char_h;
  prim[0x24] = uv_y_top;
  prim[0x25] = uv_y_bottom + char_h;
  *(short *)(prim + 8) = dstX;
  tpageBit = (uint)tpage_clut >> 0x14 & 0x10;
  *(ushort *)(prim + 0x16) =
       (char_x & 3) << 7 | (ushort)tpageBit | (ushort)((int)(tpage_clut & 0x3ffU) >> 6);
  *(ushort *)(prim + 10) = y_top + (ushort)char_h;
  *(short *)(prim + 0x10) = x_plus_w;
  *(ushort *)(prim + 0x12) = y_top + (ushort)char_h;
  *(short *)(prim + 0x18) = dstX;
  *(short *)(prim + 0x1a) = y_top;
  *(short *)(prim + 0x20) = x_plus_w;
  *(short *)(prim + 0x22) = y_top;
  return tpageBit;
}

/* end of psxfront.cpp */
