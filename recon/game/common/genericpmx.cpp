/* game/common/genericpmx.cpp -- RECONSTRUCTED (NFS4 PSX generic-PMX texture loader; C++ TU)
 *   1 free fn: GenericPMX_LoadTexture(void). The unproved pmx_height carrier remains. GTE-free.
 */
#include "genericpmx_types.h"
#include "genericpmx_externs.h"

/* ---- genericpmx.obj-owned Draw_tPixMap globals ----
 * P912: native typed SYM27bd72..27be86 fixes the seven .data arrays at
 * 0x80112B2C..0x80113044 in the order below. Their zero-filled payload cannot
 * reveal a wrong named-array order: Spark/StartUp/Weather precede Flare/Lightning.
 * The former 0x80112AE0 base/order comment was not native evidence.
 * Existing .sdata declarations from 0x8013D1DC and their literal pool are
 * unchanged by this .data-only declaration-order recovery.
 */
Draw_tPixMap  *gDLPixmap[10];        /* @0x80112b2c; .data +0x00 */
Draw_tPixMap  *gSparkHPixmap[6];     /* @0x80112b54; .data +0x28 */
Draw_tPixMap  *gStartUpPixmap[4];    /* @0x80112b6c; .data +0x40 */
Draw_tPixMap  *gWeatherPixmap[3];    /* @0x80112b7c; .data +0x50 */
Draw_tPixMap  *gFlarePixmap[3];      /* @0x80112b88; .data +0x5c */
Draw_tPixMap  *gLightningPixmap[16]; /* @0x80112b94; .data +0x68 */
Draw_tPixMap  gPixmaps[71];          /* @0x80112bd4; .data +0xa8 */
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
  /* SOURCE-RECOVERY-UNRESOLVED: pmx_height is not a recovered caller name.
     Its 0xa0 value feeds Texture_LoadPmx's ry argument (SYM46bf5f), not height.
     P913 production-compiler traces show a shared constant pseudo that reload
     rematerializes in t0. This explains current PASS, not original identity.
     Literal removal on the restored scope shape still emits 579/593 with
     494 detailed diffs. Keep this existing name visibly unresolved until
     its original source/context is recovered; do not rename it to ry. */
  int pmx_height;

  np = 0;
  pmx_height = 0xa0;
  if ((GameSetup_gData.track & 0xfU) == 4) {
    if (GameSetup_gData.Weather != 0) {
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

  if (GameSetup_gData.Weather != 0) {
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

  if ((GameSetup_gData.Time == 0) &&
      (GameSetup_gData.commMode != 1)) {
    shapetbl *shape;
    char shpname[5];
    sprintf(shpname,"LF%02d",GameSetup_gData.track);
    shape = (shapetbl *)locateshapez(shpfile,shpname);
    if (shape != 0) {
      {
        Draw_tPixMap *pmx = &gPixmaps[np++];
        Texture_LoadPmx(0,(char *)shape,0x40,0,pmx_height,-1,-1,pmx);
        gLeafPixmap = pmx;
      }
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

  if (GameSetup_gData.Weather != 0) {
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
    if ((TrackSpec_gSpec.skyspec.flags & 8U) != 0) {
      {
        Draw_tPixMap *pmx = &gPixmaps[np++];
        Texture_LoadPmx(shpfile,"MONF",0x40,0,pmx_height,-1,-1,pmx);
        gFlarePixmap[0] = pmx;
      }
    }

    if ((TrackSpec_gSpec.skyspec.flags & 4U) != 0) {
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
      ({
        ChangeTPage(&gFlarePixmap[0]->tpage,1);
        ChangeTPage(&gFlarePixmap[1]->tpage,1);
        ChangeTPage(&gFlarePixmap[2]->tpage,1);
      });
    }
  }

  purgememadr(shpfile);
}

/* end of genericpmx.cpp */
