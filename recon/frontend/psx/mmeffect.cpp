/* frontend/psx/mmeffect.cpp  --  RECONSTRUCTED  (PSX main-menu effect; C++ TU)
 *   Body: Ghidra decompiler. Line numbers: PsyQ SLD (8c-start, 8e-end).
 *   1 function; C++ linkage (cfront-mangled in SYM: FeDraw_SetABRMode__Fi). VA 0x8004d6d8.
 *   SYM locals: abr (REGPARM int) + dr_mode (REG DR_MODE*). 18 callers.
 *   Externs declared in mmeffect_externs.h (libgpu GetTPage/SetDrawMode + render cursors).
 */
#include "mmeffect.h"
#include "mmeffect_externs.h"

/* lines 1-232: file header, #includes, static data, macros (no symbols emitted) */

/* ---- FeDraw_SetABRMode  (mmeffect.cpp:233, code lines 233-237) ---- */
/* GPU packet: builds DR_MODE (stride 0xc, SetDrawMode); dr_mode=DR_MODE* cursor (SYM REG),
 * prevPrim=u_char* link word. 24-bit OT stitch (same pattern + naming as PSXFRONT shape emitters):
 * write the prev packet's 24-bit link into the new packet's tag, advance the global packet
 * pointer by one DR_MODE (0xc), then patch the previous pal-link word. tpage = GetTPage(16bpp,
 * abr, 0, 0x100); SetDrawMode emits the draw-mode primitive. abr arrives in a0 (the decompiler's
 * lost-dataflow `in_a0` read == the regparm abr). Non-SYM temps named to match PSXFRONT:
 * linkAddr (24-bit OT link), prevPrim (= Render_gPalettePtr link cursor). */
void FeDraw_SetABRMode(int abr)

{
  short tpage;
  int linkAddr;
  DR_MODE *dr_mode;
  u_char *prevPrim;

  dr_mode = (DR_MODE *)Render_gPacketPtr;
  prevPrim = Render_gPalettePtr;
  *(uint *)Render_gPacketPtr =
       *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
  linkAddr = (uint)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0xc;
  *(uint *)prevPrim = *(uint *)prevPrim & 0xff000000 | linkAddr;
  tpage = GetTPage(2,abr,0,0x100);
  SetDrawMode(dr_mode,0,0,(u_long)(u_short)tpage,(RECT *)0x0);
  return;
}

/* end of mmeffect.cpp */
