/* game/common/textsys.h — reconstructed from game/common/textsys.cpp (8 fns) */
#ifndef _GAME_COMMON_TEXTSYS_H_
#define _GAME_COMMON_TEXTSYS_H_
#include "../../nfs4_types.h"

void TextSys_LoadWordsGeneric__FiPc(int language, char *path);   /* :41 */
void TextSys_LoadInGame__Fi(int language);   /* :55 */
void TextSys_LoadWords__Fi(int language);   /* :62 */
char * TextSys_Word__Fi(int wordnum);   /* :69 */
int TextSys_WordFlags__Fi(int wordnum);   /* :120 */
int TextSys_WordX__Fi(int wordnum);   /* :132 */
int TextSys_WordY__Fi(int wordnum);   /* :147 */
void TextSys_UnloadWords__Fv(void);   /* :162 */

#endif /* _GAME_COMMON_TEXTSYS_H_ */
