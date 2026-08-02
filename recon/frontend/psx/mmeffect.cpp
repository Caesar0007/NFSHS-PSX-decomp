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
  /* SYM 8c: named locals are EXACTLY abr (REGPARM int) + dr_mode (REG DR_MODE*).
   * SLD: 0x8004D708..0x8004D740 -- the WHOLE OT-link block -- is ONE source line
   * (236); the SetDrawMode call is line 237.  So retail wrote line 236 as a single
   * OT-link MACRO, and `linkWord` below is that macro's internal temp (it holds no
   * value across a statement boundary in the original, which is why the SYM has no
   * Def record for it -- cf. psxfront.cpp's `linkAddr`, the same house idiom).
   *
   * MATCH (the lever, cracked 2026-08-02): SPLIT the palette read-modify-write into
   * a VALUE statement + a STORE statement, and put the packet-cursor bump BETWEEN
   * them.  That makes the palette store the LAST insn before `jal GetTPage`, so
   * dbr's backward `fill_simple_delay_slots` scan takes IT into the call's delay
   * slot (the oracle's pick) while the cursor store keeps its position ahead of the
   * OR chain.  The un-split form leaves the cursor store last -> dbr steals THAT.
   * FALSIFIED (all gated): bump-before-pal (40) incl. a `next` cursor temp (40) and
   * a swapped pal-OR (40); psxfront's own `prevPrim` scratchpad-pointer cache -- this
   * fn is straight-line, so re-reading the slot IS right here and the cache costs
   * diffs (the full psxfront `prevPrim`+`linkAddr` spelling measured 30, `linkAddr`
   * alone 30, vs PASS for the value/store split with no pointer cache); the
   * Draw_PrimStruct struct-field view of the cursor for
   * both orders (17 / 19); volatile on the palette store (8); psxfront's exact
   * `prevPrim`+`linkAddr` spelling (30) and `linkAddr` alone (30); linkWord with the
   * OR operands swapped (26); and the -G / -mno-split-addresses axis (gprobe: all
   * four settings == baseline). */
  DR_MODE *dr_mode;
  u_long linkWord;

  dr_mode = (DR_MODE *)Render_gPacketPtr;
  dr_mode->tag = dr_mode->tag & 0xff000000 | *(u_long *)Render_gPalettePtr & 0xffffff;
  linkWord = *(u_long *)Render_gPalettePtr & 0xff000000 | (u_long)dr_mode & 0xffffff;
  Render_gPacketPtr = (u_char *)dr_mode + 0xc;
  *(u_long *)Render_gPalettePtr = linkWord;
  SetDrawMode(dr_mode,0,0,(u_short)GetTPage(2,abr,0,0x100),(RECT *)0x0);
  return;
}

/* end of mmeffect.cpp */
