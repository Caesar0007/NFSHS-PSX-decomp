import os

HP = "        hp = hoff + i;"
G = ["        if (InGame_GetDevice(h[0x4f - *hp]) == 1) {",
     "        if (InGame_GetDevice(h[0x51 - *hp]) == 1) {",
     "        if (InGame_GetDevice(h[0x52 - *hp]) == 1) {"]
GN = ["        if (InGame_GetDevice(h[0x4f + -*hp]) == 1) {",
      "        if (InGame_GetDevice(h[0x51 + -*hp]) == 1) {",
      "        if (InGame_GetDevice(h[0x52 + -*hp]) == 1) {"]
RAMP = ("        *(int *)(ctrl + 0x1c) = 1;\r\n"
        "        *(int *)(ctrl + 0x20) = 1;\r\n"
        "        *(int *)(ctrl + 0x18) = 1;")
CTRL = "        ctrl = *(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288);"


def negu(s):
    for a, b in zip(G, GN):
        assert s.count(a) == 1, a
        s = s.replace(a, b)
    return s


V = {
 'z0': lambda s: s,
 'z1': lambda s: s.replace(HP, "        hp = hoff + ((i << 16) >> 16);"),
 'z2': negu,
 'z3': lambda s: s.replace(RAMP,
        "        { int one = 1;\r\n"
        "        *(int *)(ctrl + 0x1c) = one;\r\n"
        "        *(int *)(ctrl + 0x20) = one;\r\n"
        "        *(int *)(ctrl + 0x18) = one; }"),
 'z4': lambda s: negu(s.replace(HP, "        hp = hoff + ((i << 16) >> 16);")),
 'z5': lambda s: s.replace(CTRL,
        "        ctrl = (int)((char *)*(int **)((char *)Cars_gHumanRaceCarList[i] + 0x288) + 0);"),
 'z6': lambda s: negu(negu(s) if False else s).replace(RAMP,
        "        *(int *)((char *)ctrl + 0x1c) = 1;\r\n"
        "        *(int *)((char *)ctrl + 0x20) = 1;\r\n"
        "        *(int *)((char *)ctrl + 0x18) = 1;"),
 'z7': lambda s: negu(s).replace(HP, "        hp = hoff + ((i << 16) >> 16);").replace(RAMP,
        "        { int one = 1;\r\n"
        "        *(int *)(ctrl + 0x1c) = one;\r\n"
        "        *(int *)(ctrl + 0x20) = one;\r\n"
        "        *(int *)(ctrl + 0x18) = one; }"),
}


def apply(src):
    assert src.count(HP) == 1 and src.count(RAMP) == 1
    return V[os.environ['V']](src)
