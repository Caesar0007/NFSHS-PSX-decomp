/* Skidmark.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_SKIDMARK_TYPES_H
#define NFS4_GAME_PSX_SKIDMARK_TYPES_H

#include "../common/color_types.h"

#include "shared/POLY_GT4.h"







#include "shared/DRender_tView.h"




#include "shared/Draw_SubdivStruct.h"

#include "shared/Track_tArtresource.h"







#include "shared/Track_tMaterial.h"

#include "shared/TCB.h"
#include "shared/EXEC.h"



struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

#include "shared/Skidmark_Segment.h"






#include "shared/tSkid.h"







#include "shared/Skidmark_Chunk.h"





#include "shared/Draw_tCtrlSkidmark.h"






#endif
