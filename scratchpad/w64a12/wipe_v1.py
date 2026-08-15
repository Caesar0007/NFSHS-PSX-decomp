import json, os
CR = "\r\n"
NV = "      new_var = AI_elapsedTime * 29;"
IFB = ('      if (randVal < perTickProb) {                                /* 0x800633DC-E8 */' + CR
       + '        this->carObj_->wipeOutEndTick = simGlobal.gameTicks + 0xC0;      /* 0x800633EC-F8 */' + CR
       + '      }')
PINFO = '      pInfo = &this->perpChaseInfo_;'
GUARD = '      if (pInfo->bestChaseLevelIndex_ != (pInfo->copGameInfo_)->numLevels + -1) {'
PF = ('        playFines = Cars_gNumHumanRaceCars;            /* w63-a12 REF-STEP dial (SYM-declared local' + CR
      + '                                       re-used as the loop-bound carrier) */')
FENCE = ('        __asm__("" : : "r"(playFines));                /* +1 out-of-loop ref, 0 insns: floor_log2' + CR
         + "                                       3->4 lifts the bound's allocno over the simGlobal-base copy," + CR
         + "                                       reproducing retail's $t3/$t4 (reqdelta-priced) */")

ORIG = CR.join([NV, IFB, PINFO, GUARD, PF, FENCE]) + CR


def mk(lines):
    return [[ORIG, CR.join(lines) + CR]]


V = [
    {"name": "w1_nv_after_if(=wipe52)", "subs": mk([IFB, NV, PINFO, GUARD, PF, FENCE])},
    {"name": "w2_nv_after_pinfo", "subs": mk([IFB, PINFO, NV, GUARD, PF, FENCE])},
    {"name": "w3_nv_in_guard_first", "subs": mk([IFB, PINFO, GUARD, "  " + NV, PF, FENCE])},
    {"name": "w4_nv_in_guard_after_pf", "subs": mk([IFB, PINFO, GUARD, PF, "  " + NV, FENCE])},
    {"name": "w5_nv_in_guard_after_fence", "subs": mk([IFB, PINFO, GUARD, PF, FENCE, "  " + NV])},
    {"name": "w6_nv_after_if_nofence", "subs": mk([IFB, NV, PINFO, GUARD, PF])},
    {"name": "w7_nv_in_guard_last_nofence", "subs": mk([IFB, PINFO, GUARD, PF, "  " + NV])},
]
p = os.path.join(os.path.dirname(__file__), "wipe_v1.json")
json.dump(V, open(p, "w", encoding="utf-8"))
print(p)
