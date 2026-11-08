/* femenudefs_after_video.h -- FEMenuDefs owner hook (NFS4_SCREENDISPLAY_HOOK_AFTER_VIDEO): retail FEMenuDefs emits
 * tGlobalMenuDefs right after tVideo, then the memory-card records TCB .. MCRDFILEINFO_def in this order. */
#include "femenudefs_globalmenudefs.h"
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "mcrd_productloc.h"
#include "shared/CARDINFO_def.h"
#include "shared/MCRDFILE_def.h"
#include "mcrd_managertask.h"
#include "shared/MCRDFILEHEADER_def.h"
#include "shared/MCRDFILEINFO_def.h"
