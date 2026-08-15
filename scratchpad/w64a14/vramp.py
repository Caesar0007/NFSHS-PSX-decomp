CR = chr(13) + chr(10)

HP_DECL = "  int *hp;" + CR
HP_ASG = "        hp = hoff + i;" + CR


def drop_hp(s):
    assert s.count(HP_DECL) == 1 and s.count(HP_ASG) == 1
    out = s.replace(HP_DECL, "", 1).replace(HP_ASG, "", 1)
    assert out.count("*hp]") == 3
    return out.replace("*hp]", "hoff[i]]")


def drop_hp_keep_decl(s):
    out = s.replace(HP_ASG, "", 1)
    return out.replace("*hp]", "hoff[i]]")


def fence_hp(s):
    return s.replace(HP_ASG, HP_ASG + '        __asm__("" : "=r"(hp) : "0"(hp));' + CR, 1)


def hp_two_sets(s):
    return s.replace(HP_ASG, "        hp = hoff;" + CR + "        hp = hp + i;" + CR, 1)


def hp_late(s):
    """use-adjacency: move the assignment down to just before its first use"""
    key = "        if (InGame_GetDevice(h[0x4f - *hp]) == 1) {"
    assert s.count(key) == 1
    return s.replace(HP_ASG, "", 1).replace(key, HP_ASG + key, 1)


PATCHES = [
    ('R_drop_hp', drop_hp),
    ('R_drop_hp_keepdecl', drop_hp_keep_decl),
    ('R_fence_hp', fence_hp),
    ('R_hp_two_sets', hp_two_sets),
    ('R_hp_late', hp_late),
]
