/* input_externs.h -- cross-TU decls for game/common/input.cpp (NFS4 controller input layer).
 *   Types (Input_tResults, Input_tDeviceList) live in nfs4_types.h. input.obj OWNS its Input_g*
 *   globals (defined in the .cpp, NOT here). */
#ifndef INPUT_EXTERNS_H
#define INPUT_EXTERNS_H

#include "input_types.h"

/* ---- device.obj ---- */
extern void Device_StartUp(void);
extern void Device_Update(void);
/* The owner SYM omits the private 12-byte device-row body.  Draw_PrimStruct is
 * an already-emitted three-word carrier with the same pointer slot at +4. */
extern Draw_PrimStruct Input_DeviceRows[] __asm__("Device_gDeviceList");

/* ---- simqueue.obj ---- */
extern void SimQueue_GetCurrentInput(int player, Input_tResults *out);
extern int  SimQueue_Put(int player, Input_tResults *in);     /* returns int (used in Input_Store) */
extern int  gSimQueue_BlockSelf;

/* ---- sim.obj / gmesetup.obj ---- */
extern int Input_simGlobalWords[] __asm__("simGlobal");
extern int Input_gameSetupWords[] __asm__("GameSetup_gData");

/* Proven retail word offsets in the opaque owner globals. */
#define Input_time32Hz           Input_simGlobalWords[2]
#define Input_commMode           Input_gameSetupWords[3]
#define Input_localCar           Input_gameSetupWords[7]
#define Input_numPlayerRaceCars  Input_gameSetupWords[242]

#endif /* INPUT_EXTERNS_H */
