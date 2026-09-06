#include "C:/Temp/nfs4-decomp/recon/game/psx/font.h"
void (*p875_probe_0)(int color) = &Font_TextColor;
void (*p875_probe_1)(int rgb) = &Font_TextTint;
void (*p875_probe_2)(int abr) = &Font_SetABR;
void (*p875_probe_3)(int x,int y,void * src,int u,int v,charactertbl * ch,int tpage) = &Font_Blit;
void (*p875_probe_4)(int colour,int forecolour,int backcolour,char in_game) = &Font_ComputeColors;
charactertbl * (*p875_probe_5)(int targetindex) = &Font_Getcharacter;
void (*p875_probe_6)(void (*blitter)(int, int, void *, int, int, charactertbl *, int)) = &Font_SetBlitter;
void (*p875_probe_7)(void) = &Font_ReSetBlitter;
void (*p875_probe_8)(char * f1) = &Font_SwitchFont;
void (*p875_probe_9)(void) = &Font_DeInit;
void (*p875_probe_10)(void) = &Font_ExitFromGame;
int (*p875_probe_11)(char * f1,int x,int y,char in_game) = &Font_LoadFont;
void (*p875_probe_12)(char * string,int x,int y) = &Font_TextXY;
void (*p875_probe_13)(char code,int * u,int * v,int * w,int * h,int * yoff) = &Font_GetUVWH;
