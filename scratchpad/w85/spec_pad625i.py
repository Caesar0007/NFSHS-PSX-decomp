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

INIT = ("  PAD_update();\n"
        "  {\n"
        "    int padBase = (int)&gPadinfo;\n"
        "    type = padBase + (player << 5);\n"
        "  }\n")


def V(nopad, idexp):
    return (INIT + "  if (" + nopad + " != '\\0') {\n"
            "    goto GetPSXPadValue_noPad;\n"
            "  }\n"
            "  type = " + idexp + ";\n"
            "  goto GetPSXPadValue_gotType;\n"
            "GetPSXPadValue_noPad:\n"
            "  type = 0;\n"
            "  goto GetPSXPadValue_gotType;\n"
            "GetPSXPadValue_gotType:\n")


VARIANTS = [
 ("I0 baseline", OLD),
 ("I1 raw u_char offsets 4/5",
  V("*(u_char *)(type + 4)", "*(u_char *)(type + 5)")),
 ("I2 PAD_COMMON view at +4",
  V("((PAD_COMMON *)(type + 4))->nopad", "((PAD_COMMON *)(type + 4))->ID")),
 ("I3 tPadModuleState view",
  V("((tPadModuleState *)type)->buf[0].nopad",
    "((tPadModuleState *)type)->buf[0].ID")),
 ("I4 PAD_COMMON view, ptr local",
  V("((PAD_COMMON *)(type + 4))->nopad", "((PAD_COMMON *)(type + 4))->ID")),
]
