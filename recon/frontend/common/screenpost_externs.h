#ifndef NFS4_FRONTEND_COMMON_SCREENPOST_EXTERNS_H
#define NFS4_FRONTEND_COMMON_SCREENPOST_EXTERNS_H

#include "screenpost_types.h"

extern tfrontEnd frontEnd;
extern tTournamentManager tournamentManager;
extern tTrackManager trackManager;
extern tGlobalMenuDefs *menuDefs;
extern int ticks[];
extern int kRGBVals[28];
extern char textDefinitions[14][6];
extern tTexture_ShapeInfo *gCurrentShapes[];

extern __nfs4_vtbl_ptr_t tScreenTournamentStandings_vtable[10];
extern __nfs4_vtbl_ptr_t tScreenTournamentStandings3item_vtable[10];
extern __nfs4_vtbl_ptr_t tScreenPinkSlipStandings_vtable[10];

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
int Front_GetTrackRaced(void);
char *Stattool_GetAINameFromPersonality(tPersonalities);
int tScreen_ProcessInput(tScreen *, tPlayer, tInputKeyType &, tMenuCommand &)
    asm("ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand");

/* ScreenPost.obj owns these zero-initialized frontend singletons. */
tScreenTournamentStandings *screenTournamentStandings = 0;
tScreenTournamentStandings3item *screenTournamentStandings3item = 0;
tScreenPinkSlipStandings *screenPinkSlipStandings = 0;

#endif
