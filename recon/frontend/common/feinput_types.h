/* Owner-specific type tail for FEInput.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEINPUT_TYPES_H
#define NFS4_FRONTEND_COMMON_FEINPUT_TYPES_H

#include "fe_core_types.h"
#include "fe_input_enums.h"

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

struct tPSXToFEMapping {
    int PSXKey;
    tInputKeyType FEKey;
};

#endif
