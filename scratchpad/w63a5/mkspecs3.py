#!/usr/bin/env python3
"""CD_cw round 3 -- the region is now STRUCTURALLY retail-exact (count 259/259);
   the residual is a 3-way local-alloc qty rotation:
       ours   ip=$v1  tbl=$a1  maskedcom/idx=$a0
       retail ip=$a1  tbl=$v1  maskedcom/idx=$v1(reused)/$a0
   Dials: the ip identity fence (already present, +2 refs) vs a tbl fence, and
   the birth ORDER of the two pointer locals (local-alloc ties on qty number)."""
import json
import os

HERE = os.path.dirname(os.path.abspath(__file__))
IPF = "    __asm__(\"\" : \"=r\"(ip) : \"0\"(ip));\n"
DUP = "    CDREG0 = 0;\n    i = 0;\n    cnt = tbl + 0x40;\n    i = 0;\n"
CLEAN = "    CDREG0 = 0;\n    cnt = tbl + 0x40;\n    i = 0;\n"
TBL = "    tbl = _cd_result_flag;\n"
IPB = "    ip = &Intr;\n"

V = {}
V["clean"] = [[DUP, CLEAN]]
V["no-ip-fence"] = [[DUP, CLEAN], [IPF, ""]]
V["tbl-ro-fence"] = [[DUP, CLEAN], [TBL, TBL + "    __asm__(\"\" : : \"r\"(tbl));\n"]]
V["tbl-id-fence-no-ip"] = [[DUP, CLEAN], [IPF, ""],
                           [TBL, TBL + "    __asm__(\"\" : \"=r\"(tbl) : \"0\"(tbl));\n"]]
V["tbl-id-fence-keep-ip"] = [[DUP, CLEAN],
                             [TBL, TBL + "    __asm__(\"\" : \"=r\"(tbl) : \"0\"(tbl));\n"]]
V["tbl-first"] = [[DUP, CLEAN], [TBL, ""], [IPB, TBL + IPB]]
V["tbl-first-no-ipfence"] = [[DUP, CLEAN], [IPF, ""], [TBL, ""], [IPB, TBL + IPB]]
V["tbl-first-idf"] = [[DUP, CLEAN], [TBL, ""],
                      [IPB, TBL + "    __asm__(\"\" : \"=r\"(tbl) : \"0\"(tbl));\n" + IPB]]
V["ip-ro-fence"] = [[DUP, CLEAN], [IPF, "    __asm__(\"\" : : \"r\"(ip));\n"]]

for name, subs in V.items():
    json.dump({"name": name, "subs": subs},
              open(os.path.join(HERE, "spec_%s.json" % name), "w", encoding="utf-8"))
print(" ".join(sorted(V)))
