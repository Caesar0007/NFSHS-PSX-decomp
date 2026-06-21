/* game/psx/font.h — reconstructed from game/psx/font.cpp (15 fns) */
#ifndef _GAME_PSX_FONT_H_
#define _GAME_PSX_FONT_H_
#include "../../nfs4_types.h"

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

#endif /* _GAME_PSX_FONT_H_ */
