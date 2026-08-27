/* Exact type-only surface emitted by Fecntl.obj. */
#ifndef NFS4_FRONTEND_COMMON_FECNTL_TYPES_H
#define NFS4_FRONTEND_COMMON_FECNTL_TYPES_H

#include "../../game/common/color_types.h"
#include "fe_core_types.h"

struct tOldMenu;

struct tItemButton {
    short type, text;
    tOldMenu *nextMenu;
    char *value;
    short *selection;
    char defaultvalue;
    u_char flags, cases;
};

struct tOldMenu {
    char *artFileName, *backgrName;
    short driver, current, flags, helpvariant;
    tItemButton *item[16];
};

typedef int (*menuDrivers_t)();
#ifndef NFS4_FECNTL_NO_INPUT_DEVICE_CALL
typedef int Input_tDeviceCall();
#endif

/* The linked Fecntl SYM retains tSaveRecords[187] while attributing the
 * already-known element tag body to an earlier owner.  CC1PL needs the exact
 * element body to form the array; the canonical audit pair-locks this carrier. */
#ifndef NFS4_FECNTL_NO_RECORD_CARRIER
struct tRecordBuffer {
    char sName[8];
    int nCar, nTime, nBestLap;
};
typedef tRecordBuffer tSaveRecords[187];
#endif

#endif
