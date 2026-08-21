/* game/common/genericpmx.cpp -- RECONSTRUCTED (NFS4 PSX generic-PMX texture loader; C++ TU)
 *   1 free fn: GenericPMX_LoadTexture(void) [208 LoC]. Full SYM-locals applied. GTE-free.
 */
#include "genericpmx_types.h"
#include "genericpmx_externs.h"

/* ---- genericpmx.obj OWNED globals (Draw_tPixMap pool; EXT; SYM Globals.jsonl) ----
 * DECLARATION ORDER IS RETAIL'S EMISSION ORDER (w64-a18).  The list was
 * previously ALPHABETICAL -- a reconstruction artefact, not retail: gcc emits
 * each section in declaration order, so the alphabetical list put this TU's
 * 13 small-data pointers in the wrong .sdata order and the whole 276-byte
 * retail run 0x8013D10C..0x8013D220 was un-placeable (ownmap E3: 10 distinct
 * implied bases).  The two groups below are ordered by their RETAIL VAs:
 *   .data  @0x80112AE0: gDLPixmap gFlarePixmap gLightningPixmap gSparkHPixmap
 *                       gStartUpPixmap gWeatherPixmap gPixmaps
 *   .sdata @0x8013D1DC: gDPixmap gSpikeBeltPixmap gShadowPixmap
 *                       gSkidMarkPixmap gSMokePixmap gSMokePalette
 *                       gDirtPalette gGravelPixmap gGravelPalette
 *                       gGrassPalette gSnowPalette gLeafPixmap gDamagePixmap
 * Do NOT re-sort these lists.
 */
Draw_tPixMap  *gDLPixmap[10];        /* .data  +0x00 */
Draw_tPixMap  *gFlarePixmap[3];      /* .data  +0x28 */
Draw_tPixMap  *gLightningPixmap[16]; /* .data  +0x34 */
Draw_tPixMap  *gSparkHPixmap[6];     /* .data  +0x74 */
Draw_tPixMap  *gStartUpPixmap[4];    /* .data  +0x8c */
Draw_tPixMap  *gWeatherPixmap[3];    /* .data  +0x9c */
Draw_tPixMap  gPixmaps[71];          /* .data  +0xa8 */
Draw_tPixMap  *gDPixmap;             /* @0x8013d1dc */
Draw_tPixMap  *gSpikeBeltPixmap;     /* @0x8013d1e0 */
Draw_tPixMap  *gShadowPixmap[2];     /* @0x8013d1e4 */
Draw_tPixMap  *gSkidMarkPixmap[2];   /* @0x8013d1ec */
Draw_tPixMap  *gSMokePixmap[2];      /* @0x8013d1f4 */
Draw_tPixMap  *gSMokePalette;        /* @0x8013d1fc */
Draw_tPixMap  *gDirtPalette;         /* @0x8013d200 */
Draw_tPixMap  *gGravelPixmap[2];     /* @0x8013d204 */
Draw_tPixMap  *gGravelPalette;       /* @0x8013d20c */
Draw_tPixMap  *gGrassPalette;        /* @0x8013d210 */
Draw_tPixMap  *gSnowPalette;         /* @0x8013d214 */
Draw_tPixMap  *gLeafPixmap;          /* @0x8013d218 */
Draw_tPixMap  *gDamagePixmap;        /* @0x8013d21c */

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void GenericPMX_LoadTexture(void);


/* ---- GenericPMX_LoadTexture__Fv  [GENERICPMX.CPP:54-200] SLD-VERIFIED ---- */
void GenericPMX_LoadTexture(void)
{
  char name[255];
  char *shpfile;
  int np;
  int i;
  int recolor_flag;
  int pmx_height; /* matching aid (permuter): keep the repeated call argument in one pseudo */
  shapetbl *shape_result; /* matching aid (permuter): preserve the locate result pseudo */

  np = 0;
  pmx_height = 0xa0;
  if ((GenericPMX_gameSetupWords[15] & 0xfU) == 4) {
    if (GenericPMX_gameSetupWords[18] != 0) {
      sprintf(name,"%sSfx4w.psh",Paths_Paths[0x19]);
    }
    else {
      sprintf(name,"%sSfx4.psh",Paths_Paths[0x19]);
    }
  }
  else {
    sprintf(name,"%sSfx.psh",Paths_Paths[0x19]);
  }

  shpfile = (char *)loadfileadr(name,0);
  Texture_ResetPaletteSharing();
  recolor_flag = 0;

  for (i = 0; i < 10; i++) {
    sprintf(name,"LIN%d",i);
    {
      Draw_tPixMap *pmx = &gPixmaps[np++];
      Texture_LoadPmx(shpfile,name,recolor_flag | 0x40,0,pmx_height,-1,-1,pmx);
      gDLPixmap[i] = pmx;
    }
  }

  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"spik",0x40,0,pmx_height,-1,-1,pmx);
    gSpikeBeltPixmap = pmx;
  }
  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"DEBG",0x40,0,pmx_height,-1,-1,pmx);
    gDPixmap = pmx;
  }
  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"SHAD",0x40,0,pmx_height,-1,-1,pmx);
    gShadowPixmap[0] = pmx;
  }
  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"SKD0",0x40,0,pmx_height,-1,-1,pmx);
    gSkidMarkPixmap[0] = pmx;
  }
  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"SKD1",0x40,0,pmx_height,-1,-1,pmx);
    gSkidMarkPixmap[1] = pmx;
  }
  ChangeTPage(&gSkidMarkPixmap[0]->tpage,2);
  ChangeTPage(&gSkidMarkPixmap[1]->tpage,2);

  if (GenericPMX_gameSetupWords[18] != 0) {
    {
      Draw_tPixMap *pmx = &gPixmaps[np++];
      Texture_LoadPmx(shpfile,"FLAK",0x40,0,pmx_height,-1,-1,pmx);
      gWeatherPixmap[0] = pmx;
    }
    {
      Draw_tPixMap *pmx = &gPixmaps[np++];
      Texture_LoadPmx(shpfile,"FLA1",0x40,0,pmx_height,-1,-1,pmx);
      gWeatherPixmap[1] = pmx;
    }
    {
      Draw_tPixMap *pmx = &gPixmaps[np++];
      Texture_LoadPmx(shpfile,"SPLT",0x40,0,pmx_height,-1,-1,pmx);
      gWeatherPixmap[2] = pmx;
    }
    ChangeTPage(&gWeatherPixmap[0]->tpage,1);
    ChangeTPage(&gWeatherPixmap[1]->tpage,1);
    ChangeTPage(&gWeatherPixmap[2]->tpage,1);
  }

  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"SMX0",0x40,0,pmx_height,-1,-1,pmx);
    gSMokePixmap[0] = pmx;
  }
  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"SMX1",0x40,0,pmx_height,-1,-1,pmx);
    gSMokePixmap[1] = pmx;
  }
  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"SMOK",0,-1,-1,-1,-1,pmx);
    gSMokePalette = pmx;
  }
  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"DIRT",0,-1,-1,-1,-1,pmx);
    gDirtPalette = pmx;
  }
  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"GRX0",0x40,0,pmx_height,-1,-1,pmx);
    gGravelPixmap[0] = pmx;
  }
  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"GRX1",0x40,0,pmx_height,-1,-1,pmx);
    gGravelPixmap[1] = pmx;
  }
  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"GRAV",0,-1,-1,-1,-1,pmx);
    gGravelPalette = pmx;
  }
  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"GRAS",0,-1,-1,-1,-1,pmx);
    gGrassPalette = pmx;
  }
  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"SNOW",0,-1,-1,-1,-1,pmx);
    gSnowPalette = pmx;
  }

  for (i = 0; i < 6; i++) {
    sprintf(name,"SHX%d",i);
    {
      Draw_tPixMap *pmx = &gPixmaps[np++];
      Texture_LoadPmx(shpfile,name,0x40,0,pmx_height,-1,-1,pmx);
      gSparkHPixmap[i] = pmx;
    }
  }

  if ((GenericPMX_gameSetupWords[21] == 0) &&
      (GenericPMX_gameSetupWords[3] != 1)) {
    shapetbl *shape;
    char shpname[5];
    sprintf(shpname,"LF%02d",GenericPMX_gameSetupWords[15]);
    shape = (shape_result = (shapetbl *)locateshapez(shpfile,shpname));
    if (shape != 0) {
      Draw_tPixMap *pmx = &gPixmaps[np++];
      Texture_LoadPmx(0,(char *)shape,0x40,0,pmx_height,-1,-1,pmx);
      gLeafPixmap = pmx;
    }
    else {
      gLeafPixmap = 0;
    }
  }
  else {
    gLeafPixmap = 0;
  }

  {
    Draw_tPixMap *pmx = &gPixmaps[np++];
    Texture_LoadPmx(shpfile,"DAMG",0x40,0,pmx_height,-1,-1,pmx);
    gDamagePixmap = pmx;
  }

  if (GenericPMX_gameSetupWords[18] != 0) {
    for (i = 0; i < 8; i++) {
      sprintf(name,"LNG%d",i);
      {
        Draw_tPixMap *pmx = &gPixmaps[np++];
        Texture_LoadPmx(shpfile,name,0x40,0,pmx_height,-1,-1,pmx);
        gLightningPixmap[i] = pmx;
      }
      {
        Draw_tPixMap *pmx = &gPixmaps[np++];
        gLightningPixmap[i + 8] = pmx;
      }
      ChangeTPage(&gLightningPixmap[i]->tpage,1);
      Texture_CloneUVPmx(gLightningPixmap[i],0,gLightningPixmap[i + 8]);
    }
  }
  else {
    if ((GenericPMX_trackSpecWords[23] & 8U) != 0) {
      Draw_tPixMap *pmx = &gPixmaps[np++];
      Texture_LoadPmx(shpfile,"MONF",0x40,0,pmx_height,-1,-1,pmx);
      gFlarePixmap[0] = pmx;
    }

    if ((GenericPMX_trackSpecWords[23] & 4U) != 0) {
      {
        Draw_tPixMap *pmx = &gPixmaps[np++];
        Texture_LoadPmx(shpfile,"FLR0",0x40,0,pmx_height,-1,-1,pmx);
        gFlarePixmap[0] = pmx;
      }
      {
        Draw_tPixMap *pmx = &gPixmaps[np++];
        Texture_LoadPmx(shpfile,"FLR1",0x40,0,pmx_height,-1,-1,pmx);
        gFlarePixmap[1] = pmx;
      }
      {
        Draw_tPixMap *pmx = &gPixmaps[np++];
        Texture_LoadPmx(shpfile,"RBOW",0x40,0,pmx_height,-1,-1,pmx);
        gFlarePixmap[2] = pmx;
      }
      ChangeTPage(&gFlarePixmap[0]->tpage,1);
      ChangeTPage(&gFlarePixmap[1]->tpage,1);
      ChangeTPage(&gFlarePixmap[2]->tpage,1);
    }
  }

  purgememadr(shpfile);
}

/* end of genericpmx.cpp */
