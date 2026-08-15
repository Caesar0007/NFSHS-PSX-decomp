CR = chr(13) + chr(10)
FIRSTUSE = "        if (InGame_GetDevice(h[0x4f - *hp]) == 1) {"
CUR = ("        hp = hoff;" + CR
       + '        __asm__("" : "=r"(hp) : "0"(hp));' + CR
       + "        hp = hp + i;" + CR)
STORES = "        *(int *)(ctrl + 0x18) = 1;" + CR


def swapop(s):
    return s.replace(CUR, "        hp = hoff;" + CR
                     + '        __asm__("" : "=r"(hp) : "0"(hp));' + CR
                     + "        hp = i + hp;" + CR, 1)


def vfence(s):
    assert s.count(STORES) == 1
    return s.replace(STORES, STORES + '        __asm__("" : : "i"(0));' + CR, 1)


def sized(s):
    # sized view of hoff -> self-temp %hi is the CURRENT shape; try the two-step base
    return s.replace(CUR, "        { int *hb = hoff;" + CR
                     + '          __asm__("" : "=r"(hb) : "0"(hb));' + CR
                     + "          hp = hb + i; }" + CR, 1)


PATCHES = [
    ('V_vfence', vfence),
    ('V_swapop', swapop),
    ('V_vfence_swapop', lambda s: vfence(swapop(s))),
    ('V_blockbase', sized),
]
