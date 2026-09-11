/* eac_shape.h -- EACPSXZ shape group.
 *
 * The EA "shape" bitmap subsystem: headers, CLUTs, VRAM blits and the
 * primitive/ordering-table cursor.
 *
 * A convenience aggregate: it only includes the owner headers, one per archive
 * member, so every declaration keeps its owning module.  Include this when a TU
 * wants the whole group, or the individual owner header when it wants one module.
 *
 * Members (11): cluttype fastmovf loadshp locatshp movf primate shpclut shpdepth
 *          shpsubs shptype vramfxya
 */
#ifndef _EAC_SHAPE_H_
#define _EAC_SHAPE_H_

#include "cluttype.h"
#include "fastmovf.h"
#include "loadshp.h"
#include "locatshp.h"
#include "movf.h"
#include "primate.h"
#include "shpclut.h"
#include "shpdepth.h"
#include "shpsubs.h"
#include "shptype.h"
#include "vramfxya.h"

#endif
