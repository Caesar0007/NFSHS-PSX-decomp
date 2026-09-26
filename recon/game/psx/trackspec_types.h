/* trackspec.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_TRACKSPEC_TYPES_H
#define NFS4_GAME_PSX_TRACKSPEC_TYPES_H

#include "../common/gamesetup_leaf_types.h"

/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















#include "shared/CHorizonSpec.h"





#include "shared/CSkySpec.h"













#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"

#include "shared/CFogSpec.h"





#include "shared/CDepthCueSpec.h"




#include "shared/CWorldColor.h"





struct CTrackSpecHeader { int version, num_spec; };

#include "shared/CTrackSpec.h"











#include "shared/kernpair.h"




typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
