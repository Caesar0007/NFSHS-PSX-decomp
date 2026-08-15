import re
NL = chr(13) + chr(10)
ENV = {}

# ---- flatten the six tagged 0x53/0x73 arms: `(HI * 0x10000 | TAG) |` -> `TAG |\n HI * 0x10000 |`
RX6 = re.compile(
    r"                   \((?P<hi>\([^\r\n]*?\)) \* 0x10000 \| (?P<tag>0x[0-9a-f]+)\) \|\r\n")
SUB6 = "                   \\g<tag> |\r\n                   \\g<hi> * 0x10000 |\r\n"

# ---- flatten the two tagged 0x23 arms: `(X * 0x100 | TAG) ;` -> `TAG |\n X * 0x100 ;`
RX2 = re.compile(
    r"                   \((?P<v>GameSetup_gData\.controllerData\.I{1,2}maxRange\[player\]) \* 0x100 \| (?P<tag>0x[0-9a-f]+)\) ;\r\n")
SUB2 = "                   \\g<tag> |\r\n                   \\g<v> * 0x100 ;\r\n"

FENCE = '      __asm__ volatile("" : : "r"(newControl));' + NL


def apply6(s):
    s2, n = RX6.subn(SUB6, s)
    assert n == 6, ('RX6', n)
    return s2


def apply2(s):
    s2, n = RX2.subn(SUB2, s)
    assert n == 2, ('RX2', n)
    return s2


def nofence(s):
    assert s.count(FENCE) == 2
    return s.replace(FENCE, '')


PATCHES = [
    ("ctl", lambda s: s),
    ("p1_flat6", apply6),
    ("p2_flat6+2", lambda s: apply2(apply6(s))),
    ("p3_flat6+2_nofence", lambda s: nofence(apply2(apply6(s)))),
    ("p4_flat6_nofence", lambda s: nofence(apply6(s))),
    ("p5_flat2only", apply2),
]
