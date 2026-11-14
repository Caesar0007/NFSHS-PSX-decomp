/* nfs4_core_2_shape_d3 -- moved verbatim out of nfs4_core_2_shape.h so that header holds only its include list. */
#ifndef NFS4_NFS4_CORE_2_SHAPE_D3_H
#define NFS4_NFS4_CORE_2_SHAPE_D3_H
struct shapetbl {
    unsigned int type : 8;
    int          next : 24;
    short        width, height, centerx, centery;
    int          shapex : 12;
    unsigned int reserved : 1;
    unsigned int twiddled : 1;
    unsigned int transposed : 1;
    unsigned int rotated : 1;
    int          shapey : 12;
    unsigned int mipmaps : 4;
    char         data;
};
typedef struct shapetbl SHAPE;
#endif
