TU = 'recon/game/psx/hud.cpp'
FNS = 'Hud_BuildETimeString__FP4SPRTi'

HEAD = """  temp2 = __builtin_abs(time);
  temp1 = time / 0x40;
"""

TAIL = """  hun = (temp2 - temp1 * 0x40) * 100 / 0x40;
"""

VARIANTS = [
    # J1: abs in place on temp1, survivor copy, divide in place  (re-test, NEW BASIN)
    ('J1 temp1=abs; temp2=temp1; temp1/=64', [
        (HEAD, """  temp1 = __builtin_abs(time);
  temp2 = temp1;
  temp1 = temp1 / 0x40;
""")]),
    # J2: same but hun off `time`
    ('J2 J1 + hun uses time', [
        (HEAD, """  temp1 = __builtin_abs(time);
  temp2 = temp1;
  temp1 = temp1 / 0x40;
"""),
        (TAIL, """  hun = (time - temp1 * 0x40) * 100 / 0x40;
""")]),
    # J3: abs in place on the PARAM, survivor copy of the param, divide on the param
    ('J3 time=abs(time); temp2=time; temp1=time/64', [
        (HEAD, """  time = __builtin_abs(time);
  temp2 = time;
  temp1 = time / 0x40;
""")]),
    # J4: abs in place on the param, hun uses time (no temp2)
    ('J4 time=abs(time); temp1=time/64; hun off time', [
        (HEAD, """  time = __builtin_abs(time);
  temp1 = time / 0x40;
"""),
        (TAIL, """  hun = (time - temp1 * 0x40) * 100 / 0x40;
""")]),
    # J5: swap statement order in the current basin
    ('J5 divide first, abs second', [
        (HEAD, """  temp1 = time / 0x40;
  temp2 = __builtin_abs(time);
""")]),
    # J6: current basin but hun off `time`
    ('J6 current + hun uses time', [
        (TAIL, """  hun = (time - temp1 * 0x40) * 100 / 0x40;
""")]),
]
