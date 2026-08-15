/* frontend/common/felines_externs.h - reconstructed extern decls (game C++ helpers).
 * NOT an original header; added for standalone C++ compile. */
#ifndef _FRONTEND_COMMON_FELINES_EXTERNS_H_
#define _FRONTEND_COMMON_FELINES_EXTERNS_H_
#include "../../nfs4_types.h"

/* game-side C++ helpers (cfront-mangled in originals; normal C++ linkage) */
int  CalcFadeVal(int col, int target, int amount);
void PSXDrawGouraudSquare(int x, int y, int w, int h, int c1, int c2, int c3, int c4);
void PSXDrawSquare(int col, int x, int y, int w, int h);
void PSXDrawTransSquare(int col, int x, int y, int w, int h, short opacity);

#endif