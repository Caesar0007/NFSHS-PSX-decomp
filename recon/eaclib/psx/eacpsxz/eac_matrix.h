/* eac_matrix.h -- EACPSXZ matrix group.
 *
 * 3x3 matrix and vector transforms (all built on fixedmult).
 *
 * A convenience aggregate: it only includes the owner headers, one per archive
 * member, so every declaration keeps its owning module.  Include this when a TU
 * wants the whole group, or the individual owner header when it wants one module.
 *
 * Members (7): crossprd fxform matrix trnsfrm trnsmult trnspos xform
 */
#ifndef _EAC_MATRIX_H_
#define _EAC_MATRIX_H_

#include "crossprd.h"
#include "fxform.h"
#include "matrix.h"
#include "trnsfrm.h"
#include "trnsmult.h"
#include "trnspos.h"
#include "xform.h"

#endif
