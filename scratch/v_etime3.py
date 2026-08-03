TU = 'recon/game/psx/hud.cpp'
FNS = 'Hud_BuildETimeString__FP4SPRTi'

CLAMP = """  if (time < 0) {
    time = 0;
  }
"""
HEAD = """  temp2 = __builtin_abs(time);
  temp1 = time / 0x40;
"""

VARIANTS = [
    # K1: ternary clamp (different clamp RTL -> different pseudo for `time`)
    ('K1 ternary clamp', [(CLAMP, "  time = (time < 0) ? 0 : time;\n")]),
    # K2: clamp into a fresh local, divide on it, abs on it
    ('K2 clamp into fresh local', [
        (CLAMP + HEAD, """  {
  int t;
  t = time;
  if (t < 0) {
    t = 0;
  }
  temp2 = __builtin_abs(t);
  temp1 = t / 0x40;
  }
""")]),
    # K3: abs of the SURVIVOR taken from the divide's quotient path
    ('K3 divide first on abs, survivor from time', [
        (HEAD, """  temp1 = __builtin_abs(time) / 0x40;
  temp2 = __builtin_abs(time);
""")]),
    # K4: current basin, but `time` re-read after the divide (keeps time live -> forces a copy)
    ('K4 extra late use of time', [
        (HEAD, """  temp2 = __builtin_abs(time);
  temp1 = time / 0x40;
  temp2 = temp2 + (time - time);
""")]),
]
