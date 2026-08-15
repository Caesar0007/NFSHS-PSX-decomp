CR = chr(13) + chr(10)
HP_ASG = "        hp = hoff + i;" + CR
FIRSTUSE = "        if (InGame_GetDevice(h[0x4f - *hp]) == 1) {"
E_FENCE = ("        hp = hoff;" + CR
           + '        __asm__("" : "=r"(hp) : "0"(hp));' + CR
           + "        hp = hp + i;" + CR)
E_FENCE2 = ("        hp = hoff;" + CR
            + "        hp = hp + i;" + CR
            + '        __asm__("" : "=r"(hp) : "0"(hp));' + CR)
E_FENCE3 = ("        hp = hoff;" + CR
            + '        __asm__("" : "=r"(hp) : "0"(hp));' + CR
            + "        hp = hp + i;" + CR
            + '        __asm__("" : "=r"(hp) : "0"(hp));' + CR)


def rep(extra, late=False):
    def go(s):
        assert s.count(HP_ASG) == 1
        if late:
            return s.replace(HP_ASG, "", 1).replace(FIRSTUSE, extra + FIRSTUSE, 1)
        return s.replace(HP_ASG, extra, 1)
    return go


PATCHES = [
    ('U_fence_late', rep(E_FENCE, True)),
    ('U_fence_after', rep(E_FENCE2)),
    ('U_fence_both', rep(E_FENCE3)),
]
