CR = chr(13) + chr(10)

HP_ASG = "        hp = hoff + i;" + CR
FIRSTUSE = "        if (InGame_GetDevice(h[0x4f - *hp]) == 1) {"


def variant(text, late):
    def go(s):
        assert s.count(HP_ASG) == 1 and s.count(FIRSTUSE) == 1
        out = s.replace(HP_ASG, "", 1)
        if late:
            out = out.replace(FIRSTUSE, text + FIRSTUSE, 1)
        else:
            out = s.replace(HP_ASG, text, 1)
        return out
    return go


T1 = "        hp = hoff; hp = hp + i;" + CR
T2 = "        hp = hoff;" + CR + "        hp = hp + i;" + CR
T3 = "        hp = hoff + i;" + CR
T4 = "        hp = &hoff[i];" + CR

PATCHES = [
    ('S_2set_late', variant(T2, True)),
    ('S_2set_late_1line', variant(T1, True)),
    ('S_1set_late', variant(T3, True)),
    ('S_amp_late', variant(T4, True)),
]
