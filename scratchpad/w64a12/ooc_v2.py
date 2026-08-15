import json, os
CR = "\r\n"
call = "  currentLatVel = AIWorld_CalcFutureLateralVel(carObj,carObj->direction * AIPhysicConfig.latvelcalc_lookahead);"
cfgline = "  cfg = &AIPhysicConfig;"
ifblk = (CR + "  if (carObj->direction * carObj->currentSpeed < 0) {" + CR
         + "    uTurn = carObj->driveDirection != -1;" + CR
         + "  }" + CR)
tick = "  carObj->wipeOutEndTick = simGlobal[1];"

orig = call + CR + cfgline + ifblk + tick

V = [
    {"name": "m1_cfg_after_ifblock",
     "subs": [[orig, call + ifblk + cfgline + CR + tick]]},
    {"name": "m2_cfg_after_tick",
     "subs": [[orig, call + ifblk + tick + CR + cfgline]]},
    {"name": "m3_cfg_after_tick_nodecl_high",
     "subs": [[orig, call + ifblk + tick + CR
               + "  cfg = (AIPhysic_Config_t *)&AIPhysicConfig.latvelcalc_lookahead;"]]},
]
p = os.path.join(os.path.dirname(__file__), "ooc_v2.json")
json.dump(V, open(p, "w", encoding="utf-8"))
print(p)
