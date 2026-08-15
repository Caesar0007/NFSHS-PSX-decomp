#!/usr/bin/env python3
"""Generate CD_cw probe specs for the count-table base-sharing angle."""
import json
import os

HERE = os.path.dirname(os.path.abspath(__file__))

DECL = "    int i;\n    int ret;\n"
DECL_TBL = "    int i;\n    int ret;\n    int *tbl;\n"

FLAG_CAST = "    if (*(int *)((com << 2) + (int)_cd_result_flag))\n"
CNT_GUARD = "    if (_cd_result_flag[0x40 + com] > 0)\n"
CNT_WHILE = "        } while (i < _cd_result_flag[0x40 + com]);\n"

V = {}

# 1  tbl base used for the COUNT only, assigned right before the flag test
V["cnt-tbl-early"] = [
    [DECL, DECL_TBL],
    [FLAG_CAST, "    tbl = _cd_result_flag;\n" + FLAG_CAST],
    [CNT_GUARD, "    if (tbl[0x40 + com] > 0)\n"],
    [CNT_WHILE, "        } while (i < tbl[0x40 + com]);\n"],
]
# 2  same, but tbl assigned AFTER the flag test (just before CDREG0 = 0)
V["cnt-tbl-late"] = [
    [DECL, DECL_TBL],
    ["    CDREG0 = 0;\n", "    tbl = _cd_result_flag;\n    CDREG0 = 0;\n"],
    [CNT_GUARD, "    if (tbl[0x40 + com] > 0)\n"],
    [CNT_WHILE, "        } while (i < tbl[0x40 + com]);\n"],
]
# 3  tbl for BOTH accesses (flag becomes a plain subscript off tbl)
V["both-tbl"] = [
    [DECL, DECL_TBL],
    [FLAG_CAST, "    tbl = _cd_result_flag;\n    if (tbl[com])\n"],
    [CNT_GUARD, "    if (tbl[0x40 + com] > 0)\n"],
    [CNT_WHILE, "        } while (i < tbl[0x40 + com]);\n"],
]
# 4  SOTN operand order `com + 0x40` at both count sites (no tbl)
V["sotn-order"] = [
    [CNT_GUARD, "    if (_cd_result_flag[com + 0x40] > 0)\n"],
    [CNT_WHILE, "        } while (i < _cd_result_flag[com + 0x40]);\n"],
]
# 5  count via an index-first cast on the base + 0x100 bytes
V["cnt-cast"] = [
    [CNT_GUARD, "    if (*(int *)((com << 2) + (int)_cd_result_flag + 256) > 0)\n"],
    [CNT_WHILE, "        } while (i < *(int *)((com << 2) + (int)_cd_result_flag + 256));\n"],
]
# 6  tbl base + count via pointer arithmetic on tbl (tbl + 0x40)
V["cnt-ptr64"] = [
    [DECL, DECL_TBL],
    [FLAG_CAST, "    tbl = _cd_result_flag + 0x40;\n" + FLAG_CAST],
    [CNT_GUARD, "    if (tbl[com] > 0)\n"],
    [CNT_WHILE, "        } while (i < tbl[com]);\n"],
]
# 7  fenced tbl base (identity launder) for the count, assigned before the flag test
V["cnt-tbl-fenced"] = [
    [DECL, DECL_TBL],
    [FLAG_CAST,
     "    tbl = _cd_result_flag;\n    __asm__(\"\" : \"=r\"(tbl) : \"0\"(tbl));\n" + FLAG_CAST],
    [CNT_GUARD, "    if (tbl[0x40 + com] > 0)\n"],
    [CNT_WHILE, "        } while (i < tbl[0x40 + com]);\n"],
]

for name, subs in V.items():
    json.dump({"name": name, "subs": subs},
              open(os.path.join(HERE, "spec_%s.json" % name), "w", encoding="utf-8"))
print(" ".join(sorted(V)))
