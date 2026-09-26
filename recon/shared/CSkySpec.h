/* CSkySpec -- the one definition of this type, shared by 9 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_CSKYSPEC_H
#define NFS4_SHARED_CSKYSPEC_H

struct CSkySpec {
    int type, flags;
    CVECTOR frontcolors[5], backcolors[5], clearcolor;
    int sunAngleInSky, sunHeightInSky, moonAngleInSky, moonHeightInSky;
    int numStars, starAngleLow, starAngleHigh, starBrightMin, starBrightMax;
    CVECTOR starBaseColor;
    int starRandomSeed;
    CVECTOR sunBeamColor, sunHaloColor;
    int yoffset;
    char cloudIndices[5][4];
    int ringAngles[5];
};
#endif
