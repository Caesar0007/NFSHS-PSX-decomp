/* screenmain_early.h -- ScreenMain.obj owner records retail emits right after the dialogs (screenmain_types.h
 * after-color hook pass): TV, tCredit, tScreenMainState, tVideoTransition, tVideo, tVideoWallConfig, tScreenMain. */
#include "shared/tTVState.h"
#include "shared/tTVConfig.h"
#include "shared/tCredit.h"
#include "screenmain_state.h"
#include "shared/tVideoTransition.h"
#include "shared/tVideo.h"
struct tVideoWallConfig {
    short numVideos, flags;
    tVideo *videos[4];
};
#include "screenmain.h"
