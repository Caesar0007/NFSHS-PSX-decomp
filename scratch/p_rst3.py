import os

MULT = "  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * 0x96;"
POSX = "  HUD_STATS_POS_X = 0xa0 - Cars_gNumHumanRaceCars * 0x4b;"
COL2A = "  col2 = 0xa0;"
TITLEX = "  titleX = 0xa0 - (textpixels(TextSys_Word(0x39)) >> 1);"
DECL = "  int titleY;\r\n\r\n  HUD_STATS_SIZE_H = (GameSetup_gData.numLaps + 1) * 0xc + 0x28;"
SZH1 = "  HUD_STATS_SIZE_H = (GameSetup_gData.numLaps + 1) * 0xc + 0x28;"
SZH2 = "    HUD_STATS_SIZE_H = (GameSetup_gData.numLaps + 1) * 0xc + 0x1c;"


def decls(names, head):
    return ("  int titleY;\r\n" + "".join("  int %s;\r\n" % n for n in names) +
            "\r\n" + head)


def fence(assigns, ops):
    return ("  {\r\n  " + assigns + "\r\n"
            "  __asm__ volatile(\"\" : : " + ", ".join('"r"(%s)' % o for o in ops) + ");\r\n"
            "  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * pitch;\r\n  }")


def apply(src):
    v = os.environ['V']
    assert src.count(MULT) == 1 and src.count(DECL) == 1
    s = src
    names = ['pitch', 'cx', 'one']
    head = SZH1
    if v in ('t1', 't2', 't3'):
        names = ['pitch', 'cx', 'one', 'rows']
        head = "  rows = (GameSetup_gData.numLaps + 1) * 0xc;\r\n  HUD_STATS_SIZE_H = rows + 0x28;"
    s = s.replace(DECL, decls(names, head))
    s = s.replace(MULT, fence("pitch = 0x96; cx = 0xa0; one = 1;", ['pitch', 'cx', 'one']))
    if v in ('t1', 't2', 't3'):
        assert s.count(SZH2) == 1
        s = s.replace(SZH2, "    HUD_STATS_SIZE_H = rows + 0x1c;")
    if v in ('t0', 't1', 't3'):
        s = s.replace(POSX, "  HUD_STATS_POS_X = cx - Cars_gNumHumanRaceCars * 0x4b;")
        s = s.replace(COL2A, "  col2 = cx;")
        s = s.replace(TITLEX, "  titleX = cx - (textpixels(TextSys_Word(0x39)) >> 1);")
    if v == 't2':                     # cx routed only to POS_X and col2, not titleX
        s = s.replace(POSX, "  HUD_STATS_POS_X = cx - Cars_gNumHumanRaceCars * 0x4b;")
        s = s.replace(COL2A, "  col2 = cx;")
    if v == 't3':
        for a, b in [("(int)HUD_STATS_SIZE_W,1,0,'\\0','\\0');",
                      "(int)HUD_STATS_SIZE_W,one,0,'\\0','\\0');"),
                     ("0xb,1,barH - ", "0xb,one,barH - "),
                     ("col1 + -2,posyL,1,barH8,", "col1 + -2,posyL,one,barH8,")]:
            s = s.replace(a, b)
    return s
