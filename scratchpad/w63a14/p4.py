import importlib.util, pathlib
NL = chr(13) + chr(10)
ENV = {}

_s2 = importlib.util.spec_from_file_location('p2', str(pathlib.Path(__file__).with_name('p2.py')))
p2 = importlib.util.module_from_spec(_s2); _s2.loader.exec_module(p2)
BASE, drop, twostage, F8 = p2.BASE, p2._drop, p2.twostage, p2.F8

LAST8 = ("                   (0x80 - GameSetup_gData.controllerData.deadSpot[player]) * 0x10000 |" + NL +
         "                   (0x80 - GameSetup_gData.controllerData.steeringRange[player]) * 0x100 ;" + NL)
NEW8 = "                   (0x80 - GameSetup_gData.controllerData.deadSpot[player]) * 0x10000 ;" + NL
RET = "      return newControl | 1;" + NL
RET2 = ("      return (newControl |=" + NL +
        "              (0x80 - GameSetup_gData.controllerData.steeringRange[player]) * 0x100) | 1;" + NL)


def twostage8(s):
    """arm 8 (0x23 / 0x800000): move the low-byte OR into the return (front.cpp shape)."""
    i = s.find(F8)
    assert i >= 0, 'F8 missing'
    assert s.count(LAST8) == 1, ('LAST8', s.count(LAST8))
    s = s.replace(LAST8, NEW8)
    j = s.find(RET, i)
    assert j >= 0, 'RET missing'
    return s[:j] + RET2 + s[j + len(RET):]


PATCHES = [
    ("r1_f8_ts8", lambda s: twostage8(drop(BASE(s), (8,)))),
    ("r2_f8_ts8_ts9", lambda s: twostage(twostage8(drop(BASE(s), (8,))))),
    ("r3_none_ts8_ts9", lambda s: twostage(twostage8(drop(BASE(s), ())))),

]
