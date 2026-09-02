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

def V(b):
    return "  PAD_update();\n" + b

VARIANTS = [
 ("Q0 baseline", OLD),
 ("Q1 morph only in the id arm", V(r"""  if (gPadinfo.buf[player * 4].nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  type = (int)&gPadinfo.buf[player * 4];
  type = ((PAD_COMMON *)type)->ID;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
""")),
 ("Q2 Y2 + redundant 2nd goto", V(r"""  type = (int)&gPadinfo.buf[player * 4];
  if (((PAD_COMMON *)type)->nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  type = ((PAD_COMMON *)type)->ID;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
""")),
 ("Q3 morph via int carrier, uchar cast", V(r"""  type = (int)&gPadinfo.buf[player * 4];
  if (*(u_char *)type != '\0') {
    goto GetPSXPadValue_noPad;
  }
  type = *(u_char *)(type + 1);
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
""")),
 ("Q4 nopad tested via separate temp", V(r"""  {
    u_char np = gPadinfo.buf[player * 4].nopad;
    if (np != '\0') {
      goto GetPSXPadValue_noPad;
    }
  }
  type = gPadinfo.buf[player * 4].ID;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
""")),
 ("Q5 arms swapped, id fallthrough last", V(r"""  if (gPadinfo.buf[player * 4].nopad == '\0') {
    goto GetPSXPadValue_hasPad;
  }
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_hasPad:
  type = gPadinfo.buf[player * 4].ID;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
""")),
 ("Q6 id arm keeps ptr live via 2nd read", V(r"""  if (gPadinfo.buf[player * 4].nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  type = gPadinfo.buf[player * 4].ID;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = gPadinfo.buf[player * 4].nopad & 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
""")),
]
