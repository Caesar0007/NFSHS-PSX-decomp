/* frontend/common/fedialog.h -- retail FRONTEND\COMMON\FEDIALOG.H: the one definition of the dialog class family.  The SYM records the header (SLD records of its inline members) and the layout of every class
 * (tDialogBase 144, tDialogMessageString 152, tDialogInteractive 160, tDialogYesNo 168, tDialogHelp 212); the methods themselves are FEDIALOG.CPP's.  The including surface provides tScreen (fescreen.h) and the types the declarations name (tPlayer, tInputKeyType, tMenuCommand). */
#ifndef NFS4_FRONTEND_COMMON_FEDIALOG_H
#define NFS4_FRONTEND_COMMON_FEDIALOG_H
#ifdef NFS4_FEDIALOG_DIRECT   /* FEDialog.obj emits standalone copies of these inline members; SLINK /strip removed them (P6 Route C 2026-11-07) */
#include "../../link_stripped.h"
#define NFS4_FEDIALOG_STRIP LINK_STRIPPED
#else
#define NFS4_FEDIALOG_STRIP
#endif
struct tDialogBase : public tScreen {
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);   /* overrides (retail vtable), declared on every owner surface */
    virtual void CalculateDimensions() = 0;   /* virtuals introduced by tDialogBase, in retail slot order [10] [11] (real virtuals since 2026-09-20) */
    virtual void Draw();
    short specificPlayer, left, top, width, height, reservedheight;
    bool currentlyOn;
    long startTicks, timeOutTicks;
    short OffsetX, OffsetY, MaxW, MaxH;
    bool fFullyOpen;
    short fDefault, ReturnValue;
    int fFadeText;
    void Display();
    tDialogBase() NFS4_FEDIALOG_STRIP;
    void Hide();
    short ShouldTimeOut();
    static void InitializeClass();
    static void DrawAllDialogs();
    static void HideAllDialogs();
    static tDialogBase *GetTopMostDialog();
    inline bool IsVisible() NFS4_FEDIALOG_STRIP;
    inline void SetSpecificPlayer(short) NFS4_FEDIALOG_STRIP;   /* FRONT26: defined for every includer (retail class-region TPDEFs) */
    /* 2-argument form (OffsetX/OffsetY stores only): retail Confirm / SaveGame / SavePinkSlipsCarsWithErrorDialogs
       record it as a record-less inline pair after SetString; screencarselect chains it with SetSpecificPlayer. */
    inline tDialogBase *SetPosition(int, int) NFS4_FEDIALOG_STRIP;   /* int parameters: measured on SavePinkSlipsCarsWithErrorDialogs (short parameters route the OffsetY store through `this`) */

#ifdef NFS4_FEDIALOG_DIRECT   /* FEDialog.obj's link-stripped standalone SetChoices copies: pre-D1 shape kept (no retail bytes survive the strip) */
#define NFS4_FEDIALOG_SETCHOICES_T tDialogYesNo *
#define NFS4_FEDIALOG_SETCHOICES_RET this
#else
#define NFS4_FEDIALOG_SETCHOICES_T void   /* callers: retail records ONE tDialogYesNo per SetChoices body (`this` only) */
#define NFS4_FEDIALOG_SETCHOICES_RET
#endif
#line 132 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 38 "recon/frontend/common/fedialog.h"
inline bool tDialogBase::IsVisible() { return currentlyOn != 0; } inline void tDialogBase::SetSpecificPlayer(short player) { specificPlayer = player; } inline tDialogBase *tDialogBase::SetPosition(int x, int y) { OffsetX = x; OffsetY = y; return this; }
struct tDialogHelp : public tDialogBase {
    /* overrides (retail vtable), declared on every owner surface */
    void CalculateDimensions();
    void Draw();
    short variant;
    char *text[7];
    int cont[7];
    short numItems, helpcontrollers, lefttext;
    void AddItem(short, short); inline void SetVariant(int);
    inline void CalculateDimensionsVirtual() NFS4_FEDIALOG_STRIP;
    tDialogHelp();
#line 174 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 51 "recon/frontend/common/fedialog.h"
inline void tDialogHelp::CalculateDimensionsVirtual() { CalculateDimensions(); }
struct tDialogMessageString : public tDialogBase {
    /* overrides (retail vtable), declared on every owner surface */
    void CalculateDimensions();
    void Draw();
    char *string;
    bool Centerit;
    inline tDialogMessageString *SetString(char *mess) NFS4_FEDIALOG_STRIP;
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
    tDialogMessageString() NFS4_FEDIALOG_STRIP;
#if 1   /* FRONT26: every includer (retail class-region MS TPDEFs); was DIRECT || FULLYOPEN_SURFACE */
    /* ORIGINAL-NAME-UNRESOLVED: retail tDialogYesNo::ProcessInput records an inline pair with a
       tDialogMessageString `this` REG at its fFullyOpen guard (xori;bnez). */
    inline bool IsFullyOpen() NFS4_FEDIALOG_STRIP;
#endif
#line 204 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 76 "recon/frontend/common/fedialog.h"
inline tDialogMessageString *tDialogMessageString::SetString(char *mess) { string = mess; return this; }
/* the two constructors every includer inlines (retail records their TPDEF runs in every including object: 8 tDialogBase TPDEFs each) */
inline tDialogBase::tDialogBase() { currentlyOn = 0; reservedheight = 0; MaxH = 0; OffsetY = 0; OffsetX = 0; height = 0; width = 0; top = 0; left = 0; MaxW = 0x120; specificPlayer = -1; fDefault = 0; timeOutTicks = 0; }
inline tDialogMessageString::tDialogMessageString() { Centerit = 0; fFullyOpen = 0; timeOutTicks = 0; fFadeText = 0x80; }
#if 1
inline bool tDialogMessageString::IsFullyOpen() { return fFullyOpen == true; }
#endif
struct tDialogMessageStringWithTimeout : public tDialogMessageString {
    tDialogMessageStringWithTimeout();
#line 215 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 80 "recon/frontend/common/fedialog.h"

struct tDialogBackUpOnly : public tDialogMessageString {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    /* implicit ctor (retail declares none: no body block in SYM) */
#line 223 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 86 "recon/frontend/common/fedialog.h"

struct tDialogNoInputMessage : public tDialogMessageString {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    /* implicit ctor (retail declares none: compiler-synthesized, no body block in SYM) */
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
    inline NFS4_FEDIALOG_SETCHOICES_T SetChoices(int yes, int no, short defaultValue, short player) NFS4_FEDIALOG_STRIP;
    inline NFS4_FEDIALOG_SETCHOICES_T SetChoices(int yes, int no, short defaultValue) NFS4_FEDIALOG_STRIP;








#line 275 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 127 "recon/frontend/common/fedialog.h"

inline NFS4_FEDIALOG_SETCHOICES_T tDialogYesNo::SetChoices(int yes, int no, short defaultValue, short player) {
    yesnowords[0] = yes; yesnowords[1] = no;
    fDefault = defaultValue; specificPlayer = player;
    return NFS4_FEDIALOG_SETCHOICES_RET; }


inline NFS4_FEDIALOG_SETCHOICES_T tDialogYesNo::SetChoices(int yes, int no, short defaultValue) {
    yesnowords[0] = yes; yesnowords[1] = no;
    fDefault = defaultValue;
    return NFS4_FEDIALOG_SETCHOICES_RET; }


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
    /* FESCR3: no inline ctor body in any includer -- retail has no tDialogYesNoTri ctor walk (YesNo/Interactive/MessageString/Base
       re-emit); femenudefs, the only TU constructing one, already used the implicit ctor.  Every includer: implicit ctor. */

#line 294 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 144 "recon/frontend/common/fedialog.h"

#endif
