/* Draw_tGiveShelbyMoreCache -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DRAW_TGIVESHELBYMORECACHE_H
#define NFS4_SHARED_DRAW_TGIVESHELBYMORECACHE_H

struct Draw_tGiveShelbyMoreCache {
    Draw_tCacheHeader head;
    MATRIX matB, matNight, matCop, identMat;
    int otz;
    VECTOR tVn0, tVn1, tVn2, tVn3;
    short light, doublelayer, startfog, distfog;
    CCOORD16 *vertices;
    u_char chunkInd, rezInd, garb3, quadCount;
    void *quads;
    int offset;
    Track_tMaterial *materials;
    COORD16 trans;
    Track_tArtresource *artInfo;
    Trk_NewStrip *stripPtr;
    short numStrips;
    char nightFlags, zeroGTETransFlag;
    short night_ZNear;
    u_char night_XDistShift, night_ZDistShift, night_DrawLightning;
    u_char night_LightningType, fogstate, padnight;
    POLY_GT4 GT4Prim;
    u_short tpage, clut;
    short offsubdivid;
    u_char code, magiknum;
    Draw_SVertex v0, v1, v2, v3;
    Draw_SubdivStruct div;
};
#endif
