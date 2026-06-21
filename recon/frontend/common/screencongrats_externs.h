/* frontend/common/screencongrats_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENCONGRATS_EXTERNS_H_
#define _FE_SCREENS_SCREENCONGRATS_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
#include "../psx/psxfront.h"   /* DrawShapeExtended/CleanupSpinningCarsMenu */

extern tfrontEnd          frontEnd;
extern tCarManager        carManager;
extern tTournamentManager tournamentManager;

extern char congratsSwapFileName[16];
extern char fPermFileNameBuf[16];
extern int  kRGBVals[28];
extern char textDefinitions[14][6];
/* (gFE_congratsCarRot is NOT extern: SYM marks it STAT carRotate = DrawBackground-local static) */
extern int  R3DCar_aSyncLoading;

/* external methods declared free-form (mgr/mgr2 = the implicit this) */
tCarInfo *GetCarFromID(tCarManager *mgr, short carID);
void GetGarageCar(tCarManager *mgr, short garageNumber, tCarInfo *carInfo, short playerNum);
void GetPinkSlipsCar(tCarManager *mgr, short garageNumber, tCarInfo *carInfo, short playerNum);
void GetAwardInformation(tTournamentManager *mgr, tAwardInformation *info);
void GetTrophyName(tTournamentManager *mgr, tTourneyInfo *tourn, tTrophySize size, char *buffer, int place);
short PlayerRanking(tTournamentManager *mgr, short pos);

/* game C++ helpers + eaclib */
void  AudioCmn_PlayFESFX(int SFXnum);
int   CalcFadeVal(int col1, int col2, int amount);
int   CalcFadeVal(int col1, int amount);   /* 2-arg overload */
extern int ticks;
void  CarIO_CleanUpLicense(int player);
void  CarIO_CreateLicense(char *text, int carType, int player);
void  DrawCar(tCarInfo *carInfo, short x, short y, float camerax, float cameray, char brightness, bool reflection, u_long rotate, tPlayer player);
void  DrawMoney(int x, int y, int numplaces, long number, int colfore, int colback);
void  ScaleShapeExtended(int index, int flags, int x, int y, int fade, int abr, tDrawShapeExtended *extra);
void  FETextRender_FullTextRGB(char *s, short x, short y, int col, char size, short justify);
void  FETextRender_MenuTextFade(int fade, short index, tMenuTextState st, tMenuTextType ty);
int   FETextRender_WordWrapHeight(short width, char *str);
void  FETextRender_WordWrapText(char *str, RECT *r, tMenuTextState st, tMenuTextType ty);
void  FETextRender_WordWrapTextFade(int fade, char *str, RECT *r, tMenuTextState st, tMenuTextType ty);
short FeAudio_AsyncPlaySpeech(int type, int index);
void  FeTools_FormatMoney(char *string, long amount);
char *PlayerName(int player);
void  SetLicensePlate(void);
char *TextSys_Word(int wordnum);
int   TextSys_WordX(int wordnum);
int   TextSys_WordY(int wordnum);
void  trap(int code);


#endif