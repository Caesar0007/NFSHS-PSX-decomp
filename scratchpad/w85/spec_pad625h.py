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

TAIL = r"""  if (*(u_char *)(type + 4) != '\0') {
    goto GetPSXPadValue_noPad;
  }
  type = *(u_char *)(type + 5);
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
"""


def V(init):
    return "  PAD_update();\n" + init + TAIL


VARIANTS = [
 ("H0 baseline", OLD),
 ("H1 base local first, then shift, +=",
  V("  {\n  int b = (int)&gPadinfo;\n  type = player << 5;\n  type += b;\n  }\n")),
 ("H2 base local first, type = b + shift",
  V("  {\n  int b = (int)&gPadinfo;\n  type = b + (player << 5);\n  }\n")),
 ("H3 base local first, type = shift + b",
  V("  {\n  int b = (int)&gPadinfo;\n  type = (player << 5) + b;\n  }\n")),
 ("H4 type = base then += shift",
  V("  type = (int)&gPadinfo;\n  type += player << 5;\n")),
 ("H5 type = shift then += base",
  V("  type = player << 5;\n  type += (int)&gPadinfo;\n")),
 ("H6 base local, shift local, sum",
  V("  {\n  int b = (int)&gPadinfo;\n  int sh = player << 5;\n  type = sh + b;\n  }\n")),
 ("H7 base local, shift local, sum rev",
  V("  {\n  int b = (int)&gPadinfo;\n  int sh = player << 5;\n  type = b + sh;\n  }\n")),
 ("H8 base local, shift into type first",
  V("  {\n  int b;\n  b = (int)&gPadinfo;\n  type = player * 32;\n  type = type + b;\n  }\n")),
]
