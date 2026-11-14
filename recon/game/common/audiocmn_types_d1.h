/* audiocmn_types_d1 -- moved verbatim out of audiocmn_types.h so that header holds only its include list. */
#ifndef NFS4_AUDIOCMN_TYPES_D1_H
#define NFS4_AUDIOCMN_TYPES_D1_H
typedef struct Channels_t { int Partial, SFXnum; } Channels_t; /* Completed C/C++ alias restores the owning SYM producer,not a pointer-use workaround;see build/nc12/playsfx_roles_20261027/. */
typedef enum s_type {
    kAsphalt = 0, kCarBody = 1, kTires = 2, kGravel = 3, kWall = 4,
    kSign = 5, kBush = 6, kBlowOut = 7, kBackFire = 8, kHorn = 9,
    kGearShift = 10, kSnow = 11, kGrass = 12, kWoodWall = 13,
    kGrassWall = 14, kWallSpark = 15, kWetAsphalt = 16,
    kRaceTireOnAsphalt = 17, kRainTireOnAsphalt = 18
} s_type;
#endif
