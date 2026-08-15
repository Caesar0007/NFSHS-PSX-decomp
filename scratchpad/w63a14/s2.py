NL = chr(13) + chr(10)
ENV = {}

B = ("  puVar4 = (carObj->render).sort_carObj;" + NL +
     "  (carObj->render).world_otz = sd->sub_otz;" + NL)
B2 = ("  (carObj->render).world_otz = sd->sub_otz;" + NL +
      "  puVar4 = (carObj->render).sort_carObj;" + NL)

NB = ("      if (quadB < (int)(envExtra & 0xff)) {" + NL +
      "        uVar5 = (int)(envExtra << 0x10) >> 0x18;" + NL +
      "      }" + NL +
      "      nabr_blend = 2;" + NL)
NB2 = ("      nabr_blend = 2;" + NL +
       "      if (quadB < (int)(envExtra & 0xff)) {" + NL +
       "        uVar5 = (int)(envExtra << 0x10) >> 0x18;" + NL +
       "      }" + NL)

D = "    iVar3 = (int)((uVar5 - 1) * 0x10000) >> 0x10;" + NL
D2 = ("    uVar5 = uVar5 - 1;" + NL +
      "    iVar3 = (int)(uVar5 * 0x10000) >> 0x10;" + NL)


def rep(pairs):
    def f(s):
        for o, n in pairs:
            assert s.count(o) == 1, ('anchor', s.count(o), o[:50])
            s = s.replace(o, n)
        return s
    return f


PATCHES = [
    ("t0_swap_only", rep([(B, B2)])),
    ("t1_swap+nabr", rep([(B, B2), (NB, NB2)])),
    ("t2_swap+dec", rep([(B, B2), (D, D2)])),
    ("t3_all", rep([(B, B2), (NB, NB2), (D, D2)])),
    ("t4_dec_only", rep([(D, D2)])),
]
