/* frontend/common/screencongrats_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENCONGRATS_EXTERNS_H_
#define _FE_SCREENS_SCREENCONGRATS_EXTERNS_H_
#include "screencongrats_types.h"

extern tfrontEnd          frontEnd;
extern tCarManager        carManager;
extern tTournamentManager tournamentManager;

extern char congratsSwapFileName[16];
extern char fPermFileNameBuf[16];
extern int  kRGBVals[28];
extern char textDefinitions[14][6];
/* (gFE_congratsCarRot is NOT extern: SYM marks it STAT carRotate = DrawBackground-local static) */
extern int  R3DCar_aSyncLoading;
extern int  showRoomFlag[];

/* external methods declared free-form (mgr/mgr2 = the implicit this) */
tCarInfo *GetCarFromID(tCarManager *mgr, short carID) asm("GetCarFromID__11tCarManagers");
void GetGarageCar(tCarManager *mgr, short garageNumber, tCarInfo *carInfo, short playerNum) asm("GetGarageCar__11tCarManagersR8tCarInfos");
void GetPinkSlipsCar(tCarManager *mgr, short garageNumber, tCarInfo *carInfo, short playerNum) asm("GetPinkSlipsCar__11tCarManagersR8tCarInfos");
void GetAwardInformation(tTournamentManager *mgr, tAwardInformation *info) asm("GetAwardInformation__18tTournamentManagerR17tAwardInformation");
void GetTrophyName(tTournamentManager *mgr, tTourneyInfo *tourn, tTrophySize size, char *buffer, int place) asm("GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci");
short PlayerRanking(tTournamentManager *mgr, short pos) asm("PlayerRanking__18tTournamentManagers");

/* game C++ helpers + eaclib */
void  AudioCmn_PlayFESFX(int SFXnum);
int   CalcFadeVal(int col1, int col2, int amount);
int   CalcFadeVal(int col1, int amount);   /* 2-arg overload */
extern int ticks[];
void  CarIO_CleanUpLicense(int player);
void  CarIO_CreateLicense(char *text, int carType, int player);
void  DrawCar(tCarInfo &carInfo, short x, short y, float camerax, float cameray, char brightness, bool reflection, u_long rotate, tPlayer player);
void  DrawMoney(int x, int y, int numplaces, long number, int colfore, int colback);
void  CleanupSpinningCarsMenu(void);
void  DrawShapeExtended(int index, int flags, int x, int y, int fade, int abr, tDrawShapeExtended *extra);
void  ScaleShapeExtended(int index, int flags, int x, int y, int fade, int abr, tDrawShapeExtended *extra);
void  FETextRender_FullTextRGB(char *s, short x, short y, int col, char size, short justify);
void  FETextRender_MenuTextFade(int fade, short index, int st, int ty)
    asm("FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType");
int   FETextRender_WordWrapHeight(short width, char *str);
void  FETextRender_WordWrapText(char *str, RECT &r, int st, int ty)
    asm("FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType");
void  FETextRender_WordWrapTextFade(int fade, char *str, RECT &r, int st, int ty)
    asm("FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType");
short FeAudio_AsyncPlaySpeech(int type, int index);
void  FeTools_FormatMoney(char *string, long amount);
char *PlayerName(int player);
void  SetLicensePlate(void);
char *TextSys_Word(int wordnum);
int   TextSys_WordX(int wordnum);
int   TextSys_WordY(int wordnum);
void  trap(int code);

extern "C" {
u_short PAD_state(int padID);
void blockmove(void *source, void *destination, int size);
int sprintf(char *buffer, const char *format, ...);
}


#endif
