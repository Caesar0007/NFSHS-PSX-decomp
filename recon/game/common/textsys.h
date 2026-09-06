/* game/common/textsys.h — reconstructed from game/common/textsys.cpp (8 fns) */
#ifndef _GAME_COMMON_TEXTSYS_H_
#define _GAME_COMMON_TEXTSYS_H_
#include "../../nfs4_types.h"

/* P875: native signatures and defining exports verified by typed-reference
 * probes. Source names let the compiler emit the original C++ linkage. */

void TextSys_LoadWordsGeneric(int language, char *path);   /* :41 */
void TextSys_LoadInGame(int language);   /* :55 */
void TextSys_LoadWords(int language);   /* :62 */
char * TextSys_Word(int wordnum);   /* :69 */
int TextSys_WordFlags(int wordnum);   /* :120 */
int TextSys_WordX(int wordnum);   /* :132 */
int TextSys_WordY(int wordnum);   /* :147 */
void TextSys_UnloadWords(void);   /* :162 */

#endif /* _GAME_COMMON_TEXTSYS_H_ */
