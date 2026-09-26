/* Draw_CarCache -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DRAW_CARCACHE_H
#define NFS4_SHARED_DRAW_CARCACHE_H

struct Draw_CarCache {
    Draw_tCacheHeader head;
    MATRIX matB;
    int pad;
    u_long *sub_ot;
    int otz, sub_otz, bfct;
    DR_MODE drawModeOn, drawModeOff;
    Draw_tPixMap *pmxStart;
    Draw_tPixMap ePmx0, ePmx1;
    int eAddZ, sub_otSize;
    long color, eColor0, eColor1, eColor2;
    VECTOR tv;
    COORD16 vt0; u_char u0, v0;
    COORD16 vt1; u_char u1, v1;
    COORD16 vt2; u_char u2, v2;
    short dvx0, dvy0, dvx1, dvy1, dvx2, dvy2;
    Draw_CarVertex tV[96];
    COORD16 vt3; u_char u3, v3;
    COORD16 vt4; u_char u4, v4;
    COORD16 vt5; u_char u5, v5;
    COORD16 vt6; u_char offsetU0, offsetV0;
    COORD16 vt7; u_char offsetU1, offsetV1;
    COORD16 vt8; u_char offsetU2, offsetV2;
};
#endif
