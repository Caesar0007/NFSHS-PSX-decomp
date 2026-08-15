NL = chr(13) + chr(10)
ENV = {}

FENCE = '  __asm__("" : : "r"(carPixMapCount));' + NL


def F(v, n=1):
    return ('  __asm__("" : : "r"(%s));' % v + NL) * n


def add(v, n=1, before=False):
    def f(s):
        assert s.count(FENCE) == 1
        return s.replace(FENCE, (F(v, n) + FENCE) if before else (FENCE + F(v, n)))
    return f


def only(v, n=1):
    def f(s):
        assert s.count(FENCE) == 1
        return s.replace(FENCE, F(v, n))
    return f


PATCHES = [
    ("ctl", lambda s: s),
    ("plus_vx", add("vx")),
    ("plus_vy", add("vy")),
    ("plus_player", add("player")),
    ("plus_shpfile", add("shpfile")),
    ("pre_vx", add("vx", 1, True)),
    ("plus_vx_x3", add("vx", 3)),
    ("only_vx", only("vx")),
]
