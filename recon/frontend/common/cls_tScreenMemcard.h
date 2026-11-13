/* frontend/common/cls_tScreenMemcard.h -- class tScreenMemcard, one definition for every includer (header-truth 4v; the owner's text from screenmemcard_types.h). */
#ifndef NFS4_FRONTEND_COMMON_CLS_TSCREENMEMCARD_H
#define NFS4_FRONTEND_COMMON_CLS_TSCREENMEMCARD_H
struct tScreenMemcard : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    int theNFS4icon, card;
    CARDINFO_def *pCI;
    char fMemTitle[15][32];
    char goticon[15];
    u_char numicon[15], numblock[15];
    MCRDFILE_def fMemFile[15];
    u_short fMemIconClutId[15];
    short fFadeIcon[15];
    bool fReadyToGetNewIcons, fInitedMemCard;
    char fMemCardMessage[40];
    int fMemCardMessageTextSys, message;
    short memcardanimframe, count, cursorPosition;
    int checkingstart;
    bool fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons;
    int fScreenFadeReadyTick;
    short player;
    bool fGetNewIcons;
    void DrawIcon(shapetbl *, int, int, int, int, short);
    void LoadIcon(int);
    void DrawVerticalLine(short, short, short, short);
    void DrawHorizontalLine(short, short, short, short);
    void PlaceIcons(int, int);
    void DrawMemCardStuff(short);
    void SetEnablings();
    tScreenMemcard();
    void ReleaseIcons();
    inline void SetMessage(int newMessage) TSCREENMEMCARD_KEY_STRIP;   /* key object: standalone copy goes to .text.strip (fe_core_types.h) */


#line 99 "C:/nfs4/FRONTEND/COMMON/SCREENMEMCARD.H"
}; inline void tScreenMemcard::SetMessage(int newMessage) { message = newMessage; }
#line 43 "recon/frontend/common/cls_tScreenMemcard.h"
#endif
