/* frontend/common/femission_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FEMISSION_EXTERNS_H_
#define _FE_FEMISSION_EXTERNS_H_
#include "femission_types.h"

extern tfrontEnd frontEnd;
extern char     *Paths_Paths[];

extern "C" {
void blockmove(...);
void *loadfileadr(...);
int purgememadr(...);
void *reservememadr(...);
int sprintf(...);
}


#endif
