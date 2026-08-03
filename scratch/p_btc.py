import os

OLD = ("                 HUD_STATS_SIZE_H - ((startY + 0xf - HUD_STATS_POS_Y) + (postgame ? 8 : 0)) -\r\n"
       "                 (showtimeleft ? 0x10 : 0),0,'\\0','\\0');")


def mk(expr):
    return ("                 HUD_STATS_SIZE_H - ((startY + 0xf - HUD_STATS_POS_Y) + (%s)) -\r\n"
            "                 (showtimeleft ? 0x10 : 0),0,'\\0','\\0');" % expr)


V = {
 't1': mk("postgame << 3"),
 't2': mk("(int)postgame << 3"),
 't3': mk("(postgame != 0) * 8"),
 't4': mk("(postgame != 0) << 3"),
 't5': mk("postgame * 8"),
 't6': mk("-(int)postgame & 8"),
 't7': mk("((int)postgame << 3) & 8"),
}


def apply(src):
    assert src.count(OLD) == 1
    return src.replace(OLD, V[os.environ['V']])
