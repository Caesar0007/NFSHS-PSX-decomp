TU = 'recon/game/psx/hud.cpp'
FNS = 'Hud_BuildETimeString__FP4SPRTi'

HEAD = """  if (time < 0) {
    time = 0;
  }
  temp2 = __builtin_abs(time);
  temp1 = temp2 / 0x40;
  min = (temp1 / 0x3c) % 0x3c;
  sec = temp1 % 0x3c;
"""

TAIL = """  hun = (temp2 - temp1 * 0x40) * 100 / 0x40;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[min / 10];
"""

TAIL_TIME = """  hun = (time - temp1 * 0x40) * 100 / 0x40;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[min / 10];
"""

TAIL_NONE = """  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[min / 10];
"""

VARIANTS = [
    ('H1 no-temp2, hun uses time', [
        (HEAD, """  if (time < 0) {
    time = 0;
  }
  temp1 = __builtin_abs(time) / 0x40;
  min = (temp1 / 0x3c) % 0x3c;
  sec = temp1 % 0x3c;
"""),
        (TAIL, TAIL_TIME)]),

    ('H2 named abs for divide, hun uses time', [(TAIL, TAIL_TIME)]),

    ('H3 hun-numerator early', [
        (HEAD, """  if (time < 0) {
    time = 0;
  }
  temp2 = __builtin_abs(time);
  temp1 = temp2 / 0x40;
  hun = (temp2 - temp1 * 0x40) * 100 / 0x40;
  min = (temp1 / 0x3c) % 0x3c;
  sec = temp1 % 0x3c;
"""),
        (TAIL, TAIL_NONE)]),

    ('H4 u_int survivor', [
        (HEAD, """  if (time < 0) {
    time = 0;
  }
  {
  u_int uabs;
  uabs = (u_int)__builtin_abs(time);
  temp2 = (int)uabs;
  }
  temp1 = temp2 / 0x40;
  min = (temp1 / 0x3c) % 0x3c;
  sec = temp1 % 0x3c;
""")]),

    ('H5 divide time, survivor abs', [
        (HEAD, """  if (time < 0) {
    time = 0;
  }
  temp2 = __builtin_abs(time);
  temp1 = time / 0x40;
  min = (temp1 / 0x3c) % 0x3c;
  sec = temp1 % 0x3c;
""")]),
]
