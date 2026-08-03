import os

FENCE = '  __asm__ volatile("" : : "r"(i));'
I0 = "  i = 0;\r\n"
FOG = "  spec->fogstate = 0;\r\n"
WEA = "  weather = (short)GameSetup_gData.Weather;\r\n"
DEPTH = "  spec->depthcuestate = 1;\r\n"
MIRROR = "  (spec->horizonspec).mirror = 1;\r\n"

V = {
 # fence BEFORE fogstate (untried position)
 'w1': lambda s: s.replace(FENCE + '\r\n', '').replace(I0, I0 + FENCE + '\r\n'),
 # fence before the weather read
 'w2': lambda s: s.replace(FENCE + '\r\n', '').replace(WEA, FENCE + '\r\n' + WEA),
 # keep fence, ALSO fence before fogstate
 'w3': lambda s: s.replace(I0, I0 + FENCE + '\r\n'),
 # keep fence + move mirror up before fogstate (spread the 1 into region 1)
 'w4': lambda s: s.replace(MIRROR, '').replace(FOG, MIRROR + FOG),
 # keep fence + move depthcuestate up before fogstate
 'w5': lambda s: s.replace(DEPTH, '').replace(FOG, DEPTH + FOG),
 # keep fence + move mirror up between fogstate and weather
 'w6': lambda s: s.replace(MIRROR, '').replace(WEA, MIRROR + WEA),
}


def apply(src):
    assert src.count(FENCE) == 1
    return V[os.environ['V']](src)
