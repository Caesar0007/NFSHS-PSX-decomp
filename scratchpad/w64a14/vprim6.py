import re

FUSED = re.compile(r'( *)id0 = id0 \* 8 \+ \(int\)sd;\r\n( *)id1 = id1 \* 8 \+ \(int\)sd;\r\n'
                   r'( *)id2 = id2 \* 8 \+ \(int\)sd;\r\n')

# PrimMenu recipe: split morph + do{}while(0) ref-step dial reversing the id order
PM = ("id0 = id0 * 8;\r\n"
      "%sid0 = id0 + (int)sd;\r\n"
      "%sid1 = id1 * 8;\r\n"
      "%sdo { id1 = id1 + (int)sd; } while (0);\r\n"
      "%sdo { id2 = id2 * 8; } while (0);\r\n"
      "%sdo { id2 = id2 + (int)sd; } while (0);\r\n")

SPLIT = ("id0 = id0 * 8; id0 = id0 + (int)sd;\r\n"
         "%sid1 = id1 * 8; id1 = id1 + (int)sd;\r\n"
         "%sid2 = id2 * 8; id2 = id2 + (int)sd;\r\n")


def at(idxs, tmpl, nrep):
    def go(s):
        n = [0]
        def r(m):
            n[0] += 1
            ind = m.group(1)
            if n[0] - 1 not in idxs:
                return m.group(0)
            return ind + (tmpl % ((ind,) * nrep))
        out, k = FUSED.subn(r, s)
        assert k == 4, k
        return out
    return go


PATCHES = [
    ('E_pm_s0', at({0}, PM, 5)),
    ('E_pm_s1', at({1}, PM, 5)),
    ('E_pm_s3', at({2}, PM, 5)),     # 3rd remaining fused site == old index 3
    ('E_pm_s4', at({3}, PM, 5)),
    ('E_pm_all', at({0, 1, 2, 3}, PM, 5)),
]
