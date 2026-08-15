import json, os
CR = "\r\n"
OLD = ('  if (carObj->carFlags & 0x20) {' + CR
       + '    *(volatile int *)&GameSetup_gData.raceType;' + CR
       + '  }' + CR)


def blk(*stmts):
    return ('  if (carObj->carFlags & 0x20) {' + CR
            + CR.join('    ' + s for s in stmts) + CR
            + '  }' + CR)


DEAD = '*(volatile int *)&GameSetup_gData.raceType;'
MF = '__asm__("" : : "m"(GameSetup_gData.raceType));'
MF2 = '__asm__("" : : "m"(*(volatile int *)&GameSetup_gData.raceType));'
MFR = '__asm__("" : : "m"(GameSetup_gData.raceType), "r"(0));'

V = [
    {"name": "q1_m_after_dead", "subs": [[OLD, blk(DEAD, MF)]]},
    {"name": "q2_m_before_dead", "subs": [[OLD, blk(MF, DEAD)]]},
    {"name": "q3_m_volatile_after", "subs": [[OLD, blk(DEAD, MF2)]]},
    {"name": "q4_m_only", "subs": [[OLD, blk(MF)]]},
    {"name": "q5_m_twice", "subs": [[OLD, blk(DEAD, MF, MF)]]},
    {"name": "q6_named_then_m",
     "subs": [[OLD, blk('int rt = *(volatile int *)&GameSetup_gData.raceType;', MF,
                        '__asm__("" : : "r"(rt));')]]},
]
p = os.path.join(os.path.dirname(__file__), "cdd_v2.json")
json.dump(V, open(p, "w", encoding="utf-8"))
print(p)
