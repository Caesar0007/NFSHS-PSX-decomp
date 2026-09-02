OLD = r"""  int newControl;
  int type;
"""

BODY_OLD = r"""  PAD_update();
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

PLAIN = r"""  PAD_update();
  if (gPadinfo.buf[player * 4].nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  type = gPadinfo.buf[player * 4].ID;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
"""

PERARM = r"""  PAD_update();
  if (gPadinfo.buf[player * 4].nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  {
    int t1 = gPadinfo.buf[player * 4].ID;
    type = t1;
  }
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  {
    int t0 = 0;
    type = t0;
  }
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
"""

# each variant = (decl-block, body) rendered as decl + a marker; the sweep only
# replaces the decl block, so the body variants are pre-substituted by the caller.
VARIANTS = [
 ("Z0 baseline decls (fence in body)", OLD),
 ("Z1 register int type", "  int newControl;\n  register int type;\n"),
 ("Z2 type declared first", "  int type;\n  int newControl;\n"),
 ("Z3 register on both", "  register int newControl;\n  register int type;\n"),
 ("Z4 short type", "  int newControl;\n  int type;\n  /*z4*/\n"),
]
