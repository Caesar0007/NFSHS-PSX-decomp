TAIL = """  SetDrawMode(dr_mode,0,0,(u_short)GetTPage(2,2,0,0x100),(RECT *)0x0);
  __asm__("" : : "r"(packetCell));
  __asm__("" : "=r"(x) : "0"(x));
  __asm__("" : "=r"(x) : "0"(x));
  return;
"""
XY = """  (prim->x0 = x,
   prim->y0 = y,
   prim->x1 = x + w,
   prim->y1 = y,
   prim->x2 = x,
   prim->y2 = y + h,
   prim->x3 = x + w,
   prim->y3 = y + h);
"""

CASES = [
 ("V0 baseline", []),
 ("V1 all three out", [(TAIL, "  SetDrawMode(dr_mode,0,0,(u_short)GetTPage(2,2,0,0x100),(RECT *)0x0);\n  return;\n")]),
 ("V2 all out + separate x stores", [(TAIL, "  SetDrawMode(dr_mode,0,0,(u_short)GetTPage(2,2,0,0x100),(RECT *)0x0);\n  return;\n"),
   (XY, """  prim->x0 = x;
  prim->y0 = y;
  prim->x1 = x + w;
  prim->y1 = y;
  prim->x2 = x;
  prim->y2 = y + h;
  prim->x3 = x + w;
  prim->y3 = y + h;
""")]),
 ("V3 all out + w+x operand order", [(TAIL, "  SetDrawMode(dr_mode,0,0,(u_short)GetTPage(2,2,0,0x100),(RECT *)0x0);\n  return;\n"),
   (XY, XY.replace("x + w", "w + x").replace("y + h", "h + y"))]),
 ("V4 packetCell fence kept only", [(TAIL, """  SetDrawMode(dr_mode,0,0,(u_short)GetTPage(2,2,0,0x100),(RECT *)0x0);
  __asm__("" : : "r"(packetCell));
  return;
""")]),
 ("V5 x identity uses kept only", [(TAIL, """  SetDrawMode(dr_mode,0,0,(u_short)GetTPage(2,2,0,0x100),(RECT *)0x0);
  __asm__("" : "=r"(x) : "0"(x));
  __asm__("" : "=r"(x) : "0"(x));
  return;
""")]),
 ("V6 all out + x via a named carrier", [(TAIL, "  SetDrawMode(dr_mode,0,0,(u_short)GetTPage(2,2,0,0x100),(RECT *)0x0);\n  return;\n"),
   (XY, """  {
    int xr = x + w;
    int yb = y + h;
    prim->x0 = x;
    prim->y0 = y;
    prim->x1 = xr;
    prim->y1 = y;
    prim->x2 = x;
    prim->y2 = yb;
    prim->x3 = xr;
    prim->y3 = yb;
  }
""")]),
]
