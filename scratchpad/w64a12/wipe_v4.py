import json, os
CR = "\r\n"
NV = '      new_var = AI_elapsedTime * 29;' + CR
FORHEAD = '        for (hLoop = 0; hLoop < playFines; hLoop = hLoop + 1) {   /* 0x80063450 */' + CR
CAR = '          Car_tObj    *carObj_h     = Cars_gHumanRaceCarList[hLoop];           /* 0x8006345C */' + CR

BODY_OLD = ('              perTickProb = new_var * 4;' + CR
            + '              if (randVal < perTickProb)           /* 0x800634B8 */' + CR
            + '                this->carObj_->wipeOutEndTick = simGlobal.gameTicks + 0xC0;    /* 0x800634C4-D0 */' + CR
            + '            } else if (2 <= oppFines_v1 - oppFines) {                          /* 0x800634A8-B0 (skip if <2) */' + CR
            + '              perTickProb = new_var * 4;' + CR
            + '              if (randVal < perTickProb)          /* $t2<<2, 0x800634B4-BC */' + CR
            + '                this->carObj_->wipeOutEndTick = simGlobal.gameTicks + 0xC0;    /* 0x800634C4-D0 */' + CR
            + '            }' + CR)


def body(expr):
    return BODY_OLD.replace('new_var * 4', expr)


DECL = ('  int perTickProb;' + CR
        + '  int new_var;    /* w59-a17: the 116 multiplier as a pre-loop local -- 68->51 (placement load-bearing: top-of-fn init = 77) */' + CR
        + '  int randVal;' + CR)

V = [
    # inv declared block-local at the top of the loop body, LICM hoists it
    {"name": "z1_inv_loopbody_decl",
     "subs": [[NV, ""],
              [FORHEAD + CAR, FORHEAD + '          int          inv          = AI_elapsedTime * 29;' + CR + CAR],
              [BODY_OLD, body('inv * 4')]]},
    # same but assigned into the existing fn-scope new_var inside the loop
    {"name": "z2_newvar_assigned_inloop",
     "subs": [[NV, ""],
              [FORHEAD + CAR, FORHEAD + '          new_var = AI_elapsedTime * 29;' + CR + CAR],
              [BODY_OLD, body('new_var * 4')]]},
    # z1 + drop the now-unused fn-scope new_var declaration (pseudo renumber)
    {"name": "z3_inv_loopbody_nodecl",
     "subs": [[NV, ""],
              [DECL, '  int perTickProb;' + CR + '  int randVal;' + CR],
              [FORHEAD + CAR, FORHEAD + '          int          inv          = AI_elapsedTime * 29;' + CR + CAR],
              [BODY_OLD, body('inv * 4')]]},
    # x1 (anonymous 116) but with new_var declaration dropped
    {"name": "z4_116_nodecl",
     "subs": [[NV, ""],
              [DECL, '  int perTickProb;' + CR + '  int randVal;' + CR],
              [BODY_OLD, body('AI_elapsedTime * 116')]]},
]
p = os.path.join(os.path.dirname(__file__), "wipe_v4.json")
json.dump(V, open(p, "w", encoding="utf-8"))
print(p)
