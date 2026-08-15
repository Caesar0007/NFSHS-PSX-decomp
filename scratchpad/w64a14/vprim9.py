CR = chr(13) + chr(10)
OLD = "      overlayRaw = (int)((u_int)DrawC_gOverlay[*(u_char *)(facet + 2)] << 0x10);"
NEWU = "      overlayRaw = (int)((u_int)(u_short)DrawC_gOverlay[*(u_char *)(facet + 2)] << 0x10);"


def at(idxs, new=NEWU):
    def go(s):
        assert s.count(OLD) == 4, s.count(OLD)
        out = []
        i = 0
        k = 0
        while True:
            j = s.find(OLD, i)
            if j < 0:
                out.append(s[i:]); break
            out.append(s[i:j])
            out.append(new if k in idxs else OLD)
            k += 1
            i = j + len(OLD)
        return ''.join(out)
    return go


PATCHES = [
    ('Z2_prim_both', at({0, 1})),
    ('Z2_prim_0', at({0})),
    ('Z2_prim_1', at({1})),
    ('Z2_all4', at({0, 1, 2, 3})),
]
