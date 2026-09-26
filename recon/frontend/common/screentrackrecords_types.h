/* Owner-specific type surface for ScreenTrackRecords.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENTRACKRECORDS_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTRACKRECORDS_TYPES_H

/* Reuse the exact shared render/frontend graph while excluding input enums,
 * songs, saved-game and memory-card records, and dialogs. */
#define NFS4_SCREENMEMCARD_FEAPP_SURFACE
#define NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE
#include "screenmemcard_types.h"
#undef NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE
#undef NFS4_SCREENMEMCARD_FEAPP_SURFACE

/* These foreign enum tags are absent from this owner graph. */
typedef enum tMenuTextState {
    textState_Unselected = 0,
    textState_Selected = 1,
    textState_Hilighted = 2,
    textState_NumStates = 3
} tMenuTextState;
#define tMenuTextType int
#define textType_TrackRecords 11

#include "shared/FLARE_PIECE_DEF.h"





struct tRecordBuffer;

struct tScreenTrackRecords : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    void Cleanup();
    tRecordBuffer *TrackRecords;
    int flare_intensity, flareextra;
    bool fReadNewData;

    tScreenTrackRecords();
    void DrawOneRecord(int, bool, int);
    void DrawRecords(short);
};

/* SYM completes this record after tScreenTrackRecords. */
#include "shared/tRecordBuffer.h"



typedef tRecordBuffer tSaveRecords[187];

#endif
