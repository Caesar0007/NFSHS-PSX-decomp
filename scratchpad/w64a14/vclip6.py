import re
CR = chr(13) + chr(10)

BLK = re.compile(r'( *)id2 = id2 \* 8; id2 = id2 \+ \(int\)sd;\r\n'
                 r' *id0 = id0 \* 8; id0 = id0 \+ \(int\)sd;\r\n'
                 r' *id1 = id1 \* 8; id1 = id1 \+ \(int\)sd;\r\n')

# id2 boosted at depth D, id1 boosted at depth E (0 = plain), id0 plain
def mk(d2, d1):
    def wrap(stmt, d, ind):
        for _ in range(d):
            stmt = "do { " + stmt + " } while (0);"
        return ind + stmt + CR
    def tmpl(ind):
        out = wrap("id2 = id2 * 8;", d2, ind) + wrap("id2 = id2 + (int)sd;", d2, ind)
        out += ind + "id0 = id0 * 8; id0 = id0 + (int)sd;" + CR
        if d1:
            out += ind + "id1 = id1 * 8;" + CR + wrap("id1 = id1 + (int)sd;", d1, ind)
        else:
            out += ind + "id1 = id1 * 8; id1 = id1 + (int)sd;" + CR
        return out
    return tmpl


def at(idxs, tmplf):
    def go(s):
        n = [0]
        def r(m):
            n[0] += 1
            if n[0] - 1 not in idxs:
                return m.group(0)
            return m.group(1) + tmplf(m.group(1))[len(m.group(1)):]
        out, k = BLK.subn(r, s); assert k == 2, k
        return out
    return go


PATCHES = [
    ('L_s1_d2', at({0}, mk(2, 1))),
    ('L_s1_d2only', at({0}, mk(2, 0))),
    ('L_s1_d1only', at({0}, mk(1, 0))),
    ('L_s3_d2', at({1}, mk(2, 1))),
    ('L_s3_d2only', at({1}, mk(2, 0))),
    ('L_s3_d1only', at({1}, mk(1, 0))),
]
