#!/usr/bin/env python3
"""w60a8: reorder aiphysic.cpp function definitions into retail VA order.
Byte-exact block permutation; no text edits except lifting the run-tree
divider comment out of the function sequence."""
import os, re, sys

P = r"C:/Temp/nfs4-decomp/recon/game/common/aiphysic.cpp"
data = open(P, 'rb').read()
N = len(data)

DIV_S = b"/* ============================================================================\r\n * PORTED from run-tree"
DIV_E = b" * ========================================================================== */\r\n\r\n"
ds = data.index(DIV_S)
de = data.index(DIV_E) + len(DIV_E)
divider = data[ds:de]
data = data[:ds] + data[de:]

# split the 3-stub block into three separate blocks
STUBS = (b"/* ---- AIPhysic_StartUp__Fv / Reset / CleanUp (empty stubs) ---- */\r\n"
         b"void AIPhysic_StartUp(void) { return; }\r\n"
         b"void AIPhysic_Reset(void)   { return; }\r\n"
         b"void AIPhysic_CleanUp(void) { return; }\r\n\r\n")
assert data.count(STUBS) == 1
NEWSTUBS = (b"/* ---- AIPhysic_StartUp__Fv / CleanUp / Reset (empty stubs, retail VA order"
            b" 0x8006cc3c/44/4c) ---- */\r\n"
            b"void AIPhysic_StartUp(void) { return; }\r\n"
            b"void AIPhysic_CleanUp(void) { return; }\r\n"
            b"void AIPhysic_Reset(void)   { return; }\r\n\r\n")
data = data.replace(STUBS, NEWSTUBS)

# carve blocks at every top-of-line banner
starts = [m.start() for m in re.finditer(br"(?m)^/\* ---- ", data)]
head = data[:starts[0]]
bounds = starts + [len(data)]
blocks = []
for i in range(len(starts)):
    b = data[bounds[i]:bounds[i + 1]]
    name = re.match(br"/\* ---- (\S+)", b).group(1).decode()
    blocks.append((name, b))

order = """AIPhysic_StopCar__FP8Car_tObjii
AIPhysic_RevEngine__FP8Car_tObj
AIPhysic_HandleShifting__FP8Car_tObj
AIPhysic_CalculateGear__FP8Car_tObj
AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t
AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t
AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t
AIPhysic_CalcAcceleration__FP8Car_tObji
AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji
AIPhysic_CalcDeceleration__FP8Car_tObj
AIPhysic_CheckDesiredDirection__FP8Car_tObj
AIPhysic_HandleSignalling__FP8Car_tObj
AIPhysic_HandleWipeoutTimer__FP8Car_tObj
AIPhysic_Main__FP8Car_tObj
AIPhysic_CheckForBadPosition__FP8Car_tObj
AIPhysics_UseCoolPhysics__FP8Car_tObj
AIPhysic_SimplePhysics__FP8Car_tObj
AIPhysic_SimplePhysics_LongVel__FP8Car_tObj
AIPhysic_SimplePhysics_LatVel__FP8Car_tObj
AIPhysic_CoolPhysics__FP8Car_tObj
AIPhysic_HandleDirection__FP8Car_tObj
AIPhysic_Preperation__FP8Car_tObj
AIPhysic_CalculateRoadPosition__FP8coorddefi
AIPhysic_GetDesiredVector__FP8Car_tObj
AIPhysic_TargetedGetDesiredVector__FP8Car_tObj
AIPhysic_CheckIfOutOfControl__FP8Car_tObj
AIPhysic_OutOfControlPhysics__FP8Car_tObj
AIPhysic_GetRearEndDamageFactor__FP8Car_tObj
AIPhysic_InControlPhysics__FP8Car_tObj
AIPhysic_FinishUp__FP8Car_tObj
AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType
AIPhysic_HitWallCheck__FP8Car_tObj
AIPhysic_ProcessBarrierCollision__FP8Car_tObj
AIPhysic_ProcessCollision__FP8Car_tObj
AIPhysic_ChangeDirection__FP8Car_tObji
AIPhysic_CheckForGripReduction__FP8Car_tObj
AIPhysic_StartUp__Fv
AIPhysic_ResetCar__FP8Car_tObj
AIPhysic_InitCar__FP8Car_tObj
AIPhysic_DeInitCar__FP8Car_tObj""".split("\n")

have = [n for n, _ in blocks]
assert len(have) == len(set(have)), "duplicate banner names"
missing = [n for n in have if n not in order]
extra = [n for n in order if n not in have]
if missing or extra:
    sys.exit(f"MISMATCH missing-from-order={missing} not-in-file={extra}")

bym = dict(blocks)
out = head + divider + b"".join(bym[n] for n in order)
assert len(out) == len(data) + len(divider), (len(out), len(data), len(divider))
tmp = P + ".tmp"
open(tmp, 'wb').write(out)
os.replace(tmp, P)
print(f"reordered {len(order)} blocks; size {N} -> {len(out)}")
