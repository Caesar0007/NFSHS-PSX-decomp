/* frontend/common/screendisplay_carblock.h -- the car/track/tournament part of screendisplay_types.h (fe_core_cars,
 * fe_tournament_types, the car/track/tournament list iterators, tTournamentManager).  A separate piece only so that
 * NFS4_SCREENDISPLAY_CARS_AFTER_MENUS owners emit it after the tMenuNFS4 / options family (retail type order).
 * Pass logic: the first include emits the car part (and, unless NFS4_SCREENDISPLAY_TRACKS_AFTER_MENUS, the track/
 * tournament part too); with that key the second include (site 2, after the menu family) emits the track part. */
#ifndef NFS4_FRONTEND_COMMON_SCREENDISPLAY_CARBLOCK_H
#define NFS4_FRONTEND_COMMON_SCREENDISPLAY_CARBLOCK_H
#define NFS4_SCREENDISPLAY_CB_CARS 1
#ifdef NFS4_SCREENDISPLAY_TRACKS_AFTER_MENUS
#define NFS4_SCREENDISPLAY_CB_TRACKS 0
#else
#define NFS4_SCREENDISPLAY_CB_TRACKS 1
#endif
#elif defined(NFS4_SCREENDISPLAY_TRACKS_AFTER_MENUS) && !defined(NFS4_FRONTEND_COMMON_SCREENDISPLAY_CARBLOCK_PASS2)
#define NFS4_FRONTEND_COMMON_SCREENDISPLAY_CARBLOCK_PASS2
#undef NFS4_SCREENDISPLAY_CB_CARS
#undef NFS4_SCREENDISPLAY_CB_TRACKS
#define NFS4_SCREENDISPLAY_CB_CARS 0
#define NFS4_SCREENDISPLAY_CB_TRACKS 1
#else
#undef NFS4_SCREENDISPLAY_CB_CARS
#undef NFS4_SCREENDISPLAY_CB_TRACKS
#define NFS4_SCREENDISPLAY_CB_CARS 0
#define NFS4_SCREENDISPLAY_CB_TRACKS 0
#endif
#if NFS4_SCREENDISPLAY_CB_CARS && NFS4_SCREENDISPLAY_CB_TRACKS
#endif
#if NFS4_SCREENDISPLAY_CB_CARS
#include "fe_core_cars.h"
#endif
#if NFS4_SCREENDISPLAY_CB_CARS && NFS4_SCREENDISPLAY_CB_TRACKS
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
#endif
#if NFS4_SCREENDISPLAY_CB_CARS
struct tCarManager;
#ifndef NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* else via NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER */
#define NFS4_SCREENDISPLAY_ITERS_CARS
#include "screendisplay_carblock_iters.h"
#undef NFS4_SCREENDISPLAY_ITERS_CARS
#endif
#endif
#if NFS4_SCREENDISPLAY_CB_TRACKS
#if !NFS4_SCREENDISPLAY_CB_CARS
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
#endif

#include "fetourn_manager_class.h"   /* class tTournamentManager: one definition (header-truth 4l) */




































































#ifndef NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* else via NFS4_FE_TRACK_HOOK_AFTER_MANAGER */
#define NFS4_SCREENDISPLAY_ITERS_TRACK
#include "screendisplay_carblock_iters.h"
#undef NFS4_SCREENDISPLAY_ITERS_TRACK
#endif

#include "felist_tournament_iter.h"   /* tListIteratorTournament: one definition (header-truth 4s) */











#ifdef NFS4_SCREENDISPLAY_SCREEN_AFTER_TOURNAMENT   /* retail FEMenuDefs: tShapeInformation + the tScreen definition right after tListIteratorTournament (earlier: forward copy only) */
#include "shared/tShapeInformation.h"
#include "fescreen.h"
#endif
#endif
