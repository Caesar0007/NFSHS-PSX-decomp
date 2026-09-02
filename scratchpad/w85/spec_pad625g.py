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

TAIL = r"""    goto GetPSXPadValue_noPad;
  }
  type = @ID;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
"""


def V(init, nopad, idexp):
    return ("  PAD_update();\n  " + init + "\n  if (" + nopad + " != '\\0') {\n"
            + TAIL.replace('@ID', idexp))


VARIANTS = [
 ("G0 baseline", OLD),
 ("G1 base-first, gPadinfo + shift",
  V("type = (int)&gPadinfo + (player << 5);",
    "*(u_char *)(type + 4)", "*(u_char *)(type + 5)")),
 ("G2 shift-first, gPadinfo + shift",
  V("type = (player << 5) + (int)&gPadinfo;",
    "*(u_char *)(type + 4)", "*(u_char *)(type + 5)")),
 ("G3 base-first, PAD_COMMON view",
  V("type = (int)&gPadinfo + player * 32;",
    "((PAD_COMMON *)(type + 4))->nopad", "((PAD_COMMON *)(type + 4))->ID")),
 ("G4 &gPadinfo.buf[0] + shift, base-first",
  V("type = (int)&gPadinfo.buf[0] + (player << 5);",
    "((PAD_COMMON *)type)->nopad", "((PAD_COMMON *)type)->ID")),
 ("G5 &gPadinfo.buf[player*4], PAD_COMMON",
  V("type = (int)&gPadinfo.buf[player * 4];",
    "((PAD_COMMON *)type)->nopad", "((PAD_COMMON *)type)->ID")),
 ("G6 base-first, u_char* carrier",
  V("type = (int)&gPadinfo + (player << 5);",
    "((PAD_COMMON *)((char *)type + 4))->nopad",
    "((PAD_COMMON *)((char *)type + 4))->ID")),
 ("G7 gPadinfo.initialized addr base",
  V("type = (int)&gPadinfo.initialized + (player << 5);",
    "*(u_char *)(type + 4)", "*(u_char *)(type + 5)")),
]
