#ifndef _NSYNC_H_
#define _NSYNC_H_

#include "eac_types.h"

/* internals -> nsync_private.h (library sources only; no retail game object records them) */







extern int filesize(char *name);   /* @0x800E566C */
extern int loadfileadrz(char *name, int memclass);   /* @0x800E57A8 */
extern int loadfileadr(char *name, int memclass);   /* @0x800E57E8 */
extern int loadfileatadrz(char *name, int dest);   /* @0x800E58B0 */
extern int loadfileatadr(char *name, int dest);   /* @0x800E58F0 */
extern int loadbigfileheader(char *name, int memclass);   /* @0x800E5A7C */

#endif
