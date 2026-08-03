import os

RET = "      return newControl | 1;"
FENCE = '      __asm__ volatile("" : : "r"(newControl));\r\n'
NOPAD = ("  if (gPadinfo.buf[player * 4].nopad == '\\0') {\r\n"
         "    type = gPadinfo.buf[player * 4].ID;\r\n"
         "  }\r\n"
         "  else {\r\n"
         "    type = 0;\r\n"
         "  }")
K1 = ("  type = gPadinfo.buf[player * 4].ID;\r\n"
      "  if (gPadinfo.buf[player * 4].nopad != '\\0') {\r\n    type = 0;\r\n  }")

SETS = {
 'm0': set(), 'm1': {8}, 'm2': {9}, 'm3': {8, 9}, 'm4': {8, 9, 10},
 'm5': {8, 9, 11}, 'm6': {8, 9, 10, 11}, 'm7': {9, 10}, 'm8': {8, 10},
 'm9': {0, 8, 9}, 'ma': {1, 8, 9}, 'mb': {2, 8, 9}, 'mc': {3, 8, 9},
 'md': {4, 8, 9}, 'me': {5, 8, 9}, 'mf': {6, 8, 9}, 'mg': {7, 8, 9},
}


def apply(src):
    assert src.count(RET) == 12 and src.count(NOPAD) == 1
    idxs = SETS[os.environ['V']]
    parts = src.split(RET)
    res = parts[0]
    for k in range(1, len(parts)):
        res += (FENCE + RET if (k - 1) in idxs else RET) + parts[k]
    return res.replace(NOPAD, K1)
