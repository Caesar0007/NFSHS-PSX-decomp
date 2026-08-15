NL = chr(13) + chr(10)
ENV = {}

A = ("  shapeIdx = sd->sub_otz;" + NL +
     "  sub_otz_h2 = shapeIdx >> 1;" + NL +
     "  if (R3DCar_InMenu == 0) {" + NL)

B = ("  puVar4 = (carObj->render).sort_carObj;" + NL +
     "  (carObj->render).world_otz = sd->sub_otz;" + NL)
B2 = ("  (carObj->render).world_otz = sd->sub_otz;" + NL +
      "  puVar4 = (carObj->render).sort_carObj;" + NL)


def rep(pairs):
    def f(s):
        for o, n in pairs:
            assert s.count(o) == 1, ('anchor', s.count(o), o[:50])
            s = s.replace(o, n)
        return s
    return f


A_TMP = ("  {" + NL + "  int inMenu = R3DCar_InMenu;" + NL +
         "  shapeIdx = sd->sub_otz;" + NL +
         "  sub_otz_h2 = shapeIdx >> 1;" + NL +
         "  if (inMenu == 0) {" + NL)
A_TMP_END_OLD = ("  else {" + NL + "    sd->sub_otz = 0;" + NL + "  }" + NL)
A_TMP_END_NEW = ("  else {" + NL + "    sd->sub_otz = 0;" + NL + "  }" + NL + "  }" + NL)

PATCHES = [
    ("ctl", rep([(A, A)])),
    ("s1_swap_worldotz", rep([(B, B2)])),
    ("s2_inmenu_temp", rep([(A, A_TMP), (A_TMP_END_OLD, A_TMP_END_NEW)])),
    ("s3_both", rep([(B, B2), (A, A_TMP), (A_TMP_END_OLD, A_TMP_END_NEW)])),
]
