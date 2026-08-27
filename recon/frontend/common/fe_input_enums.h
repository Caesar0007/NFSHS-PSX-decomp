/* Frontend input enums shared by the retail FEInput and FEScreen owners. */
#ifndef NFS4_FRONTEND_COMMON_FE_INPUT_ENUMS_H
#define NFS4_FRONTEND_COMMON_FE_INPUT_ENUMS_H

#ifndef NFS4_FE_INPUT_NO_PLAYER
#include "fe_player_types.h"
#endif

typedef enum tInputKeyType {
    kInput_KeyType_NoKey = 0,
    kInput_KeyType_AlreadyProcessed = 1,
    kInput_KeyType_Cross = 2,
    kInput_KeyType_Circle = 4,
    kInput_KeyType_Square = 8,
    kInput_KeyType_Triangle = 16,
    kInput_KeyType_L1 = 32,
    kInput_KeyType_L2 = 64,
    kInput_KeyType_R1 = 128,
    kInput_KeyType_R2 = 256,
    kInput_KeyType_Up = 512,
    kInput_KeyType_Down = 1024,
    kInput_KeyType_Left = 2048,
    kInput_KeyType_Right = 4096,
    kInput_KeyType_Start = 8192,
    kInput_KeyType_Select = 16384
} tInputKeyType;

#endif
