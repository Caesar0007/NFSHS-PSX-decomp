import json, os
CR = "\r\n"
call = "  currentLatVel = AIWorld_CalcFutureLateralVel(carObj,carObj->direction * AIPhysicConfig.latvelcalc_lookahead);"
cfg = "  cfg = &AIPhysicConfig;"
anchor = call + CR + cfg


def ins(after_call="", after_cfg=""):
    s = call
    if after_call:
        s += CR + "  " + after_call
    s += CR + cfg
    if after_cfg:
        s += CR + "  " + after_cfg
    return [[anchor, s]]


V = [
    {"name": "v1_r_currentLatVel_after_call",
     "subs": ins(after_call='__asm__("" : : "r"(currentLatVel));')},
    {"name": "v2_i0_after_call(regate w63)",
     "subs": ins(after_call='__asm__("" : : "i"(0));')},
    {"name": "v3_i0_after_cfg",
     "subs": ins(after_cfg='__asm__("" : : "i"(0));')},
    {"name": "v4_identity_cfg",
     "subs": ins(after_cfg='__asm__("" : "=r"(cfg) : "0"(cfg));')},
    {"name": "v5_r_carObj_after_call",
     "subs": ins(after_call='__asm__("" : : "r"(carObj));')},
    {"name": "v6_r_cfg_after_cfg",
     "subs": ins(after_cfg='__asm__("" : : "r"(cfg));')},
]
p = os.path.join(os.path.dirname(__file__), "ooc_v1.json")
json.dump(V, open(p, "w", encoding="utf-8"))
print(p)
