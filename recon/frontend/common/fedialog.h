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
};

struct tDialogHelp : public tDialogBase {
    /* overrides (retail vtable), declared on every owner surface */
    void CalculateDimensions();
    void Draw();
    short variant;
    char *text[7];
    int cont[7];
    short numItems, helpcontrollers, lefttext;
    void AddItem(short, short);
    inline void CalculateDimensionsVirtual() { CalculateDimensions(); }
    tDialogHelp();
};

struct tDialogMessageString : public tDialogBase {
    /* overrides (retail vtable), declared on every owner surface */
    void CalculateDimensions();
    void Draw();
    char *string;
    bool Centerit;
    inline tDialogMessageString *SetString(char *text) {
        string = text;
        return this;
    }
    tDialogMessageString();
};

struct tDialogMessageStringWithTimeout : public tDialogMessageString {
    tDialogMessageStringWithTimeout();
};

struct tDialogBackUpOnly : public tDialogMessageString {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    tDialogBackUpOnly(int);
};

struct tDialogNoInputMessage : public tDialogMessageString {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    tDialogNoInputMessage();
};

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
};

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
};

struct tDialogYesNoMem : public tDialogYesNo {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
};

struct tDialogYesNoTri : public tDialogYesNo {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    inline tDialogYesNoTri() {}
};

#endif
