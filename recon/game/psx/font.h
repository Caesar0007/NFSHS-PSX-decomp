/* game/psx/font.h — reconstructed from game/psx/font.cpp (15 fns) */
#ifndef _GAME_PSX_FONT_H_
#define _GAME_PSX_FONT_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void Font_TextColor(int color);   /* SYM 3f4d88 @0x800cb20c */
void Font_TextTint(int rgb);   /* SYM 3f4da8 @0x800cb244 */
void Font_SetABR(int abr);   /* SYM 3f4dc7 @0x800cb264 */
void Font_Blit(int x,int y,void * src,int u,int v,charactertbl * ch,int tpage);   /* SYM 3f4de4 @0x800cb2ac */
void Font_ComputeColors(int colour,int forecolour,int backcolour,char in_game);   /* SYM 3f4e14 @0x800cb388 */
charactertbl * Font_Getcharacter(int targetindex);   /* SYM 3f4e72 @0x800cb740 */
void Font_SetBlitter(void (*blitter)(int, int, void *, int, int, charactertbl *, int));   /* SYM 3f4ea4 @0x800cb7cc */
void Font_ReSetBlitter(void);   /* SYM 3f4ede @0x800cb7d8 */
void Font_SwitchFont(char * f1);   /* SYM 3f4f01 @0x800cb7ec */
void Font_DeInit(void);   /* SYM 3f4f23 @0x800cb858 */
void Font_ExitFromGame(void);   /* SYM 3f4f40 @0x800cb8a8 */
int Font_LoadFont(char * f1,int x,int y,char in_game);   /* SYM 3f4f63 @0x800cb8bc */
void Font_TextXY(char * string,int x,int y);   /* SYM 3f4f86 @0x800cba90 */
void Font_GetUVWH(char code,int * u,int * v,int * w,int * h,int * yoff);   /* SYM 3f4fa6 @0x800cbbe8 */

#endif /* _GAME_PSX_FONT_H_ */
