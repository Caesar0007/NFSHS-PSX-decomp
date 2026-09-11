/* eac_util.h -- EACPSXZ util group.
 *
 * Byte readers, string helpers, the PRNG, the shared globals and the
 * one-body nullsub family.
 *
 * A convenience aggregate: it only includes the owner headers, one per archive
 * member, so every declaration keeps its owning module.  Include this when a TU
 * wants the whole group, or the individual owner header when it wants one module.
 *
 * Members (5): getm nullfunc random stricmp vars
 */
#ifndef _EAC_UTIL_H_
#define _EAC_UTIL_H_

#include "getm.h"
#include "nullfunc.h"
#include "random.h"
#include "stricmp.h"
#include "vars.h"

#endif
