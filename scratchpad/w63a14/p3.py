import importlib.util, pathlib
NL = chr(13) + chr(10)
ENV = {}

_s1 = importlib.util.spec_from_file_location('p1', str(pathlib.Path(__file__).with_name('p1.py')))
p1 = importlib.util.module_from_spec(_s1); _s1.loader.exec_module(p1)
_s2 = importlib.util.spec_from_file_location('p2', str(pathlib.Path(__file__).with_name('p2.py')))
p2 = importlib.util.module_from_spec(_s2); _s2.loader.exec_module(p2)

BASE, drop, twostage, F8 = p2.BASE, p2._drop, p2.twostage, p2.F8

TS8_OLD = (F8 + "      return newControl | 1;" + NL)
TS8_NEW = ('''      newControl = player << 0x1e |
                   (0x80 - GameSetup_gData.controllerData.deadSpot[player]) * 0x10000 ;
      return (newControl |=
              (0x80 - GameSetup_gData.controllerData.steeringRange[player]) * 0x100) | 1;
'''.replace('\n', NL))


def twostage8(s):
    assert s.count(TS8_OLD) == 1, ('ts8', s.count(TS8_OLD))
    return s.replace(TS8_OLD, TS8_NEW)


PATCHES = [
    ("q5_f8_twostage9", lambda s: twostage(drop(BASE(s), (8,)))),
    ("q6_none_twostage89", lambda s: twostage8(twostage(drop(BASE(s), ())))),
    ("q7_f8_twostage89", lambda s: twostage8(twostage(drop(BASE(s), (8,))))),
    ("q8_none_twostage8", lambda s: twostage8(drop(BASE(s), ()))),
]
