/* game/psx/textpsx.c -- RECONSTRUCTED (NFS4 PSX text-draw hooks)
 *   C TU: SLD source = C:\nfs4\GAME\PSX\TEXTPSX.C -> CC1PSX lane (methodology 3.25;
 *   migrated from textpsx.cpp, task #90). Self-contained per C-lane convention.
 *   3 free fns: fortext4 (text-blit callback; empty stub w/ 8 params), inittextdraw
 *   (installs fortext4 into the active-font fn-ptr slot), restoretextdraw (clears a
 *   font working-state word). currentfont = external font-state blob (raw-offset access).
 */

/* currentfont: active-font working-state blob @ 0x80135ba0 (spans 696B to Font@0x80135e58).
 * Defined in a sibling font TU; this TU only touches the word field at +0x94 and the
 * text-draw fn-ptr field at +0x148, both by raw offset (no named struct in this TU's SYM). */
extern unsigned char currentfont[];

/* ---- fortext4  [TEXTPSX.C:153-179] SLD-VERIFIED ---- */
void fortext4(int x, int y, void *source, int u, int v, int width, int height, int rowbytes)
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

/* end of textpsx.c */
