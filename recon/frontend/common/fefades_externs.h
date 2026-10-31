/* frontend/common/fefades_externs.h - reconstructed extern decls. NOT original. */
#ifndef _FRONTEND_COMMON_FEFADES_EXTERNS_H_
#define _FRONTEND_COMMON_FEFADES_EXTERNS_H_
#include "fefades_types.h"

extern int  kRGBVals[28];            /* RGB palette (fronttext) */
extern char textDefinitions[14][6];  /* per-tMenuTextType colour indices */

static inline int TextDefinitionColor(tMenuTextType type, int column)
{
  /* The retail SYM records a nested inline block for each lookup. */
  return kRGBVals[(byte)textDefinitions[type][column]];
}

#endif
