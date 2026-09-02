import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from pathlib import Path
p = Path(r'C:\Temp\nfs4-decomp\recon\frontend\common\femenuoptions.cpp')
s = p.read_text(encoding='latin-1')
subs = [
("""  DR_MODE *dr_mode;
  /* SYM-CODEGEN-CARRIER: packetCell -- the W59 oracle receipt above proves
     this source-only address pseudo is required for retail register allocation. */
  u_char **packetCell;
  POLY_G4 *prim;
""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read dr_mode, prim; the non-SYM
     packetCell carrier follows the SYM set. */
  DR_MODE *dr_mode;
  POLY_G4 *prim;
  /* SYM-CODEGEN-CARRIER: packetCell -- the W59 oracle receipt above proves
     this source-only address pseudo is required for retail register allocation. */
  u_char **packetCell;
"""),
("""  /* SYM-CODEGEN-CARRIER: entry -- manual representation of the compiler's
     old-ABI virtual-dispatch row; flattening row 5 is FAIL 7 (128/129). */
  __vtbl_ptr_type *entry;
  /* SYM-CODEGEN-CARRIER: adjusted -- preserves retail's dead receiver
     mutation before the indirect call; inlining it is FAIL 25 (128/129). */
  char *adjusted;
  short i;
  tDrawShapeExtended drawFlags;
""",
 """  /* SYM ORDER (W86-S2): the SYM rows i, drawFlags lead; the two non-SYM
     carriers follow the SYM set. */
  short i;
  tDrawShapeExtended drawFlags;
  /* SYM-CODEGEN-CARRIER: entry -- manual representation of the compiler's
     old-ABI virtual-dispatch row; flattening row 5 is FAIL 7 (128/129). */
  __vtbl_ptr_type *entry;
  /* SYM-CODEGEN-CARRIER: adjusted -- preserves retail's dead receiver
     mutation before the indirect call; inlining it is FAIL 25 (128/129). */
  char *adjusted;
"""),
("""  /* SYM-CODEGEN-CARRIER: entry10 -- the original virtual dispatch created
     this row-10 compiler temporary without a source local; flattening the
     ABI-neutral manual `_vf` form is FAIL 7 (152/153). */
  __vtbl_ptr_type *entry10;
  /* SYM-CODEGEN-CARRIER: entry6 -- distinct row-6 dispatch lifetime required
     by retail allocation; flattening it is FAIL 18 (153/153). */
  __vtbl_ptr_type *entry6;
  short i;
  short j;
  """,
 """  /* SYM ORDER (W86-S2): the SYM rows i, j lead; the two non-SYM carriers
     follow the SYM set. */
  short i;
  short j;
  /* SYM-CODEGEN-CARRIER: entry10 -- the original virtual dispatch created
     this row-10 compiler temporary without a source local; flattening the
     ABI-neutral manual `_vf` form is FAIL 7 (152/153). */
  __vtbl_ptr_type *entry10;
  /* SYM-CODEGEN-CARRIER: entry6 -- distinct row-6 dispatch lifetime required
     by retail allocation; flattening it is FAIL 18 (153/153). */
  __vtbl_ptr_type *entry6;
"""),
("""  int ColText;
  tDrawShapeExtended aCol;
  """,
 """  /* SYM ORDER (W86-S2): the 8c Def rows read aCol, ColText. */
  tDrawShapeExtended aCol;
  int ColText;
"""),
("""  /* SYM-CODEGEN-CARRIER: x -- adjusting the parameters directly is two
     instructions short and 68 diffs; retaining only y leaves 64 diffs. */
  int x;
  /* SYM-CODEGEN-CARRIER: y -- retaining only x leaves 80 diffs.  The two
     independent values restore the exact 94-insn frame and allocation. */
  int y;
  int ColTextOn;
  int ColTextOff;
""",
 """  /* SYM ORDER (W86-S2): the SYM rows ColTextOn, ColTextOff lead; the two
     non-SYM carriers follow the SYM set. */
  int ColTextOn;
  int ColTextOff;
  /* SYM-CODEGEN-CARRIER: x -- adjusting the parameters directly is two
     instructions short and 68 diffs; retaining only y leaves 64 diffs. */
  int x;
  /* SYM-CODEGEN-CARRIER: y -- retaining only x leaves 80 diffs.  The two
     independent values restore the exact 94-insn frame and allocation. */
  int y;
"""),
("""  int coltext;
  /* SYM-CODEGEN-CARRIER: brightTextColor
     The trusted block names only `coltext` ($s0). Retail nevertheless holds
     textDefinitions[][5]'s bright palette color across DrawLeftFlare in $s2;
     no debug name survives, so this semantic name is not claimed as original. */
  int brightTextColor;
  /* SYM-CODEGEN-CARRIER: rgbVals
     GCC must materialize kRGBVals before the first TextSys_WordFlags call so
     the address remains in $s1 across both calls; inlining the array base
     rematerializes it after the call and loses the 131/131 retail allocation. */
  int *rgbVals;
  tDrawShapeExtended tCol;
""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read coltext, tCol; the two non-SYM
     carriers follow the SYM set. */
  int coltext;
  tDrawShapeExtended tCol;
  /* SYM-CODEGEN-CARRIER: brightTextColor
     The trusted block names only `coltext` ($s0). Retail nevertheless holds
     textDefinitions[][5]'s bright palette color across DrawLeftFlare in $s2;
     no debug name survives, so this semantic name is not claimed as original. */
  int brightTextColor;
  /* SYM-CODEGEN-CARRIER: rgbVals
     GCC must materialize kRGBVals before the first TextSys_WordFlags call so
     the address remains in $s1 across both calls; inlining the array base
     rematerializes it after the call and loses the 131/131 retail allocation. */
  int *rgbVals;
"""),
("""  int song;
  int j;
  int drawY;
  int drawBaseY;
  u_int slide;
  tfrontEnd *fe;
  int width;
""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read j, drawY, song; the four non-SYM
     carriers follow the SYM set. */
  int j;
  int drawY;
  int song;
  int drawBaseY;
  u_int slide;
  tfrontEnd *fe;
  int width;
"""),
("""  int Col;
  int ColText;
  int ColTextOn;
  int ColTextOff;
""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read Col, ColTextOn, ColTextOff,
     ColText. */
  int Col;
  int ColTextOn;
  int ColTextOff;
  int ColText;
"""),
("""  tTexture_ShapeInfo *shape;
  /* SYM-CODEGEN-CARRIER: x -- parameter mutation leaves 34 diffs; retaining
     only y leaves 24.  Its independent pseudo is required by retail. */
  int x;
  /* SYM-CODEGEN-CARRIER: y -- retaining only x leaves 28 diffs.  With both
     values exposed, GCC reproduces the exact 129-insn saved-register map. */
  int y;
  int Col;
  int ColText;
  int w;
""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read shape, Col, ColText (drawFlags and
     tCol are the AUTO rows declared at their own blocks); the three non-SYM
     carriers follow the SYM set. */
  tTexture_ShapeInfo *shape;
  int Col;
  int ColText;
  /* SYM-CODEGEN-CARRIER: x -- parameter mutation leaves 34 diffs; retaining
     only y leaves 24.  Its independent pseudo is required by retail. */
  int x;
  /* SYM-CODEGEN-CARRIER: y -- retaining only x leaves 28 diffs.  With both
     values exposed, GCC reproduces the exact 129-insn saved-register map. */
  int y;
  int w;
"""),
("""  u_short selection;
  int col2;
  int col;
  int coltext;
  /* SYM-CODEGEN-CARRIER: fWidth
     A named narrow value preserves the shared 16-bit width passed to both
     DrawSlider calls; inlining it changes the retail argument schedule. */
  short fWidth;
  int ww;
""",
 """  u_short selection;
  /* SYM ORDER (W86-S2): the 8c Def rows read ww, col, col2, coltext. */
  int ww;
  int col;
  int col2;
  int coltext;
  /* SYM-CODEGEN-CARRIER: fWidth
     A named narrow value preserves the shared 16-bit width passed to both
     DrawSlider calls; inlining it changes the retail argument schedule. */
  short fWidth;
"""),
("""  tTexture_ShapeInfo *shape;
  short sVar2;
  int x;
  int y;
  int Col;
  int ColText;
  int fEnableSlide;
  int fEnableFade;
  int fWidth;
  tDrawShapeExtended tCol;
  int v;
  int sv;
  int less;
""",
 """  /* SYM ORDER (W86-S2): the 8c Def rows read fEnableFade, fEnableSlide, x, y,
     ColText, Col, tCol, fWidth, shape; the four non-SYM carriers follow. */
  int fEnableFade;
  int fEnableSlide;
  int x;
  int y;
  int ColText;
  int Col;
  tDrawShapeExtended tCol;
  int fWidth;
  tTexture_ShapeInfo *shape;
  short sVar2;
  int v;
  int sv;
  int less;
"""),
]
for a, b in subs:
    c = s.count(a)
    if c != 1:
        print("MISS/AMBIG:", repr(a[:70]), c)
        continue
    s = s.replace(a, b)
p.write_text(s, encoding='latin-1')
print("written")
