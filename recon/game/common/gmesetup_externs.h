#include "../../lib/libfns.h"
/* gmesetup_externs.h -- cross-TU decls for game/common/gmesetup.cpp (NFS4 game-setup startup/cleanup).
 *   Type Input_tDeviceList lives in nfs4_types.h. */
#ifndef GMESETUP_EXTERNS_H
#define GMESETUP_EXTERNS_H

extern Input_tDeviceList Device_gDeviceList[];   /* device.obj; .startupfunc fn-ptr dispatched */
extern void Device_SetHardCodedKeys(void);       /* device.obj */
extern void Input_StartUp(void);                 /* input.obj */
                 /* libpad (eaclib PADPSXZ) */
                    /* libpad */
                /* eaclib EACPSXZ memstd */
                   /* eaclib EACPSXZ timer */

/* ---- cross-TU globals ---- */
extern FEI_tList FEI_gList[];                     /* FEI.obj [114] */
extern int  gMasterMusicLevel, gMasterSFXLevel, gMasterEngineLevel,
            gMasterAmbientLevel, gMasterFENarrationLevel;   /* audiocmn.obj */

#endif /* GMESETUP_EXTERNS_H */
