/* front_after_video.h -- Front owner hook (NFS4_SCREENDISPLAY_HOOK_AFTER_VIDEO): retail Front emits tScreenMain right after
 * tVideo, then the memory-card records TCB .. MCRDFILEINFO_def in this order. */
#include "screenmain.h"
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "mcrd_productloc.h"
#include "shared/CARDINFO_def.h"
#include "shared/MCRDFILE_def.h"
#include "mcrd_managertask.h"
#include "shared/MCRDFILEHEADER_def.h"
#include "shared/MCRDFILEINFO_def.h"
