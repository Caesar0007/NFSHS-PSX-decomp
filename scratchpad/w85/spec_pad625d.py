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
    return "  PAD_update();\n" + body


VARIANTS = [
 ("Y0 baseline", OLD),
 ("Y1 type morphs addr->value, if/else", V(r"""  type = (int)&gPadinfo.buf[player * 4];
  if (((PAD_COMMON *)type)->nopad != '\0') {
    type = 0;
  } else {
    type = ((PAD_COMMON *)type)->ID;
  }
""")),
 ("Y2 type morphs, goto arms", V(r"""  type = (int)&gPadinfo.buf[player * 4];
  if (((PAD_COMMON *)type)->nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  type = ((PAD_COMMON *)type)->ID;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
GetPSXPadValue_gotType:
""")),
 ("Y3 type morphs, ternary", V(r"""  type = (int)&gPadinfo.buf[player * 4];
  type = (((PAD_COMMON *)type)->nopad != '\0') ? 0 : ((PAD_COMMON *)type)->ID;
""")),
 ("Y4 type morphs, default+override", V(r"""  type = (int)&gPadinfo.buf[player * 4];
  if (((PAD_COMMON *)type)->nopad == '\0') {
    type = ((PAD_COMMON *)type)->ID;
  } else {
    type = 0;
  }
""")),
 ("Y5 morph via u_char deref", V(r"""  type = (int)&gPadinfo.buf[player * 4];
  if (*(u_char *)type != '\0') {
    type = 0;
  } else {
    type = *(u_char *)(type + 1);
  }
""")),
 ("Y6 morph, gPadinfo base + shift", V(r"""  type = (int)&gPadinfo + (player << 5);
  if (*(u_char *)(type + 4) != '\0') {
    type = 0;
  } else {
    type = *(u_char *)(type + 5);
  }
""")),
 ("Y7 morph + goto both arms", V(r"""  type = (int)&gPadinfo.buf[player * 4];
  if (((PAD_COMMON *)type)->nopad == '\0') {
    goto GetPSXPadValue_hasPad;
  }
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_hasPad:
  type = ((PAD_COMMON *)type)->ID;
GetPSXPadValue_gotType:
""")),
 ("Y8 ptr local of PAD_COMMON*, morph int", V(r"""  {
    PAD_COMMON *pb = &gPadinfo.buf[player * 4];
    type = (int)pb;
    if (pb->nopad != '\0') {
      type = 0;
    } else {
      type = pb->ID;
    }
  }
""")),
]
