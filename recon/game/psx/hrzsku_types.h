#ifndef NFS4_GAME_PSX_HRZSKU_TYPES_H
#define NFS4_GAME_PSX_HRZSKU_TYPES_H   /* hrzsku.obj's exact source-visible type surface reconstructed from SYM. */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail place (after COORD16, before the pads) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#include "../common/draw_leaf_types.h"
#include "../common/gamesetup_leaf_types.h"
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)
/* Canonical gmesetup.obj aggregate retained by hrzsku.obj. */
#include "shared/GameSetup_tData.h"
















#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"

#include "shared/POLY_FT4.h"




#include "shared/POLY_G4.h"




#include "shared/POLY_GT4.h"





struct TILE_1 { u_long tag; u_char r0,g0,b0,code; short x0,y0; };

#include "shared/CCOORD16.h"
#include "shared/DRender_tView.h"
#include "shared/Draw_SubdivStruct.h"
#include "shared/Draw_DCache.h"



#include "shared/Trk_Quad.h"
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"
#include "shared/RelCoord16.h"
struct Group { int m_num_elements; inline void *GetData(){return this+1;} inline int GetNumElements(){return m_num_elements;} };
#include "shared/Track_tArtresource.h"
#include "shared/Track_tMaterial.h"
#include "shared/tSaveSurface.h"

#include "shared/BWorldSm_Pos.h"





struct BO_tNewtonObj;
#include "shared/BO_tNewtonCollisionInfo.h"




#include "shared/BO_tNewtonObj.h"












#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"

typedef enum forceFocus_t { FOCUS_NORMAL=0, FOCUS_AI=1, FOCUS_COPANDAI=2 } forceFocus_t;
#include "shared/FLARE_PIECE_DEF.h"
#include "shared/CHorizonSpec.h"
#include "shared/CSkySpec.h"






#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"
#include "shared/CTrackSpec.h"










#include "shared/kernpair.h"
typedef kernpair KERN;
typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];
typedef int (*getcode)();
typedef void (*adjustchar)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();

typedef struct Draw_HorizonCache {
    Draw_tCacheHeader head; DVECTOR scptTop[17],scptMidBot[17],scptPmxLeft[17],scptPmxRight[17];
    int vertexTop[18];
} Draw_HorizonCache;
typedef struct Draw_SkyCache { Draw_tCacheHeader head; DVECTOR pSkyMesh[85]; int pSkyZ[85]; } Draw_SkyCache;
struct tHrz_LightningFork { DVECTOR pos; char pmxIndex; };
struct tHrz_Lightning { tHrz_LightningFork forks[16]; int brightness; char numForks; };

struct Draw_FlareCache;

#endif
