CR = chr(13) + chr(10)
HP_ASG = "        hp = hoff + i;" + CR
T2 = "        hp = hoff;" + CR + "        hp = hp + i;" + CR


def base(s):
    assert s.count(HP_ASG) == 1
    return s.replace(HP_ASG, T2, 1)


def with_(extra):
    def go(s):
        return s.replace(HP_ASG, extra, 1)
    return go


def gotoloop(s):
    s = base(s)
    old = ("    if (i < Cars_gNumHumanRaceCars) {" + CR + "      do {" + CR)
    assert s.count(old) == 1, s.count(old)
    s = s.replace(old, "    if (i < Cars_gNumHumanRaceCars) {" + CR + "      ramp_top:" + CR + "      {" + CR, 1)
    old2 = ("        i = i + 1;" + CR + "      } while (i < Cars_gNumHumanRaceCars);" + CR)
    assert s.count(old2) == 1
    s = s.replace(old2, "        i = i + 1;" + CR + "      }" + CR
                  + "      if (i < Cars_gNumHumanRaceCars) goto ramp_top;" + CR, 1)
    return s


E_FENCE = ("        hp = hoff;" + CR
           + '        __asm__("" : "=r"(hp) : "0"(hp));' + CR
           + "        hp = hp + i;" + CR)
E_3SET = ("        hp = hoff;" + CR
          + "        hp = hp + i;" + CR
          + "        hp = hp + 0;" + CR)
E_CASTSPLIT = ("        hp = (int *)((char *)hoff + 0);" + CR
               + "        hp = hp + i;" + CR)

PATCHES = [
    ('T_2set_ctl', base),
    ('T_2set_fence', with_(E_FENCE)),
    ('T_3set', with_(E_3SET)),
    ('T_castsplit', with_(E_CASTSPLIT)),
    ('T_gotoloop', gotoloop),
]
