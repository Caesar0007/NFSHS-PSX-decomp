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
    inline tDialogBase *SetPosition(short, short, tPlayer) NFS4_FEDIALOG_STRIP;
    inline void SetSpecificPlayer(short) NFS4_FEDIALOG_STRIP;   /* FRONT26: defined for every includer (retail class-region TPDEFs) */
#ifdef NFS4_FEDIALOG_SCREENCARSELECT_SURFACE
    /* Inferred two-call position spelling; no original names survive. */
    inline tDialogBase *SetPosition(short, short);
#endif
#ifdef NFS4_FEDIALOG_DIRECT   /* FEDialog.obj's link-stripped standalone SetChoices copies: pre-D1 shape kept (no retail bytes survive the strip) */
#define NFS4_FEDIALOG_SETCHOICES_T tDialogYesNo *
#define NFS4_FEDIALOG_SETCHOICES_RET this
#else
#define NFS4_FEDIALOG_SETCHOICES_T void   /* callers: retail records ONE tDialogYesNo per SetChoices body (`this` only) */
#define NFS4_FEDIALOG_SETCHOICES_RET
#endif
#if !defined(NFS4_FEDIALOG_DIRECT) && !defined(NFS4_FEDIALOG_NO_INFERRED_BASE)   /* INFERRED bodies: retail TPDEF run evidence (class-region TPDEF counts); builtin-only, never called */
    inline short GetOffsetX() { return OffsetX; } inline short GetOffsetY() { return OffsetY; }
#endif
#if !defined(NFS4_FEDIALOG_DIRECT) && !defined(NFS4_FEDIALOG_NO_INFERRED_FESCR3_BASE)   /* INFERRED body (FESCR3): retail run Help x2 | Base | Help x4 = one tDialogBase member body defined after tDialogHelp; builtin-only, never called */
    inline short GetMaxW();
#define NFS4_FEDIALOG_INF_BASE_AFTER_HELP inline short tDialogBase::GetMaxW() { return MaxW; }
#else
#define NFS4_FEDIALOG_INF_BASE_AFTER_HELP
#endif
#line 132 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 38 "recon/frontend/common/fedialog.h"
inline bool tDialogBase::IsVisible() { return currentlyOn != 0; } inline tDialogBase *tDialogBase::SetPosition(short x, short y, tPlayer player) { OffsetX = x; OffsetY = y; specificPlayer = (short)player; return this; } inline void tDialogBase::SetSpecificPlayer(short player) { specificPlayer = player; }
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
#if !defined(NFS4_FEDIALOG_DIRECT) && !defined(NFS4_FEDIALOG_NO_INFERRED_HELP)   /* INFERRED bodies: retail TPDEF run evidence (class-region TPDEF counts); builtin-only, never called */
    inline short Variant() { return variant; } inline short NumItems(); inline short HelpControllers(); inline short LeftText();
#define NFS4_FEDIALOG_INF_HELP_DEFS inline short tDialogHelp::NumItems() { return numItems; } inline short tDialogHelp::HelpControllers() { return helpcontrollers; } inline short tDialogHelp::LeftText() { return lefttext; }
#else
#define NFS4_FEDIALOG_INF_HELP_DEFS
#endif
#line 174 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 51 "recon/frontend/common/fedialog.h"
NFS4_FEDIALOG_INF_BASE_AFTER_HELP NFS4_FEDIALOG_INF_HELP_DEFS inline void tDialogHelp::CalculateDimensionsVirtual() { CalculateDimensions(); }
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
#if !defined(NFS4_FEDIALOG_DIRECT) && !defined(NFS4_FEDIALOG_NO_INFERRED_MS)   /* INFERRED bodies: retail TPDEF run evidence (class-region TPDEF counts); builtin-only, never called */
    inline char *GetString() { return string; } inline bool IsCentered() { return Centerit; }
#endif
#if !defined(NFS4_FEDIALOG_DIRECT) && !defined(NFS4_FEDIALOG_NO_INFERRED_FESCR3_MS)   /* INFERRED body (FESCR3): retail run WT | MessageString | WT x2 = one tDialogMessageString member body defined after the WT class; builtin-only, never called */
    inline int FadeText();
#define NFS4_FEDIALOG_INF_MS_AFTER_WT inline int tDialogMessageString::FadeText() { return fFadeText; }
#else
#define NFS4_FEDIALOG_INF_MS_AFTER_WT
#endif
#line 204 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 76 "recon/frontend/common/fedialog.h"
inline tDialogMessageString *tDialogMessageString::SetString(char *mess) { string = mess; return this; }
#if 1
inline bool tDialogMessageString::IsFullyOpen() { return fFullyOpen == true; }
#endif
struct tDialogMessageStringWithTimeout : public tDialogMessageString {
    tDialogMessageStringWithTimeout();
#if !defined(NFS4_FEDIALOG_DIRECT) && !defined(NFS4_FEDIALOG_NO_INFERRED_WT)   /* INFERRED bodies: retail TPDEF run evidence (class-region TPDEF counts); builtin-only, never called */
    inline void SetTimeoutTicks(long t); inline long TimeoutTicks();   /* INFERRED (FESCR3): retail WT x3 = class + 2 bodies, defined after the class */
#define NFS4_FEDIALOG_INF_WT_DEFS inline void tDialogMessageStringWithTimeout::SetTimeoutTicks(long t) { timeOutTicks = t; } inline long tDialogMessageStringWithTimeout::TimeoutTicks() { return timeOutTicks; }
#else
#define NFS4_FEDIALOG_INF_WT_DEFS
#endif
#line 215 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 80 "recon/frontend/common/fedialog.h"
NFS4_FEDIALOG_INF_MS_AFTER_WT NFS4_FEDIALOG_INF_WT_DEFS   /* INFERRED bodies: retail run WT | MessageString | WT x2 (MessageString member, then the 2 WT bodies) */
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
#if !defined(NFS4_FEDIALOG_DIRECT) && !defined(NFS4_FEDIALOG_NO_INFERRED_FESCR3_INT)   /* INFERRED body (FESCR3): retail Interactive x4 at the class; builtin-only, never called */
    inline bool IsRunning() { return fCurrentlyRunning; }
#endif
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
    inline NFS4_FEDIALOG_SETCHOICES_T SetChoices(int yesWord, int noWord, short defaultValue, short player) NFS4_FEDIALOG_STRIP;
    inline NFS4_FEDIALOG_SETCHOICES_T SetChoices(int yesWord, int noWord, short defaultValue) NFS4_FEDIALOG_STRIP;
#ifdef NFS4_FEDIALOG_MEMCARD_CONFIRM_SURFACE
    /* ORIGINAL-NAME-UNRESOLVED: retail fememcard Confirm__Fii records a receiver-free inline pair with param `yes`
       (REG $20) at its yes-word setup. Only the TU defining this surface macro sees it (no out-of-line copy). */
    inline tDialogYesNo *SetYes(int yes) {
        yesnowords[0] = yes;
        return this;
    }
#endif
#line 275 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
};
#line 127 "recon/frontend/common/fedialog.h"
#if defined(NFS4_FEDIALOG_DIRECT) || defined(NFS4_TU_FEMEMCARD)   /* retail: ONE SetChoices body per includer (YesNo x2 = class + 1 body); fememcard is the only 4-arg caller */
inline NFS4_FEDIALOG_SETCHOICES_T tDialogYesNo::SetChoices(int yesWord, int noWord, short defaultValue, short player) {
    yesnowords[0] = yesWord; yesnowords[1] = noWord;
    fDefault = defaultValue; specificPlayer = player;
    return NFS4_FEDIALOG_SETCHOICES_RET; }
#endif
#if defined(NFS4_FEDIALOG_DIRECT) || !defined(NFS4_TU_FEMEMCARD)   /* the 3-arg body for every other includer (femenudefs / screencontroller callers) */
inline NFS4_FEDIALOG_SETCHOICES_T tDialogYesNo::SetChoices(int yesWord, int noWord, short defaultValue) {
    yesnowords[0] = yesWord; yesnowords[1] = noWord;
    fDefault = defaultValue;
    return NFS4_FEDIALOG_SETCHOICES_RET; }
#endif

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
