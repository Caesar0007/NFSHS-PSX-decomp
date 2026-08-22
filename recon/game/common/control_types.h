/* control.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_CONTROL_TYPES_H
#define NFS4_GAME_COMMON_CONTROL_TYPES_H

#include "color_types.h"

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

struct SNDSYSCAP {
    u_short outputratemin, outputratemax;
    u_char outputchannelsmin, outputchannelsmax;
    u_char inputvoicesmax, input3dvoicesmax, eax, voicemanager;
    char pad[2];
};

struct SNDSYSSET {
    u_short maxbanks, outputrate;
    u_char outputchannels, inputvoices, useeax, use3dacceleration, use3dmixing;
    char pad;
    u_short emulationsubtype;
    u_short spkrcfg3d[4][4];
};

struct SNDSYSVEC {
    int (*issurfacelocked)(void);
};

struct SNDSAMPLEFORMAT {
    u_short samplerate;
    u_char channels, samplerep;
};

typedef int CarLogic_tObservations[1][3];
typedef int Input_tDeviceCall();

#endif
