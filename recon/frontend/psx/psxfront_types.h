/* PSXFront.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_FRONTEND_PSX_PSXFRONT_TYPES_H
#define NFS4_FRONTEND_PSX_PSXFRONT_TYPES_H
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
/* Fetools.obj contributes the exact 95-definition shared graph.  Its four
 * menu-only classes and Fecntl's Input_tDeviceCall typedef are absent from
 * PSXFront.obj and therefore omitted only for this composition. */
#define NFS4_FETOOLS_OMIT_MENU_CLASSES
#define NFS4_FECNTL_NO_INPUT_DEVICE_CALL
#include "../common/fetools_types.h"
#undef NFS4_FECNTL_NO_INPUT_DEVICE_CALL
#undef NFS4_FETOOLS_OMIT_MENU_CLASSES

/* Scratchpad render cursors are fixed-address lvalues, not owned globals. */
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

#include "shared/CdlLOC.h"



#include "shared/charactertbl.h"






#include "shared/DR_OFFSET.h"




#include "shared/eacelement.h"



#include "shared/POLY_F4.h"





#include "shared/POLY_FT4.h"
















#include "shared/POLY_G4.h"











#include "shared/POLY_GT4.h"


















#include "../../game/common/color_types.h"   /* retail PSXFront: color.obj graph before the SND records */
#include "shared/SNDSYSCAP.h"






#include "shared/SNDSYSSET.h"








#include "shared/SNDSYSVEC.h"



#include "shared/SNDSAMPLEFORMAT.h"




typedef void (*CdlCB)(u_char intr, u_char *result); /* PsyQ 4.3 <libcd.h> */
typedef charactertbl FONTFILECHAR;
typedef eacelement EACELEMENT;
typedef unsigned int qfunc();

/* These completed foreign-owner tags are absent from PSXFront.obj.  Exact
 * private compiler-boundary views preserve the known extents and field
 * offsets used by the byte-matched bodies without claiming foreign types. */
/* GameSetup_gData: PSXFront.obj records no GameSetup type -- read through a word view of the same 2600 bytes
   (psxfront_externs.h: `extern int GameSetup_gData[650];`; Weather [18], &carInfo[i] = [245] + i*45 words). */















#include "shared/DRender_tView.h"   /* the real DRender_tView / dflip (no codegen views; header-truth 4-B.4) */
#include "shared/dflip.h"








#endif
