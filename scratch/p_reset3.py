import os

ST = "  GameSetup_gData.controllerData.controllerConfig[player] = config;\r\n"
IFB = ("  if (frontEnd.controlType[player] != (u_short)gPadinfo.buf[player * 4].ID) {\r\n"
       "    frontEnd.controlType[player] = (u_short)gPadinfo.buf[player * 4].ID;\r\n"
       "  }\r\n")


def F(*ops):
    return '  __asm__ volatile("" : : %s);\r\n' % ", ".join('"r"(%s)' % o for o in ops)


OPS = {
 'z1': ("&hoff[player]",),
 'z2': ("h", "&hoff[player]"),
 'z3': ("hoff[player]",),
 'z4': ("&hoff[player]", "config"),
 'z5': ("&hoff[player]", "type"),
 'z6': ("&h[-hoff[player]]",),
 'z7': ("h - hoff[player]",),
 'z8': ("&mappings[config][0][type]",),
 'z9': ("&hoff[player]", "player"),
}


def apply(src):
    assert src.count(ST) == 1 and src.count(IFB) == 1
    return src.replace(ST, '').replace(IFB, F(*OPS[os.environ['V']]) + IFB + ST)
