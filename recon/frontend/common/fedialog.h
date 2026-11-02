/* frontend/common/fedialog.h -- retail FRONTEND\COMMON\FEDIALOG.H: the one definition of the
 * dialog class family.  The SYM records the header (SLD records of its inline members) and the layout of every
 * class (tDialogBase 144, tDialogMessageString 152, tDialogInteractive 160, tDialogYesNo 168, tDialogHelp 212);
 * the methods themselves are FEDIALOG.CPP's.  The including surface provides tScreen (fescreen.h) and the types
 * the declarations name (tPlayer, tInputKeyType, tMenuCommand). */
#ifndef NFS4_FRONTEND_COMMON_FEDIALOG_H
#define NFS4_FRONTEND_COMMON_FEDIALOG_H

struct tDialogBase : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    /* virtuals introduced by tDialogBase, in retail slot order [10] [11] (real virtuals since 2026-09-20) */
    virtual void CalculateDimensions() = 0;
    virtual void Draw();
    short specificPlayer, left, top, width, height, reservedheight;
    bool currentlyOn;
    long startTicks, timeOutTicks;
    short OffsetX, OffsetY, MaxW, MaxH;
    bool fFullyOpen;
    short fDefault, ReturnValue;
    int fFadeText;
    void Display();
    tDialogBase();
    void Hide();
    short ShouldTimeOut();
    static void InitializeClass();
    static void DrawAllDialogs();
    static void HideAllDialogs();
    static tDialogBase *GetTopMostDialog();
    inline bool IsVisible() { return currentlyOn != 0; }
    inline tDialogBase *SetPosition(short, short, tPlayer);
#ifdef NFS4_FEDIALOG_SCREENCARSELECT_SURFACE
    /* Inferred two-call position/player spelling; no original names survive. */
    inline tDialogBase *SetPosition(short, short);
    inline void SetSpecificPlayer(short);
#endif
#line 132 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 38 "recon/frontend/common/fedialog.h"

struct tDialogHelp : public tDialogBase {
    /* overrides (retail vtable), declared on every owner surface */
    void CalculateDimensions();
    void Draw();
    short variant;
    char *text[7];
    int cont[7];
    short numItems, helpcontrollers, lefttext;
    void AddItem(short, short); inline void SetVariant(int);
    inline void CalculateDimensionsVirtual() { CalculateDimensions(); }
    tDialogHelp();
#line 174 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 51 "recon/frontend/common/fedialog.h"

struct tDialogMessageString : public tDialogBase {
    /* overrides (retail vtable), declared on every owner surface */
    void CalculateDimensions();
    void Draw();
    char *string;
    bool Centerit;
    inline tDialogMessageString *SetString(char *mess) {
        string = mess;
        return this;
    }
#ifdef NFS4_FEMENUDEFS_SURFACE
    /* Inferred word-ID overload: retail SaveGame holds this across the word
       lookup. The operation/receiver are verified; literal original signature
       and cross-owner visibility are not uniquely recovered. */
#endif
    inline tDialogMessageString *SetString(int);
#ifdef NFS4_FEDIALOG_SCREENCARSELECT_SURFACE
    /* ORIGINAL-SIGNATURE-UNRESOLVED: owner-local inferred display overloads;
     * their actual expansions are validated against retail receiver scopes. */
    inline void Display(char *text);
    inline void Display(int word);
#endif
    tDialogMessageString();
#line 204 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 76 "recon/frontend/common/fedialog.h"

struct tDialogMessageStringWithTimeout : public tDialogMessageString {
    tDialogMessageStringWithTimeout();
#line 215 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 80 "recon/frontend/common/fedialog.h"

struct tDialogBackUpOnly : public tDialogMessageString {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    tDialogBackUpOnly(int);
#line 223 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 86 "recon/frontend/common/fedialog.h"

struct tDialogNoInputMessage : public tDialogMessageString {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    tDialogNoInputMessage();
#line 233 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 92 "recon/frontend/common/fedialog.h"

struct tDialogInteractive : public tDialogMessageString {
    bool ReadyToReturnValue, fCurrentlyRunning;
    short Run();
    /* an explicit inline ctor: retail's derived constructors (tDialogYesNo...) store THIS class's vtable on the way
     * (Base, MessageString, Interactive, YesNo);
 a compiler-synthesized ctor leaves that store out. */
    tDialogInteractive();
   /* defined inline in fedialog.cpp, after tDialogMessageString's inline ctor */
    inline void CalculateDimensionsVirtual() { CalculateDimensions(); }
    inline void ProcessInputVirtual(tPlayer player, tInputKeyType &key, tMenuCommand &command) { ProcessInput(player, key, command); }
#line 254 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 104 "recon/frontend/common/fedialog.h"

struct tDialogYesNo : public tDialogInteractive {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void CalculateDimensions();
    void Draw();
    int yesnowords[2];
    tDialogYesNo();
    inline tDialogYesNo *SetChoices(int yesWord, int noWord,
                                    short defaultValue, short player) {
        yesnowords[0] = yesWord;
        yesnowords[1] = noWord;
        fDefault = defaultValue;
        specificPlayer = player;
        return this;
    }
    inline tDialogYesNo *SetChoices(int yesWord, int noWord, short defaultValue) {
        yesnowords[0] = yesWord;
        yesnowords[1] = noWord;
        fDefault = defaultValue;
        return this;
    }
#line 275 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 127 "recon/frontend/common/fedialog.h"

struct tDialogYesNoMem : public tDialogYesNo {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#line 284 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 132 "recon/frontend/common/fedialog.h"

struct tDialogYesNoTri : public tDialogYesNo {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    /* FEMenuDefs' retail expansion has only the implicit constructor's
       parameter region, not an explicit empty-body region. Other owner
       surfaces retain the previous definition: global removal changes eight
       TU objects. Original cross-TU body visibility remains under review. */
#ifndef NFS4_FEMENUDEFS_SURFACE
    inline tDialogYesNoTri() {}
#endif
#line 294 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 144 "recon/frontend/common/fedialog.h"

#endif
