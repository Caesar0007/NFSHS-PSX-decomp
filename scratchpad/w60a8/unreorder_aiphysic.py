#!/usr/bin/env python3
"""w60a8: INVERSE of reorder_aiphysic.py -- restore aiphysic.cpp to its
pre-W60-A8 emission order (used to keep the tree at zero PASS->FAIL while the
paired tools/build.py TEXT_MOVES regex change is pending)."""
import os, re, sys

P = r"C:/Temp/nfs4-decomp/recon/game/common/aiphysic.cpp"
data = open(P, 'rb').read()

DIV_S = b"/* ============================================================================\r\n * PORTED from run-tree"
DIV_E = b" * ========================================================================== */\r\n\r\n"
ds = data.index(DIV_S)
de = data.index(DIV_E) + len(DIV_E)
divider = data[ds:de]
data = data[:ds] + data[de:]

NEWSTUBS = (b"/* ---- AIPhysic_StartUp__Fv / CleanUp / Reset (empty stubs, retail VA order"
            b" 0x8006cc3c/44/4c) ---- */\r\n"
            b"void AIPhysic_StartUp(void) { return; }\r\n"
            b"void AIPhysic_CleanUp(void) { return; }\r\n"
            b"void AIPhysic_Reset(void)   { return; }\r\n\r\n")
STUBS = (b"/* ---- AIPhysic_StartUp__Fv / Reset / CleanUp (empty stubs) ---- */\r\n"
         b"void AIPhysic_StartUp(void) { return; }\r\n"
         b"void AIPhysic_Reset(void)   { return; }\r\n"
         b"void AIPhysic_CleanUp(void) { return; }\r\n\r\n")
assert data.count(NEWSTUBS) == 1
data = data.replace(NEWSTUBS, STUBS)

starts = [m.start() for m in re.finditer(br"(?m)^/\* ---- ", data)]
head = data[:starts[0]]
bounds = starts + [len(data)]
blocks = {}
for i in range(len(starts)):
    b = data[bounds[i]:bounds[i + 1]]
    blocks[re.match(br"/\* ---- (\S+)", b).group(1).decode()] = b

pre_divider = """AIPhysic_StartUp__Fv
AIPhysic_ResetCar__FP8Car_tObj
AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t
AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t
AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t
AIPhysic_TargetedGetDesiredVector__FP8Car_tObj
AIPhysic_DeInitCar__FP8Car_tObj
AIPhysic_GetRearEndDamageFactor__FP8Car_tObj
AIPhysic_CalcDeceleration__FP8Car_tObj
AIPhysic_ProcessBarrierCollision__FP8Car_tObj
AIPhysic_HitWallCheck__FP8Car_tObj
AIPhysic_CoolPhysics__FP8Car_tObj
AIPhysic_ProcessCollision__FP8Car_tObj
AIPhysic_HandleSignalling__FP8Car_tObj
AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji
AIPhysics_UseCoolPhysics__FP8Car_tObj
AIPhysic_CheckForBadPosition__FP8Car_tObj
AIPhysic_CalculateGear__FP8Car_tObj
AIPhysic_HandleDirection__FP8Car_tObj
AIPhysic_CalculateRoadPosition__FP8coorddefi
AIPhysic_SimplePhysics_LatVel__FP8Car_tObj
AIPhysic_HandleWipeoutTimer__FP8Car_tObj
AIPhysic_ChangeDirection__FP8Car_tObji""".split("\n")

post_divider = """AIPhysic_StopCar__FP8Car_tObjii
AIPhysic_RevEngine__FP8Car_tObj
AIPhysic_HandleShifting__FP8Car_tObj
AIPhysic_CalcAcceleration__FP8Car_tObji
AIPhysic_CheckDesiredDirection__FP8Car_tObj
AIPhysic_Main__FP8Car_tObj
AIPhysic_SimplePhysics__FP8Car_tObj
AIPhysic_SimplePhysics_LongVel__FP8Car_tObj
AIPhysic_Preperation__FP8Car_tObj
AIPhysic_GetDesiredVector__FP8Car_tObj
AIPhysic_CheckIfOutOfControl__FP8Car_tObj
AIPhysic_OutOfControlPhysics__FP8Car_tObj
AIPhysic_InControlPhysics__FP8Car_tObj
AIPhysic_FinishUp__FP8Car_tObj
AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType
AIPhysic_CheckForGripReduction__FP8Car_tObj
AIPhysic_InitCar__FP8Car_tObj""".split("\n")

order = pre_divider + post_divider
assert sorted(order) == sorted(blocks), (set(order) ^ set(blocks))
out = (head + b"".join(blocks[n] for n in pre_divider) + divider
       + b"".join(blocks[n] for n in post_divider))
assert len(out) == len(data) + len(divider)
tmp = P + ".tmp"
open(tmp, 'wb').write(out)
os.replace(tmp, P)
print(f"restored pre-W60-A8 order; size {len(out)}")
