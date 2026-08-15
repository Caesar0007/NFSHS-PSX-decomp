#!/usr/bin/env python3
"""CD_cw round 2: reproduce retail's `la tbl; addiu cnt,tbl,256; addu idx; lw 0()`
   -- the +256 must be its OWN addiu on a base REGISTER, and the index add must
   come AFTER it (ours folds +256 into the load displacement instead)."""
import json
import os

HERE = os.path.dirname(os.path.abspath(__file__))
DECL = "    int i;\n    int ret;\n"
FLAG_CAST = "    if (*(int *)((com << 2) + (int)_cd_result_flag))\n"
CNT_GUARD = "    if (_cd_result_flag[0x40 + com] > 0)\n"
CNT_WHILE = "        } while (i < _cd_result_flag[0x40 + com]);\n"
FENCE = "    __asm__(\"\" : \"=r\"(tbl) : \"0\"(tbl));\n"

V = {}


def mk(name, decl_extra, pre_flag, guard, whl):
    V[name] = [[DECL, DECL + decl_extra],
               [FLAG_CAST, pre_flag + FLAG_CAST],
               [CNT_GUARD, guard],
               [CNT_WHILE, whl]]


# 8  tbl (fenced) + cnt = tbl + 0x40 as its own statement, cnt[com]
mk("split-cnt-fenced", "    int *tbl;\n    int *cnt;\n",
   "    tbl = _cd_result_flag;\n" + FENCE,
   "    cnt = tbl + 0x40;\n    i = 0;\n    if (cnt[com] > 0)\n",
   "        } while (i < cnt[com]);\n")
# 9  same, unfenced (the mandatory unlaundered control -- 13B identity-launder law)
mk("split-cnt-plain", "    int *tbl;\n    int *cnt;\n",
   "    tbl = _cd_result_flag;\n",
   "    cnt = tbl + 0x40;\n    i = 0;\n    if (cnt[com] > 0)\n",
   "        } while (i < cnt[com]);\n")
# 10 fenced tbl, cnt = &tbl[0x40]
mk("split-amp-fenced", "    int *tbl;\n    int *cnt;\n",
   "    tbl = _cd_result_flag;\n" + FENCE,
   "    cnt = &tbl[0x40];\n    i = 0;\n    if (cnt[com] > 0)\n",
   "        } while (i < cnt[com]);\n")
# 11 fenced tbl, cnt fenced too (both laundered)
mk("split-cnt-2fence", "    int *tbl;\n    int *cnt;\n",
   "    tbl = _cd_result_flag;\n" + FENCE,
   "    cnt = tbl + 0x40;\n    __asm__(\"\" : \"=r\"(cnt) : \"0\"(cnt));\n    i = 0;\n    if (cnt[com] > 0)\n",
   "        } while (i < cnt[com]);\n")
# 12 fenced tbl assigned AFTER the flag test (statement position dial)
V["split-cnt-after"] = [
    [DECL, DECL + "    int *tbl;\n    int *cnt;\n"],
    [CNT_GUARD,
     "    tbl = _cd_result_flag;\n" + FENCE + "    cnt = tbl + 0x40;\n    if (cnt[com] > 0)\n"],
    [CNT_WHILE, "        } while (i < cnt[com]);\n"],
]
# 13 fenced tbl before the flag test, and the FLAG also read through tbl
mk("split-both-fenced", "    int *tbl;\n    int *cnt;\n",
   "    tbl = _cd_result_flag;\n" + FENCE,
   "    cnt = tbl + 0x40;\n    i = 0;\n    if (cnt[com] > 0)\n",
   "        } while (i < cnt[com]);\n")
V["split-both-fenced"][1] = [FLAG_CAST,
                             "    tbl = _cd_result_flag;\n" + FENCE + "    if (tbl[com])\n"]

for name, subs in V.items():
    json.dump({"name": name, "subs": subs},
              open(os.path.join(HERE, "spec_%s.json" % name), "w", encoding="utf-8"))
print(" ".join(sorted(V)))
