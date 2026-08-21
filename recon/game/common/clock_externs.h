/* game/common/clock_externs.h - reconstructed externs. NOT original. */
#ifndef _GAME_COMMON_CLOCK_EXTERNS_H_
#define _GAME_COMMON_CLOCK_EXTERNS_H_
#include "clock_types.h"

/* ---- globals (cross-TU) ---- */
extern int Input_gTime;        /* Input.obj */
extern int R3DCar_ClockLast;   /* R3DCar.obj */

/* ---- Input.obj ---- */
void Input_Store(void);
void Input_Update(void);

/* ---- EAC root-counter timer chain (EAC_timerproc = void(*)(void)) ---- */
extern "C" int addtimer(void (*proc)(void));
extern "C" int deltimer(void (*proc)(void));

/* ---- eaclib gp save/restore ---- */
extern "C" void savegp(u_int *ctx);
extern "C" void restoregp(u_int saved);

#endif /* _GAME_COMMON_CLOCK_EXTERNS_H_ */
