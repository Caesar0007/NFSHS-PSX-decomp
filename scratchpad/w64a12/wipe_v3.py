import json, os
CR = "\r\n"
PF = ('        playFines = Cars_gNumHumanRaceCars;            /* w63-a12 REF-STEP dial (SYM-declared local' + CR
      + '                                       re-used as the loop-bound carrier) */' + CR)
FENCE = ('        __asm__("" : : "r"(playFines));                /* +1 out-of-loop ref, 0 insns: floor_log2' + CR
         + "                                       3->4 lifts the bound's allocno over the simGlobal-base copy," + CR
         + "                                       reproducing retail's $t3/$t4 (reqdelta-priced) */" + CR)
FOR = '        for (hLoop = 0; hLoop < playFines; hLoop = hLoop + 1) {   /* 0x80063450 */' + CR
FORG = '        for (hLoop = 0; hLoop < Cars_gNumHumanRaceCars; hLoop = hLoop + 1) {   /* 0x80063450 */' + CR
OLD = PF + FENCE + FOR

V = [
    {"name": "y1_nofence", "subs": [[OLD, PF + FOR]]},
    {"name": "y2_nofence_noglocal", "subs": [[OLD, FORG]]},
    {"name": "y3_fence_after_for_head", "subs": [[OLD, PF + FOR + '        ' + FENCE.strip()[:31] + CR]]},
    {"name": "y4_globaldirect_keepcarrier", "subs": [[OLD, PF + FENCE + FORG]]},
]
p = os.path.join(os.path.dirname(__file__), "wipe_v3.json")
json.dump(V, open(p, "w", encoding="utf-8"))
print(p)
