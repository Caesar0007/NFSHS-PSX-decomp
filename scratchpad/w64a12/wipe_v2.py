import json, os
CR = "\r\n"
BODY_OLD = ('              perTickProb = new_var * 4;' + CR
            + '              if (randVal < perTickProb)           /* 0x800634B8 */' + CR
            + '                this->carObj_->wipeOutEndTick = simGlobal.gameTicks + 0xC0;    /* 0x800634C4-D0 */' + CR
            + '            } else if (2 <= oppFines_v1 - oppFines) {                          /* 0x800634A8-B0 (skip if <2) */' + CR
            + '              perTickProb = new_var * 4;' + CR
            + '              if (randVal < perTickProb)          /* $t2<<2, 0x800634B4-BC */' + CR
            + '                this->carObj_->wipeOutEndTick = simGlobal.gameTicks + 0xC0;    /* 0x800634C4-D0 */' + CR
            + '            }' + CR)


def body(expr):
    return ('              perTickProb = ' + expr + ';' + CR
            + '              if (randVal < perTickProb)           /* 0x800634B8 */' + CR
            + '                this->carObj_->wipeOutEndTick = simGlobal.gameTicks + 0xC0;    /* 0x800634C4-D0 */' + CR
            + '            } else if (2 <= oppFines_v1 - oppFines) {                          /* 0x800634A8-B0 (skip if <2) */' + CR
            + '              perTickProb = ' + expr + ';' + CR
            + '              if (randVal < perTickProb)          /* $t2<<2, 0x800634B4-BC */' + CR
            + '                this->carObj_->wipeOutEndTick = simGlobal.gameTicks + 0xC0;    /* 0x800634C4-D0 */' + CR
            + '            }' + CR)


NV = '      new_var = AI_elapsedTime * 29;' + CR
PINFO = '      pInfo = &this->perpChaseInfo_;' + CR

V = [
    {"name": "x1_116_inloop_no_newvar",
     "subs": [[NV, ""], [BODY_OLD, body("AI_elapsedTime * 116")]]},
    {"name": "x2_29x4_inloop_no_newvar",
     "subs": [[NV, ""], [BODY_OLD, body("AI_elapsedTime * 29 * 4")]]},
    {"name": "x3_newvar_before_pinfo_keep",
     "subs": [[NV + PINFO, PINFO + NV]]},
    {"name": "x4_116_inloop_keep_newvar_unused",
     "subs": [[BODY_OLD, body("AI_elapsedTime * 116")]]},
]
p = os.path.join(os.path.dirname(__file__), "wipe_v2.json")
json.dump(V, open(p, "w", encoding="utf-8"))
print(p)
