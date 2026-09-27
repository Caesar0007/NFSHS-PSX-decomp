/* frontend/common/screentrophyroom.h -- retail SCREENTROPHYROOM.H: the one definition of tScreenTrophyRoom.  Layout and the defining
 * .CPP are the retail SYM's; the including surface provides tScreen (fescreen.h) and the types
 * the declarations name. */
#ifndef _FE_SCREENS_SCREENTROPHYROOM_H_
#define _FE_SCREENS_SCREENTROPHYROOM_H_

struct tScreenTrophyRoom : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void PreLoad();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    tShapeInformation fTrophyShapes;
    short fNumTrophies;
    int startTicks;
    short fShapeCount;
    bool fLoadingTrophy;
    char fPreviousTrophy, fDoUpdate;
    bool fClearScreen;
    char fBrightness;
    u_long fStartTicks;
    short fTextInfo[16];
    char thisisuseless;
    int tier;
    short fRealCurrentTourn[2];
    short fTrophyList[64];
    tScreenTrophyRoom();
    ~tScreenTrophyRoom();
    void LoadTrophy();
};


#endif
