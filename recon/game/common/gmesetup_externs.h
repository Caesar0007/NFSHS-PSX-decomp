/* gmesetup_externs.h -- cross-TU decls for game/common/gmesetup.cpp (NFS4 game-setup startup/cleanup).
 *   Type Input_tDeviceList lives in nfs4_types.h. */
#ifndef GMESETUP_EXTERNS_H
#define GMESETUP_EXTERNS_H

extern int GameSetup_DeviceListWords[][3] asm("Device_gDeviceList");
#define GAMESETUP_DEVICE_STARTUP(i) \
    ((int (*)(int))GameSetup_DeviceListWords[(i)][2])
extern void Device_SetHardCodedKeys(void);       /* device.obj */
extern void Input_StartUp(void);                 /* input.obj */
                 /* libpad (eaclib PADPSXZ) */
                    /* libpad */
                /* eaclib EACPSXZ memstd */
                   /* eaclib EACPSXZ timer */

/* ---- cross-TU globals ---- */
extern FEI_tList FEI_gList[];                     /* FEI.obj [114] */
extern int  Input_gHandler[];                     /* input.obj @0x80113C14 [184] — device-cmd handler table */
extern int  gMasterMusicLevel, gMasterSFXLevel, gMasterEngineLevel,
             gMasterAmbientLevel, gMasterFENarrationLevel;   /* audiocmn.obj */

extern "C" {
u_short PAD_state(int);
void PAD_update(...);
int purgememadr(...);
void timedwait(...);
}

#endif /* GMESETUP_EXTERNS_H */
