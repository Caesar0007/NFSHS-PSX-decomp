/* tCreditManager -- FECREDITS.H, one definition for every includer (header-truth 4t). Members are defined in fecredits.cpp. */
#ifndef NFS4_SHARED_TCREDITMANAGER_H
#define NFS4_SHARED_TCREDITMANAGER_H
typedef struct tCreditManager {
    tCredit *CreditBuffer;
    int fTVFade, fTextFade, fTextFadeDir;
    bool fCreditsInitialized, fRequestDeInit;
    int fNumCredits, fShowCreditNum, fCurrCredit;
    bool StartedTransition, StartedLines, StartedTextFade;
    int fLineTicks, fStartTicks;

    void Setup();
    void Init(int);
    void DeInit();
    void RealDeInit();
    void Draw(bool);
    void SetupCurrCredit();
    void DrawCurrCredit();
} tCreditManager;
#endif
