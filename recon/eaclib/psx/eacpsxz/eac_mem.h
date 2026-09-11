/* eac_mem.h -- EACPSXZ mem group.
 *
 * The memory-class allocator and the block primitives.
 *
 * A convenience aggregate: it only includes the owner headers, one per archive
 * member, so every declaration keeps its owning module.  Include this when a TU
 * wants the whole group, or the individual owner header when it wants one module.
 *
 * Members (5): blkfill blkmov meminit memstd resize
 */
#ifndef _EAC_MEM_H_
#define _EAC_MEM_H_

#include "blkfill.h"
#include "blkmov.h"
#include "meminit.h"
#include "memstd.h"
#include "resize.h"

#endif
