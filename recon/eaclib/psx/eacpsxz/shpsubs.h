#ifndef _SHPSUBS_H_
#define _SHPSUBS_H_

#include "eac_types.h"

extern int shapecount(void *shapefile);   /* @0x800F0AAC */
extern void *shapepointer(void *shapefile, unsigned int index);   /* @0x800F0AB8 */
extern void shapename(void *shapefile, unsigned int index, void *dst);   /* @0x800F0AE0 */

#endif
