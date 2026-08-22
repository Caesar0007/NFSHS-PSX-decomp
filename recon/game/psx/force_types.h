/* force.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_FORCE_TYPES_H
#define NFS4_GAME_PSX_FORCE_TYPES_H

#include "../common/color_types.h"

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

struct Force_tGlobal {
    u_char active, high, low, jolt, time, fade;
    u_char actuator[2];
};

struct TCB { long status, mode; u_long reg[40]; long system[6]; };
struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};
struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

typedef int Input_tDeviceCall();

#endif
