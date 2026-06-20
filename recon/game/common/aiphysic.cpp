/* game/common/aiphysic.cpp -- RECONSTRUCTED (AI physics subsystem).
 *   AIPhysic_* — AI car physics: gear/speed tables, collision, control, road position.
 *   Reconstruction in progress (started 2026-06-20). NOT original source; SYM-faithful,
 *   recompilable C++. Verified per-function vs asm/nonmatchings/main/*.s.
 */
#include "../../nfs4_types.h"
#include "aiphysic_externs.h"


/* ---- AIPhysic_StartUp__Fv / Reset / CleanUp (empty stubs) ---- */
void AIPhysic_StartUp(void) { return; }
void AIPhysic_Reset(void)   { return; }
void AIPhysic_CleanUp(void) { return; }

/* ---- AIPhysic_ResetCar__FP8Car_tObj ---- */
void AIPhysic_ResetCar(Car_tObj *car)
{
    *(int *)((char *)car + 0x278) = 0;
    *(int *)((char *)car + 0x274) = 0;
}

/* ---- AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t  (clamp via tail-recursion -> gcc `j self`) ---- */
int AIPhysic_GearTopSpeed(Car_tObj *car, Gear_t gear)
{
    if (gear < 2) return AIPhysic_GearTopSpeed(car, (Gear_t)2);
    return car->topSpeeds[gear - 2];
}

/* ---- AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t ---- */
int AIPhysic_GearBottomSpeed(Car_tObj *car, Gear_t gear)
{
    if (gear < 3) return 0;
    return car->topSpeeds[gear - 3];
}

/* ---- AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t ---- */
int AIPhysic_GearInvSpeedRange(Car_tObj *car, Gear_t gear)
{
    if (gear < 2) return AIPhysic_GearInvSpeedRange(car, (Gear_t)2);
    return car->invTopSpeeds[gear - 2];
}
