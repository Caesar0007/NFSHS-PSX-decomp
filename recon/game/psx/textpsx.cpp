/* frontend/common/textpsx.cpp -- RECONSTRUCTED (NFS4 PSX text-draw hooks; C TU)
 *   3 free fns: fortext4 (text-blit callback; empty stub w/ 8 params), inittextdraw
 *   (installs fortext4 into the active-font fn-ptr slot), restoretextdraw (clears a
 *   font working-state word). currentfont = external font-state blob (raw-offset access).
 */
#include "../../nfs4_types.h"
#include "textpsx_externs.h"


/* ---- fortext4  [TEXTPSX.C:153-179] SLD-VERIFIED ---- */
void fortext4
               (int x,int y,void *source,int u,int v,int width,int height,int rowbytes)

{
  return;
}

/* ---- inittextdraw  [TEXTPSX.C:254-270] SLD-VERIFIED ---- */
void inittextdraw(void)

{
  *(void **)(currentfont + 0x148) = (void *)fortext4;
  return;
}

/* ---- restoretextdraw  [TEXTPSX.C:280-289] SLD-VERIFIED ---- */
void restoretextdraw(void)

{
  *(int *)(currentfont + 0x94) = 0;
  return;
}

/* end of textpsx.cpp */
