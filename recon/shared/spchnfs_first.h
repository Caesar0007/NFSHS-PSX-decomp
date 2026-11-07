/* speech.obj's first header (retail SYM): the SPCHNFSType structs, in this order, ahead of the PsyQ/EA core.
   Included by nfs4_types.h under NFS4_CORE_SPCH_FIRST (game/common/speech_types.h) / NFS4_CORE_SND_FIRST (audiocmn_types.h). */
#ifndef NFS4_SHARED_SPCHNFS_FIRST_H
#define NFS4_SHARED_SPCHNFS_FIRST_H
#ifdef NFS4_CORE_SPCH_FIRST
#include "shared/SPCHNFSType_POSITION.h"
#include "shared/SPCHNFSType_DISTANCE.h"
#include "shared/SPCHNFSType_COLOUR.h"
#include "shared/SPCHNFSType_ACCIDENT.h"
#include "shared/SPCHNFSType_AMBULANCE.h"
#include "shared/SPCHNFSType_PURS_UPDT.h"
#include "shared/SPCHNFSType_ARREST.h"
#include "shared/SPCHNFSType_vs_KMH_MPH.h"
#include "shared/SPCHNFSType_vs_RDBLK_SSTRP.h"
#include "shared/SPCHNFSType_PERP_NAME.h"
#include "shared/SPCHNFSType_VOICE.h"
#include "shared/SPCHNFSType_CONFIRM.h"
#include "shared/SPCHNFSType_SPIKE_BELT_SIDE.h"
#include "shared/SPCHNFSType_REVINTRO.h"
#endif
#ifdef NFS4_CORE_SND_FIRST   /* audiocmn.obj (audiocmn_types.h): the EA sound-system structs ahead of the core */
#include "shared/SNDSYSCAP.h"
#include "shared/SNDSYSSET.h"
#include "shared/SNDSYSVEC.h"
#include "shared/SNDPLAYOPTS.h"
#include "shared/SNDSAMPLEFORMAT.h"
#endif
#endif
