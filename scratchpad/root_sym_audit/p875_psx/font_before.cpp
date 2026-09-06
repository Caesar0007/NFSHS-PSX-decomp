/* Frozen original recon/game/psx/font.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
void Font_TextColor__Fi(int color);   /* :83 */
void Font_TextTint__Fi(int rgb);   /* :89 */
void Font_SetABR__Fi(int abr);   /* :96 */
void Font_Blit__FiiPviiP12charactertbli(int x, int y, void *src, int u, int v, charactertbl *ch);   /* :128 */
void Font_ComputeColors__Fiiic(int colour, int forecolour, int backcolour, char in_game);   /* :168 */
void * Font_textbsearch__FiPcUlUl(int key, char *base, u_long nmemb, u_long size);   /* :262 */
void * Font_Getcharacter__Fi(int targetindex);   /* :286 */
void Font_SetBlitter__FPFiiPviiP12charactertbli_v(void *blitter);   /* :305 */
void Font_ReSetBlitter__Fv(void);   /* :311 */
void Font_SwitchFont__FPc(char *f1);   /* :317 */
void Font_DeInit__Fv(void);   /* :333 */
void Font_ExitFromGame__Fv(void);   /* :342 */
int Font_LoadFont__FPciic(char *f1, int x, int y, char in_game);   /* :348 */
void Font_TextXY__FPcii(char *string, int x, int y);   /* :414 */
void Font_GetUVWH__FcPiN41(char code, int *u, int *v, int *w, int *h, int *yoff);   /* :541 */
void (*p875_probe_0)(int color) = &Font_TextColor__Fi;
void (*p875_probe_1)(int rgb) = &Font_TextTint__Fi;
void (*p875_probe_2)(int abr) = &Font_SetABR__Fi;
void (*p875_probe_3)(int x, int y, void *src, int u, int v, charactertbl *ch) = &Font_Blit__FiiPviiP12charactertbli;
void (*p875_probe_4)(int colour, int forecolour, int backcolour, char in_game) = &Font_ComputeColors__Fiiic;
void * (*p875_probe_5)(int key, char *base, u_long nmemb, u_long size) = &Font_textbsearch__FiPcUlUl;
void * (*p875_probe_6)(int targetindex) = &Font_Getcharacter__Fi;
void (*p875_probe_7)(void *blitter) = &Font_SetBlitter__FPFiiPviiP12charactertbli_v;
void (*p875_probe_8)(void) = &Font_ReSetBlitter__Fv;
void (*p875_probe_9)(char *f1) = &Font_SwitchFont__FPc;
void (*p875_probe_10)(void) = &Font_DeInit__Fv;
void (*p875_probe_11)(void) = &Font_ExitFromGame__Fv;
int (*p875_probe_12)(char *f1, int x, int y, char in_game) = &Font_LoadFont__FPciic;
void (*p875_probe_13)(char *string, int x, int y) = &Font_TextXY__FPcii;
void (*p875_probe_14)(char code, int *u, int *v, int *w, int *h, int *yoff) = &Font_GetUVWH__FcPiN41;
