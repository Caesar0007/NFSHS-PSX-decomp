/* game/common/genericpmx.cpp -- RECONSTRUCTED (NFS4 PSX generic-PMX texture loader; C++ TU)
 *   1 free fn: GenericPMX_LoadTexture(void) [208 LoC]. Full SYM-locals applied. GTE-free.
 */
#include "../../nfs4_types.h"
#include "genericpmx_externs.h"

/* ---- genericpmx.obj OWNED globals (Draw_tPixMap pool; EXT; SYM Globals.jsonl) ---- */
Draw_tPixMap  *gDLPixmap[10];
Draw_tPixMap  *gDPixmap;
Draw_tPixMap  *gDamagePixmap;
Draw_tPixMap  *gDirtPalette;
Draw_tPixMap  *gFlarePixmap[3];
Draw_tPixMap  *gGrassPalette;
Draw_tPixMap  *gGravelPalette;
Draw_tPixMap  *gGravelPixmap[2];
Draw_tPixMap  *gLeafPixmap;
Draw_tPixMap  *gLightningPixmap[16];
Draw_tPixMap  *gSMokePalette;
Draw_tPixMap  *gSMokePixmap[2];
Draw_tPixMap  *gShadowPixmap[2];
Draw_tPixMap  *gSkidMarkPixmap[2];
Draw_tPixMap  *gSnowPalette;
Draw_tPixMap  *gSparkHPixmap[6];
Draw_tPixMap  *gSpikeBeltPixmap;
Draw_tPixMap  *gStartUpPixmap[4];
Draw_tPixMap  *gWeatherPixmap[3];
Draw_tPixMap  gPixmaps[71];

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void GenericPMX_LoadTexture(void);


/* ---- GenericPMX_LoadTexture__Fv  [GENERICPMX.CPP:54-200] SLD-VERIFIED ---- */
void GenericPMX_LoadTexture(void)

{
  bool bVar1;
  shapetbl *shape;
  char *n;
  Draw_tPixMap *pDVar2;
  char *pcVar3;
  Draw_tPixMap *pmx;
  Draw_tPixMap **ppDVar4;
  void *tp5;
  int i;
  int iVar5;
  int iVar6;
  int iVar7;
  int np;
  int iVar8;
  char *shpfile;
  int recolor_flag;
  char name [255];
  char shpname [5];
  
  if ((GameSetup_gData.track & 0xfU) == 4) {
    if (GameSetup_gData.Weather == 0) {
      pcVar3 = "%sSfx4.psh";
    }
    else {
      pcVar3 = "%sSfx4w.psh";
    }
  }
  else {
    pcVar3 = "%sSfx.psh";
  }
  pcVar3 = (char *)sprintf(name,pcVar3,Paths_Paths[0x19]);
  loadfileadr(name,0);
  Texture_ResetPaletteSharing();
  ppDVar4 = gDLPixmap;
  iVar7 = 0;
  for (iVar5 = 0; iVar5 < 10; iVar5 = iVar5 + 1) {
    sprintf(name,"LIN%d",iVar5);
    Texture_LoadPmx(pcVar3,name,0x40,0,0xa0,-1,-1,gPixmaps + iVar7);
    *ppDVar4 = gPixmaps + iVar7;
    ppDVar4 = ppDVar4 + 1;
    iVar7 = iVar7 + 1;
  }
  Texture_LoadPmx(pcVar3,"spik",0x40,0,0xa0,-1,-1,gPixmaps + iVar7);
  gSpikeBeltPixmap = gPixmaps + iVar7;
  Texture_LoadPmx(pcVar3,"DEBG",0x40,0,0xa0,-1,-1,gPixmaps + iVar7 + 1);
  gDPixmap = gPixmaps + iVar7 + 1;
  Texture_LoadPmx(pcVar3,"SHAD",0x40,0,0xa0,-1,-1,gPixmaps + iVar7 + 2);
  gShadowPixmap[0] = gPixmaps + iVar7 + 2;
  Texture_LoadPmx(pcVar3,"SKD0",0x40,0,0xa0,-1,-1,gPixmaps + iVar7 + 3);
  gSkidMarkPixmap[0] = gPixmaps + iVar7 + 3;
  Texture_LoadPmx(pcVar3,"SKD1",0x40,0,0xa0,-1,-1,gPixmaps + iVar7 + 4);
  gSkidMarkPixmap[1] = gPixmaps + iVar7 + 4;
  ChangeTPage(&gSkidMarkPixmap[0]->tpage,2);
  ChangeTPage(&gSkidMarkPixmap[1]->tpage,2);
  iVar5 = iVar7 + 5;
  if (GameSetup_gData.Weather != 0) {
    Texture_LoadPmx(pcVar3,"FLAK",0x40,0,0xa0,-1,-1,gPixmaps + iVar5);
    gWeatherPixmap[0] = gPixmaps + iVar5;
    Texture_LoadPmx(pcVar3,"FLA1",0x40,0,0xa0,-1,-1,gPixmaps + iVar7 + 6);
    iVar5 = iVar7 + 8;
    gWeatherPixmap[1] = gPixmaps + iVar7 + 6;
    Texture_LoadPmx(pcVar3,"SPLT",0x40,0,0xa0,-1,-1,gPixmaps + iVar7 + 7);
    gWeatherPixmap[2] = gPixmaps + iVar7 + 7;
    ChangeTPage(&gWeatherPixmap[0]->tpage,1);
    ChangeTPage(&gWeatherPixmap[1]->tpage,1);
    ChangeTPage(&gWeatherPixmap[2]->tpage,1);
  }
  Texture_LoadPmx(pcVar3,"SMX0",0x40,0,0xa0,-1,-1,gPixmaps + iVar5);
  gSMokePixmap[0] = gPixmaps + iVar5;
  Texture_LoadPmx(pcVar3,"SMX1",0x40,0,0xa0,-1,-1,gPixmaps + iVar5 + 1);
  gSMokePixmap[1] = gPixmaps + iVar5 + 1;
  Texture_LoadPmx(pcVar3,"SMOK",0,-1,-1,-1,-1,gPixmaps + iVar5 + 2);
  gSMokePalette = gPixmaps + iVar5 + 2;
  Texture_LoadPmx(pcVar3,"DIRT",0,-1,-1,-1,-1,gPixmaps + iVar5 + 3);
  gDirtPalette = gPixmaps + iVar5 + 3;
  Texture_LoadPmx(pcVar3,"GRX0",0x40,0,0xa0,-1,-1,gPixmaps + iVar5 + 4);
  gGravelPixmap[0] = gPixmaps + iVar5 + 4;
  Texture_LoadPmx(pcVar3,"GRX1",0x40,0,0xa0,-1,-1,gPixmaps + iVar5 + 5);
  gGravelPixmap[1] = gPixmaps + iVar5 + 5;
  Texture_LoadPmx(pcVar3,"GRAV",0,-1,-1,-1,-1,gPixmaps + iVar5 + 6);
  gGravelPalette = gPixmaps + iVar5 + 6;
  Texture_LoadPmx(pcVar3,"GRAS",0,-1,-1,-1,-1,gPixmaps + iVar5 + 7);
  gGrassPalette = gPixmaps + iVar5 + 7;
  Texture_LoadPmx(pcVar3,"SNOW",0,-1,-1,-1,-1,gPixmaps + iVar5 + 8);
  ppDVar4 = gSparkHPixmap;
  iVar7 = iVar5 + 9;
  gSnowPalette = gPixmaps + iVar5 + 8;
  for (iVar6 = 0; iVar6 < 6; iVar6 = iVar6 + 1) {
    sprintf(name,"SHX%d",iVar6);
    Texture_LoadPmx(pcVar3,name,0x40,0,0xa0,-1,-1,gPixmaps + iVar7);
    *ppDVar4 = gPixmaps + iVar7;
    ppDVar4 = ppDVar4 + 1;
    iVar7 = iVar7 + 1;
  }
  if ((GameSetup_gData.Time == 0) && (GameSetup_gData.commMode != 1)) {
    sprintf(shpname,"LF%02d",GameSetup_gData.track);
    n = locateshapez(pcVar3,shpname);
    if (n != (char *)0x0) {
      pDVar2 = gPixmaps + iVar7;
      Texture_LoadPmx((char *)0x0,n,0x40,0,0xa0,-1,-1,pDVar2);
      iVar7 = iVar7 + 1;
      gLeafPixmap = pDVar2;
      goto GenPMX_loadDamgPmx;
    }
  }
  gLeafPixmap = (Draw_tPixMap *)0x0;
GenPMX_loadDamgPmx:
  pDVar2 = gPixmaps + iVar7;
  Texture_LoadPmx(pcVar3,"DAMG",0x40,0,0xa0,-1,-1,pDVar2);
  iVar5 = iVar7 + 1;
  gDamagePixmap = pDVar2;
  if (GameSetup_gData.Weather == 0) {
    iVar6 = iVar5;
    if ((TrackSpec_gSpec.skyspec.flags & 8U) != 0) {
      iVar6 = iVar7 + 2;
      Texture_LoadPmx(pcVar3,"MONF",0x40,0,0xa0,-1,-1,gPixmaps + iVar5);
      gFlarePixmap[0] = gPixmaps + iVar5;
    }
    if ((TrackSpec_gSpec.skyspec.flags & 4U) != 0) {
      Texture_LoadPmx(pcVar3,"FLR0",0x40,0,0xa0,-1,-1,gPixmaps + iVar6);
      gFlarePixmap[0] = gPixmaps + iVar6;
      Texture_LoadPmx(pcVar3,"FLR1",0x40,0,0xa0,-1,-1,gPixmaps + iVar6 + 1);
      gFlarePixmap[1] = gPixmaps + iVar6 + 1;
      Texture_LoadPmx(pcVar3,"RBOW",0x40,0,0xa0,-1,-1,gPixmaps + iVar6 + 2);
      gFlarePixmap[2] = gPixmaps + iVar6 + 2;
      ChangeTPage(&gFlarePixmap[0]->tpage,1);
      ChangeTPage(&gFlarePixmap[1]->tpage,1);
      ChangeTPage(&gFlarePixmap[2]->tpage,1);
    }
  }
  else {
    iVar7 = 0;
    ppDVar4 = gLightningPixmap;
    iVar6 = 0x20;
    bVar1 = true;
    while (bVar1) {
      sprintf(name,"LNG%d",iVar7);
      iVar8 = iVar5 + 1;
      pDVar2 = gPixmaps + iVar5;
      Texture_LoadPmx(pcVar3,name,0x40,0,0xa0,-1,-1,pDVar2)
      ;
      iVar5 = iVar5 + 2;
      tp5 = (void *)((int)&gLightningPixmap + iVar6);
      iVar6 = iVar6 + 4;
      *ppDVar4 = pDVar2;
      *(Draw_tPixMap **)tp5 = gPixmaps + iVar8;
      iVar7 = iVar7 + 1;
      ChangeTPage(&(*ppDVar4)->tpage,1);
      pDVar2 = *ppDVar4;
      ppDVar4 = ppDVar4 + 1;
      Texture_CloneUVPmx(pDVar2,0,*(Draw_tPixMap **)tp5);
      bVar1 = iVar7 < 8;
    }
  }
  purgememadr(pcVar3);
  return;
}

/* end of genericpmx.cpp */
