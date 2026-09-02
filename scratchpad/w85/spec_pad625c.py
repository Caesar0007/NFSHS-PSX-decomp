OLD = r"""  PAD_update();
  if (gPadinfo.buf[player * 4].nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  type = gPadinfo.buf[player * 4].ID;
  __asm__("");
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
"""

def V(body):
    return "  PAD_update();\n  {\n  PAD_COMMON *pb;\n  u_char t;\n" + body + "  }\n"


VARIANTS = [
 ("X0 baseline", OLD),
 ("X1 ptr + uchar t, if/else", V(r"""  pb = &gPadinfo.buf[player * 4];
  if (pb->nopad != '\0') { t = 0; } else { t = pb->ID; }
  type = t;
""")),
 ("X2 ptr + uchar t, goto arms", V(r"""  pb = &gPadinfo.buf[player * 4];
  if (pb->nopad != '\0') { goto L_np; }
  t = pb->ID;
  goto L_got;
L_np:
  t = 0;
L_got:
  type = t;
""")),
 ("X3 uchar t only, no ptr", V(r"""  if (gPadinfo.buf[player * 4].nopad != '\0') { t = 0; }
  else { t = gPadinfo.buf[player * 4].ID; }
  type = t;
""")),
 ("X4 uchar t, id-first goto", V(r"""  if (gPadinfo.buf[player * 4].nopad == '\0') { goto L_hp; }
  t = 0;
  goto L_got;
L_hp:
  t = gPadinfo.buf[player * 4].ID;
L_got:
  type = t;
""")),
 ("X5 uchar t, ternary", V(r"""  t = (gPadinfo.buf[player * 4].nopad != '\0') ? 0 : gPadinfo.buf[player * 4].ID;
  type = t;
""")),
 ("X6 uchar t, default+override", V(r"""  t = 0;
  if (gPadinfo.buf[player * 4].nopad == '\0') { t = gPadinfo.buf[player * 4].ID; }
  type = t;
""")),
 ("X7 signed char t", V(r"""  if (gPadinfo.buf[player * 4].nopad != '\0') { type = 0; }
  else { type = (signed char)gPadinfo.buf[player * 4].ID; }
""")),
 ("X8 short t", V(r"""  {
    short s;
    if (gPadinfo.buf[player * 4].nopad != '\0') { s = 0; }
    else { s = gPadinfo.buf[player * 4].ID; }
    type = s;
  }
""")),
 ("X9 uchar t + ptr, in-place", V(r"""  pb = &gPadinfo.buf[player * 4];
  t = 0;
  if (pb->nopad == '\0') { t = pb->ID; }
  type = t;
""")),
 ("X10 uchar t, uchar-typed switch var", V(r"""  if (gPadinfo.buf[player * 4].nopad != '\0') { t = 0; }
  else { t = gPadinfo.buf[player * 4].ID; }
  type = (int)t;
""")),
]
