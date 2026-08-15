/* input_externs.h -- cross-TU decls for game/common/input.cpp (NFS4 controller input layer).
 *   Types (Input_tResults, Input_tDeviceList) live in nfs4_types.h. input.obj OWNS its Input_g*
 *   globals (defined in the .cpp, NOT here). */
#ifndef INPUT_EXTERNS_H
#define INPUT_EXTERNS_H

/* ---- device.obj ---- */
extern Input_tDeviceList Device_gDeviceList[];   /* [5]; .devicefunc fn-ptr dispatched in Input_Update */
extern void Device_StartUp(void);
extern void Device_Update(void);

/* ---- simqueue.obj ---- */
extern void SimQueue_GetCurrentInput(int player, Input_tResults *out);
extern int  SimQueue_Put(int player, Input_tResults *in);     /* returns int (used in Input_Store) */
extern int  gSimQueue_BlockSelf;

/* ---- sim.obj / gmesetup.obj ---- */
extern Sim_tSimGlobalVar simGlobal;
extern GameSetup_tData   GameSetup_gData;

#endif /* INPUT_EXTERNS_H */
