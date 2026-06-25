#include "../../lib/libfns.h"
/* track_externs.h -- extern decls for game/psx/track.cpp. */
#ifndef TRACK_EXTERNS_H
#define TRACK_EXTERNS_H

extern void trap(int);  /* MIPS break (gcc div-guard) */

/* ---- libc ---- */

/* ---- harvested ---- */
extern CTrackSpec TrackSpec_gSpec;
extern CVECTOR * Chunk_lightTable;
extern Chunk * Track_chunkList;
extern Draw_tPixMap Track_gReflectionMaps[4];
extern GameSetup_tData   GameSetup_gData;
extern Group * gPersistMidgroundObjInst;
extern Group * gPersistObjDefBoundingSpheres;
extern Group * gPersistObjInst;
extern Sim_tSimGlobalVar simGlobal;                /* 0x8011e0ac */
extern Track_tArtresource gInitialArt;
extern Track_tMaterial * Track_materials;
extern Trk_ObjectDef ** Track_gObjDefs;
extern char       *Paths_Paths[];
extern coorddef * Chunk_chunkCenters;
extern int            Chunk_numLight;            /* 0x8013d4ec */
extern short ** Track_gInViewList;
extern void  TextureProcess_Init(void);                    /* sibling TextureProcess.obj */
extern void  Texture_CloneUVPmx(Draw_tPixMap *dst, int flag, Draw_tPixMap *src);
extern void Texture_LoadPmx(char *, char *, int, int, int, int, int, Draw_tPixMap *);
extern void Texture_ResetPaletteSharing(void);

/* ---- SYM Globals + free fns ---- */
extern void *BWAllocMem(int);
extern void BWorldSm_DeInit(void);
extern void BWorldSm_Init(Group *);
extern void Chunk_DeInit(void);
extern void Chunk_Init(void);
extern void *FeignAlloc(void *, int);
extern void Hrz_GetHorizonPixMap(Draw_tPixMap *);
/* InstanceGroup is a Chunk member -> chunk->InstanceGroup(...) (struct Chunk) */
extern int Math_DistXZ(coorddef *, coorddef *);
/* SerializedGroup container ops (CreateLiteGroup/LocateGroupNum/LocateGroupType/
   LocateCreateGroupType/LocateNextGroupType) are MEMBER fns -> see struct SerializedGroup. */


/* ---- Ghidra C++/alloca idioms + typedef aliases ---- */
typedef SerializedGroup SerializedGroup___0_;  /* Ghidra anon-member alias */
extern void *__builtin_new(u_int);
extern void  __builtin_delete(void *);
extern void *alloca(int);  /* stack VLA for per-group ptr array */
/* strspc_42/45 -> now SYM-faithful function-local `static char strspc[64]` in track.cpp (STAT) */
/* ---- libc / eaclib / shape-lib functions ---- */
extern "C" int shapecount(void *);  /* @0x800F0AAC eaclib shpsubs (real target of old "Libp_table") */
/* ---- Track.obj globals (SYM c_type absent; types from field-owner structs/usage) ---- */
extern TrackHeader            *Track_header;          /* ->chunkCount */
extern Track_tMaterialController *Track_gMatController;/* ->pmxIndex */
extern SimpleMem              *Track_mem;             /* ->heap/freeMem */
extern Group                  *gPersistObjDef;        /* ->m_num_elements */
extern Group                  *gObjDefOffsetsGroup;   /* = Group* (indexed) */
extern Draw_tPixMap           *gSpikeBeltPixmap;      /* ->clut */
extern Track_MipMap           *gTempMipMapInfo;       /* ->code */
extern Track_MultiPalette     *gTempMultiPalInfo;     /* ->charcode */
extern SaveSurface            *Track_gSaveSurface;    /* ctor returns SaveSurface* */
extern int   Track_gControllerCount;
extern int  *Track_gInViewCount;     /* = Alloc(...), indexed */
extern int   gtrackNumber;
extern int   wordFile_psh_snow;        /* (int)cast usage -- refine */

extern SaveSurface *SaveSurface_ct(SaveSurface *, int);
extern "C" void  ___11SaveSurface(SaveSurface *, int);
extern void *Alloc(SimpleMem *, int, int);
extern void  ResizeToFit(SimpleMem *);
#endif
