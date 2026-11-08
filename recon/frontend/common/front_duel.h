/* front_duel.h -- Front.obj tScreenCarSelectDuel, moved verbatim from front_cs_screens.h (owner hook
 * NFS4_SCREENCARSELECT_HOOK_AFTER_DUEL: retail right after tScreenCarSelect, before tScreenCarSelectTwoPlayer). */
#ifndef NFS4_FRONTEND_COMMON_FRONT_DUEL_H
#define NFS4_FRONTEND_COMMON_FRONT_DUEL_H
struct tScreenCarSelectDuel : public tScreenCarSelect {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void PreLoad();
    void Initialize();
    void Cleanup();
    void DrawVideoWall(short);
    void InitializeVideoWall();
    void UpdateVideoWall(tCarInfo &);
    void AllocateAsyncBuffer();
    void FreeAsyncBuffer();
    short fPreviousOpponent;
    bool fOpponentTVsInitialized;
    tShapeInformation fOpponentShapes;

    /* implicit ctor (retail declares none: no body block in SYM) */
    void DrawOpponentVideoWall(short);   /* declared on every surface: see fevirt_tscreen7.py */
};
#endif
