/* screenmain_state.h -- tScreenMainState, moved verbatim from screendisplay_types.h (ScreenMain.obj emits it from
 * its after-dialogs owner block, screenmain_early.h). */
#ifndef NFS4_FRONTEND_COMMON_SCREENMAIN_STATE_H
#define NFS4_FRONTEND_COMMON_SCREENMAIN_STATE_H
enum tScreenMainState {
    kScreenMain_Off = 0,
    kScreenMain_StaticImage = 1,
    kScreenMain_DynamicImage = 2,
    kScreenMain_WarningImage = 3,
    kScreenMain_Credits = 4
};
#endif
