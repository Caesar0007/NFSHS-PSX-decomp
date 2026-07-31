#include "../../lib/libfns.h"
/* cario_externs.h -- extern decls for game/psx/cario.cpp (NFS4 PSX car texture/CLUT I/O). */
#ifndef CARIO_EXTERNS_H
#define CARIO_EXTERNS_H

/* ---- libc ---- */

/* ---- harvested from sealed *_externs.h ---- */
extern Draw_tPixMap *CarIO_carPixMap;
extern GameSetup_tData   GameSetup_gData;
extern Texture_pal8bit*Texture_palCopy;         /* 0x8013db0c */
extern int             Texture_palNum;          /* 0x8013db10 */
extern int R3DCar_InMenu;
  /* generic shape-data ptr (int, char, void ptr) */
extern void      Texture_MenuReleaseClutId(short id);
extern void  ChangeTPage(u_short *tpage, int abr);

/* ---- SYM Globals + free fns ---- */
extern void Texture_LoadPmx(char *, char *, int, int, int, int, int, Draw_tPixMap *);
extern void Texture_ResetPaletteSharing(void);

/* ---- CarIO.obj own globals (SYM dims known; element widths from cpp reads/casts) ---- */
extern CarIO_textureInfo CarIO_textureName[51];  /* dims 1 51; pCVar->pal/palShare/tex */
extern short     CarIO_carVRamSlots[18][2];    /* [c][0/1] -> short sVar / (int) cast */
extern short     CarIO_carVRamSlotsMenu[6][2]; /* short */
extern short     CarIO_carVRamAdd[6];          /* SYM: ARY SHORT dims 1 6, size 12 (data
                                                * 8011EAC8 = {2,1,2,1,2,1}).  Was wrongly
                                                * declared int[6]: 4-byte stride read past
                                                * the end into CarIO_carVRamOffset. */
extern short     CarIO_carVRamOffset[6];       /* (int) cast => short */
extern short     CarIO_licensePlate[22][6];    /* [c][0..2] short (id+coords) */
extern short     CarIO_licenseSFX_Vram[12][2]; /* short vram coords */
extern shapetbl *CarIO_Plate1[2];              /* = (shapetbl*)0 */
extern shapetbl *CarIO_Plate2[2];
extern int       CarIO_carPixMapCount;
extern int       CarIO_carVRamCount;
extern int       CarIO_licenseSFX_Count;
extern char      R3DCar_LicenseShapeFile[];    /* locateshapez(name,...) */

#endif
