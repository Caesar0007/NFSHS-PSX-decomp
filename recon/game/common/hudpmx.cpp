/* game/common/hudpmx.cpp -- RECONSTRUCTED (NFS4 HUD pixmap/shape loader; C++ TU).
 *   3 free fns: HudPmx_LoadShape (locate+LoadPmx a HUD shape), HudPmx_InitTextures (build the
 *   HUD glyph/icon texture set), HudPmx_Kill. GTE-free.
 */
#include "../../nfs4_types.h"
#include "hudpmx_externs.h"

/* ---- HudPmx.obj OWNED globals ($gp state) ---- */
char  *gHudFont;        /* 0x8013dda4 */
char  *gShpfile;        /* 0x8013dda8 */
char   loadShapeXOff;   /* 0x8013ddac */
/* Note: the two patchable HUD shape-name buffers @0x8013cd34/0x8013cd3c are the SYM STAT locals
   `alph` (char[5]="alpX"), materialized as scoped statics inside InitTextures; the other 8 names
   (alTR/alCI/.. @0x8013cd44+) are anonymous .rodata strings -> emitted as string literals. */
/* ---- HudPmx.obj OWNED data tables ---- */
HudPmx_tUV     HudPmx_gHudNumberUV[10];   /* 0x80110c70 */
HudPmx_tShape  HudPmx_gShapes[175];        /* 0x80110c98 */

/* ---- intra-TU forward declarations ---- */
void HudPmx_LoadShape(char *n,HudPmx_tShape *s);
void HudPmx_InitTextures(void);
void HudPmx_Kill(void);


/* ---- HudPmx_LoadShape__FPcP13HudPmx_tShape  [HUDPMX.CPP:24-36] SLD-VERIFIED ---- */
/* HIDDEN-PHANTOM FIX (w14-a2): oracle mangles __FPcP13HudPmx_tShape (2nd param HudPmx_tShape*)
 * -- was P12Draw_tPixMap, a NAME MISMATCH invisible to the gate. Raw @0x80092464 also shows the
 * body was wrong regardless of the type name: it stored to a bogus s[1] (stride-16, the WRONG
 * struct's size) instead of s->width/s->height (offsets +0x10/+0x12 of the real 20-byte
 * HudPmx_tShape, matching `*((short*)(16+$s0))`/`*((short*)(18+$s0))`) and fabricated a `clut`
 * store the oracle never makes. Texture_LoadPmx's last arg is literally $s0 (s itself, cast --
 * HudPmx_tShape::pixmap is the struct's first member so the address is identical). */
void HudPmx_LoadShape(char *n,HudPmx_tShape *s)

{
  shapetbl *shp;

  shp = locateshape(gShpfile,n);
  s->width  = shp->width;
  s->height = shp->height;
  Texture_LoadPmx(gShpfile,n,0x41,loadShapeXOff + 0x80,0x80,-1,-1,(Draw_tPixMap *)s);
  return;
}

/* ---- HudPmx_InitTextures__Fv  [HUDPMX.CPP:40-204] SLD-VERIFIED ---- */
void HudPmx_InitTextures(void)

{
  int carType0;
  int carType1;
  char name[256];
  int i;
  char *tachs[29] = {
    "tslk","tbz3","thsv","tfor","tz28","ttra","tdb7","txkr","ttm5","tvet",
    "t550","t911","tf50","tdsv","tclk","tmcf","t911","thsv","tvet","tbon",
    "tbon","tbon","tcap","thsv","ttm5","tvet","t911","tdsv","tbon"
  };
  char *ntachs[29] = {
    "nslk","nbz3","nhsv","nfor","nz28","ntra","ndb7","nxkr","nnm5","nvet",
    "n550","n911","nf50","tdsv","tclk","nmcf","n911","nhsv","nvet","nbon",
    "nbon","nbon","ncap","nhsv","nnm5","nvet","n911","tdsv","nbon"
  };
  char mapname[5];

  sprintf(mapname,"mp%02d",GameSetup_gData.track);

  char *shapes[132] = {
    "cmra","cam0","cam1","cam2","cam3","cam4","cam5","cam6","cam7","cam8",
    "cam9","ca10","ca11","ca12","crn1","crn2","crn3","crn4","arrl","arrr",
    "mwt1","mwt2","mwb1","mwb2","msid","msi2","kmhh","mphh","gea1","gea2",
    "gea3","gea4","gea5","gea6","smln","smlr","pau0","pau1","pau2","pau3",
    "rwid","rwi2","rsid","rsi2","big0","big1","big2","big3","big4","big5",
    "big6","big7","big8","big9","sml1","sml2","sml3","sml4","sml5","sml6",
    "321d","321l","mpbt","smlx","sml+","sml-","sml:","sml\"","sml'","sml,",
    "sml.","sml/","ahyp","acol","a192","a193","a194","wrng","a196","a197",
    "wrng","a199","a200","a201","wrng","a203","a204","a205","a206","a207",
    "wrng","a209","a210","a211","a212","wrng","a214","wrng","wrng","a217",
    "a218","a219","a220","A229","wrng","time","timb","laps","ejct","play",
    "paus","resg","rad0","rad1","s1/4","s1/2","spd2","spd1","plus","minu",
    mapname,"plr1","oppn","barl","barr","barb","baXl","baXr","tacc",
    tachs[0],"tpno",tachs[0]
  };
  loadShapeXOff = 0;
  sprintf(name,"%sfont.pfn",Paths_Paths[0x1a]);
  gHudFont = loadfileadrz(name,0);
  Font_LoadFont(gHudFont,0x80,0x80,1);
  {
    int u;
    int v;
    int w;
    int h;
    int yo;

    HudPmx_tUV *numberUV = HudPmx_gHudNumberUV;
    i = 0;
    goto HudPmxInit_fontLoopTest;
HudPmxInit_fontLoop:
      Font_GetUVWH((char)(i + '0'),&u,&v,&w,&h,&yo);
      numberUV->u0 = (u_char)u;
      numberUV->v0 = (u_char)v;
      numberUV->clut = gFontClut;
      i = i + 1;
      numberUV = numberUV + 1;
HudPmxInit_fontLoopTest:
    if (i < 10) {
      goto HudPmxInit_fontLoop;
    }
  }
  sprintf(name,"%shud.psh",Paths_Paths[0x1a]);
  gShpfile = (char *)loadfileadr(name,0);
  Texture_ResetPaletteSharing();
  carType0 = GameSetup_gData.carInfo[0].carType;
  carType1 = GameSetup_gData.carInfo[1].carType;
  if (GameSetup_gData.Time != 0) {
    if (carType0 < 0x1e) {
      shapes[129] = ntachs[carType0];
    }
    else {
      shapes[129] = "nbon";
    }
    if (carType1 < 0x1e) {
      shapes[131] = ntachs[carType1];
      goto HudPmxInit_shapeLoadLoop;
    }
    shapes[131] = "nbon";
  }
  else {
    if (carType0 < 0x1e) {
      shapes[129] = tachs[carType0];
    }
    else {
      shapes[129] = "tbon";
    }
    if (carType1 < 0x1e) {
      shapes[131] = tachs[carType1];
      goto HudPmxInit_shapeLoadLoop;
    }
    shapes[131] = "tbon";
  }
HudPmxInit_shapeLoadLoop:
  i = 0;
  {
    char **shape = shapes;
    HudPmx_tShape *hudShape = HudPmx_gShapes;

  do {
    HudPmx_LoadShape(*shape,hudShape);
    shape = shape + 1;
    hudShape = hudShape + 1;
    i = i + 1;
  } while (i < 0x83);
  }
  {
    HudPmx_tShape *hudShape = HudPmx_gShapes + 132;

  for (i = 0x84; i < 0x9e; i = i + 1) {
    { static char alph [5] = "alpX";  /* @0x8013cd34, runtime-patched at [3] */
      alph[3] = (char)i + -0x43;
      HudPmx_LoadShape(alph,hudShape); }
    hudShape = hudShape + 1;
  }
  }
  {
    HudPmx_tShape *hudShape = HudPmx_gShapes + 158;

  for (i = 0x9e; i < 0xa8; i = i + 1) {
    { static char alph [5] = "alpX";  /* @0x8013cd3c, runtime-patched at [3] */
      alph[3] = (char)i + -0x6e;
      HudPmx_LoadShape(alph,hudShape); }
    hudShape = hudShape + 1;
  }
  }
  HudPmx_LoadShape("alTR",&HudPmx_gShapes[168] /* @0x801119b8 */);
  HudPmx_LoadShape("alCI",&HudPmx_gShapes[169] /* @0x801119cc */);
  HudPmx_LoadShape("alSQ",&HudPmx_gShapes[170] /* @0x801119e0 */);
  HudPmx_LoadShape("negA",&HudPmx_gShapes[171] /* @0x801119f4 */);
  HudPmx_LoadShape("negB",&HudPmx_gShapes[172] /* @0x80111a08 */);
  HudPmx_LoadShape("neg2",&HudPmx_gShapes[173] /* @0x80111a1c */);
  HudPmx_LoadShape("alUP",&HudPmx_gShapes[174] /* @0x80111a30 */);
  {
  HudPmx_tShape *hudShape = HudPmx_gShapes + 74;
  for (i = 0; i < 0x1c; i = i + 1) {
    HudPmx_LoadShape(shapes[i + 74],hudShape);
    hudShape = hudShape + 1;
  }
  }
  HudPmx_LoadShape("a229",&HudPmx_gShapes[103] /* @0x801114a4 */);
  HudPmx_LoadShape("ahyp",&HudPmx_gShapes[72] /* @0x80111238 */);
  HudPmx_LoadShape("acol",&HudPmx_gShapes[73] /* @0x8011124c */);
  if (DashHUD_gInfo.splitscreen != 0) {
    loadShapeXOff = 0x16;
    HudPmx_LoadShape(shapes[131],&HudPmx_gShapes[131] /* @0x801116d4 */);
  }
  purgememadr(gShpfile);
  return;
}

/* ---- HudPmx_Kill__Fv  [HUDPMX.CPP:209-210] SLD-VERIFIED ---- */
void HudPmx_Kill(void)

{
  purgememadr(gHudFont);
  return;
}

/* end of hudpmx.cpp */
