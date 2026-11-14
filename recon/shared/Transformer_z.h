/* Transformer_zUV .. Transformer_zVertex -- moved verbatim from game/common/color_types.h (INVC 2026-11-08) so an
 * owner can emit them at its retail place (gmesetup.obj: right after the GameSetup records, before the draw leaf). */
#ifndef NFS4_SHARED_TRANSFORMER_Z_H
#define NFS4_SHARED_TRANSFORMER_Z_H
typedef struct Transformer_zUV { u_char u, v; } Transformer_zUV;

typedef struct Transformer_zFacet {
    short flag;
    u_char textureIndex, vertexId0, vertexId1, vertexId2;
    Transformer_zUV uv0, uv1, uv2;
} Transformer_zFacet;

typedef struct Transformer_zObj {
    u_short numVertex, numFacet;
    coorddef translation;
    COORD16 *vertex, *Nvertex;
    Transformer_zFacet *facet;
} Transformer_zObj;

typedef struct Transformer_zOverlay { short offset; u_char u, v; } Transformer_zOverlay;
typedef COORD16 Transformer_zVertex;
#endif
