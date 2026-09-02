OLD = r"""  if (gPadinfo.buf[player * 4].nopad != '\0') {
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

VARIANTS = [
 ("V0 baseline (device present)", OLD),
 ("V1 plain goto, no fence", r"""  if (gPadinfo.buf[player * 4].nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  type = gPadinfo.buf[player * 4].ID;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
"""),
 ("V2 if/else nopad-first", r"""  if (gPadinfo.buf[player * 4].nopad != '\0') {
    type = 0;
  }
  else {
    type = gPadinfo.buf[player * 4].ID;
  }
"""),
 ("V3 if/else id-first", r"""  if (gPadinfo.buf[player * 4].nopad == '\0') {
    type = gPadinfo.buf[player * 4].ID;
  }
  else {
    type = 0;
  }
"""),
 ("V4 ternary", r"""  type = (gPadinfo.buf[player * 4].nopad != '\0') ? 0 :
         gPadinfo.buf[player * 4].ID;
"""),
 ("V5 default+override", r"""  type = 0;
  if (gPadinfo.buf[player * 4].nopad == '\0') {
    type = gPadinfo.buf[player * 4].ID;
  }
"""),
 ("V6 goto, no redundant 2nd goto", r"""  if (gPadinfo.buf[player * 4].nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  type = gPadinfo.buf[player * 4].ID;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
GetPSXPadValue_gotType:
"""),
 ("V7 goto + do{}while(0)", r"""  if (gPadinfo.buf[player * 4].nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  do { type = gPadinfo.buf[player * 4].ID; } while (0);
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
"""),
 ("V8 two vars merged", r"""  {
    int t0;
    if (gPadinfo.buf[player * 4].nopad != '\0') {
      t0 = 0;
    }
    else {
      t0 = gPadinfo.buf[player * 4].ID;
    }
    type = t0;
  }
"""),
 ("V9 switch on nopad", r"""  switch (gPadinfo.buf[player * 4].nopad) {
  case '\0':
    type = gPadinfo.buf[player * 4].ID;
    break;
  default:
    type = 0;
    break;
  }
"""),
 ("V10 goto both arms, id arm last", r"""  if (gPadinfo.buf[player * 4].nopad == '\0') {
    goto GetPSXPadValue_hasPad;
  }
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_hasPad:
  type = gPadinfo.buf[player * 4].ID;
GetPSXPadValue_gotType:
"""),
 ("V11 if/else with block-local decl", r"""  if (gPadinfo.buf[player * 4].nopad != '\0') {
    type = 0;
  } else {
    int id = gPadinfo.buf[player * 4].ID;
    type = id;
  }
"""),
]
