import json, os
CR = "\r\n"
drag = "  carObj->drag = 0;"
ut = "  uTurn = 0;"
call = "  currentLatVel = AIWorld_CalcFutureLateralVel(carObj,carObj->direction * AIPhysicConfig.latvelcalc_lookahead);"
cfg = "  cfg = &AIPhysicConfig;"
orig = CR.join([drag, ut, call, cfg]) + CR

def mk(lines):
    return [[orig, CR.join(lines) + CR]]

V = [
    {"name": "t1_uturn_after_call_before_cfg", "subs": mk([drag, call, ut, cfg])},
    {"name": "t2_uturn_after_cfg", "subs": mk([drag, call, cfg, ut])},
    {"name": "t3_cfg_first", "subs": mk([drag, cfg, ut, call])},
    {"name": "t4_uturn_first_cfg_second", "subs": mk([ut, drag, call, cfg])},
    {"name": "t5_drag_after_call", "subs": mk([ut, call, drag, cfg])},
]
p = os.path.join(os.path.dirname(__file__), "ooc_v3.json")
json.dump(V, open(p, "w", encoding="utf-8"))
print(p)
