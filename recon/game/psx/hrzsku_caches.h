/* hrzsku.obj: Draw_HorizonCache/Draw_SkyCache sit between GameSetup and Group in retail. */
#ifndef NFS4_GAME_PSX_HRZSKU_CACHES_H
#define NFS4_GAME_PSX_HRZSKU_CACHES_H
typedef struct Draw_HorizonCache {
    Draw_tCacheHeader head; DVECTOR scptTop[17],scptMidBot[17],scptPmxLeft[17],scptPmxRight[17];
    int vertexTop[18];
} Draw_HorizonCache;
typedef struct Draw_SkyCache { Draw_tCacheHeader head; DVECTOR pSkyMesh[85]; int pSkyZ[85]; } Draw_SkyCache;
#endif
