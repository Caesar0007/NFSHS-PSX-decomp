/* eac_math.h -- EACPSXZ math group.
 *
 * Fixed-point and integer math, with the lookup tables each function owns.
 *
 * A convenience aggregate: it only includes the owner headers, one per archive
 * member, so every declaration keeps its owning module.  Include this when a TU
 * wants the whole group, or the individual owner header when it wants one module.
 *
 * Members (18): asinfunc asintbl atanfunc atantbl fatantbl fixdatan fixddiv fixdinv
 *          fixdmult fixdsin fixdsqrt fsincos isincos isqrt isqrttbl math64a
 *          sinfunc sintbl
 */
#ifndef _EAC_MATH_H_
#define _EAC_MATH_H_

#include "asinfunc.h"
#include "asintbl.h"
#include "atanfunc.h"
#include "atantbl.h"
#include "fatantbl.h"
#include "fixdatan.h"
#include "fixddiv.h"
#include "fixdinv.h"
#include "fixdmult.h"
#include "fixdsin.h"
#include "fixdsqrt.h"
#include "fsincos.h"
#include "isincos.h"
#include "isqrt.h"
#include "isqrttbl.h"
#include "math64a.h"
#include "sinfunc.h"
#include "sintbl.h"

#endif
