/* game/psx/filedbg.h -- filedbg.obj's type environment.
 * The retail SYM block of filedbg.obj (67 type records) = the graphics/sys types of nfs4_types.h, coorddef/LIBCOORD,
 * linedef/LINE, SHAPETABLEENTRY and the EA scalar typedefs va_list..arg_t (paths.obj's common core without the pad
 * structs, the anonymous struct and the boolean/fixed* typedefs). */
#ifndef _GAME_PSX_FILEDBG_H_
#define _GAME_PSX_FILEDBG_H_

#include "nfs4_types.h"

#include "shared/coorddef.h"

typedef struct coorddef LIBCOORD;

#include "shared/linedef.h"

typedef struct linedef LINE;

#include "shared/SHAPETABLEENTRY.h"

typedef void *va_list;
typedef int INTFN();
typedef void MVI;
typedef int EACHOOKCALLBACKFUNC();
typedef int arg_t;

#endif /* _GAME_PSX_FILEDBG_H_ */
