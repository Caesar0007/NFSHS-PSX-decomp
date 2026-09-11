/* eac_text.h -- EACPSXZ text group.
 *
 * Font state, glyph lookup and the ANSI / Shift-JIS decoders.
 *
 * A convenience aggregate: it only includes the owner headers, one per archive
 * member, so every declaration keeps its owning module.  Include this when a TU
 * wants the whole group, or the individual owner header when it wants one module.
 *
 * Members (4): textcode textcrnt textfor textset
 */
#ifndef _EAC_TEXT_H_
#define _EAC_TEXT_H_

#include "textcode.h"
#include "textcrnt.h"
#include "textfor.h"
#include "textset.h"

#endif
