/* tScreenMainState -- the one definition of this enum, shared by 3 headers (moved verbatim by enum_dedup; every
   former copy includes this file at the same place). */
#ifndef NFS4_SHARED_TSCREENMAINSTATE_H
#define NFS4_SHARED_TSCREENMAINSTATE_H

enum tScreenMainState {
    kScreenMain_Off = 0,
    kScreenMain_StaticImage = 1,
    kScreenMain_DynamicImage = 2,
    kScreenMain_WarningImage = 3,
    kScreenMain_Credits = 4
};
#endif
