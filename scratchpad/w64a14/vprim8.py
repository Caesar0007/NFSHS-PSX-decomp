CR = chr(13) + chr(10)
OLD = "      overlayRaw = (int)((u_int)DrawC_gOverlay[*(u_char *)(facet + 2)] << 0x10);"
NEWU = "      overlayRaw = (int)((u_int)(u_short)DrawC_gOverlay[*(u_char *)(facet + 2)] << 0x10);"
NEWTEX = ("      { int tex = *(u_char *)(facet + 2);" + CR
          + "      overlayRaw = (int)((u_int)(u_short)DrawC_gOverlay[tex] << 0x10); }")


def ucast(s):
    assert s.count(OLD) == 2
    return s.replace(OLD, NEWU)


def tex(s):
    assert s.count(OLD) == 2
    return s.replace(OLD, NEWTEX)


def ucast_first(s):
    i = s.index(OLD)
    return s[:i] + NEWU + s[i + len(OLD):]


def ucast_second(s):
    i = s.index(OLD)
    j = s.index(OLD, i + 1)
    return s[:j] + NEWU + s[j + len(OLD):]


PATCHES = [
    ('Z_ucast_both', ucast),
    ('Z_ucast_first', ucast_first),
    ('Z_ucast_second', ucast_second),
    ('Z_tex_both', tex),
]
