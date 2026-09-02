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
 ("W0 baseline", OLD),
 ("W1 ptr local, goto arms", V(r"""  {
    PAD_COMMON *pb = &gPadinfo.buf[player * 4];
    if (pb->nopad != '\0') {
      type = 0;
    } else {
      type = pb->ID;
    }
  }
""")),
 ("W2 ptr local, fn-scope", V(r"""  pb = &gPadinfo.buf[player * 4];
  if (pb->nopad != '\0') {
    type = 0;
  } else {
    type = pb->ID;
  }
""")),
 ("W3 ptr local, id-first goto", V(r"""  pb = &gPadinfo.buf[player * 4];
  if (pb->nopad == '\0') {
    goto GetPSXPadValue_hasPad;
  }
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_hasPad:
  type = pb->ID;
GetPSXPadValue_gotType:
""")),
 ("W4 ptr local + in-place mutate", V(r"""  pb = &gPadinfo.buf[player * 4];
  if (pb->nopad != '\0') {
    type = 0;
  } else {
    pb = (PAD_COMMON *)&pb->ID;
    type = *(u_char *)pb;
  }
""")),
 ("W5 char-typed type var", V(r"""  {
    u_char t;
    if (gPadinfo.buf[player * 4].nopad != '\0') {
      t = 0;
    } else {
      t = gPadinfo.buf[player * 4].ID;
    }
    type = t;
  }
""")),
 ("W6 ptr walk, index form", V(r"""  pb = gPadinfo.buf + player * 4;
  if (pb[0].nopad != '\0') {
    type = 0;
  } else {
    type = pb[0].ID;
  }
""")),
 ("W7 ptr local, ternary", V(r"""  pb = &gPadinfo.buf[player * 4];
  type = (pb->nopad != '\0') ? 0 : pb->ID;
""")),
 ("W8 ptr local, default+override", V(r"""  pb = &gPadinfo.buf[player * 4];
  type = 0;
  if (pb->nopad == '\0') {
    type = pb->ID;
  }
""")),
 ("W9 ptr local, cast-int subscript", V(r"""  pb = (PAD_COMMON *)((player << 5) + (int)&gPadinfo.buf[0]);
  if (pb->nopad != '\0') {
    type = 0;
  } else {
    type = pb->ID;
  }
""")),
]
