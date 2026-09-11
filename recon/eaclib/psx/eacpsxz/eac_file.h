/* eac_file.h -- EACPSXZ file group.
 *
 * The FILE_* operation layer, its CD and host backends, the async and
 * synchronous wrappers, streaming, and bigfile lookup.
 *
 * A convenience aggregate: it only includes the owner headers, one per archive
 * member, so every declaration keeps its owning module.  Include this when a TU
 * wants the whole group, or the individual owner header when it wants one module.
 *
 * Members (10): cdfs fileroot locatbig nasync nfile nloadpk nsync stream syncfile
 *          wildcard
 */
#ifndef _EAC_FILE_H_
#define _EAC_FILE_H_

#include "cdfs.h"
#include "fileroot.h"
#include "locatbig.h"
#include "nasync.h"
#include "nfile.h"
#include "nloadpk.h"
#include "nsync.h"
#include "stream.h"
#include "syncfile.h"
#include "wildcard.h"

#endif
