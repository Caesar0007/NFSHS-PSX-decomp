#ifndef NFS4_FRONTEND_COMMON_SCREENPOST_EXTERNS_H
#define NFS4_FRONTEND_COMMON_SCREENPOST_EXTERNS_H

#include "screenpost_types.h"

extern tfrontEnd frontEnd;
extern tTournamentManager tournamentManager;
extern tTrackManager trackManager;
extern tGlobalMenuDefs *menuDefs;
/* P892: vars.obj scalar at NFS4 019199/8013DCAC; NFS2 13bb6c records INT. */
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/vars.h"
}
extern int kRGBVals[28];
extern char textDefinitions[14][6];
/* P885: SYM56d925 is one PTR cell; the pointed-to shapes are the array. */
extern tTexture_ShapeInfo *gCurrentShapes;


extern "C" int sprintf(char *, const char *, ...);
extern "C" int textpixels(char *);

char *PlayerName(int);
char *TextSys_Word(int);
int TextSys_WordX(int);
int TextSys_WordY(int);
int CalcFadeVal(int, int);
short TextValue(void *, tPlayer)
    asm("TextValue__23tListIteratorTournament7tPlayer");
void DrawBackgroundImage(tScreen *, int, int, tTexture_ShapeInfo *, int)
    asm("DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi");
void DrawShapeExtended(int, int, int, int, int, int, tDrawShapeExtended *);
void PSXDrawSquare(int, int, int, int, int);
int PSXDrawBrightEndLine(int, int, int, int, int, int, int, int);
int FeTools_FormatMoney(char *, long);
int FETextRender_FullTextRGB(char *, short, short, int, char, short)
    asm("FETextRender_FullTextRGB__FPcssics");
int FETextRender_FullTextFade(int, char *, short, short,
                              tMenuTextType, tMenuTextState, short);
int FETextRender_MenuTextPositionedJustifyFade(
    int, short, short, short, short, tMenuTextState, tMenuTextType);
int AudioCmn_PlayFESFX(int);
short Front_GetTrackRaced(void); /* owning Front.cpp/SYM result type */
char *Stattool_GetAINameFromPersonality(tPersonalities);
int tScreen_ProcessInput(tScreen *, tPlayer, tInputKeyType &, tMenuCommand &)
    asm("ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand");

/* ScreenPost.obj owns these zero-initialized frontend singletons. */
tScreenTournamentStandings *screenTournamentStandings = 0;
tScreenTournamentStandings3item *screenTournamentStandings3item = 0;
tScreenPinkSlipStandings *screenPinkSlipStandings = 0;

/* retail's SYM records an inline-call pair at these reads: the value is read through an inline getter */
static inline tfrontEnd & FrontEnd(void) { return frontEnd; }

/* retail's SYM records an inline-call pair at these reads: the value is read through an inline getter */
static inline tGlobalMenuDefs * MenuDefs(void) { return menuDefs; }

/* retail's SYM records an inline-call pair at every tick read in this TU: the tick counter is read
   through an inline getter, not directly */
static inline int FE_Ticks(void) { return ticks; }

static inline long Tournament_Money(tTournamentManager &tm) { return tm.fMoney; }

/* ORIGINAL-NAME-UNRESOLVED: inferred definition/count field accessors for
   the two receiver-free retail pairs at the opening standings phase. */
static inline tTournamentDefinition *Tournament_Definition() {
  return tournamentManager.fDefinition;
}

static inline int Tournament_NumRacers() {
  return tournamentManager.fNumRacers;
}

/* ORIGINAL-NAME-UNRESOLVED: inferred accessor for the retail personality
   pair. Its j parameter is the nested INT:$19 record, not a caller copy. */
static inline tPersonalities Tournament_Personality(int j) {
  return tournamentManager.fCompetitors[j].fPersonality;
}

/* ORIGINAL-NAME-UNRESOLVED: same color-table lookup used by FEFades. */
static inline int TextDefinitionColor(tMenuTextType type, int column) {
  return kRGBVals[(byte)textDefinitions[type][column]];
}

/* Retail screenpost.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

#endif
