import re, importlib.util, pathlib
NL = chr(13) + chr(10)
ENV = {}

_spec = importlib.util.spec_from_file_location('p1', str(pathlib.Path(__file__).with_name('p1.py')))
p1 = importlib.util.module_from_spec(_spec); _spec.loader.exec_module(p1)

FENCE = p1.FENCE
BASE = lambda s: p1.apply2(p1.apply6(s))

F8 = ('''      newControl = player << 0x1e |
                   (0x80 - GameSetup_gData.controllerData.deadSpot[player]) * 0x10000 |
                   (0x80 - GameSetup_gData.controllerData.steeringRange[player]) * 0x100 ;
'''.replace('\n', NL))
F9 = ('''      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.deadSpot[player] + 0x80) * 0x10000 |
                   (GameSetup_gData.controllerData.steeringRange[player] + 0x80) * 0x100 ;
'''.replace('\n', NL))


def _drop(s, keep):
    """remove all fences, then re-insert after the arms named in `keep` (8 and/or 9)."""
    assert s.count(FENCE) == 2
    s = s.replace(FENCE, '')
    for k, anchor in ((8, F8), (9, F9)):
        if k in keep:
            assert s.count(anchor) == 1, ('anchor', k, s.count(anchor))
            s = s.replace(anchor, anchor + FENCE)
    return s


# front.cpp's two-stage compound spelling for the 0x23 / 0x200000 arm
TWOSTAGE_OLD = (F9 + "      return newControl | 1;" + NL)
TWOSTAGE_NEW = ('''      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.deadSpot[player] + 0x80) * 0x10000 ;
      return (newControl |=
              (GameSetup_gData.controllerData.steeringRange[player] + 0x80) * 0x100) | 1;
'''.replace('\n', NL))


def twostage(s):
    assert s.count(TWOSTAGE_OLD) == 1, ('2stage', s.count(TWOSTAGE_OLD))
    return s.replace(TWOSTAGE_OLD, TWOSTAGE_NEW)


PATCHES = [
    ("q0_none", lambda s: _drop(BASE(s), ())),
    ("q1_f8", lambda s: _drop(BASE(s), (8,))),
    ("q2_f9", lambda s: _drop(BASE(s), (9,))),
    ("q3_none_twostage", lambda s: twostage(_drop(BASE(s), ()))),
    ("q4_f89_twostage", lambda s: twostage(_drop(BASE(s), (8, 9)))),
]
