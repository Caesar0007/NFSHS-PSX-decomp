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
  /* SYM 8c: locals are EXACTLY abr (REGPARM int) + dr_mode (REG DR_MODE*).
   * `tpage`, `linkAddr`, `prevPrim` were Ghidra fictions.
   * RESIDUAL 8 @ 39/39 -- a dbr delay-slot PICK plus the `li a3,256` position.
   * The oracle fills GetTPage's jal slot with the PALETTE store and emits the
   * cursor store ahead of it; ours picks the cursor store.  Source order
   * bump-then-pal does give the oracle's slot but then sched1 hoists the cursor
   * store above the dr_mode tag store (40).  FALSIFIED: both statement orders x
   * both OR-operand orders; volatile on the tag store / palette store / cursor
   * store in all 6 combinations (39-42); bump spelled `+ 0xc` / `+= 0xc` /
   * `(dr_mode + 1)`; and the -G / -mno-split-addresses axis (tools/gprobe.py --
   * all four settings == baseline).  SAME residual shape as drawshp's
   * DrawShape_SubtractNFS4RectEdges post-loop DR_MODE block: one lever cracks both. */
  DR_MODE *dr_mode;

  dr_mode = (DR_MODE *)Render_gPacketPtr;
  dr_mode->tag = dr_mode->tag & 0xff000000 | *(u_long *)Render_gPalettePtr & 0xffffff;
  *(u_long *)Render_gPalettePtr =
       *(u_long *)Render_gPalettePtr & 0xff000000 | (u_long)dr_mode & 0xffffff;
  Render_gPacketPtr = (u_char *)dr_mode + 0xc;
  SetDrawMode(dr_mode,0,0,(u_short)GetTPage(2,abr,0,0x100),(RECT *)0x0);
  return;
}

/* end of mmeffect.cpp */
