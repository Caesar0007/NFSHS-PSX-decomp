/* Track.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_TRACK_TYPES_H
#define NFS4_GAME_COMMON_TRACK_TYPES_H

#define NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#include "chunk_types.h"
#undef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES

struct BW_tContext {
    int client;
    BWorldSm_Pos slicePos;
    int currentChunk, chunkFarZClipSq, polyFarZClipSq;
    int lowDetailDistSq, lineFarZClipSq;
};

struct CHorizonSpec {
    int mirror, angle, yoffset, height;
    CVECTOR frontColor[2], backColor[2];
    char ringPMX[16];
};
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
struct CNightSpec { CVECTOR nightcolor; };
struct CWeatherSpec { int type, intensity_limit; };
struct CFogSpec { int contrast; CVECTOR color; int start, dist2base; };
struct CDepthCueSpec { CVECTOR color; int distance; };
struct CWorldColor {
    int contrast;
    CVECTOR contrast_color;
    short worldR, worldG, worldB, type;
};

typedef void (*Sched_tFunctionPt)(void *);
struct Sched_tFunctionSchedule {
    int priority;
    Sched_tFunctionPt function;
    void *var1, *var2;
};
struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

struct Trk_Material {
    short shapeIndex;
    u_char flag, uvFlag, r, g, b;
    char textureCount;
    u_char interval;
    char pad;
};
struct TrackHeader {
    int type, version, maxMetaChunkSize, maxGeomCollSize;
    int maxFullSize, maxSplitSize, metaChunkCount, chunkCount;
};
struct SaveSurface {
    short fCount, fMaxCount;
    tSaveSurface *fStack;
    SaveSurface(int numEntries);
    ~SaveSurface();
    void Save(Trk_NewSimQuad *simQuad);
    void RestoreAll();
};
struct tBoundingSphere { COORD16 cp; short radius; };
struct Track_MipMap {
    u_short code[2];
    int shapeParentIndex, mipMapIndex;
};
struct Track_MultiPalette {
    u_char charcode[2];
    short palnum, origshapeindex, actualshapeindex;
};
struct Track_tMaterialController {
    short type;
    u_char textureMax;
    char pad;
    u_char uv0, uv1, uv2, uv3;
    char textureCount;
    u_char interval;
    short pmxIndex;
    Track_tMaterial *matPtr;
};

/* These completed foreign tags are absent from Track.obj's linked SYM graph,
 * but retail directly reads their storage. Keep exact private compiler views
 * at the translation-unit boundary. */
struct Track_TrackSpecCodegenView {
    short fogstate, weatherstate, horizonstate, skystate;
    short nightstate, depthcuestate, worldcolorstate, pad0;
    CFogSpec fogspec;
    CWeatherSpec weatherspec;
    CHorizonSpec horizonspec;
    CSkySpec skyspec;
    CNightSpec nightspec;
    CDepthCueSpec depthcuespec;
    CWorldColor worldcolorspec;
};
struct Track_GameSetupCodegenView {
    int raceType, numLaps, skill, commMode;
    int setup04_10[7];
    int mirrorTrack, reverseTrack, measurement, sgge, track, trackSegment;
    int song, Weather, Fog, Damage, Time, randSeed, easter;
    int controllerWords[22];
    int pinkSlipsForfeit, checkpointType, checkpointHUD[2];
    int dispatchSpeech, reverseCallSpeech, languageSpeech;
    int SceneNumber, SceneStartLap, SceneEndLap;
    GameSetup_tUserSetting userSetting;
    int numPerps, stageOffset, perpArrests, finalPerpArrests;
    GameSetup_tPerpData perpInfo[10];
    int numCars, numPlayerRaceCars, numOpponentRaceCars, opponentCarType;
    GameSetup_tCarData carInfo[9];
};
struct Track_SimGlobalCodegenView {
    int gameStarted, gameTicks, time32Hz;
    void *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};

#endif
