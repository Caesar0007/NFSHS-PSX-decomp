/* screencarselect_tail.h -- included by screencarselect_types.h right before tScreenTournamentStandings: the color.obj
 * graph (retail ScreenCarSelect/FEMenuDefs: after the car-select screens), then -- ScreenCarSelect only
 * (NFS4_SCREENCARSELECT_TAIL_LATE) -- AudioMus_tSongEntry (retail: after the color graph). */
#include "../../game/common/color_types.h"
#ifdef NFS4_SCREENCARSELECT_TAIL_HOOK_AFTER_COLOR   /* owner records right after the color.obj graph (FEMenuDefs: mission records) */
#include NFS4_SCREENCARSELECT_TAIL_HOOK_AFTER_COLOR
#endif
#ifdef NFS4_SCREENCARSELECT_TAIL_LATE
#include "shared/AudioMus_tSongEntry.h"
#endif
#ifdef NFS4_SCREENDISPLAY_MENUS_LATE   /* retail ScreenCongrats: tMenuNFS4 family .. tVideo (screendisplay_types.h) after the car-select screens */
#define NFS4_SCREENDISPLAY_IN_MENUS_PASS
#include "screendisplay_types.h"
#undef NFS4_SCREENDISPLAY_IN_MENUS_PASS
#endif
