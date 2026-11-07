/* tTVState -- the screen-display TV state enum (same text as fetv_types.h); included early by owner surfaces whose retail
 * object records the TV state with the mission/TV block; screendisplay_types.h includes it at the old late place. */
#ifndef NFS4_SHARED_TTVSTATE_H
#define NFS4_SHARED_TTVSTATE_H
enum tTVState {
    tv_StateOff = 0,
    tv_StateOn = 1,
    tv_TransitionOn = 2,
    tv_TransitionOff = 3
};
#endif
