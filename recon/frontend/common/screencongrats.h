#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_SCREENDISPLAY_COLOR_BEFORE_CARS   /* color.obj graph before the car/track graph */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* draw_leaf phase 1 only; screendisplay_types.h emits PCOORD16 .. Draw_* after tScreen */
#define NFS4_SCREENDISPLAY_DIALOGS_EARLY   /* retail: dialogs before the car/track graph (screendisplay_types.h) */
#ifndef _FE_SCREENS_SCREENCONGRATS_H_
#define _FE_SCREENS_SCREENCONGRATS_H_   /* frontend/common/screencongrats.h - reconstructed decls for ScreenCongrats.obj (C++ TU) */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#include "screencongrats_types.h"
#include "screencongrats_externs.h"

/* member fns declared in nfs4_types.h (5 classes). Instance pointers: */
extern tScreenPinkSlipCongrats   *screenPinkSlipCongrats;
extern tScreenTournamentTrophy   *screenTournamentTrophy;
extern tScreenBeTheCopCongrats   *screenBeTheCopCongrats;
extern tScreenTournamentCongrats *screenTournamentCongrats;

#endif
