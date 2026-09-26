/* tCarInfo -- the one definition of this type, shared by 4 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TCARINFO_H
#define NFS4_SHARED_TCARINFO_H

struct tCarInfo {
    signed char fCarID;
    u_char fSimNumber, fCarClass, fABSAvailable, fDefaultColor;
    u_char fCopClass, fDefaultTires, fAvailable;
    char fShapeName[8], fSmallName[8], fQTVRName[8];
    long fPrices[4];
    u_char fStats[4][5];
    u_long fColorList[16];
    u_char fSpeechColors[16];
    u_long fHudColor[2];
    char fDayTachFile[8], fNightTachFile[8];
    char fNumLightColors, fNumDarkColors;
    u_char fCountries;
    char fColorOrder[16];
    u_char fPursuitAvailable, fEnginePatch;
    signed char fSpeechCarID;
    u_char fTractionAvailable, fExoticCar, fUpgrades, fColor;
    u_char fViewable, fCountry, fCarIndex;
    u_char fReserved[3];
};
#endif
