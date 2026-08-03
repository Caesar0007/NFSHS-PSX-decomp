import os

HP = "        hp = hoff + i;"
G = [("        if (InGame_GetDevice(h[0x%x - *hp]) == 1) {" % k) for k in (0x4f, 0x51, 0x52)]
SH = [("        if (InGame_GetDevice(h[((0x%x - *hp) << 16) >> 16]) == 1) {" % k)
      for k in (0x4f, 0x51, 0x52)]
CAR = "*(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288)"
CARSH = "*(int *)((char *)Cars_gHumanRaceCarList[((i << 16) >> 16)] + 0x288)"


def sh(s, n):
    for a, b in list(zip(G, SH))[:n]:
        assert s.count(a) == 1, a
        s = s.replace(a, b)
    return s


V = {
 'y1': lambda s: sh(s.replace(HP, "        hp = hoff + ((i << 16) >> 16);"), 1),
 'y2': lambda s: sh(s.replace(HP, "        hp = hoff + ((i << 16) >> 16);"), 2),
 'y3': lambda s: sh(s.replace(HP, "        hp = hoff + ((i << 16) >> 16);"), 3),
 'y4': lambda s: sh(s.replace(HP, "        hp = hoff + ((i << 16) >> 16);"), 3)
                  .replace(CAR, CARSH),
}


def apply(src):
    assert src.count(HP) == 1
    return V[os.environ['V']](src)
