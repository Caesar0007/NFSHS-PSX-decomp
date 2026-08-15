import json, os
CR = "\r\n"
OLD = ('  if (carObj->carFlags & 0x20) {' + CR
       + '    *(volatile int *)&GameSetup_gData.raceType;' + CR
       + '  }' + CR)


def blk(*stmts):
    return ('  if (carObj->carFlags & 0x20) {' + CR
            + CR.join('    ' + s for s in stmts) + CR
            + '  }' + CR)


RD = 'int rt = *(volatile int *)&GameSetup_gData.raceType;'
ID = '__asm__("" : "=r"(rt) : "0"(rt));'
RO = '__asm__("" : : "r"(rt));'

V = [
    {"name": "p1_identity_fence", "subs": [[OLD, blk(RD, ID)]]},
    {"name": "p2_identity_then_readonly", "subs": [[OLD, blk(RD, ID, RO)]]},
    {"name": "p3_two_identity", "subs": [[OLD, blk(RD, ID, ID)]]},
    {"name": "p4_readonly_only", "subs": [[OLD, blk(RD, RO)]]},
    {"name": "p5_identity_outside_block",
     "subs": [[OLD, '  int rt = 0;' + CR + blk('rt = *(volatile int *)&GameSetup_gData.raceType;')
               + '  __asm__("" : "=r"(rt) : "0"(rt));' + CR]]},
]
p = os.path.join(os.path.dirname(__file__), "cdd_v1.json")
json.dump(V, open(p, "w", encoding="utf-8"))
print(p)
