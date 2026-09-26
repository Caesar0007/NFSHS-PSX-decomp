/* audio.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_AUDIO_TYPES_H
#define NFS4_GAME_PSX_AUDIO_TYPES_H

#include "../common/color_types.h"

#include "shared/SndBnk_t.h"

#include "shared/SNDSYSCAP.h"






#include "shared/SNDSYSSET.h"







#include "shared/SNDSYSVEC.h"



#include "shared/SNDSYSOPTS.h"





#include "shared/SNDSAMPLEFORMAT.h"




#include "shared/AudioMus_tSongEntry.h"





struct SpuVolume {
    short left, right;
};

struct SpuExtAttr {
    SpuVolume volume;
    long reverb, mix;
};

struct SpuStVoiceAttr {
    char status, pad1, pad2, pad3;
    long last_size;
    u_long buf_addr, data_addr;
};

typedef void (*SpuIRQCallbackProc)();
typedef void (*SpuTransferCallbackProc)();
typedef void (*SpuStCallbackProc)();

#endif
