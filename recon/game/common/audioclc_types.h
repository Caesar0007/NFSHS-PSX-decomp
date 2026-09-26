/* audioclc.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AUDIOCLC_TYPES_H
#define NFS4_GAME_COMMON_AUDIOCLC_TYPES_H

#include "color_types.h"

#define RaceType_HotPursuit 1
#define RaceType_Id5 5

/* The completed s_type enum is absent from audioclc.obj; it survives only in
 * two external C++ function names. */
#ifndef NFS4_AUDIOCLC_OMIT_S_TYPE_ALIAS
#define s_type int
#endif

#include "shared/POLY_GT4.h"







#include "shared/Draw_SubdivStruct.h"

#include "shared/Track_tArtresource.h"







#include "shared/Track_tMaterial.h"

#ifndef NFS4_AUDIOCLC_OMIT_SOUND_API_TYPES
#include "shared/SNDSYSCAP.h"






#include "shared/SNDSYSSET.h"







#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"
#endif

#ifndef NFS4_AUDIOCLC_OMIT_SCHED_SCHEDULE
#include "shared/Sched_tSchedule.h"



#endif

#ifndef NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
#include "shared/Trk_AnimateInst.h"




#endif

#ifndef NFS4_AUDIOCLC_OMIT_SCENE_TYPES
#include "shared/SceneElem.h"







#include "shared/SceneSortedElem.h"
#endif

#include "shared/TCB.h"

#include "shared/EXEC.h"




#include "shared/DIRENTRY.h"







#include "shared/Skidmark_Segment.h"






#include "shared/Skidmark_Chunk.h"





#ifdef NFS4_AUDIOCLC_OMIT_FORCE_FOCUS
#define forceFocus_t int
#else
#ifdef NFS4_SINGLE_IMPLICIT_ENUM_TYPEDEF
enum forceFocus_t {
#else
typedef enum forceFocus_t {
#endif
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
#ifdef NFS4_SINGLE_IMPLICIT_ENUM_TYPEDEF
};
#else
} forceFocus_t;
#endif
#endif

#include "shared/kernpair.h"





#ifndef NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
struct AudioClc_tSource {
    Car_tObj *car;
    int distToCamera, dopplerShift, relVelocity, gameTicks, distSq;
    int frequency, channel, horn, hornOn, hornOff, hornCount, pursuit, yelled;
};

struct AudioClc_tPlayer {
    int cameraMode, gameTicks, warnings;
    coorddef lastview;
    AudioClc_tSource source;
};

struct AudioClc_tCLCache { Car_tObj *ptr; int dst; };
#endif

/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















#ifndef NFS4_AUDIOCLC_OMIT_CAMERA_VIEW
#include "shared/camera_info.h"




























#endif

struct CARDINFO_def;
typedef struct CARDINFO_def CARDINFO_def;
struct Trk_NewSlice;
typedef struct Trk_NewSlice Trk_NewSlice;

#ifndef NFS4_AUDIOCLC_OMIT_CARLOGIC_OBSERVATIONS
typedef int CarLogic_tObservations[1][3];
#endif
#ifndef NFS4_AUDIOCLC_OMIT_INPUT_DEVICE_CALL
typedef int Input_tDeviceCall();
#endif
typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
