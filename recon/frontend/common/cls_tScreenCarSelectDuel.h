/* frontend/common/cls_tScreenCarSelectDuel.h -- class tScreenCarSelectDuel, one definition for every includer (header-truth 4u; the owner's text from screencarselect_types.h). */
#ifndef NFS4_FRONTEND_COMMON_CLS_TSCREENCARSELECTDUEL_H
#define NFS4_FRONTEND_COMMON_CLS_TSCREENCARSELECTDUEL_H
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
    /* virtuals introduced by this class, in retail slot order (real virtuals since 2026-09-20) */
    virtual void DrawOpponentVideoWall(short);
    short fPreviousOpponent;
    bool fOpponentTVsInitialized;
    tShapeInformation fOpponentShapes;

    /* implicit ctor (retail declares none: no body block in SYM) */
    void UpdateOpponentVideoWall(tCarInfo &);
#line 285 "C:/nfs4/FRONTEND/COMMON/SCREENCARSELECT.H"
};
#endif
